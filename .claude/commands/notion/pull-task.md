# Pull Task

Get the next task from Notion and prepare to work on it.

## Instructions

1. **Query** the Notion task database
2. **Filter** for tasks where:
   - Status = "Backlog" (prioritize) or "In Progress"
   - Project = current project (if known)
3. **Sort** by:
   - Priority (High → Medium → Low)
   - Created date (oldest first)
4. **Select** the top result

## Display Format
```
📋 NEXT TASK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Task: [title]
Priority: [High/Medium/Low]
Project: [project name]

Description:
[description text]

Acceptance Criteria:
[criteria text]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

5. **Ask**: "Start this task? I'll update status to 'In Progress'."
6. **If confirmed**: Update task status in Notion to "In Progress"