# Shadcn Registry Testing Results

## Latest Test: 2026-02-22 (via shadcn MCP tools)
## Previous Test: 2025-10-26 (via URL fetching)

---

## Summary
Tested 15 configured registries via `mcp__shadcn__list_items_in_registries`. **11 fully working**, **1 partial**, **3 broken**.

## Fully Working Registries (10) - Full MCP Support

| Registry | Items | URL Pattern | Specialization |
|----------|-------|-------------|----------------|
| **@shadcn** | 403 | `https://ui.shadcn.com/registry/{name}.json` | Official core components |
| **@aceternity** | 101 | `https://ui.aceternity.com/registry/{name}.json` | Advanced animations & effects |
| **@cult** | 98 | `https://cult-ui.com/r/{name}.json` | Framer Motion components |
| **@kibo** | 41 | `https://www.kibo-ui.com/r/{name}.json` | Extended shadcn functionality |
| **@kokonutui** | 40 | `https://kokonutui.com/r/{name}.json` | Modern animations, Vercel OSS |
| **@magicui** | 207 | `https://magicui.design/r/{name}.json` | Professional design patterns |
| **@retroui** | 97 | `https://retroui.dev/r/{name}.json` | Vintage/retro themes |
| **@animate-ui** | 580 | `https://animate-ui.com/r/{name}.json` | Motion & transitions (largest!) |
| **@diceui** | 239 | `https://diceui.com/r/{name}.json` | Accessibility-focused |
| **@eldoraui** | 115 | `https://eldoraui.site/r/{name}.json` | Text animations & device mockups |
| **@ai-elements** | 77 | `https://registry.ai-sdk.dev/{name}.json` | AI-native components (Vercel AI SDK) |

**Total: ~1,998 discoverable items across 11 registries**

## Partially Working Registries (1) - Individual Items Only

| Registry | URL Pattern | Issue |
|----------|-------------|-------|
| **@neobrutalism** | `https://neobrutalism.dev/r/{name}.json` | No `registry.json` index. `list` and `search` MCP calls fail, but `view_items` works if you know the component name (e.g. `@neobrutalism/accordion`). |

## Broken Registries (3) - Not Working

| Registry | URL Pattern | Error | Notes |
|----------|-------------|-------|-------|
| **@reui** | `https://reui.io/r/{name}.json` | 404 on registry.json AND individual items | Was working 2025-10-26, now dead |
| **@icons-pqoqubbw** | `https://icons.pqoqubbw.dev/c/{name}.json` | 404 on registry.json AND individual items | Was working 2025-10-26, now dead |
| **@originui** | `https://originui.com/r/{name}.json` | Returns HTML, not JSON | Wrong URL. Old test used `https://coss.com/origin/r/{comp}.json` which may still work |

---

## Changes Since Previous Test (2025-10-26)

### Registries That Died
- **@reui** - Domain returns 404 for all endpoints
- **@icons-pqoqubbw** - Domain returns 404 for all endpoints

### Component Count Changes
| Registry | Old Count | New Count | Change |
|----------|-----------|-----------|--------|
| @shadcn | 449 | 403 | -46 (restructured?) |
| @aceternity | 91 | 101 | +10 |
| @cult | 82 | 98 | +16 |
| @kibo | unknown | 41 | now known |
| @kokonutui | 100+ | 40 | -60 (restructured or was overcounted) |
| @magicui | unknown | 207 | now known |
| @retroui | unknown | 97 | now known |
| @animate-ui | unknown | 580 | now known (largest registry!) |
| @diceui | unknown | 239 | now known |
| @eldoraui | 87 | 115 | +28 |
| @neobrutalism | unknown | N/A | no index, individual items work |

### New Discovery
- **@originui** is in the live `components.json` at `/Users/pavlo/cogni-base/components.json` but uses wrong URL (`originui.com` instead of `coss.com`)

---

## Usage Recommendations (Updated)

### For Animations (Best Options)
- **@animate-ui** - 580 items, largest animation registry
- **@aceternity** - 101 items, spectacular visual effects
- **@eldoraui** - 115 items, text animations & device mockups
- **@cult** - 98 items, Framer Motion components

### For Professional/Production UI
- **@shadcn** - 403 items, official foundation
- **@magicui** - 207 items, professional design patterns
- **@diceui** - 239 items, accessibility-focused

### For Distinctive Styles
- **@neobrutalism** - Bold brutalist aesthetic (partial MCP support)
- **@retroui** - 97 items, vintage/retro themes

### For Extended Functionality
- **@kibo** - 41 items, extends shadcn with utilities
- **@kokonutui** - 40 items, modern components, Vercel OSS

---

## Registries NOT in components.json (from previous test, untested in MCP)

These were tested via direct URL in 2025-10-26 but never added to `components.json`:
- **Origin UI (COSS)** - `https://coss.com/origin/r/{comp}.json` (was working)
- **ShadcnUI Blocks** - `https://www.shadcnui-blocks.com/r/{name}.json` (was working)
- **Jolly UI** - `https://jollyui.dev/default/{name}` (was working)

### Separate CLIs (not shadcn-compatible)
- **AI Elements** - `npx ai-elements@latest add`
- **ElevenLabs** - `pnpm dlx @elevenlabs/cli@latest components add`

### Confirmed Dead (from previous test)
- **Skiper UI** - Domain offline (skiper-ui.dev)
- **Irsyad UI** - Domain not found (irsyadadl.com)

---

## Testing Methodology
1. Configured all registries in `components.json`
2. Used `mcp__shadcn__get_project_registries` to verify MCP sees them
3. Used `mcp__shadcn__list_items_in_registries` per registry (limit=3) to test index
4. For failed registries, used `mcp__shadcn__search_items_in_registries` to test search
5. For still-failed registries, used `mcp__shadcn__view_items_in_registries` with known item names to test direct access
