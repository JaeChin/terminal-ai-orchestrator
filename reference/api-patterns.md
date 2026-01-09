# API Integration Patterns

## Calling AI APIs

### Standard Pattern
```
1. Load API key from environment
2. Construct request with system prompt
3. Add user message/context
4. Make request with error handling
5. Parse and validate response
6. Handle rate limits and retries
```

### Error Handling
- Catch and log API errors
- Implement exponential backoff for rate limits
- Provide fallback behavior when APIs fail
- Don't expose raw API errors to users

## Agent Communication
- Pass context via structured prompts
- Keep conversation history manageable
- Clear context between unrelated tasks
- Use router to select appropriate agent