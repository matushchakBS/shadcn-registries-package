# Shadcn Registry Testing Results

## Summary
Tested 18 potential shadcn registries. **12 working**, **3 not found**, **3 separate CLIs**.

## ✅ Working Registries (12)

### Already Configured & Working in MCP
- **@cult** - https://cult-ui.com/r/{name}.json (82 components)
- **@kibo** - https://www.kibo-ui.com/r/{name}.json 
- **@reui** - https://reui.io/r/{name}.json

### Newly Added & Working
- **@kokonutui** - https://kokonutui.com/r/{name}.json (100+ components)
- **@magicui** - https://magicui.design/r/{name}.json
- **@neobrutalism** - https://neobrutalism.dev/r/{name}.json
- **@retroui** - https://retroui.dev/r/{name}.json
- **@animate-ui** - https://animate-ui.com/r/{name}.json
- **@diceui** - https://diceui.com/r/{name}.json
- **@icons-pqoqubbw** - https://icons.pqoqubbw.dev/c/{name}.json

### Direct URL Only (No Registry Config)
- **Origin UI (COSS)** - https://coss.com/origin/r/{comp}.json
- **ShadcnUI Blocks** - https://www.shadcnui-blocks.com/r/{name}.json
- **Jolly UI** - https://jollyui.dev/default/{name}

## ❌ Not Working (6)

### Not Found (3)
- **Skiper UI** - Domain offline (skiper-ui.dev)
- **Irsyad UI** - Domain not found (irsyadadl.com)
- **Eldora UI** - Domain offline (eldoraui.com)

### Separate CLIs (3)
- **AI Elements** - Uses `npx ai-elements@latest add`
- **ElevenLabs** - Uses `pnpm dlx @elevenlabs/cli@latest components add`
- **Kibo UI** - Also has `npx kibo-ui add` (but registry works too)

## Usage Recommendations

### For Modern Animations
- **@kokonutui** - 100+ components, Motion animations, Vercel OSS
- **@animate-ui** - Focus on transitions and motion
- **@cult** - Framer Motion components (already working)

### For Distinctive Styles
- **@neobrutalism** - Bold borders, distinctive aesthetic
- **@retroui** - Vintage/retro themes
- **@magicui** - Modern design patterns

### For Specialized Use Cases
- **@diceui** - Accessibility-focused components
- **@icons-pqoqubbw** - Animated icons with programmatic control
- **@reui** - Complex form components (already working)

### For Extended Functionality
- **@kibo** - Extends shadcn/ui with additional components (already working)

## Updated components.json
All working registries have been added to components.json. Total of **12 registries** now available for use.

## Testing Methodology Lessons
1. **Always test actual URLs first** before assumptions
2. **Check both with/without www subdomains**
3. **Some registries use separate CLIs** (not shadcn-compatible)
4. **MCP server caching requires restart** to pick up new registries
5. **Direct URL imports work even without registry config**