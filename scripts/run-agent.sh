#!/bin/bash
# Run Agent - Unified agent runner for role-based agents
# Usage: ./scripts/run-agent.sh plan "I want to build a CRM"

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default values
MODEL="claude-sonnet-4-5-20250929"
MAX_TOKENS=2000

# Colors
CYAN='\033[0;36m'
GRAY='\033[0;90m'
RED='\033[0;31m'
NC='\033[0m' # No Color

show_help() {
    cat << EOF
Terminal AI Orchestrator - Agent Runner

USAGE:
    ./scripts/run-agent.sh <agent> <prompt>

AGENTS:
    plan        Requirements gathering, research, blueprints
    architect   System design, tech stack, folder structure
    devsecops   Secure coding, infrastructure, CI/CD
    ui          Frontend styling, components, accessibility
    review      Code review, security audit, best practices
    debug       Systematic troubleshooting, root cause analysis

EXAMPLES:
    ./scripts/run-agent.sh plan "I want to build a secure CRM"
    ./scripts/run-agent.sh architect "Review this blueprint and design the system"
    ./scripts/run-agent.sh review "Check this code for security issues"
    ./scripts/run-agent.sh debug "API returns 500 errors intermittently"

OPTIONS:
    --model     Override model (default: claude-sonnet-4-5-20250929)
    --tokens    Override max tokens (default: 2000)
EOF
}

# Parse arguments
AGENT=""
PROMPT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --model)
            MODEL="$2"
            shift 2
            ;;
        --tokens)
            MAX_TOKENS="$2"
            shift 2
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        plan|architect|devsecops|ui|review|debug)
            AGENT="$1"
            shift
            ;;
        *)
            if [[ -n "$AGENT" ]]; then
                PROMPT="$PROMPT $1"
            else
                echo -e "${RED}Unknown agent: $1${NC}"
                echo "Valid agents: plan, architect, devsecops, ui, review, debug"
                exit 1
            fi
            shift
            ;;
    esac
done

# Trim leading space from prompt
PROMPT="${PROMPT# }"

# Show help if no agent
if [[ -z "$AGENT" ]]; then
    show_help
    exit 0
fi

# Check for prompt
if [[ -z "$PROMPT" ]]; then
    echo -e "${RED}No prompt provided.${NC}"
    echo "Usage: ./scripts/run-agent.sh $AGENT \"your prompt here\""
    exit 1
fi

# Load .env
if [[ -f "$PROJECT_ROOT/.env" ]]; then
    export $(grep -v '^#' "$PROJECT_ROOT/.env" | xargs)
fi

# Verify API key
if [[ -z "$ANTHROPIC_API_KEY" ]]; then
    echo -e "${RED}ANTHROPIC_API_KEY not set. Add it to .env file.${NC}"
    exit 1
fi

# Load agent system prompt
AGENT_PATH="$PROJECT_ROOT/agents/$AGENT/system.md"
if [[ ! -f "$AGENT_PATH" ]]; then
    echo -e "${RED}Agent not found: $AGENT_PATH${NC}"
    exit 1
fi

SYSTEM_PROMPT=$(cat "$AGENT_PATH")

# Load context if available
CONTEXT=""
CONTEXT_PATH="$PROJECT_ROOT/context/memory.md"
if [[ -f "$CONTEXT_PATH" ]]; then
    CONTEXT="\n\n## Context from Previous Sessions:\n$(cat "$CONTEXT_PATH")"
fi

# Build JSON payload (escape special characters)
ESCAPED_SYSTEM=$(echo "$SYSTEM_PROMPT" | jq -Rs .)
ESCAPED_PROMPT=$(echo "$PROMPT$CONTEXT" | jq -Rs .)

JSON_BODY=$(cat <<EOF
{
    "model": "$MODEL",
    "max_tokens": $MAX_TOKENS,
    "system": $ESCAPED_SYSTEM,
    "messages": [
        {
            "role": "user",
            "content": $ESCAPED_PROMPT
        }
    ]
}
EOF
)

# Make API request
RESPONSE=$(curl -s -X POST "https://api.anthropic.com/v1/messages" \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    -d "$JSON_BODY")

# Check for errors
if echo "$RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
    ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error.message')
    echo -e "${RED}API Error: $ERROR_MSG${NC}"
    exit 1
fi

# Extract and display response
CONTENT=$(echo "$RESPONSE" | jq -r '.content[0].text // empty')

if [[ -z "$CONTENT" ]]; then
    echo -e "${RED}Agent returned no content.${NC}"
    echo "Raw response: $RESPONSE"
    exit 1
fi

echo ""
echo -e "${CYAN}[${AGENT^^} AGENT]${NC}"
echo -e "${GRAY}==================================================${NC}"
echo "$CONTENT"
echo -e "${GRAY}==================================================${NC}"