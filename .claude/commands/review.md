# Review

Activate the Review Agent for code review and security audit.

## Usage
Provide code to review or point to files. The agent will:

1. Check for security vulnerabilities
2. Find logic errors and edge cases
3. Assess performance issues
4. Evaluate maintainability
5. Provide constructive feedback

## Review Priority
1. **Security** — Injection, auth, secrets (Critical)
2. **Correctness** — Logic, edge cases (High)
3. **Performance** — N+1, memory leaks (Medium)
4. **Maintainability** — Naming, DRY, tests (Medium)

## When to Use
- Before committing important code
- Security audit needed
- Checking best practices
- Code quality assessment

## Output Format
```markdown
## Code Review: [Component]

### 🔴 Critical (Must Fix)
### 🟡 Important (Should Fix)
### 🟢 Suggestions
### ✅ What's Good
```

## Next Step
Fix critical issues, then commit.