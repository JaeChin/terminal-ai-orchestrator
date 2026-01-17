# Complete Task

Verify work and mark the current task as done in Notion.

## Instructions

1. **Identify** the current "In Progress" task from Notion
2. **Review** the acceptance criteria
3. **Run** /verify to check code quality
4. **If verification passes**:
   - Add a comment to the Notion task:
```
     ✅ Completed
     
     Files changed:
     - [list files]
     
     Notes:
     - [any implementation decisions]
     
     Verified: [timestamp]
```
   - Update Status to "Done"
5. **If verification fails**:
   - Report the issues
   - Add a comment explaining what needs fixing
   - Do NOT mark as done

## Output

- Confirmation message
- Summary of what was completed
- Ask: "Pull the next task?"