# Terminal AI Orchestrator - Product Requirements Document

## Mission
Build a terminal-based AI orchestration system that intelligently routes tasks to specialized AI agents, maintains persistent context across sessions, and automates repetitive workflows.

## Target User
- Primary: Jaedon Chin (developer/learning tool)
- Secondary: Developers who want multi-agent AI assistance

## Problem Statement
Single AI assistants have limitations. Different models excel at different tasks. Manually switching between tools and maintaining context is inefficient. This system solves that by:
1. Routing tasks to the best agent automatically
2. Maintaining memory and context across sessions
3. Automating common workflows via n8n

## In Scope (MVP)
- [ ] Agent routing based on task type
- [ ] Claude, ChatGPT, and Gemini agent configurations
- [ ] Persistent memory system
- [ ] Basic n8n workflow integration
- [ ] Cross-platform scripts (Windows + Linux)
- [ ] Claude Code integration with custom commands

## Out of Scope (Future)
- Web UI for orchestration
- Real-time agent collaboration
- Custom model fine-tuning
- Public API

## Architecture

### Components
1. **Router** (`agents/router.md`) - Decides which agent handles a task
2. **Agents** (`agents/*/system.md`) - Specialized system prompts per AI
3. **Context** (`context/`) - Memory and state persistence
4. **Scripts** (`scripts/`) - Execution layer for running agents
5. **Workflows** (`workflows/`) - Project-specific task definitions
6. **n8n** (`n8n/`) - Automation triggers and workflows

### Data Flow
```
User Task → Router → Select Agent → Load Context → Execute → Update Memory
```

## Success Criteria
- Can route tasks to correct agent 90%+ of the time
- Context persists across terminal sessions
- Setup works on both Windows and WSL
- Documented well enough to explain in interviews

## Current Status
- [x] Basic directory structure
- [x] Agent system prompts created
- [x] Cross-platform scripts
- [ ] Claude Code commands
- [ ] Reference documentation
- [ ] Comprehensive README
- [ ] n8n workflow testing