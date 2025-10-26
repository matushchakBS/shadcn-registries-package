# Usage Guide - Post-Installation

> **📚 PREREQUISITE**: This file should be read as part of the agent documentation sequence. If you haven't completed `AGENT_DOCUMENTATION_CHECKLIST.md`, do that first.

## 🚨 CRITICAL RULE FOR AGENTS: DEMO VIEWING MANDATORY

### **HARD RULE**: Before adding ANY component, agents MUST:
1. ✅ View component demo using `mcp__shadcn__get_item_examples_from_registries`
2. ✅ Show demo to user for approval  
3. ✅ Only then proceed with component addition

**Example workflow:**
```javascript
// 1. Search for component
mcp__shadcn__search_items_in_registries(["@kokonutui"], "search bar")

// 2. MANDATORY: Get demo/example
mcp__shadcn__get_item_examples_from_registries(["@kokonutui"], "action-search-bar-demo")

// 3. Show demo to user: "Here's how this component looks and works..."

// 4. Get user approval: "Should I add this component?"

// 5. Only if approved: Get add command and proceed
mcp__shadcn__get_add_command_for_items(["@kokonutui/action-search-bar"])
```

## 🎯 Component Discovery Workflow

### Step 1: Search Components
```bash
# Use MCP tool to search registries
mcp__shadcn__search_items_in_registries(["@kokonutui", "@aceternity"], "button")
```

### Step 2: View Component Details  
```bash
# Get detailed component information
mcp__shadcn__view_items_in_registries(["@kokonutui/action-search-bar"])
```

### Step 3: **MANDATORY DEMO VIEWING**
```bash
# CRITICAL: Always check demo before adding
mcp__shadcn__get_item_examples_from_registries(["@kokonutui"], "action-search-bar-demo")
```

### Step 4: Get Add Command
```bash
# Only after demo approval
mcp__shadcn__get_add_command_for_items(["@kokonutui/action-search-bar"])
```

### Step 5: Execute Addition
```bash
# Run the returned command
npx shadcn@latest add @kokonutui/action-search-bar
```

## 📦 Registry-Specific Component Usage

### @shadcn (Official - 449 components)
```bash
# Basic components - usually no demos needed for standard ones
npx shadcn@latest add button
npx shadcn@latest add card  
npx shadcn@latest add table
npx shadcn@latest add dialog

# But still check demos for complex components
mcp__shadcn__get_item_examples_from_registries(["@shadcn"], "data-table-demo")
```

### @kokonutui (Modern - 100+ components)
```bash
# Always view demos for these modern components
mcp__shadcn__get_item_examples_from_registries(["@kokonutui"], "action-search-bar-demo")
npx shadcn@latest add @kokonutui/action-search-bar

mcp__shadcn__get_item_examples_from_registries(["@kokonutui"], "feature-card-demo")  
npx shadcn@latest add @kokonutui/feature-card
```

### @aceternity (Animations - 91 components)
```bash
# Demos are ESSENTIAL for animation components
mcp__shadcn__get_item_examples_from_registries(["@aceternity"], "meteors-demo")
npx shadcn@latest add @aceternity/meteors

mcp__shadcn__get_item_examples_from_registries(["@aceternity"], "parallax-scroll-demo")
npx shadcn@latest add @aceternity/parallax-scroll
```

### @eldoraui (Text Animations - 87 components)
```bash
# Text animation demos show different effects
mcp__shadcn__get_item_examples_from_registries(["@eldoraui"], "fade-text-demo")
npx shadcn@latest add @eldoraui/fade-text

mcp__shadcn__get_item_examples_from_registries(["@eldoraui"], "wavy-text-demo")
npx shadcn@latest add @eldoraui/wavy-text
```

### @cult (Interactive - 82 components)  
```bash
# Interactive component demos show behavior
mcp__shadcn__get_item_examples_from_registries(["@cult"], "neumorph-button-demo")
npx shadcn@latest add @cult/neumorph-button
```

## 🎨 Component Selection Best Practices

### For Animations (Always View Demos!)
```bash
# Search animation registries
mcp__shadcn__search_items_in_registries(["@aceternity", "@eldoraui", "@animate-ui"], "text animation")

# MANDATORY: View demos for each candidate
mcp__shadcn__get_item_examples_from_registries(["@eldoraui"], "gradual-spacing-text-demo")
mcp__shadcn__get_item_examples_from_registries(["@aceternity"], "text-generate-effect-demo")

# Show user: "Here are two text animation options..."
# Get approval, then add selected component
```

### For Forms
```bash
# Search form registries  
mcp__shadcn__search_items_in_registries(["@reui", "@diceui"], "input group")

# View form component demos
mcp__shadcn__get_item_examples_from_registries(["@reui"], "combobox-group-demo")
mcp__shadcn__get_item_examples_from_registries(["@diceui"], "input-group-demo")
```

### For Styling/Design
```bash
# Distinctive style registries
mcp__shadcn__search_items_in_registries(["@neobrutalism", "@retroui"], "button")

# Style demos are crucial for design decisions
mcp__shadcn__get_item_examples_from_registries(["@neobrutalism"], "accordion-demo")
mcp__shadcn__get_item_examples_from_registries(["@retroui"], "button-demo")
```

