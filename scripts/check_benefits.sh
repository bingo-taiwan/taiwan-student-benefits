#!/usr/bin/env bash
# Student Benefits Reminder (macOS / Linux)
# Reads tracker.json and shows pending benefits with desktop notification

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
TRACKER="${1:-$BASE_DIR/student_benefits_tracker.json}"
LOG="${2:-$BASE_DIR/reminder.log}"
NOW=$(date '+%Y-%m-%d %H:%M')

log() { echo "$1" | tee -a "$LOG"; }

DIVIDER="======================================================="

# --- Check tracker exists ---
if [ ! -f "$TRACKER" ]; then
    log "[ERROR] Tracker not found: $TRACKER"
    log "Run the skill first to generate student_benefits_tracker.json"
    exit 1
fi

# --- Requires jq ---
if ! command -v jq &>/dev/null; then
    log "[ERROR] jq is required but not installed."
    log "Install: brew install jq (macOS) or apt install jq (Linux)"
    exit 1
fi

log "$DIVIDER"
log "Student Benefits Reminder - $NOW"
log "$DIVIDER"

# --- Parse tracker ---
PACK_STATUS=$(jq -r '.github_pack_status' "$TRACKER")

log ""
log "[GitHub Student Pack] Status: $PACK_STATUS"

if [ "$PACK_STATUS" = "not_applied" ]; then
    log "  >>> Apply now: https://education.github.com/pack"
    log "  This unlocks 12+ premium services worth ~\$2,200/yr"
fi

# --- Count by status ---
TOTAL=$(jq '.benefits | length' "$TRACKER")
DONE=$(jq '[.benefits[] | select(.status == "done")] | length' "$TRACKER")
SKIPPED=$(jq '[.benefits[] | select(.status == "skipped")] | length' "$TRACKER")
PENDING_COUNT=0
PACK_WAIT_COUNT=0

log ""

# --- Show actionable (pending + no pack requirement OR pack approved) ---
ACTIONABLE=$(jq -r --arg ps "$PACK_STATUS" '
  [.benefits[] | select(
    .status == "pending" and
    (.requires_pack == false or $ps == "approved")
  )] | sort_by(.id)' "$TRACKER")

PENDING_COUNT=$(echo "$ACTIONABLE" | jq 'length')

if [ "$PENDING_COUNT" -gt 0 ]; then
    log "[ACTION REQUIRED] $PENDING_COUNT benefits ready to claim:"
    echo "$ACTIONABLE" | jq -r '.[] | "  [ ] \(.name) (\(.value // "free"))\n      \(.url)"' | while IFS= read -r line; do
        log "$line"
    done
fi

# --- Show pack-dependent ---
if [ "$PACK_STATUS" != "approved" ]; then
    PACK_WAIT=$(jq -r '[.benefits[] | select(.status == "pending" and .requires_pack == true)] | sort_by(.id)' "$TRACKER")
    PACK_WAIT_COUNT=$(echo "$PACK_WAIT" | jq 'length')

    if [ "$PACK_WAIT_COUNT" -gt 0 ]; then
        log ""
        log "[WAITING FOR PACK] $PACK_WAIT_COUNT benefits need GitHub Pack approval first:"
        echo "$PACK_WAIT" | jq -r '.[] | "  [~] \(.name) (\(.value // "free"))"' | while IFS= read -r line; do
            log "$line"
        done
    fi
fi

# --- Summary ---
log ""
log "Summary: $PENDING_COUNT actionable | $PACK_WAIT_COUNT waiting for Pack | $DONE done"
log "Tracker: $TRACKER"
log "$DIVIDER"

# --- Desktop notification ---
if [ "$PENDING_COUNT" -gt 0 ]; then
    if command -v osascript &>/dev/null; then
        osascript -e "display notification \"$PENDING_COUNT items need your attention. Check reminder.log\" with title \"Student Benefits\" sound name \"Glass\"" 2>/dev/null || true
    elif command -v notify-send &>/dev/null; then
        notify-send "Student Benefits" "$PENDING_COUNT items need your attention. Check reminder.log" 2>/dev/null || true
    fi
fi
