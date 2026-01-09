# Git Commit

Prepare and execute a commit for current changes.

## Steps

1. Show `git status`
2. Show `git diff --stat`
3. Generate commit message:
   - Format: `type(scope): description`
   - Types: feat, fix, docs, refactor, chore, agent, workflow
   - Scopes: agents, context, scripts, workflows, n8n, docs
4. Stage changes: `git add -A`
5. Commit with generated message
6. Show commit log

## Examples
- `feat(agents): add specialized research agent`
- `fix(router): correct task routing for code reviews`
- `docs(readme): add setup instructions`
- `agent(claude): improve system prompt for planning`

Do NOT push. Local commit only.