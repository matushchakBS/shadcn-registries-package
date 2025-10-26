# Shadcn Extended Registries Package

A comprehensive collection of **13 tested and verified shadcn/ui registries** with over **600+ components** for modern React applications.

## 🎯 What This Package Provides

- **13 Working Registries** - All tested and verified
- **600+ Components** - From animations to device mockups
- **Automated Setup** - CLI-guided installation
- **Smart Caching** - Component lists cached for performance
- **Agent Integration** - Full Claude Code/CLI agent support
- **Project Reusability** - Easy setup across multiple projects

## 📦 Included Registries

| Registry | Components | Specialization |
|----------|------------|----------------|
| @shadcn | 449 | Official components |
| @aceternity | 91 | Animated UI effects |
| @eldoraui | 87 | Text animations & device mockups |
| @cult | 82 | Modern animated components |
| @kokonutui | 100+ | Motion animations, Vercel OSS |
| @kibo | Unknown | Extended shadcn functionality |
| @reui | Unknown | Complex form components |
| @magicui | Unknown | Professional design patterns |
| @neobrutalism | Unknown | Bold, distinctive design |
| @retroui | Unknown | Vintage/retro themes |
| @animate-ui | Unknown | Motion & transitions |
| @diceui | Unknown | Accessibility-focused |
| @icons-pqoqubbw | Unknown | Animated icons |

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ with npm/pnpm/yarn
- shadcn/ui already installed in your project
- Claude Code CLI (for agent integration)

### Installation
```bash
# Copy this package to your project
cp -r shadcn-registries-package ./

# Run the setup script
./shadcn-registries-package/scripts/setup.sh

# Follow the interactive prompts to select registries
```

**After successful installation**: See `docs/USAGE_GUIDE.md` for component discovery, demo viewing, and usage patterns.

## 🔧 Manual Setup

1. **Copy templates to your project root:**
   ```bash
   cp shadcn-registries-package/templates/components.json.example ./components.json
   cp shadcn-registries-package/templates/registry-status.json.template ./registry-status.json
   cp shadcn-registries-package/templates/registry-components-cache.json.template ./registry-components-cache.json
   ```

2. **Edit `components.json`** to include only the registries you want

3. **Initialize the registries:**
   ```bash
   ./shadcn-registries-package/scripts/init-registries.sh
   ```

## 🤖 Agent Integration

### For Claude Code CLI Agents

**HARD RULE**: Before using any MCP shadcn tools, agents MUST:

1. Check `registry-status.json` exists
2. Verify `status` is `"completed"`
3. Verify `expires_at` is not older than 24 hours
4. If either condition fails, guide user through initialization

### Agent Instructions
**CRITICAL**: Agents must complete `AGENT_DOCUMENTATION_CHECKLIST.md` before any operations.

**Reading Sequence:**
1. `CLAUDE_AGENT_FIRST_READ.md` - Critical rules overview
2. `AGENT_DOCUMENTATION_CHECKLIST.md` - Mandatory reading checklist  
3. Complete all 4 documentation files as specified
4. Verify understanding before proceeding

**HARD RULE**: Before adding any component, agents MUST use `mcp__shadcn__get_item_examples_from_registries` to view demos and get user approval.

## 📁 File Structure

```
shadcn-registries-package/
├── README.md                           # This file
├── QUICK_START.md                      # 30-second setup guide
├── CLAUDE_AGENT_FIRST_READ.md          # Critical agent rules
├── AGENT_DOCUMENTATION_CHECKLIST.md   # Mandatory reading checklist
├── docs/
│   ├── INSTALLATION.md                 # Detailed setup guide
│   ├── USAGE_GUIDE.md                  # Post-installation usage
│   ├── AGENT_INSTRUCTIONS.md           # Agent integration rules
│   └── REGISTRY_DETAILS.md             # Registry descriptions
├── templates/
│   ├── components.json.example         # Full registry configuration
│   ├── registry-status.json.template   # Tracking file template
│   └── registry-components-cache.json.template
├── scripts/
│   ├── setup.sh                       # Interactive setup
│   ├── init-registries.sh             # Registry initialization
│   ├── reset-cache.sh                 # Clear cache and reset
│   └── validate-registries.sh         # Test all registries
└── test-results/
    ├── registry-testing-results.json  # Detailed test data
    └── registry-testing-summary.md    # Testing methodology
```

## 🔄 Cache Management

- Component lists are cached for 24 hours
- Cache automatically refreshes when expired
- Manual refresh: `./scripts/init-registries.sh`
- Reset everything: `./scripts/reset-cache.sh`

## ⚡ Performance

- **Smart Caching**: Component lists cached to avoid repeated API calls
- **Selective Loading**: Choose only needed registries
- **Batch Validation**: All registries tested at once during setup
- **Status Tracking**: Prevents incomplete configurations

## 🛠 Troubleshooting

### Registry Not Working
```bash
# Validate all registries
./scripts/validate-registries.sh

# Reset and reinitialize
./scripts/reset-cache.sh
./scripts/setup.sh
```

### Cache Issues
```bash
# Clear cache and restart
rm registry-components-cache.json
./scripts/init-registries.sh
```

### Agent Issues
- Check `registry-status.json` has `"status": "completed"`
- Verify cache is not expired
- Ensure all selected registries passed validation

## 📄 License

This package configuration is MIT licensed. Individual registry components follow their respective licenses.

## 🤝 Contributing

Found a new working registry? Please:
1. Test it thoroughly
2. Add to test results
3. Update documentation
4. Submit a pull request

## 📞 Support

- Check `test-results/` for registry testing details
- Review `docs/` for detailed documentation
- Validate setup with included scripts