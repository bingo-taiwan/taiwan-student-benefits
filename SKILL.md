---
name: taiwan-student-benefits
description: "Taiwan .edu.tw student benefits tracker and reminder system. Discovers, tracks, and reminds students of 50+ free subscriptions and credits available to Taiwan university students (GitHub Student Pack, JetBrains, Azure, Figma, Notion, etc.). Use this skill whenever the user mentions: student benefits, edu.tw perks, free student subscriptions, GitHub Student Pack, student developer tools, academic discounts Taiwan, or wants to set up benefit tracking/reminders. Also trigger when user asks about free software for students, student cloud credits, or .edu.tw email benefits."
---

# Taiwan Student Benefits Tracker

A comprehensive system to help Taiwan university students (.edu.tw) discover, track, and claim 50+ free subscriptions, cloud credits, and developer tools.

## What This Skill Does

1. **Discover** - Shows all available benefits organized by category, with eligibility info
2. **Track** - Generates a personal `tracker.json` to monitor claim status
3. **Remind** - Creates scheduled reminders (Windows Task Scheduler / macOS launchd / Linux cron)
4. **Guide** - Walks through the application process for each benefit

## Quick Start

When the user asks about student benefits, follow this flow:

### Step 1: Assess Eligibility

Ask the user:
- Do you have an active `.edu.tw` email address?
- Have you already applied for GitHub Student Developer Pack?
- What's your OS? (Windows / macOS / Linux)

### Step 2: Show the Catalog

Read `references/benefits-catalog.md` for the full list of 50+ benefits organized by category. Present a summary table of the most valuable items first:

**Tier 1 - High Value (apply first):**

| Service | Value | Requires Pack? |
|---------|-------|---------------|
| GitHub Student Pack | Gateway to 12+ services | No (apply first) |
| GitHub Copilot | ~$120/yr AI coding | Auto with Pack |
| JetBrains All IDEs | ~$250/yr | No |
| Microsoft Azure | $100 credits | No |
| Figma Professional | ~$144/yr for 2 years | No |
| DigitalOcean | $200 credits | Yes |
| Frontend Masters | ~$234 (6 months) | Yes |

**Tier 2 - Apply anytime (no Pack needed):**
- Notion Plus, MS 365, Autodesk, Cursor Pro, AWS Educate, Google Cloud $300

**Tier 3 - Learning & Certs (free, no verification):**
- Coursera Financial Aid, Kaggle Learn, Microsoft Learn, IBM SkillsBuild

### Step 3: Generate Tracker

Create `student_benefits_tracker.json` in the user's preferred directory. Use the template from `scripts/generate_tracker.py` or write it directly:

```json
{
  "created": "YYYY-MM-DD",
  "edu_email": "user@school.edu.tw",
  "github_pack_status": "pending|approved|not_applied",
  "github_pack_approved_date": null,
  "benefits": [
    {
      "id": "service-id",
      "name": "Service Name",
      "category": "github_pack|dev_tools|cloud|design|productivity|learning|media|ai|devops",
      "requires_pack": true,
      "value": "$XXX or description",
      "status": "pending|done|skipped|expired",
      "done_date": null,
      "expiry_date": null,
      "renewal_info": "annual|one-time|during-enrollment",
      "url": "https://..."
    }
  ]
}
```

### Step 4: Set Up Reminders

Based on the user's OS, create a reminder script using the cross-platform templates in `scripts/`.

**Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File check_benefits.ps1
```

**macOS / Linux:**
```bash
bash check_benefits.sh
```

The scripts will:
- Read `student_benefits_tracker.json`
- Show pending items grouped by priority
- Display a desktop notification (Windows toast / macOS osascript / Linux notify-send)
- Append to `reminder.log`

Important: All script output must be in **English** to avoid encoding issues on Windows PowerShell. Comments in the scripts should also be in English.

### Step 5: Schedule Recurring Reminders

**Windows (Task Scheduler):**
Create a `.ps1` registration script - see `scripts/register_tasks_windows.ps1`

**macOS (launchd):**
Create a `.plist` file in `~/Library/LaunchAgents/`

**Linux (cron):**
Add to crontab: `0 9 * * * /path/to/check_benefits.sh`

Suggested schedule:
- Daily 09:00 - check pending benefits
- Weekly Monday 09:00 - remind to update tracker
- One-time on Pack approval date + 3 days - remind to redeem Pack benefits

---

## Application Guides

### GitHub Student Developer Pack (Do This First)

The Pack is the gateway to 12+ premium services. Application steps:

1. Go to https://education.github.com/pack
2. Click "Sign up for Student Developer Pack"
3. Select your `.edu.tw` email (must be added to your GitHub account first)
4. Upload proof: student ID card photo or enrollment certificate
5. Wait 3-7 business days for approval (sometimes instant)

**Tips for Taiwan students:**
- `.edu.tw` emails are well-recognized and usually approved quickly
- If rejected, try uploading a clearer student ID photo or a fresh enrollment certificate
- The Pack is valid during enrollment; renew annually

### Independent Benefits (No Pack Needed)

These can be claimed immediately with just your `.edu.tw` email:

1. **JetBrains** - Apply at jetbrains.com/community/education with `.edu.tw` email
2. **Azure** - No credit card needed; sign up at azure.microsoft.com/free/students
3. **Figma** - Register with `.edu.tw` at figma.com/education
4. **Notion** - Sign up with `.edu.tw`, then upgrade under Settings > Plans
5. **Cursor Pro** - Apply at cursor.com/students (manual verification may be needed for Taiwan)

### Renewal Calendar

Many benefits expire annually. The reminder system tracks expiry dates and warns 30 days before renewal is needed.

| Benefit | Duration | Renewal |
|---------|----------|---------|
| GitHub Pack | 1 year | Re-verify annually |
| JetBrains | 1 year | Re-verify annually |
| Figma Education | 2 years | Re-verify |
| Azure | 12 months | One-time |
| 1Password | 1 year | Via Pack renewal |
| Notion Plus | During enrollment | Automatic |

---

## Tracker Status Values

- `pending` - Not yet applied
- `done` - Successfully claimed (set `done_date`)
- `skipped` - Intentionally skipped (not interested)
- `expired` - Was claimed but has expired (needs renewal)

## Customization

Users can:
- Edit `tracker.json` to add/remove benefits based on their interests
- Change reminder frequency in the scheduled task settings
- Add custom benefits not in the catalog

## File Structure

```
student-benefits/
├── student_benefits_tracker.json   # Personal progress tracker
├── check_benefits.ps1              # Windows reminder script
├── check_benefits.sh               # macOS/Linux reminder script
├── reminder.log                    # Reminder output history
└── register_tasks_windows.ps1      # Windows Task Scheduler setup
```