## 🔍 Demo Analysis Guidelines

### What to Look For in Demos
1. **Visual Appearance** - Does it match the design needs?
2. **Animation Behavior** - Is the motion appropriate?
3. **Responsive Design** - How does it adapt to screen sizes?
4. **Interaction Patterns** - Are the UX patterns suitable?
5. **Dependencies** - What additional libraries are required?
6. **Performance Impact** - Heavy animations for simple needs?

### Demo Viewing Script for Agents
```javascript
// Template for agents viewing demos
async function viewComponentDemo(registry, componentName) {
  // 1. Get demo
  const demo = await mcp__shadcn__get_item_examples_from_registries([registry], `${componentName}-demo`)
  
  // 2. Analyze demo content
  const analysis = {
    visual: "Clean, modern design with subtle animations",
    behavior: "Smooth hover effects, responsive layout", 
    dependencies: "Requires framer-motion for animations",
    useCase: "Perfect for modern landing pages"
  }
  
  // 3. Present to user
  return `Here's how the ${componentName} component works:

**Visual:** ${analysis.visual}
**Behavior:** ${analysis.behavior}  
**Dependencies:** ${analysis.dependencies}
**Best For:** ${analysis.useCase}

Demo code: [show demo implementation]

Should I add this component to your project?`
}
```

## 🚀 Common Usage Patterns

### Landing Page Components
```bash
# Hero sections
mcp__shadcn__get_item_examples_from_registries(["@kokonutui"], "hero-demo")
mcp__shadcn__get_item_examples_from_registries(["@aceternity"], "spotlight-demo")

# Features sections  
mcp__shadcn__get_item_examples_from_registries(["@kokonutui"], "feature-grid-demo")

# Testimonials
mcp__shadcn__get_item_examples_from_registries(["@eldoraui"], "testimonial-slider-demo")
```

### Dashboard Components
```bash
# Data visualization
mcp__shadcn__get_item_examples_from_registries(["@shadcn"], "chart-demo")
mcp__shadcn__get_item_examples_from_registries(["@magicui"], "stats-demo")

# Navigation
mcp__shadcn__get_item_examples_from_registries(["@shadcn"], "sidebar-demo")
```

### E-commerce Components
```bash
# Product displays
mcp__shadcn__get_item_examples_from_registries(["@magicui"], "product-card-demo")

# Shopping features
mcp__shadcn__get_item_examples_from_registries(["@reui"], "cart-demo")
```

## 🔧 Maintenance Commands

### Cache Management
```bash
# Refresh component cache (run daily or when needed)
./scripts/init-registries.sh

# Check cache status
cat registry-components-cache.json | jq '.expires_at'
```

### Registry Health
```bash
# Test all registries
./scripts/validate-registries.sh

# Check status
cat registry-status.json | jq '.validation_results'
```

### Troubleshooting Component Issues
```bash
# If component not found
mcp__shadcn__list_items_in_registries(["@kokonutui"], 50)

# If demo not available
mcp__shadcn__search_items_in_registries(["@kokonutui"], "search-bar")

# If registry seems offline  
./scripts/validate-registries.sh
```

## 📊 Performance Considerations

### Component Bundle Impact
- **@shadcn**: Minimal impact, tree-shakeable
- **@kokonutui**: Moderate, includes animations
- **@aceternity**: Heavy animations, use selectively  
- **@eldoraui**: Medium, text-focused animations
- **@cult**: Medium, interactive components

### Loading Strategy
```bash
# Load core components first
npx shadcn@latest add button card input

# Add animations progressively
npx shadcn@latest add @eldoraui/fade-text  # Light
npx shadcn@latest add @aceternity/meteors   # Heavy
```

## 🎯 Component Replacement Workflow

### Upgrading Components
```bash
# 1. Find better alternatives
mcp__shadcn__search_items_in_registries(["@kokonutui", "@magicui"], "button")

# 2. View demos for comparison
mcp__shadcn__get_item_examples_from_registries(["@kokonutui"], "button-demo")
mcp__shadcn__get_item_examples_from_registries(["@magicui"], "button-demo")

# 3. Show user both options
# 4. Replace old component with new one
```

## 🔗 Integration with Existing Components

### Mixing Registries
- ✅ **Good combos**: @shadcn + @kokonutui (consistent)
- ✅ **Animation stack**: @aceternity + @eldoraui + @cult
- ✅ **Professional**: @shadcn + @magicui + @diceui
- ⚠️ **Avoid mixing**: @neobrutalism + @magicui (conflicting styles)

### Design System Consistency
```bash
# Establish base with shadcn
npx shadcn@latest add button card input

# Add consistent modern touches
npx shadcn@latest add @kokonutui/feature-card
npx shadcn@latest add @magicui/stats-display

# Avoid style conflicts
# Don't mix @neobrutalism with professional registries
```

---

**Remember: ALWAYS view demos before adding components. It's not just best practice—it's mandatory for quality user experience!** 🎯