# Debug

Activate the Debug Agent for systematic troubleshooting.

## Usage
Describe the problem. Include:
- What's happening (symptoms)
- What should happen (expected)
- Error messages or logs
- Recent changes

The agent will:
1. Gather information systematically
2. Form ranked hypotheses
3. Test each hypothesis methodically
4. Find and document root cause

## When to Use
- Something is broken
- Intermittent failures
- Need to find root cause
- "It works on my machine" situations

## Debugging Protocol
1. **Gather** — Collect all relevant information
2. **Hypothesize** — Rank possible causes
3. **Test** — Verify each hypothesis
4. **Document** — Record root cause and fix

## Do NOT
- Make random changes
- Skip straight to "solutions"
- Ignore the evidence

## Output
Root Cause Analysis document with:
- What caused the bug
- How to fix it
- How to prevent it in the future

## Next Step
After fix identified: `/review` to verify the fix