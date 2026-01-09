# Security Implementation Rules

## API Key Management
- Store all API keys in `.env`
- Reference via environment variables only
- Document required vars in `.env.example`
- Never log API keys or tokens

## Agent Security
- Validate all inputs before passing to agents
- Sanitize agent outputs before using in commands
- Don't allow agents to execute arbitrary code without review
- Log agent interactions (excluding sensitive data)

## Context Security
- Don't store passwords or tokens in context files
- Memory files should contain summaries, not raw secrets
- Workspace configs should reference env vars, not values

## Script Security
- Validate parameters before execution
- Don't pass unsanitized user input to shells
- Use proper quoting in bash scripts
- Handle errors explicitly

## n8n Security
- Use credential stores for API keys
- Validate webhook inputs
- Don't expose internal endpoints publicly