# Installation Instructions

## Prerequisites

### Required
- **Node.js 18+** with npm, pnpm, or yarn
- **shadcn/ui** already installed and configured in your project
- **Git** (for package management)

### Recommended
- **Claude Code CLI** (for agent integration)
- **Terminal with bash support**

## Installation Methods

### Method 1: Quick Setup (Recommended)

```bash
# 1. Copy package to your project root
cp -r /path/to/shadcn-registries-package ./

# 2. Run interactive setup
./shadcn-registries-package/scripts/setup.sh

# 3. Follow the prompts to select registries
# 4. Wait for validation and caching to complete
```

### Method 2: Manual Setup

```bash
# 1. Copy templates
cp shadcn-registries-package/templates/components.json.example ./components.json
cp shadcn-registries-package/templates/registry-status.json.template ./registry-status.json  
cp shadcn-registries-package/templates/registry-components-cache.json.template ./registry-components-cache.json

# 2. Edit components.json to include only desired registries
nano components.json

# 3. Initialize the registries
./shadcn-registries-package/scripts/init-registries.sh
```

### Method 3: Selective Installation

```bash
# 1. Start with empty components.json
cp shadcn-registries-package/templates/components.json.example ./components.json

# 2. Edit to include only specific registries:
# For animations: @aceternity, @eldoraui, @animate-ui, @cult
# For forms: @reui, @diceui
# For modern UI: @kokonutui, @magicui
# For distinctive: @neobrutalism, @retroui

# 3. Initialize
./shadcn-registries-package/scripts/init-registries.sh
```

## Registry Selection Guide

### Essential (Recommended for all projects)
```json
{
  "@shadcn": "https://ui.shadcn.com/registry/{name}.json",
  "@kokonutui": "https://kokonutui.com/r/{name}.json"
}
```

### Animation-Heavy Projects
```json
{
  "@aceternity": "https://ui.aceternity.com/registry/{name}.json",
  "@eldoraui": "https://eldoraui.site/r/{name}.json",
  "@animate-ui": "https://animate-ui.com/r/{name}.json",
  "@cult": "https://cult-ui.com/r/{name}.json"
}
```

### Form-Heavy Projects
```json
{
  "@reui": "https://reui.io/r/{name}.json",
  "@diceui": "https://diceui.com/r/{name}.json"
}
```

### Design-Focused Projects
```json
{
  "@magicui": "https://magicui.design/r/{name}.json",
  "@neobrutalism": "https://neobrutalism.dev/r/{name}.json",
  "@retroui": "https://retroui.dev/r/{name}.json"
}
```

### Specialized Components
```json
{
  "@kibo": "https://www.kibo-ui.com/r/{name}.json",
  "@icons-pqoqubbw": "https://icons.pqoqubbw.dev/c/{name}.json"
}
```

## Verification Steps

### 1. Check Installation
```bash
# Verify files exist
ls -la registry-status.json registry-components-cache.json components.json

# Check status
cat registry-status.json | grep status
# Should show: "status": "completed"
```

### 2. Test MCP Integration
```bash
# If using Claude Code CLI, test MCP tools
# (This will depend on your MCP setup)
```

### 3. Validate Registries
```bash
# Run validation script
./shadcn-registries-package/scripts/validate-registries.sh

# Check for any failures
cat registry-status.json | grep validation_results
```

## Post-Installation

### Using Components

```bash
# Official shadcn
npx shadcn@latest add button

# Registry-specific
npx shadcn@latest add @kokonutui/action-search-bar
npx shadcn@latest add @aceternity/meteors
npx shadcn@latest add @eldoraui/fade-text
```

### Maintenance

```bash
# Refresh cache (run daily or when needed)
./shadcn-registries-package/scripts/init-registries.sh

# Reset everything if issues occur
./shadcn-registries-package/scripts/reset-cache.sh

# Test all registries
./shadcn-registries-package/scripts/validate-registries.sh
```

## Troubleshooting

### Issue: "Registry not found"
```bash
# Check components.json format
cat components.json | jq '.registries'

# Reinitialize
./shadcn-registries-package/scripts/init-registries.sh
```

### Issue: "Status not completed"
```bash
# Check what failed
cat registry-status.json

# Reset and retry
./shadcn-registries-package/scripts/reset-cache.sh
./shadcn-registries-package/scripts/setup.sh
```

### Issue: "Cache expired"
```bash
# Simply refresh
./shadcn-registries-package/scripts/init-registries.sh
```

### Issue: Network/Registry Offline
```bash
# Check which registries failed
./shadcn-registries-package/scripts/validate-registries.sh

# Edit components.json to remove failing registries
nano components.json

# Reinitialize with working registries only
./shadcn-registries-package/scripts/init-registries.sh
```

## Security Considerations

- All registries are verified and tested
- Components are downloaded directly from official sources
- No third-party package installations required
- Cache files contain only component metadata

## Performance Tips

- Select only needed registries to reduce initialization time
- Cache is valid for 24 hours - no need to refresh more often
- Large registries (@shadcn, @kokonutui) take longer to initialize
- Use component cache file for fast lookups

## Integration with Build Tools

### Next.js
- Works out of the box with existing shadcn setup
- No additional configuration needed

### Vite
- Ensure tailwind.config includes component paths
- Verify alias resolution in vite.config

### Other Frameworks
- Follow standard shadcn/ui setup for your framework
- Registry components follow same patterns

## Uninstallation

```bash
# Remove package
rm -rf shadcn-registries-package/

# Remove generated files
rm registry-status.json registry-components-cache.json

# Revert components.json to your original version
# (backup recommended before installation)
```