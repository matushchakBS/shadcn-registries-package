#!/bin/bash

# Shadcn Registries Package - Interactive Setup Script
# This script guides users through registry selection and initialization

set -e

echo "🎨 Shadcn Extended Registries Setup"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check if shadcn is installed
if ! command -v npx &> /dev/null; then
    echo -e "${RED}❌ Error: npx not found. Please install Node.js and npm.${NC}"
    exit 1
fi

# Check if we're in a valid project directory
if [[ ! -f "package.json" ]]; then
    echo -e "${RED}❌ Error: No package.json found. Please run this from your project root.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Prerequisites check passed${NC}"
echo ""

# Registry configuration
declare -A REGISTRIES=(
    ["@shadcn"]="https://ui.shadcn.com/registry/{name}.json|Official shadcn/ui components (449 components)|essential"
    ["@kokonutui"]="https://kokonutui.com/r/{name}.json|Modern animated components (100+ components)|recommended"
    ["@aceternity"]="https://ui.aceternity.com/registry/{name}.json|Advanced animations & effects (91 components)|animation"
    ["@eldoraui"]="https://eldoraui.site/r/{name}.json|Text animations & device mockups (87 components)|animation"
    ["@cult"]="https://cult-ui.com/r/{name}.json|Framer Motion components (82 components)|animation"
    ["@kibo"]="https://www.kibo-ui.com/r/{name}.json|Extended shadcn functionality|utility"
    ["@reui"]="https://reui.io/r/{name}.json|Complex form components|forms"
    ["@magicui"]="https://magicui.design/r/{name}.json|Professional design patterns|design"
    ["@neobrutalism"]="https://neobrutalism.dev/r/{name}.json|Bold, distinctive aesthetics|style"
    ["@retroui"]="https://retroui.dev/r/{name}.json|Vintage/retro themes|style"
    ["@animate-ui"]="https://animate-ui.com/r/{name}.json|Motion & transitions|animation"
    ["@diceui"]="https://diceui.com/r/{name}.json|Accessibility-focused components|accessibility"
    ["@icons-pqoqubbw"]="https://icons.pqoqubbw.dev/c/{name}.json|Animated icons|icons"
)

# Show available registries
echo "📦 Available Registries:"
echo ""
echo -e "${BLUE}Essential:${NC}"
for registry in "${!REGISTRIES[@]}"; do
    IFS='|' read -r url description category <<< "${REGISTRIES[$registry]}"
    if [[ "$category" == "essential" ]]; then
        echo "  ✨ $registry - $description"
    fi
done

echo ""
echo -e "${BLUE}Recommended:${NC}"
for registry in "${!REGISTRIES[@]}"; do
    IFS='|' read -r url description category <<< "${REGISTRIES[$registry]}"
    if [[ "$category" == "recommended" ]]; then
        echo "  🌟 $registry - $description"
    fi
done

echo ""
echo -e "${BLUE}Specialized:${NC}"
for registry in "${!REGISTRIES[@]}"; do
    IFS='|' read -r url description category <<< "${REGISTRIES[$registry]}"
    if [[ "$category" != "essential" && "$category" != "recommended" ]]; then
        echo "  🔧 $registry - $description ($category)"
    fi
done

echo ""
echo "💡 Setup Options:"
echo "1) Essential Only (@shadcn)"
echo "2) Recommended (@shadcn + @kokonutui)"  
echo "3) Animation Pack (@shadcn + @kokonutui + @aceternity + @eldoraui + @cult)"
echo "4) Full Stack (@shadcn + @kokonutui + @reui + @diceui + @magicui)"
echo "5) All Registries (13 registries)"
echo "6) Custom Selection"
echo ""

read -p "Choose setup option (1-6): " choice

selected_registries=()

