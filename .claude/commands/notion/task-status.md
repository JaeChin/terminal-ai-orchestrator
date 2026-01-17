# Task Status

Show current project status from Notion.

## Instructions

1. **Query** all tasks for the current project
2. **Group** by status and count:
   - 📥 Backlog: X tasks
   - 🔨 In Progress: X tasks
   - ✅ Done: X tasks
   - 🚫 Blocked: X tasks

## Display Format
```
📊 PROJECT STATUS: [Project Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📥 Backlog:      [X] tasks
🔨 In Progress:  [X] tasks
✅ Done:         [X] tasks
🚫 Blocked:      [X] tasks
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total:           [X] tasks
Progress:        [X]% complete
```

3. **If any blocked**: List them with reasons
4. **If any in progress**: Show what's currently being worked on
```

---

## Part 4: How the Workflow Works

Here's the complete cycle:
```
┌─────────────────────────────────────────────────────────────┐
│                    NOTION TASK WORKFLOW                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────┐                                             │
│  │   PLANNING  │                                             │
│  └──────┬──────┘                                             │
│         │                                                    │
│         ▼                                                    │
│  /plan-to-notion ──────► Notion Database                     │
│  "Add user auth"         [Task 1: Backlog]                   │
│                          [Task 2: Backlog]                   │
│                          [Task 3: Backlog]                   │
│                                                              │
│  ┌─────────────┐                                             │
│  │  BUILDING   │                                             │
│  └──────┬──────┘                                             │
│         │                                                    │
│         ▼                                                    │
│  /pull-task ◄──────────── [Task 1: In Progress]              │
│         │                                                    │
│         ▼                                                    │
│  [Write code]                                                │
│         │                                                    │
│         ▼                                                    │
│  /verify                                                     │
│         │                                                    │
│         ▼                                                    │
│  /complete-task ────────► [Task 1: Done ✅]                  │
│         │                                                    │
│         ▼                                                    │
│  /pull-task ◄──────────── [Task 2: In Progress]              │
│         │                                                    │
│        ...                                                   │
│                                                              │
│  ┌─────────────┐                                             │
│  │ MONITORING  │                                             │
│  └──────┬──────┘                                             │
│         │                                                    │
│         ▼                                                    │
│  /task-status ─────────► "3 done, 2 backlog, 1 blocked"      │
│                                                              │
└─────────────────────────────────────────────────────────────┘