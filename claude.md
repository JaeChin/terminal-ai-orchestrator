# Terminal AI Orchestrator

## Overview
A multi-agent AI orchestration system for terminal-based development workflows. Routes tasks to specialized role-based agents, maintains persistent context, and integrates with n8n for workflow automation.

## Tech Stack
- **Orchestration**: Role-based agents with specialized system prompts
- **Automation**: n8n workflows
- **Scripts**: PowerShell (Windows), Bash (Linux/WSL)
- **Context**: Markdown-based memory and state management

## Project Structure
```
.claude/commands/    - Slash commands for agent invocation
  plan.md            - /plan command
  architect.md       - /architect command
  devsecops.md       - /devsecops command
  ui.md              - /ui command
  review.md          - /review command
  debug.md           - /debug command
  prime.md           - /prime command (load context)
  commit.md          - /commit command
  verify.md          - /verify command
  execute.md         - /execute command
  evolve.md          - /evolve command

agents/              - Agent system prompts
  router.md          - Task routing logic
  plan/system.md     - Requirements & research agent
  architect/system.md - System design agent
  devsecops/system.md - Security & infrastructure agent
  ui/system.md       - Frontend & styling agent
  review/system.md   - Code review agent
  debug/system.md    - Troubleshooting agent

context/             - Runtime context and memory
  memory.md          - Persistent memory across sessions
  project_state.md   - Current project state

docs/                - Documentation and plans
  prd.md             - Product Requirements Document
  plans/             - Feature blueprints and architectures

reference/           - Task-specific guidance
  security-rules.md  - Security implementation rules
  api-patterns.md    - API development patterns

workflows/           - Project-specific workflows
n8n/                 - n8n workflow automation
scripts/             - Automation scripts
```

## Agent Commands

| Command | Agent | Use When |
|---------|-------|----------|
| `/plan` | Plan | Starting new project, gathering requirements |
| `/architect` | Architect | Designing system, choosing tech stack |
| `/devsecops` | DevSecOps | Writing secure code, setting up infrastructure |
| `/ui` | UI | Building frontend, styling, accessibility |
| `/review` | Review | Code review, security audit |
| `/debug` | Debug | Something is broken, need root cause |

## Workflow Commands

| Command | Purpose |
|---------|---------|
| `/prime` | Load project context |
| `/commit` | Prepare and execute git commit |
| `/verify` | Verify implementation quality |
| `/execute` | Execute a saved plan |
| `/evolve` | Analyze session for improvements |

## Standard Workflows

### New Project
```
/plan → /architect → /devsecops + /ui → /review → /commit
```

### Bug Fix
```
/debug → /review → fix → /commit
```

### Feature Addition
```
/plan (scope) → /architect → implement → /review → /commit
```

## Code Conventions
- Use descriptive names for all files and functions
- Document agent prompts with clear purpose statements
- Keep system prompts focused—one responsibility per agent
- Version control all prompt changes (they're code)

## Security Requirements
- Never store API keys in files—use environment variables
- All secrets go in `.env` (gitignored)
- Document required env vars in `.env.example`
- Validate inputs before passing to external APIs
- Log agent interactions for debugging (not sensitive data)

## Before Completing Any Task
1. Verify changes follow agent system prompts
2. Test routing logic if modified
3. Update relevant documentation
4. Ensure no secrets are hardcoded
5. Run `/verify` before `/commit`