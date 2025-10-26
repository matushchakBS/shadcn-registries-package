#!/bin/bash

# Shadcn Registries Package - Reset Cache Script
# This script clears all tracking files and resets to initial state

set -e

echo "🔄 Resetting Shadcn Registries Cache"
echo "====================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${YELLOW}⚠️  This will reset all registry initialization and cache data.${NC}"
echo "Files that will be reset:"
echo "  • registry-status.json"
echo "  • registry-components-cache.json"
echo ""
echo "Your components.json will be preserved."
echo ""

read -p "Continue with reset? [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Reset cancelled."
    exit 0
fi

echo ""
echo "🧹 Clearing cache files..."

# Remove existing tracking files
if [[ -f "registry-status.json" ]]; then
    rm registry-status.json
    echo -e "${GREEN}✅ Removed registry-status.json${NC}"
fi

if [[ -f "registry-components-cache.json" ]]; then
    rm registry-components-cache.json
    echo -e "${GREEN}✅ Removed registry-components-cache.json${NC}"
fi

# Copy fresh templates if available
if [[ -f "shadcn-registries-package/templates/registry-status.json.template" ]]; then
    cp shadcn-registries-package/templates/registry-status.json.template registry-status.json
    echo -e "${GREEN}✅ Created fresh registry-status.json${NC}"
fi

if [[ -f "shadcn-registries-package/templates/registry-components-cache.json.template" ]]; then
    cp shadcn-registries-package/templates/registry-components-cache.json.template registry-components-cache.json
    echo -e "${GREEN}✅ Created fresh registry-components-cache.json${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Cache reset complete!${NC}"
echo ""
echo "📋 Next steps:"
echo "1. Run setup to reconfigure registries:"
echo "   ${BLUE}./shadcn-registries-package/scripts/setup.sh${NC}"
echo ""
echo "2. Or run initialization if components.json is already configured:"
echo "   ${BLUE}./shadcn-registries-package/scripts/init-registries.sh${NC}"
echo ""