# 🎓 Taiwan Student Benefits Tracker

[正體中文](README.md)

A Claude Code skill + cross-platform reminder system that helps Taiwan university students (`.edu.tw`) discover, track, and claim **37+ free subscriptions** worth over **$4,400/year**.

## What's Included

| Category | Examples | Count |
|----------|---------|-------|
| GitHub Student Pack | Copilot, DigitalOcean $200, Frontend Masters | 12 |
| Dev Tools & IDEs | JetBrains, Cursor Pro, Postman | 3 |
| Cloud & Hosting | Azure $100, AWS, Google Cloud $300, Oracle | 5 |
| Databases | Supabase, Neon | 2 |
| Design | Figma Professional, Autodesk, Miro | 3 |
| Productivity | Notion Plus, Microsoft 365, Obsidian | 3 |
| Learning & Certs | Coursera, Kaggle, NVIDIA DLI, IBM | 5+ |
| Media | Spotify, Apple Music, YouTube Premium | 3 |
| AI Tools | Perplexity Pro | 1 |
| **Total** | | **37+ tracked** |

## Quick Start

### Option 1: As a Claude Code Skill

1. Clone this repo and symlink it into your Claude Code skills directory:

   ```bash
   git clone https://github.com/bingo-taiwan/taiwan-student-benefits.git
   ```

   **Windows (PowerShell as Administrator):**
   ```powershell
   New-Item -ItemType SymbolicLink `
     -Path "$env:USERPROFILE\.claude\skills\taiwan-student-benefits" `
     -Target "path\to\taiwan-student-benefits"
   ```

   **macOS / Linux:**
   ```bash
   ln -s /path/to/taiwan-student-benefits ~/.claude/skills/taiwan-student-benefits
   ```

2. In Claude Code, just say:
   - "Help me set up student benefits tracking"
   - "What free subscriptions can I get with my .edu.tw email?"
   - "Set up student benefit reminders"

### Option 2: Standalone (No Claude Code)

1. Copy the tracker template:
   ```bash
   cp tracker_template.json student_benefits_tracker.json
   ```

2. Edit `student_benefits_tracker.json`: fill in your `.edu.tw` email, remove benefits you don't want

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

| Priority | Service | Value | Notes |
|----------|---------|-------|-------|
| 1 | GitHub Student Pack | Gateway | Unlocks 12+ services once approved |
| 2 | JetBrains All Products | ~$250/yr | Apply directly with `.edu.tw`, instant approval |
| 3 | Microsoft Azure | $100 | No credit card required |
| 4 | Figma Education | ~$144/yr × 2 yrs | Essential for anything design-related |
| 5 | Notion Plus | ~$96/yr | Immediate productivity boost |

### Week 2: After Pack Approval

| Priority | Service | Value |
|----------|---------|-------|
| 6 | GitHub Copilot | ~$120/yr (auto-enabled) |
| 7 | DigitalOcean | $200 credits |
| 8 | Frontend Masters | 6 months (~$234) |
| 9 | 1Password | 1 year (~$36) |
| 10 | MongoDB Atlas | $50 credits |

### Week 3+: Everything Else

- Cloud credits: AWS Educate, Google Cloud, Oracle Free Tier
- Learning platforms: Coursera Financial Aid, Kaggle, NVIDIA DLI
- Media discounts: Spotify, Apple Music, YouTube Premium student plans

## Account Type Quick Reference

> Type definitions:
> - **Type A**: Personal email is fine; student status verified separately (SheerID etc.)
> - **Type B**: `.edu.tw` email required (marked in **bold** in the tables)
> - **Type C**: Redeemed through GitHub Pack (personal email is fine)
> - **Type D**: Through your school's portal

