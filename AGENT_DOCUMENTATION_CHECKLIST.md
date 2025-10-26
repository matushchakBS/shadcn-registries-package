# 📋 Agent Documentation Reading Checklist

## 🚨 MANDATORY: Complete this checklist before any shadcn operations

### Step 1: Read Core Instructions
- [ ] **CLAUDE_AGENT_FIRST_READ.md** - Critical rules and overview
  - Understand initialization requirements
  - Learn demo viewing hard rule
  - Note registry priority order

### Step 2: Read Detailed Agent Workflow
- [ ] **docs/AGENT_INSTRUCTIONS.md** - Complete workflow procedures
  - Master the 4-step workflow (pre-check → discovery → demo → install)
  - Understand error handling patterns
  - Learn user interaction templates
  - Review troubleshooting procedures

### Step 3: Read Usage Procedures  
- [ ] **docs/USAGE_GUIDE.md** - Component usage methodology
  - Learn component discovery workflow
  - Understand demo viewing requirements and analysis
  - Master registry-specific usage patterns
  - Learn performance considerations

### Step 4: Read Registry Knowledge
- [ ] **docs/REGISTRY_DETAILS.md** - Registry specializations
  - Understand each registry's strengths
  - Learn use case recommendations
  - Know component counts and capabilities
  - Understand performance implications

## ✅ Verification Questions

After reading all documentation, you should be able to answer:

1. **What are the 3 conditions that must be met before any shadcn operations?**
2. **What is the HARD RULE before adding any component?**
3. **What MCP tool is mandatory before component addition?**
4. **Which registries specialize in animations?**
5. **What is the recommended registry priority order?**
6. **How long does the component cache last?**
7. **What should you do if registry-status.json shows 'pending'?**
8. **Which registries are best for forms vs animations vs professional design?**

## 🚫 DO NOT PROCEED UNTIL:

- [ ] All 4 documentation files have been read
- [ ] You can answer all verification questions
- [ ] You understand the demo viewing workflow
- [ ] You know how to handle initialization failures

## 📝 Knowledge Summary Template

After reading, mentally confirm you understand:

```
✅ Initialization: Check registry-status.json for "completed" + not expired
✅ Demo Viewing: MUST use mcp__shadcn__get_item_examples_from_registries before adding
✅ User Approval: Show demo to user and get approval before proceeding  
✅ Registry Priority: @shadcn → @kokonutui → @aceternity → @eldoraui → @cult → others
✅ Error Handling: Guide user to ./scripts/setup.sh if not initialized
✅ Cache Management: 24-hour expiration, refresh with ./scripts/init-registries.sh
✅ Troubleshooting: Use ./scripts/validate-registries.sh to test registries
```

---

**Only proceed with shadcn operations after completing this entire checklist!**