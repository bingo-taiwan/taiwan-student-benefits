#!/usr/bin/env bash
# Set up macOS launchd schedule for Student Benefits reminders
# Run once: bash setup_schedule_macos.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CHECK_SCRIPT="$SCRIPT_DIR/check_benefits.sh"
PLIST_DIR="$HOME/Library/LaunchAgents"
PLIST_FILE="$PLIST_DIR/com.student-benefits.reminder.plist"
LOG_FILE="$(dirname "$SCRIPT_DIR")/reminder.log"

if [ ! -f "$CHECK_SCRIPT" ]; then
    echo "[ERROR] check_benefits.sh not found at: $CHECK_SCRIPT"
    exit 1
fi

chmod +x "$CHECK_SCRIPT"
mkdir -p "$PLIST_DIR"

cat > "$PLIST_FILE" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.student-benefits.reminder</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$CHECK_SCRIPT</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>9</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$LOG_FILE</string>
    <key>StandardErrorPath</key>
    <string>$LOG_FILE</string>
    <key>RunAtLoad</key>
    <false/>
</dict>
</plist>
EOF

launchctl unload "$PLIST_FILE" 2>/dev/null || true
launchctl load "$PLIST_FILE"

echo "[OK] launchd job installed: com.student-benefits.reminder"
echo "     Schedule: daily at 09:00"
echo "     Log: $LOG_FILE"
echo ""
echo "To remove:"
echo "  launchctl unload $PLIST_FILE && rm $PLIST_FILE"