case $choice in
    1)
        selected_registries=("@shadcn")
        echo -e "${GREEN}✅ Essential setup selected${NC}"
        ;;
    2)
        selected_registries=("@shadcn" "@kokonutui")
        echo -e "${GREEN}✅ Recommended setup selected${NC}"
        ;;
    3)
        selected_registries=("@shadcn" "@kokonutui" "@aceternity" "@eldoraui" "@cult")
        echo -e "${GREEN}✅ Animation pack selected${NC}"
        ;;
    4)
        selected_registries=("@shadcn" "@kokonutui" "@reui" "@diceui" "@magicui")
        echo -e "${GREEN}✅ Full stack setup selected${NC}"
        ;;
    5)
        selected_registries=("${!REGISTRIES[@]}")
        echo -e "${GREEN}✅ All registries selected${NC}"
        ;;
    6)
        echo ""
        echo "🎛️  Custom Selection Mode"
        echo "Select registries (y/n for each):"
        echo ""
        
        for registry in "${!REGISTRIES[@]}"; do
            IFS='|' read -r url description category <<< "${REGISTRIES[$registry]}"
            read -p "Include $registry ($description)? [y/N]: " include
            if [[ "$include" =~ ^[Yy]$ ]]; then
                selected_registries+=("$registry")
                echo -e "  ${GREEN}✅ Added $registry${NC}"
            fi
        done
        ;;
    *)
        echo -e "${RED}❌ Invalid option. Exiting.${NC}"
        exit 1
        ;;
esac

if [[ ${#selected_registries[@]} -eq 0 ]]; then
    echo -e "${RED}❌ No registries selected. Exiting.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}📋 Selected Registries (${#selected_registries[@]}):${NC}"
for registry in "${selected_registries[@]}"; do
    echo "  • $registry"
done

echo ""
read -p "Proceed with installation? [Y/n]: " confirm
if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "🔧 Setting up registries..."

# Create components.json with selected registries
echo "📝 Creating components.json..."

# Start with base configuration
cat > components.json << 'EOF'
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "new-york",
  "rsc": true,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "src/app/globals.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "iconLibrary": "lucide",
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib",
    "hooks": "@/hooks"
  },
  "registries": {
EOF

# Add selected registries
first=true
for registry in "${selected_registries[@]}"; do
    IFS='|' read -r url description category <<< "${REGISTRIES[$registry]}"
    if [[ "$first" == "true" ]]; then
        first=false
    else
        echo "," >> components.json
    fi
    echo "    \"$registry\": \"$url\"" >> components.json
done

# Close JSON
cat >> components.json << 'EOF'
  }
}
EOF

echo -e "${GREEN}✅ components.json created${NC}"

# Create tracking files
echo "📝 Creating tracking files..."

# Create registry-status.json
current_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
expires_time=$(date -u -d "+1 day" +"%Y-%m-%dT%H:%M:%S.%3NZ")

cat > registry-status.json << EOF
{
  "status": "initializing",
  "initialized_at": "$current_time",
  "expires_at": "$expires_time",
  "selected_registries": [
$(printf '    "%s"' "${selected_registries[0]}")
$(for registry in "${selected_registries[@]:1}"; do printf ',\n    "%s"' "$registry"; done)
  ],
  "validation_results": {},
  "component_cache_file": "registry-components-cache.json",
  "last_error": null,
  "total_components": 0,
  "notes": "Status must be 'completed' and not expired for CLI agents to proceed"
}
EOF

echo -e "${GREEN}✅ registry-status.json created${NC}"

# Create empty cache file
cat > registry-components-cache.json << EOF
{
  "cache_created_at": "$current_time",
  "expires_at": "$expires_time",
  "registries": {}
}
EOF

echo -e "${GREEN}✅ registry-components-cache.json created${NC}"

echo ""
echo "🔍 Initializing registries..."

# Run initialization script
if [[ -f "shadcn-registries-package/scripts/init-registries.sh" ]]; then
    ./shadcn-registries-package/scripts/init-registries.sh
else
    echo -e "${YELLOW}⚠️  init-registries.sh not found. Run it manually after setup.${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo ""
echo "📚 Next Steps:"
echo "1. Check registry-status.json for initialization results"
echo "2. Start adding components:"
echo "   ${BLUE}npx shadcn@latest add button${NC}"
echo "   ${BLUE}npx shadcn@latest add @kokonutui/action-search-bar${NC}"
echo "3. See docs/ folder for detailed usage instructions"
echo ""
echo "🤖 For Claude Code agents:"
echo "The registry is ready when registry-status.json shows 'completed' status"
echo ""