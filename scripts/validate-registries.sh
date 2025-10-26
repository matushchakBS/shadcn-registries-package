#!/bin/bash

# Shadcn Registries Package - Registry Validation Script
# This script tests all configured registries without updating cache

set -e

echo "🧪 Validating Shadcn Registries"
echo "==============================="
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

echo "📋 Reading configuration..."

# Parse registries from components.json
registries=$(cat components.json | grep -A 100 '"registries"' | grep -E '^\s*"@[^"]+":' | sed 's/.*"\(@[^"]*\)".*/\1/' | tr '\n' ' ')

if [[ -z "$registries" ]]; then
    echo -e "${RED}❌ Error: No registries found in components.json${NC}"
    exit 1
fi

registry_count=$(echo $registries | wc -w)
echo -e "${BLUE}Found $registry_count registries:${NC} $registries"
echo ""

echo "🔍 Testing registry connectivity..."

# Test each registry
working_count=0
failed_count=0
failed_registries=()

for registry in $registries; do
    echo -n "  Testing $registry... "
    
    # Try to access the registry
    if timeout 30 npx shadcn@latest list "$registry" &>/dev/null; then
        echo -e "${GREEN}✅ Available${NC}"
        ((working_count++))
    else
        echo -e "${RED}❌ Failed${NC}"
        ((failed_count++))
        failed_registries+=("$registry")
    fi
done

echo ""
echo "📊 Validation Results:"
echo -e "  ${BLUE}Total registries:${NC} $registry_count"
echo -e "  ${GREEN}Working:${NC} $working_count"
echo -e "  ${RED}Failed:${NC} $failed_count"

if [[ $failed_count -eq 0 ]]; then
    echo ""
    echo -e "${GREEN}🎉 All registries are working!${NC}"
    echo "Your setup is ready for use."
    exit_code=0
elif [[ $working_count -gt 0 ]]; then
    echo ""
    echo -e "${YELLOW}⚠️  Some registries failed:${NC}"
    for failed_reg in "${failed_registries[@]}"; do
        echo -e "    ${RED}• $failed_reg${NC}"
    done
    echo ""
    echo "💡 Suggestions:"
    echo "1. Check your internet connection"
    echo "2. Some registries may be temporarily offline"
    echo "3. Remove failed registries from components.json if issues persist"
    echo "4. Working registries can still be used normally"
    exit_code=1
else
    echo ""
    echo -e "${RED}❌ All registries failed!${NC}"
    echo ""
    echo "🔧 Troubleshooting steps:"
    echo "1. Check your internet connection"
    echo "2. Verify shadcn/ui is properly installed"
    echo "3. Try running: npx shadcn@latest list @shadcn"
    echo "4. Check if you're behind a corporate firewall"
    echo "5. Reset and reconfigure: ./scripts/reset-cache.sh"
    exit_code=2
fi

# Check if status file exists and update it
if [[ -f "registry-status.json" ]]; then
    echo ""
    echo "📝 Updating validation results in registry-status.json..."
    
    # Create validation results JSON
    validation_json="{}"
    for registry in $registries; do
        if [[ " ${failed_registries[*]} " =~ " $registry " ]]; then
            validation_json=$(echo "$validation_json" | jq --arg reg "$registry" '.[$reg] = false')
        else
            validation_json=$(echo "$validation_json" | jq --arg reg "$registry" '.[$reg] = true')
        fi
    done
    
    # Update status file
    current_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
    tmp_status=$(mktemp)
    
    cat registry-status.json | jq --argjson validation "$validation_json" --arg time "$current_time" '
        .validation_results = $validation |
        .last_validation = $time
    ' > "$tmp_status"
    mv "$tmp_status" registry-status.json
    
    echo -e "${GREEN}✅ Status file updated${NC}"
fi

echo ""

if [[ $exit_code -eq 0 ]]; then
    echo -e "${GREEN}✅ Validation complete - all registries working${NC}"
elif [[ $exit_code -eq 1 ]]; then
    echo -e "${YELLOW}⚠️  Validation complete - some registries failed${NC}"
else
    echo -e "${RED}❌ Validation complete - all registries failed${NC}"
fi

exit $exit_code