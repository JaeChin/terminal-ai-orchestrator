# Terminal AI Orchestrator

## Overview
A multi-agent AI orchestration system for terminal-based development workflows. Routes tasks to specialized AI agents (Claude, ChatGPT, Gemini) based on task type, maintains persistent context, and integrates with n8n for workflow automation.

## Tech Stack
- **Orchestration**: Custom routing logic with agent-specific system prompts
- **Agents**: Claude (primary), ChatGPT, Gemini (specialized tasks)
- **Automation**: n8n workflows
- **Scripts**: PowerShell (Windows), Bash (Linux/WSL)
- **Context**: Markdown-based memory and state management

## Project Structure
```
.claude/commands/    - Claude Code slash commands
agents/              - Agent system prompts and routing
  router.md          - Task routing logic
  claude/system.md   - Claude-specific instructions
  chatgpt/system.md  - ChatGPT-specific instructions
  gemini/system.md   - Gemini-specific instructions
  assistant/         - General assistant agent
  builder/           - Code generation agent
context/             - Runtime context and memory
  memory.md          - Persistent memory across sessions
  project_state.md   - Current project state
docs/                - Documentation and plans
  prd.md             - Product Requirements Document
  plans/             - Feature implementation plans
reference/           - Task-specific detailed guidance
  security-rules.md  - Security implementation rules
  api-patterns.md    - API development patterns
workflows/           - Project-specific workflows
  crm/               - CRM project tasks
  cybersecurity/     - Lab and security tasks
  portfolio/         - Portfolio updates
n8n/                 - n8n workflow automation
scripts/             - Automation scripts (PS1 + SH)
```

## Commands
- Run Claude agent: `./scripts/run-claude.ps1` or `./scripts/run-claude.sh`
- Run ChatGPT agent: `./scripts/run-chatgpt.ps1`
- Sync context: `./scripts/sync-context.sh`
- Route task: `./scripts/agent-router.sh`

## Code Conventions
- Use descriptive names for all files and functions
- Document agent prompts with clear purpose statements
- Keep system prompts focused—one responsibility per agent
- Version control all prompt changes (they're code)

## Security Requirements
- Never store API keys in files—use environment variables
- All secrets go in `.env` (which is gitignored)
- Document required env vars in `.env.example`
- Validate inputs before passing to external APIs
- Log agent interactions for debugging (not sensitive data)

## Agent Routing Rules
When deciding which agent to use:
- **Claude**: Complex reasoning, code review, security analysis, planning
- **ChatGPT**: Creative writing, brainstorming, general questions
- **Gemini**: Research, summarization, large context tasks
- **Builder**: Code generation, scaffolding, implementation
- **Assistant**: Quick tasks, simple queries, coordination

## Reference Documents
When working on specific areas, read the relevant reference:
- Security implementations: `reference/security-rules.md`
- API development: `reference/api-patterns.md`
- Agent prompt design: `agents/router.md`

## Before Completing Any Task
1. Verify changes don't break existing agent prompts
2. Test routing logic if modified
3. Update relevant documentation
4. Ensure no secrets are hardcoded