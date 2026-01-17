# Git Commit

Prepare and execute a commit for current changes.

## Steps

1. Show `git status`
2. Show `git diff --stat`
3. Generate commit message:
   - Format: `type(scope): description`
   - Types: feat, fix, docs, refactor, chore, style, test
   - Keep description under 50 characters
   - Add body if needed for context
4. Stage changes: `git add -A`
5. Commit with generated message
6. Show commit log

## Commit Message Format

```
type(scope): short description

[optional body with more detail]

[optional footer with breaking changes or issue refs]
```

## Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `style`: Formatting, missing semicolons, etc.
- `test`: Adding or fixing tests
- `chore`: Maintenance tasks

## Examples
- `feat(auth): add JWT refresh token flow`
- `fix(api): handle null response from user service`
- `docs(readme): add setup instructions`
- `refactor(db): extract query builder to separate module`

## Rules
- Do NOT push. Local commit only.
- If there are untracked files that shouldn't be committed, mention them.
- If the diff is large, summarize the key changes in the commit body.