#!/bin/bash
# macOS notification hook for Claude Code
# Sends native notifications when Claude needs input

# Silently fail if dependencies not installed
if ! command -v jq &> /dev/null || ! command -v terminal-notifier &> /dev/null; then
    exit 0
fi

INPUT=$(cat)
if [ -z "$INPUT" ]; then
    exit 0  # No input received
fi

NOTIFICATION_TYPE=$(printf '%s' "$INPUT" | jq -r '.notification_type // "unknown"' 2>/dev/null)
MESSAGE=$(printf '%s' "$INPUT" | jq -r '.message // "Claude needs your attention"' 2>/dev/null)

case "$NOTIFICATION_TYPE" in
  "permission_prompt")
    TITLE="🔐 Claude Permission Request"
    ;;
  "idle_prompt")
    TITLE="⏳ Claude Waiting for Input"
    ;;
  *)
    TITLE="🤖 Claude Code"
    ;;
esac

terminal-notifier -title "$TITLE" -message "$MESSAGE" -sound Submarine 2>/dev/null || true
