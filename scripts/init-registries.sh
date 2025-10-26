#!/bin/bash

# Shadcn Registries Package - Registry Initialization Script
# This script validates all configured registries and caches component lists

set -e

echo "🔍 Initializing Shadcn Registries"
echo "================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check required files
if [[ ! -f "components.json" ]]; then
    echo -e "${RED}❌ Error: components.json not found${NC}"
    echo "Run './scripts/setup.sh' first to configure registries"
    exit 1
fi

if [[ ! -f "registry-status.json" ]]; then
    echo -e "${RED}❌ Error: registry-status.json not found${NC}" 
    echo "Run './scripts/setup.sh' first to configure registries"
    exit 1
fi

echo "📋 Reading configuration..."

# Parse registries from components.json
registries=$(cat components.json | grep -A 100 '"registries"' | grep -E '^\s*"@[^"]+":' | sed 's/.*"\(@[^"]*\)".*/\1/' | tr '\n' ' ')

if [[ -z "$registries" ]]; then
    echo -e "${RED}❌ Error: No registries found in components.json${NC}"
    exit 1
fi

echo -e "${BLUE}Found registries:${NC} $registries"
echo ""

# Update status to initializing
current_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
expires_time=$(date -u -d "+1 day" +"%Y-%m-%dT%H:%M:%S.%3NZ")

tmp_status=$(mktemp)
cat registry-status.json | jq --arg time "$current_time" --arg expires "$expires_time" '
    .status = "initializing" | 
    .initialized_at = $time | 
    .expires_at = $expires |
    .validation_results = {} |
    .total_components = 0 |
    .last_error = null
' > "$tmp_status"
mv "$tmp_status" registry-status.json

echo "🧪 Validating registries..."

# Initialize validation results and component cache
validation_results="{}"
cache_registries="{}"
total_components=0
failed_registries=()

# Test each registry using shadcn CLI
for registry in $registries; do
    echo -n "  Testing $registry... "
    
    # Try to list components from this registry
    if timeout 30 npx shadcn@latest list "$registry" &>/dev/null; then
        echo -e "${GREEN}✅ Available${NC}"
        
        # Try to get component count and list
        echo -n "    Caching components... "
        
        # Use a different approach - try to get component list
        component_output=$(timeout 60 npx shadcn@latest list "$registry" 2>/dev/null || echo "")
        
        if [[ -n "$component_output" ]]; then
            # Count components (rough estimate)
            component_count=$(echo "$component_output" | grep -c "^[[:space:]]*[a-zA-Z0-9-]" 2>/dev/null || echo "0")
            
            # Extract component names (simplified)
            components=$(echo "$component_output" | grep "^[[:space:]]*[a-zA-Z0-9-]" | head -50 | tr '\n' ',' | sed 's/,$//' 2>/dev/null || echo "")
            
            # Add to cache
            cache_registries=$(echo "$cache_registries" | jq --arg reg "$registry" --argjson count "$component_count" --arg comps "$components" '
                .[$reg] = {
                    "component_count": $count,
                    "components": ($comps | split(",") | map(select(. != ""))),
                    "last_updated": now | strftime("%Y-%m-%dT%H:%M:%S.%3NZ")
                }
            ')
            
            total_components=$((total_components + component_count))
            echo -e "${GREEN}✅ $component_count components cached${NC}"
        else
            echo -e "${YELLOW}⚠️  Available but couldn't cache components${NC}"
            component_count=0
        fi
        
        # Mark as successful
        validation_results=$(echo "$validation_results" | jq --arg reg "$registry" '.[$reg] = true')
        
    else
        echo -e "${RED}❌ Failed${NC}"
        failed_registries+=("$registry")
        validation_results=$(echo "$validation_results" | jq --arg reg "$registry" '.[$reg] = false')
        
        # Add empty entry to cache
        cache_registries=$(echo "$cache_registries" | jq --arg reg "$registry" '
            .[$reg] = {
                "component_count": 0,
                "components": [],
                "last_updated": now | strftime("%Y-%m-%dT%H:%M:%S.%3NZ"),
                "error": "Registry validation failed"
            }
        ')
    fi
done

echo ""

# Update component cache
cache_content=$(jq -n --arg time "$current_time" --arg expires "$expires_time" --argjson registries "$cache_registries" '{
    "cache_created_at": $time,
    "expires_at": $expires,
    "registries": $registries
}')

echo "$cache_content" > registry-components-cache.json
echo -e "${GREEN}✅ Component cache updated${NC}"

# Determine final status
if [[ ${#failed_registries[@]} -eq 0 ]]; then
    final_status="completed"
    last_error="null"
    echo -e "${GREEN}🎉 All registries initialized successfully!${NC}"
else
    final_status="partial"
    last_error="Failed registries: ${failed_registries[*]}"
    echo -e "${YELLOW}⚠️  Some registries failed: ${failed_registries[*]}${NC}"
    echo "You can still use the working registries."
fi

# Update final status
tmp_status=$(mktemp)
cat registry-status.json | jq --arg status "$final_status" --argjson validation "$validation_results" --argjson total "$total_components" --arg error "$last_error" '
    .status = $status |
    .validation_results = $validation |
    .total_components = $total |
    .last_error = (if $error == "null" then null else $error end)
' > "$tmp_status"
mv "$tmp_status" registry-status.json

echo ""
echo "📊 Summary:"
echo -e "  ${BLUE}Total registries configured:${NC} $(echo $registries | wc -w)"
echo -e "  ${GREEN}Working registries:${NC} $(($(echo $registries | wc -w) - ${#failed_registries[@]}))"
echo -e "  ${RED}Failed registries:${NC} ${#failed_registries[@]}"
echo -e "  ${BLUE}Total components available:${NC} $total_components"
echo -e "  ${BLUE}Status:${NC} $final_status"

if [[ "$final_status" == "completed" ]]; then
    echo ""
    echo -e "${GREEN}✅ Ready to use! You can now add components:${NC}"
    echo -e "  ${BLUE}npx shadcn@latest add button${NC}"
    echo -e "  ${BLUE}npx shadcn@latest add @kokonutui/action-search-bar${NC}"
    echo ""
    echo -e "${GREEN}🤖 Claude Code agents can now use MCP tools safely.${NC}"
elif [[ "$final_status" == "partial" ]]; then
    echo ""
    echo -e "${YELLOW}⚠️  Partial setup complete. Working registries are ready to use.${NC}"
    echo -e "Consider removing failed registries from components.json for faster initialization."
    echo ""
    echo -e "${GREEN}🤖 Claude Code agents can use working registries.${NC}"
fi

echo ""