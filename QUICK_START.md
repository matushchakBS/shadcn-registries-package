# 🚀 Quick Start Guide

## 30-Second Setup

```bash
# 1. Copy package to your project
cp -r /path/to/shadcn-registries-package ./

# 2. Run interactive setup
./shadcn-registries-package/scripts/setup.sh

# 3. Start using components
npx shadcn@latest add @kokonutui/action-search-bar
```

## 🎯 Recommended Setups

### For Most Projects (Recommended)
```bash
# Select option 2: "@shadcn + @kokonutui"
# Gets you: 549+ components with modern animations
```

### For Animation-Heavy Projects
```bash
# Select option 3: "Animation Pack"  
# Gets you: @shadcn + @kokonutui + @aceternity + @eldoraui + @cult
# Total: 700+ components including spectacular effects
```

### For Production Applications
```bash
# Select option 4: "Full Stack"
# Gets you: @shadcn + @kokonutui + @reui + @diceui + @magicui
# Focus: Professional UI + forms + accessibility
```

## 🤖 For Claude Code Agents

**CRITICAL:** Agents must read `CLAUDE_AGENT_FIRST_READ.md` first!

**Quick Check:**
```javascript
// Agent must verify BEFORE any shadcn operations:
const status = JSON.parse(readFile('registry-status.json'))
if (status.status !== 'completed' || new Date(status.expires_at) < new Date()) {
  return "Run './scripts/setup.sh' to initialize registries first"
}
```

**🚨 HARD RULE: DEMO VIEWING MANDATORY**
Before adding ANY component, agents MUST:
1. Use `mcp__shadcn__get_item_examples_from_registries` to view demo
2. Show demo to user for approval
3. Only then proceed with component addition

## 📦 What You Get

- **13 Tested Registries** - All verified working
- **600+ Components** - From basic to advanced
- **Smart Caching** - 24-hour cache for performance  
- **Agent Safety** - Built-in validation for AI assistants
- **Easy Maintenance** - Simple scripts for updates

## 🔧 Common Commands

```bash
# Setup new project
./scripts/setup.sh

# Refresh cache  
./scripts/init-registries.sh

# Test all registries
./scripts/validate-registries.sh

# Reset everything
./scripts/reset-cache.sh
```

## 🎨 Component Examples

```bash
# Official components
npx shadcn@latest add button card table

# Modern animations  
npx shadcn@latest add @kokonutui/action-search-bar
npx shadcn@latest add @aceternity/meteors
npx shadcn@latest add @eldoraui/fade-text

# Distinctive styles
npx shadcn@latest add @neobrutalism/accordion
npx shadcn@latest add @retroui/button

# Forms & accessibility
npx shadcn@latest add @reui/combobox-group
npx shadcn@latest add @diceui/input-group

# Specialized
npx shadcn@latest add @icons-pqoqubbw/activity
```

## 🚨 Troubleshooting

### "Registry not initialized"
```bash
./scripts/setup.sh
```

### "Cache expired"  
```bash
./scripts/init-registries.sh
```

### "Registry failed"
```bash
# Test which ones work
./scripts/validate-registries.sh

# Remove broken ones from components.json
# Re-initialize
./scripts/init-registries.sh
```

### "MCP tools not working"
```bash
# Ensure status is completed
cat registry-status.json | grep status

# Should show: "status": "completed"
# If not, run setup again
```

## 💡 Pro Tips

1. **Start small** - Use "Recommended" setup first
2. **Add gradually** - Test components before committing
3. **Cache wisely** - 24h cache means no need to refresh often  
4. **Monitor status** - Check `registry-status.json` if issues
5. **Agent safety** - Always verify initialization before using MCP tools

## 📞 Need Help?

1. Check `docs/` folder for detailed guides
2. Review `test-results/` for registry testing data
3. Run `./scripts/validate-registries.sh` to diagnose issues
4. Reset with `./scripts/reset-cache.sh` if stuck

---

**Ready to build amazing UIs? Start with `./scripts/setup.sh`!** 🎨