### GitHub Pack Services (Type C: redeem via GitHub account, no .edu.tw needed)

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [GitHub Copilot](https://github.com/settings/copilot) | C | No | Keep | AI code completion and chat, usable in your IDE or terminal (`copilot` CLI). Switch between 17 models including OpenAI GPT-5.x, Claude Sonnet 5, Gemini 3.x, Grok 4.5 ([tested list and billing](#github-copilot-student-plan-tested-2026-08-08)) |
| [GitHub Pro](https://education.github.com/pack) | C | No | Keep | Unlimited private repos, 3,000 Actions minutes, 180 hours of Codespaces cloud dev |
| [GitKraken Pro](https://www.gitkraken.com/github-student-developer-pack) | C | No | Keep | Graphical Git client — visual version control, great if you're not fluent in Git commands |
| [Educative](https://education.github.com/pack#educative) | C | No | Keep | 70+ interactive coding courses, code right in the browser, good for interview prep |
| [Frontend Masters](https://frontendmasters.com/welcome/github-student-developers/) | C | No | Keep | 6 months free — React, TypeScript, Node.js taught by industry instructors |
| [1Password](https://1password.com/developers/students) | C | No | Keep | Password + SSH key management, useful for both dev work and daily life |
| [DigitalOcean](https://www.digitalocean.com/github-students) | C | No | Keep | $200 cloud credits — host a personal site, API server, practice Linux (credit card required) |
| [MongoDB Atlas](https://www.mongodb.com/students) | C | No | Keep | $50 cloud NoSQL database, pairs with Node.js for full-stack projects (redeem within 90 days) |
| [Namecheap (.me)](https://nc.me/) | C | No | Keep | Free .me domain for a portfolio site (`.edu.tw` may not be supported — use Name.com instead) |
| [Name.com](https://www.name.com/partner/github-students) | C | No | Keep | Free domain for 1 year, 25+ TLDs — a personal site helps in interviews |
| [Heroku](https://www.heroku.com/github-students/) | C | No | Keep | $13/month × 24 months — deploy web apps fast, showcase your projects |
| [Stripe](https://education.github.com/pack#stripe) | C | No | Keep | $1,000 in waived processing fees — build an e-commerce project without paying out of pocket |

### Dev Tools (Apply Separately)

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [JetBrains All Products](https://www.jetbrains.com/community/education/#students) | A | No (link GitHub Pack) | Keep | IntelliJ for Java, PyCharm for Python, WebStorm for frontend — powerful refactoring and debugging |
| [Cursor Pro](https://cursor.com/students) | B | **Yes** (account email must match) | Migrate | AI-powered editor, like VS Code but you can write code through conversation (Taiwan requires manual review) |
| [Postman Student Expert](https://www.postman.com/students) | A | No | Keep | API testing certification — earn an official badge for LinkedIn, never expires |

### Cloud Services

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Microsoft Azure](https://azure.microsoft.com/en-us/free/students/) | B | **Yes** | Lose access | $100 credits, no credit card — spin up VMs, host sites, play with AI services (Pack may work as a workaround) |
| [AWS Educate](https://aws.amazon.com/education/awseducate/) | A | Preferred (personal email needs extra docs) | Keep | Free labs for practicing cloud architecture on the highest-market-share cloud platform |
| [Google Cloud $300](https://cloud.google.com/edu/students) | D | No (coupon applies to any account) | Keep | BigQuery data analysis, Vertex AI model training — great for data science programs |
| [Netlify](https://www.netlify.com/) | A | No | Keep | One-click static site deployment, first choice for React/Vue portfolios |
| [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) | A | No | Keep | 2 ARM VMs + 24GB RAM free forever — best value for long-running projects |

### Databases

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Supabase](https://supabase.com/pricing) | A | No | Keep | Open-source Firebase alternative, 500MB PostgreSQL + realtime API for fast full-stack development |
| [Neon](https://neon.tech/pricing) | A | No | Keep | Serverless PostgreSQL, pay for what you use — suits small projects and prototypes |

### Design Tools

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Figma Education](https://www.figma.com/education/) | B | **Yes** (strongly preferred) | Migrate | UI/UX design, presentations, collaborative design files (if rejected, email education@figma.com) |
| [Autodesk Education](https://www.autodesk.com/education/edu-software/overview) | A | No (SheerID verification) | Keep | AutoCAD engineering drawings, Maya 3D animation, Fusion 360 product design |
| [Miro Education](https://miro.com/education/) | A | No (student ID works) | Keep | Online whiteboard for team brainstorming, flowcharts, user journey maps |
| [Blender](https://www.blender.org/download/) | A | No | Keep | Open-source 3D modeling and animation — game assets, 3D printing models, short films |
| [Canva Education](https://www.canva.com/education/) | D | No (via school subscription) | Lose access | Quick presentations, posters, social posts (requires your school to have a Campus plan) |

### Learning Platforms

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Coursera Financial Aid](https://www.coursera.org/apply-for-aid) | A | No | Keep | Take Stanford, Google and other courses free with certificates — high approval rate in Taiwan |
| [edX](https://www.edx.org/) | A | No | Keep | Audit MIT and Harvard courses free — solid resource for going deep in a field |
| [Kaggle Learn](https://www.kaggle.com/learn) | A | No | Keep | Learn Python, SQL and ML free with certificates — best entry point into AI |
| [IBM SkillsBuild](https://skillsbuild.org/students) | A | No | Keep | AI, cloud and security courses — earn IBM digital badges for your résumé |
| [HackerRank](https://www.hackerrank.com/skills-verification) | A | No | Keep | Python, Java, SQL certifications to demonstrate coding ability when job hunting |
| [NVIDIA DLI](https://www.nvidia.com/training) | A | No | Keep | Learn GPU computing and deep learning free, earn official NVIDIA certificates |

### Productivity

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Notion Plus](https://www.notion.com/product/notion-for-education) | B | **Yes** | Migrate | All-in-one notes and project management — class notes, project tracking, knowledge base (school must be in WHED) |
| [Microsoft 365](https://www.microsoft.com/education/products/office) | B | **Yes** | Lose access | Word for reports, Excel for data analysis, PowerPoint for slides, Teams for online meetings |
| [Obsidian](https://obsidian.md/) | A | No | Keep | Local Markdown notes with bidirectional links to build a knowledge graph, fully offline |

### Media Streaming

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Spotify Student](https://www.spotify.com/tw/student/) | A | No (SheerID) | Back to full price | NT$88/month in Taiwan (about half price), re-verify annually |
| [Apple Music Student](https://music.apple.com/tw/subscribe) | B | **Yes** (UNiDAYS) | Back to full price | Roughly 50% off, first choice for Apple ecosystem users |
| [YouTube Premium Student](https://www.youtube.com/premium/student) | A | No (SheerID) | Back to full price | Ad-free + background playback, re-verify annually |

### AI Tools

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Perplexity Pro](https://www.perplexity.ai/students) | A | No (SheerID) | Back to full price | AI search engine, free for students up to 2 years (list price $20/month ≈ NT$6,664/year), extendable by referring classmates. [Open-ended since 2025-07-15, no end date announced](https://www.ithome.com.tw/news/170076) (surveyed 2026-03-22) |

### DevOps & Advanced

| Service | Type | .edu.tw | After Graduation | Use Cases |
|---------|------|---------|------------------|-----------|
| [Red Hat Developer](https://developers.redhat.com/register) | A | No | Keep | Free RHEL + OpenShift for learning enterprise-grade Linux system administration |

## .edu.tw Email Expiry Warning

### When Your Email Stops Working

Most Taiwanese universities disable `.edu.tw` email accounts **1 to 6 months** after graduation, though the exact timing varies by school. Some (like NTU) offer longer retention periods, but most close accounts shortly after the semester ends. **Confirm your school's retention policy with its IT department.**

### Strategy for Type B Services

Type B services (accounts bound to a `.edu.tw` email) are hit hardest after graduation. Recommended approach:

- **Notion Plus**: Export all important pages as Markdown or HTML before graduating, or migrate to a new account registered with a personal email
- **Microsoft 365**: Download OneDrive files locally, or move them to a personal Google Drive / iCloud
- **Figma Education**: Transfer design files to an account registered with a personal email, or export `.fig` backups
- **Cursor Pro**: Make the most of it while valid; switch to the free tier or a paid subscription after graduating
- **Azure for Students**: Migrate important resources to a paid plan on a personal account, or export your data

### Services Requiring Periodic Re-verification

Even when registered with a personal email (Type A), these still require **annual re-verification** and will revert to full price once you can no longer pass it:

- **Spotify Student**: Re-verify via SheerID every 12 months
- **YouTube Premium Student**: Annual re-verification
- **Apple Music Student**: Annual verification via UNiDAYS
- **Perplexity Pro**: Follows the SheerID verification cycle

### Pre-Graduation Checklist

1. **Set up email forwarding**: Forward `.edu.tw` mail to a personal inbox (Gmail etc.) so you never miss a renewal or security notice
2. **Export Type B service data**: Notion notes, OneDrive files, Figma designs — back up or migrate everything
3. **Update account contact emails**: Switch to a personal email wherever possible, as early as possible (usually works for Type A and Type C)
4. **Save certificates and credentials**: Coursera certificates, HackerRank certifications, Postman badges — download PDF backups
5. **Burn down your cloud credits**: Azure $100, DigitalOcean $200, Google Cloud $300 — use them while still enrolled
6. **Check your GitHub Pack status**: The Pack usually runs until graduation; Type C benefits redeemed while valid are unaffected
7. **Log everything you've claimed**: Keep `student_benefits_tracker.json` current so nothing gets forgotten

## Application Tips for Taiwan Students

- Your **`.edu.tw` email** is the key to most of these — make sure it's still active
- **GitHub Student Pack** usually approves `.edu.tw` quickly; if rejected, try uploading a clearer photo of your student ID
- **SheerID verification** (Spotify, Apple Music etc.) supports most Taiwanese universities
- **Coursera Financial Aid** has a high approval rate for Taiwanese students — worth trying
- **Microsoft 365** is provided by almost every Taiwanese university; ask your IT department
- **Cursor Pro** doesn't officially list Taiwan, but manual verification is worth attempting

### Perplexity Pro Application Guide (tested 2026-03-23)

**Application flow:**

1. Go to [perplexity.ai/students](https://www.perplexity.ai/students) and sign in with **a Google account or any email** (this becomes your Perplexity account — no `.edu.tw` needed)
2. After signing in you're redirected to SheerID verification; fill in your name, school and other details
3. SheerID checks its database automatically; if it can't verify you, it asks for documents
4. Once approved you get an email — click the link to activate Pro

**SheerID document requirements** (learned the hard way after a rejection):

Your document **must contain all three** of these:
- Your **full name** (matching what you entered in the form)
- Your **school name** (full or abbreviated is fine)
- A **date showing current enrollment** (within the current academic year or the last 90 days)

| Accepted documents | Rejected documents |
|--------------------|--------------------|
| Student ID with an expiry date | Student ID with no date |
| Class schedule (this semester's registration) | Screenshot of an email |
| Tuition receipt | F1 or other student visa |
| Transcript | Financial aid letter |
| Registration receipt | Entrance exam card |
| Official letter (enrollment certificate etc.) | Screenshot of an SSO landing page |

> **Recommended**: Screenshot the **class schedule** or **transcript** page from your school's student information system — it typically shows your name, school and semester dates all at once.

> **Note**: Cloudflare blocks automation tools, so you must do this manually in a browser. Review takes about half an hour.

**Pricing reference** (if you weren't on the student plan):
- List price $20 USD/month = $200 USD/year
- At the 2026-03-23 exchange rate of 33.3204, roughly **NT$6,664/year**
- Student plan: **free for up to 2 years**, extendable by another 24 months through referrals

### GitHub Copilot Student Plan (tested 2026-08-08)

**Three common misconceptions, cleared up:**

| Misconception | Reality |
|---------------|---------|
| "Copilot is an OpenAI model" | Copilot is a **product**, not a model. It can run models from six vendors: OpenAI, Anthropic, Google, xAI, Moonshot and Microsoft |
| "Copilot CLI is Codex CLI" | Two different things. Copilot CLI is GitHub's (command `copilot`); Codex CLI is OpenAI's (command `codex`). `GPT-5.3-Codex` is merely a **model name** you can select inside Copilot |
| "You need a separate GitHub account to apply with `.edu.tw`" | You don't. Add the `.edu.tw` address as a secondary email on your existing account and verify with it — all your repos, stars and contribution history stay intact |

**What your billing page looks like once the student plan is active** (use this to confirm it actually took effect):

| Subscription | Display |
|--------------|---------|
| GitHub Pro | ~~$4.00~~ **$0.00**/month (`$4.00 off · 2 years remaining`) |
| Copilot Pro | Lists at $10.00/month, but `Next payment due` shows `–` (not charged) |

Verification status lives at `github.com/settings/education/benefits`, showing `Verified (benefits available) on <date>` plus an expiry date (typically 2 years out).

#### The 17 Models Copilot Pro Can Actually Use

> Note: **neither the official docs nor the github.com web model picker is accurate**. The docs omit models
> (the Kimi family, for instance), while the web picker is missing the entire Gemini lineup and Grok 4.5 —
> all of which do work in Copilot CLI.

| Model | input | output | cache read |
|-------|------:|-------:|-----------:|
| `gpt-5.6-luna` | **20** | 120 | 2 |
| `gpt-5-mini` | 25 | 200 | 2 |
| `gpt-5.4-mini` | 75 | 450 | 7 |
| `mai-code-1-flash` | 75 | 450 | 7 |
| `kimi-k2.7-code` | 95 | 400 | 19 |
| `claude-haiku-4.5` | 100 | 500 | 10 |
| `gemini-3.5-flash` | 150 | 900 | 15 |
| `gemini-3.6-flash` | 150 | 750 | 15 |
| `gpt-5.3-codex` | 175 | 1400 | 17 |
| `claude-sonnet-5` | 200 | 1000 | 20 |
| `gemini-3.1-pro-preview` | 200 | 1200 | 20 |
| `gpt-5.6-terra` | 200 | 1200 | 20 |
| `grok-4.5` | 200 | **600** | 50 |
| `gpt-5.4` | 250 | 1500 | 25 |
| `claude-sonnet-4.6` | 300 | 1500 | 30 |
| `kimi-k3` | 300 | 1500 | 30 |
| `claude-sonnet-4.5` | 300 | 1500 | 30 |

(Units: AI credits per million tokens)

**Locked behind Pro+ / Business / Enterprise / Max**: `claude-opus-5`, `claude-opus-4.8`, `claude-opus-4.8-fast`,
`claude-opus-4.7`, `claude-opus-4.5`, `claude-fable-5`, `gpt-5.5`, `gpt-5.6-sol`.
**On the Anthropic side the student plan tops out at Sonnet 5 — every Opus model and Fable 5 requires a paid upgrade.**

#### AI Credits Are a Shared Pool, Not Per-Model Quotas

All models **share** the same 1,500 credits per month. What differs is the burn rate — up to a **15× spread**.

```
credits = tokens × price ÷ 1,000,000     (input and output priced separately; cache reads get a discount)
```

Verified empirically (Copilot CLI's opening system prompt is about 21k tokens):

| Model | Measured | Recomputed from unit price |
|-------|---------:|---------------------------|
| `grok-4.5` | 4.42 | 21.7k×200 + 1.4k×50(cached) + 12×600 = 4.42 ✅ |
| `gemini-3.6-flash` | 3.23 | 21.6k×150 ÷ 1M = 3.24 ✅ |
| `kimi-k3` | 6.32 | 21.0k×300 ÷ 1M = 6.30 ✅ |

Translated into how many interactions you actually get per month:

| Model | Per call | Fits in 1,500 credits |
|-------|---------:|----------------------:|
| `gpt-5.6-luna` | 0.42 | **~3,500 calls** |
| `claude-haiku-4.5` | 2.1 | ~700 calls |
| `gemini-3.6-flash` | 3.2 | ~470 calls |
| `claude-sonnet-5` | 4.2 | ~350 calls |
| `claude-sonnet-4.5` / `4.6` / `kimi-k3` | 6.3 | **~240 calls** |

Expect fewer in practice: input grows as the conversation gets longer (the full context is resent every turn), and output costs 5–6× what input does.

**Three ways to stretch your credits:**
1. Use `gpt-5.6-luna` for routine work (15× cheaper than Sonnet); switch to `claude-sonnet-5` only for hard problems
2. Cache reads cost 1/10 of normal input — staying in one session beats reopening a fresh one each time
3. For long outputs use `grok-4.5` (output is only 600, cheapest in its tier), though its cache read of 50 makes it a poor fit for long conversations

Running out doesn't cost you money: `Additional usage` defaults to `Not enabled` with a `$0` budget, so it simply stops until next month.

#### How to Check What *Your* Account Can Actually Use

The docs go stale and the web picker under-reports, so read the Copilot API response directly:

```bash
npm install -g @github/copilot
export GH_TOKEN=$(gh auth token)   # reuses gh's token, no separate copilot login needed

copilot --model bogus --log-level debug --log-dir ./cplog -p "hi" --allow-all-tools
# In the log, search for 'fetched models from CAPI /models' — that line's "models" field
# is the complete JSON (50 entries).
# Each entry's billing.restricted_to is the plan allowlist:
#   free / edu / pro / pro_plus / individual_trial / business / enterprise / max
# billing.token_prices.default holds the unit prices shown in the table above.
```

When parsing, `"models"` is a nested JSON string — use `json.JSONDecoder().raw_decode()` to pull out the
outer string first, then `json.loads`. Going straight to `unicode_escape` blows up on the backslashes.

#### Spending Zero Credits (BYOK)

Copilot CLI supports bringing your own model provider: any OpenAI-compatible endpoint, Azure OpenAI, Anthropic, or a local Ollama / vLLM instance.

| Environment variable | Description |
|----------------------|-------------|
| `COPILOT_PROVIDER_BASE_URL` | Your provider's API endpoint |
| `COPILOT_PROVIDER_TYPE` | `openai` (default, works with Ollama / vLLM), `azure`, or `anthropic` |
| `COPILOT_PROVIDER_API_KEY` | API key (not needed for a local Ollama instance) |
| `COPILOT_MODEL` | Model name (required when using a custom provider) |

Models must support **tool calling** and **streaming**, with a context window of at least 128k recommended. Run `copilot help providers` for details.

## Requirements

- A valid `.edu.tw` email address (currently enrolled)
- **Windows script:** PowerShell 5.1+ (built-in on Windows 10/11)
- **macOS/Linux script:** bash + [jq](https://jqlang.github.io/jq/)
  - macOS: `brew install jq`
  - Ubuntu/Debian: `sudo apt install jq`

## File Structure

```
taiwan-student-benefits/
├── SKILL.md                          # Claude Code skill definition
├── README.md                         # Traditional Chinese documentation
├── README.en.md                      # English documentation (this file)
├── tracker_template.json             # Template with all 37 benefits
├── references/
│   ├── benefits-catalog.md           # Full catalog, English (URLs and notes)
│   └── benefits-catalog.zh-TW.md     # Full catalog, Traditional Chinese
└── scripts/
    ├── check_benefits.ps1            # Windows reminder script
    ├── check_benefits.sh             # macOS/Linux reminder script
    ├── setup_schedule.ps1            # Windows Task Scheduler setup
    └── setup_schedule_macos.sh       # macOS launchd setup
```

## Contributing

Found a new student benefit? Benefit URL changed? PRs welcome!

To add a new benefit:
1. Add an entry to `tracker_template.json`
2. Add an entry to both `references/benefits-catalog.md` (English) and `references/benefits-catalog.zh-TW.md` (Chinese)
3. Submit a Pull Request

## License

MIT

## Credits

- Benefits catalog based on [Taiwan Student Free Subscriptions Guide 2025-2026](https://claude-world.com/zh-tw/articles/taiwan-student-free-subscriptions-guide-2025-2026/)
- Built with [Claude Code](https://claude.ai/claude-code)
