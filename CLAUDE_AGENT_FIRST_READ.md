# 🚨 CRITICAL INSTRUCTIONS FOR CLAUDE CODE AGENTS

## HARD RULE: READ THIS FIRST BEFORE ANY SHADCN OPERATIONS

### 📚 MANDATORY DOCUMENTATION READING

**Before proceeding with ANY shadcn operations, you MUST:**

1. **Read `AGENT_DOCUMENTATION_CHECKLIST.md`** - Complete reading checklist
2. **Read all 4 documentation files** as specified in the checklist
3. **Verify your understanding** using the checklist questions
4. **ONLY THEN** proceed with shadcn operations

**Files you MUST read (in order):**
1. **This file** (`CLAUDE_AGENT_FIRST_READ.md`) - Overview and critical rules
2. **`docs/AGENT_INSTRUCTIONS.md`** - Detailed workflow and error handling  
3. **`docs/USAGE_GUIDE.md`** - Component discovery and demo viewing procedures
4. **`docs/REGISTRY_DETAILS.md`** - Registry specializations and recommendations

**🚫 HARD RULE: DO NOT skip reading any documentation. Each file contains critical procedures that prevent errors and ensure quality user experience.**

### 🔒 MANDATORY PRE-CHECK

Before using ANY MCP shadcn tools or adding components, you MUST:

1. **Check if `registry-status.json` exists** in the project root
2. **Verify status is "completed"** 
3. **Verify expires_at is not older than 24 hours**
4. **Verify documentation_read is true** - Ensures agent has read all required docs

### 🚫 IF ANY CONDITION FAILS: STOP AND GUIDE USER

```bash
# You are NOT ALLOWED to proceed with component operations if:
- registry-status.json does not exist
- status is not "completed" 
- expires_at timestamp is in the past
- documentation_read is not true (agent must read docs first)
```

### ✅ REQUIRED STATUS FORMAT

```json
{
  "status": "completed",
  "documentation_read": true,
  "expires_at": "2025-10-27T10:30:00.000Z",
  "selected_registries": ["@shadcn", "@kokonutui", "..."],
  "registry_priorities": {
    "@shadcn": 1,
    "@kokonutui": 2,
    "@eldoraui": 3
  },
  "validation_results": { /* all registries must be true */ }
}
```

### 🚨 AGENT RESPONSIBILITY

**YOU ARE RESPONSIBLE FOR:**
- Checking initialization status before ANY shadcn operations
- Guiding users through proper setup if not initialized
- NOT bypassing these safety checks
- Ensuring user experience is smooth and reliable

### 🔧 USER GUIDANCE

**If registry not initialized, tell user:**
```
"I need to set up the shadcn registries first. This package includes 13 verified registries with 600+ components.

Run this command to start setup:
./shadcn-registries-package/scripts/setup.sh

I'll wait for you to complete the setup, then we can add components."
```

**If documentation_read is false, tell user:**
```
"The registries are set up, but I need to read the documentation first to safely use the MCP tools.

Let me complete the mandatory documentation reading checklist, then I can help you add components."
```

### 📋 QUICK REFERENCE

- **Setup script**: `./scripts/setup.sh` (interactive)
- **Initialize**: `./scripts/init-registries.sh` (if components.json exists)
- **Reset**: `./scripts/reset-cache.sh` (if issues)
- **Validate**: `./scripts/validate-registries.sh` (test only)

## ⚡ AFTER SUCCESSFUL INITIALIZATION

Once status is "completed" and not expired, you can safely use:
- `mcp__shadcn__list_items_in_registries`
- `mcp__shadcn__search_items_in_registries`
- `mcp__shadcn__view_items_in_registries`
- `mcp__shadcn__get_item_examples_from_registries` **← MANDATORY BEFORE ADDING**
- `mcp__shadcn__get_add_command_for_items`

## 🚨 CRITICAL: DEMO VIEWING MANDATORY

**HARD RULE:** Before adding ANY component, you MUST:
1. Use `mcp__shadcn__get_item_examples_from_registries` to get demo
2. Show demo/example to user 
3. Get user approval
4. ONLY then proceed with `mcp__shadcn__get_add_command_for_items`

**NO EXCEPTIONS - Every component addition requires demo viewing first!**

## 🎯 REGISTRY PRIORITY ORDER

**CRITICAL**: Agents MUST respect the priority order defined in `registry_priorities` field of registry-status.json.

**Default Priority Order (when no custom priorities set):**
1. @shadcn (official, 449 components)
2. @kokonutui (modern, 100+ components)  
3. @aceternity (animations, 91 components)
4. @eldoraui (text animations, 87 components)
5. @cult (interactions, 82 components)
6. Other configured registries

**Why Priority Matters:**
- **Component Selection**: When multiple registries have similar components, choose from higher priority registry
- **User Experience**: Ensures consistent design system by preferring certain registries
- **Performance**: Reduces decision overhead by having clear preference order
- **Project Consistency**: Maintains cohesive component selection across sessions

---

**REMEMBER: User experience > automation. Better to guide proper setup than fail silently.**