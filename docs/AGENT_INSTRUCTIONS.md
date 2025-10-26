# Agent Instructions for Shadcn Registries Package

> **📚 PREREQUISITE**: You should have reached this file through `CLAUDE_AGENT_FIRST_READ.md`. If not, go read that file first, then complete `AGENT_DOCUMENTATION_CHECKLIST.md`.

## 🚨 CRITICAL HARD RULES FOR AGENTS

### Before ANY shadcn/MCP operations, agents MUST:

1. **Check `registry-status.json` exists** in the project root
2. **Verify status is "completed"** 
3. **Verify not expired** (expires_at > current timestamp)
4. **Verify documentation_read is true** - Agent has completed mandatory reading
5. **If ANY condition fails**: Guide user through initialization or documentation reading - DO NOT proceed with component operations

## 🔒 Initialization Gate

```json
// registry-status.json must look like this for agent to proceed:
{
  "status": "completed",
  "documentation_read": true, // Must be true for MCP operations
  "expires_at": "2025-10-27T10:30:00.000Z", // Must be future
  "selected_registries": ["@shadcn", "@aceternity", "..."],
  "validation_results": { /* all registries passed */ }
}
```

**If status is NOT "completed" or expires_at is past:**
```
❌ STOP: Registry initialization required
✅ Guide user: Run './scripts/setup.sh' to initialize registries
```

**If documentation_read is NOT true:**
```
❌ STOP: Agent documentation reading required
✅ Agent action: Complete AGENT_DOCUMENTATION_CHECKLIST.md first
```

## 📋 Agent Workflow

### 1. Pre-Check (MANDATORY)
```bash
# Agent should mentally verify:
1. registry-status.json exists
2. status === "completed" 
3. expires_at > now()
4. documentation_read === true
5. selected_registries is populated
```

### 2. Component Discovery
```bash
# Only after pre-check passes:
- Use mcp__shadcn__list_items_in_registries
- Use mcp__shadcn__search_items_in_registries  
- Use mcp__shadcn__view_items_in_registries
```

### 3. MANDATORY DEMO VIEWING
```bash
# HARD RULE: Before adding ANY component, MUST view demo:
- Use mcp__shadcn__get_item_examples_from_registries
- Show demo/example to user
- Get user approval before proceeding
- NO EXCEPTIONS: Every component addition requires demo viewing
```

### 4. Component Installation
```bash
# Only after demo approval:
- Use mcp__shadcn__get_add_command_for_items
- Execute the returned command

# Preferred order for component selection:
1. @shadcn (official)
2. @kokonutui (100+ components, modern)
3. @aceternity (91 components, animations)
4. @eldoraui (87 components, text animations)
5. @cult (82 components, framer motion)
6. Other configured registries
```

## 🎯 User Interaction Patterns

### When Registry Not Initialized
```
Agent: "I need to set up the shadcn registries first. This package includes 13 verified registries with 600+ components."

User: [agrees]

Agent: "Run this command to start interactive setup:"
`./scripts/setup.sh`

Agent: "I'll wait for you to complete the setup, then we can add components."
```

### When Cache Expired
```
Agent: "The registry cache has expired (24h limit). Let me refresh it:"
`./scripts/init-registries.sh`

Agent: "This ensures we have the latest component information."
```

### Registry Selection Guidance
```
Agent: "I recommend these registries for your use case:"

For animations: @aceternity, @eldoraui, @animate-ui, @cult
For forms: @reui, @diceui  
For modern UI: @kokonutui, @magicui
For distinctive style: @neobrutalism, @retroui
For icons: @icons-pqoqubbw
```

## 🔧 Error Handling

### Missing Status File
```javascript
if (!exists('registry-status.json')) {
  return "Registry not initialized. Run './scripts/setup.sh' first."
}
```

### Documentation Not Read
```javascript
const status = JSON.parse(readFile('registry-status.json'))
if (status.documentation_read !== true) {
  return "Agent must complete documentation reading checklist first. Reading CLAUDE_AGENT_FIRST_READ.md..."
}
```

### Expired Cache
```javascript
const status = JSON.parse(readFile('registry-status.json'))
if (new Date(status.expires_at) < new Date()) {
  return "Registry cache expired. Run './scripts/init-registries.sh' to refresh."
}
```

### Failed Registry
```javascript
if (status.validation_results[registry] === false) {
  return `Registry ${registry} failed validation. Check network or run './scripts/validate-registries.sh'`
}
```

## 📊 Component Cache Usage

Agents can read from `registry-components-cache.json` for:
- Fast component lookups
- Registry component counts
- Avoiding repeated API calls

Example:
```json
{
  "cache_created_at": "2025-10-26T...",
  "expires_at": "2025-10-27T...",
  "registries": {
    "@aceternity": {
      "component_count": 91,
      "components": ["grid", "moving-line", "sparkles", "..."]
    }
  }
}
```

## 🚀 Best Practices for Agents

### 1. Always Validate First
- Check status before any component operations
- Gracefully handle uninitialized state
- Guide users through setup process

### 2. Smart Registry Selection
- Prefer registries with known component counts
- Match registry specialization to user needs
- Suggest alternatives if first choice unavailable

### 3. Performance Optimization
- Use cached component lists when available
- Batch multiple component additions
- Avoid repeated registry validations

### 4. User Education
- Explain registry benefits during setup
- Suggest complementary components
- Share registry specializations

## 🔄 Maintenance Commands

Agents can suggest these to users:

```bash
# Reset everything and start fresh
./scripts/reset-cache.sh

# Just refresh component cache
./scripts/init-registries.sh

# Test all configured registries
./scripts/validate-registries.sh

# Interactive setup (choose different registries)
./scripts/setup.sh
```

## ⚠️ Common Pitfalls

1. **Skipping initialization check** - Always verify status first
2. **Ignoring cache expiration** - Respect 24-hour limit
3. **Not handling registry failures** - Some registries may go offline
4. **Poor registry selection** - Match specialization to user needs

## 📞 When Things Go Wrong

### Debug Checklist for Agents
1. ✅ `registry-status.json` exists and has `"status": "completed"`
2. ✅ `documentation_read` is `true` (agent has read docs)
3. ✅ `expires_at` is in the future
4. ✅ `selected_registries` array is populated
5. ✅ `validation_results` shows passing registries
6. ✅ `components.json` exists with matching registries
7. ✅ `registry-components-cache.json` has cached data

### Recovery Steps
```bash
# Nuclear option - reset everything
rm registry-status.json registry-components-cache.json
./scripts/setup.sh

# Gentle option - just refresh
./scripts/init-registries.sh
```

Remember: **User experience over automation**. Better to guide users through proper setup than fail silently.