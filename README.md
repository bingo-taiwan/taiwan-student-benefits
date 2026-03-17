# Taiwan Student Benefits Tracker

A Claude Code skill + cross-platform reminder system that helps Taiwan university students (`.edu.tw`) discover, track, and claim **50+ free subscriptions** worth over **$4,400/year**.

## What's Included

| Category | Examples | Count |
|----------|---------|-------|
| GitHub Student Pack | Copilot, DigitalOcean $200, Frontend Masters | 12 |
| Dev Tools & IDEs | JetBrains, Cursor Pro, Postman | 3 |
| Cloud & Hosting | Azure $100, AWS, Google Cloud $300, Oracle | 5 |
| Databases | Supabase, Neon | 2 |
| Design | Figma Pro, Autodesk, Miro | 3 |
| Productivity | Notion Plus, MS 365, Obsidian | 3 |
| Learning & Certs | Coursera, Kaggle, NVIDIA DLI, IBM | 5+ |
| Media | Spotify, Apple Music, YouTube Premium | 3 |
| AI Tools | Perplexity Pro | 1 |
| **Total** | | **37+ tracked** |

## Quick Start

### As a Claude Code Skill

1. Copy this repo into your Claude Code skills directory:
   ```bash
   # Clone
   git clone https://github.com/bingo-taiwan/taiwan-student-benefits.git

   # Symlink into Claude Code skills
   # Windows (PowerShell as Admin):
   New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\skills\taiwan-student-benefits" -Target "path\to\taiwan-student-benefits"

   # macOS / Linux:
   ln -s /path/to/taiwan-student-benefits ~/.claude/skills/taiwan-student-benefits
   ```

2. In Claude Code, just say:
   - "Help me set up student benefits tracking"
   - "What free subscriptions can I get with my .edu.tw email?"
   - "Set up student benefit reminders"

### Standalone (No Claude Code)

1. Copy `tracker_template.json` to `student_benefits_tracker.json`
2. Edit: fill in your `.edu.tw` email, remove benefits you don't want
3. Run the reminder script:

   **Windows:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts/check_benefits.ps1
   ```

   **macOS / Linux:**
   ```bash
   bash scripts/check_benefits.sh
   ```

## Setting Up Scheduled Reminders

### Windows (Task Scheduler)

```powershell
powershell -ExecutionPolicy Bypass -File scripts/setup_schedule.ps1
```

Creates a daily 09:00 reminder + weekly Monday tracker update prompt.

### macOS (launchd)

```bash
bash scripts/setup_schedule_macos.sh
```

Creates a daily 09:00 launchd job.

### Linux (cron)

```bash
chmod +x scripts/check_benefits.sh
(crontab -l 2>/dev/null; echo "0 9 * * * $(pwd)/scripts/check_benefits.sh") | crontab -
```

## How It Works

```
tracker_template.json          # 37 benefits with URLs and metadata
        │
        ▼
student_benefits_tracker.json  # Your personal copy (track progress)
        │
        ▼
check_benefits.ps1 / .sh      # Reads tracker, shows pending items
        │
        ▼
reminder.log                   # Append-only log of all reminders
        +
Desktop notification           # Windows toast / macOS / Linux notify
```

### Tracker Status Values

| Status | Meaning |
|--------|---------|
| `pending` | Not yet applied |
| `done` | Successfully claimed (set `done_date`) |
| `skipped` | Intentionally skipped |
| `expired` | Was claimed, needs renewal |

## Application Priority

### Week 1: Foundation (No Pack Needed)
1. **GitHub Student Pack** — gateway to 12+ services
2. **JetBrains** — all IDEs free, instant approval
3. **Azure** — $100 credits, no credit card
4. **Figma Education** — Professional plan, 2 years
5. **Notion Plus** — immediate productivity boost

### Week 2: After Pack Approval
6. **GitHub Copilot** — auto-enabled
7. **DigitalOcean** — $200 credits
8. **Frontend Masters** — 6 months
9. **1Password** — 1 year
10. **MongoDB Atlas** — $50 credits

### Week 3+: Everything Else
- AWS Educate, Google Cloud, Oracle Free Tier
- Coursera Financial Aid, Kaggle, NVIDIA DLI
- Spotify, Apple Music, YouTube Premium student discounts

## Requirements

- `.edu.tw` email address (active enrollment)
- **Windows script:** PowerShell 5.1+ (built-in on Windows 10/11)
- **macOS/Linux script:** bash + [jq](https://jqlang.github.io/jq/) (`brew install jq` / `apt install jq`)

## File Structure

```
taiwan-student-benefits/
├── SKILL.md                          # Claude Code skill definition
├── README.md                         # This file
├── tracker_template.json             # Template with all 37 benefits
├── references/
│   └── benefits-catalog.md           # Full catalog with URLs and notes
└── scripts/
    ├── check_benefits.ps1            # Windows reminder script
    ├── check_benefits.sh             # macOS/Linux reminder script
    ├── setup_schedule.ps1            # Windows Task Scheduler setup
    └── setup_schedule_macos.sh       # macOS launchd setup
```

## Contributing

Found a new student benefit? Benefit URL changed? PRs welcome!

To add a new benefit:
1. Add entry to `tracker_template.json`
2. Add entry to `references/benefits-catalog.md`
3. Submit a PR

## License

MIT

## Credits

- Benefits catalog based on [Taiwan Student Free Subscriptions Guide 2025-2026](https://claude-world.com/zh-tw/articles/taiwan-student-free-subscriptions-guide-2025-2026/)
- Built with [Claude Code](https://claude.ai/claude-code)
