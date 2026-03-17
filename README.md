# 🎓 台灣學生免費資源追蹤器

[English](README.en.md)

一套 Claude Code skill + 跨平台提醒系統，幫助台灣大專院校學生（`.edu.tw`）發現、追蹤並領取 **37+ 項免費訂閱服務**，總價值超過 **$4,400 美元/年**。

## 包含哪些福利？

| 分類 | 範例 | 數量 |
|------|------|------|
| GitHub Student Pack | Copilot、DigitalOcean $200、Frontend Masters | 12 |
| 開發工具 & IDE | JetBrains 全家桶、Cursor Pro、Postman | 3 |
| 雲端服務 | Azure $100、AWS、Google Cloud $300、Oracle | 5 |
| 資料庫 | Supabase、Neon | 2 |
| 設計工具 | Figma Professional、Autodesk、Miro | 3 |
| 生產力工具 | Notion Plus、Microsoft 365、Obsidian | 3 |
| 學習平台 & 認證 | Coursera、Kaggle、NVIDIA DLI、IBM | 5+ |
| 影音串流 | Spotify、Apple Music、YouTube Premium | 3 |
| AI 工具 | Perplexity Pro | 1 |
| **合計** | | **37+ 項** |

## 快速開始

### 方式一：搭配 Claude Code 使用

1. Clone 這個 repo 並連結到 Claude Code 的 skills 目錄：

   ```bash
   git clone https://github.com/bingo-taiwan/taiwan-student-benefits.git
   ```

   **Windows（以系統管理員開啟 PowerShell）：**
   ```powershell
   New-Item -ItemType SymbolicLink `
     -Path "$env:USERPROFILE\.claude\skills\taiwan-student-benefits" `
     -Target "你的路徑\taiwan-student-benefits"
   ```

   **macOS / Linux：**
   ```bash
   ln -s /你的路徑/taiwan-student-benefits ~/.claude/skills/taiwan-student-benefits
   ```

2. 在 Claude Code 中直接說：
   - 「幫我設定學生福利追蹤」
   - 「我有 .edu.tw 信箱，有哪些免費訂閱可以申請？」
   - 「設定學生福利提醒」

### 方式二：獨立使用（不需要 Claude Code）

1. 複製追蹤模板：
   ```bash
   cp tracker_template.json student_benefits_tracker.json
   ```

2. 編輯 `student_benefits_tracker.json`：填入你的 `.edu.tw` 信箱，移除不需要的項目

3. 執行提醒腳本：

   **Windows：**
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts/check_benefits.ps1
   ```

   **macOS / Linux：**
   ```bash
   bash scripts/check_benefits.sh
   ```

## 設定排程提醒

### Windows（工作排程器）

```powershell
powershell -ExecutionPolicy Bypass -File scripts/setup_schedule.ps1
```

會建立：每天早上 9:00 提醒 + 每週一更新追蹤狀態。

### macOS（launchd）

```bash
bash scripts/setup_schedule_macos.sh
```

會建立：每天早上 9:00 的 launchd 排程。

### Linux（cron）

```bash
chmod +x scripts/check_benefits.sh
(crontab -l 2>/dev/null; echo "0 9 * * * $(pwd)/scripts/check_benefits.sh") | crontab -
```

## 運作方式

```
tracker_template.json          ← 37 項福利的完整模板
        │
        ▼
student_benefits_tracker.json  ← 你的個人追蹤檔（記錄進度）
        │
        ▼
check_benefits.ps1 / .sh      ← 讀取追蹤檔，顯示待辦項目
        │
        ▼
reminder.log                   ← 提醒紀錄（持續累加）
        +
桌面通知                        ← Windows 氣泡 / macOS / Linux
```

### 狀態值說明

| 狀態 | 說明 |
|------|------|
| `pending` | 尚未申請 |
| `done` | 已成功領取（請填入 `done_date`） |
| `skipped` | 刻意跳過（不需要） |
| `expired` | 已過期，需要續約 |

## 建議申請順序

### 第 1 週：基礎建設（不需要 Pack）

| 優先順序 | 服務 | 價值 | 說明 |
|---------|------|------|------|
| 1 | GitHub Student Pack | 門票 | 申請後可解鎖 12+ 項服務 |
| 2 | JetBrains 全家桶 | ~$250/年 | `.edu.tw` 信箱直接申請，秒過 |
| 3 | Microsoft Azure | $100 | 不需信用卡 |
| 4 | Figma Education | ~$144/年 x 2年 | 設計相關必備 |
| 5 | Notion Plus | ~$96/年 | 生產力即刻提升 |

### 第 2 週：Pack 審核通過後

| 優先順序 | 服務 | 價值 |
|---------|------|------|
| 6 | GitHub Copilot | ~$120/年（自動啟用） |
| 7 | DigitalOcean | $200 額度 |
| 8 | Frontend Masters | 6 個月（~$234） |
| 9 | 1Password | 1 年（~$36） |
| 10 | MongoDB Atlas | $50 額度 |

### 第 3 週之後：其餘項目

- 雲端額度：AWS Educate、Google Cloud、Oracle Free Tier
- 學習平台：Coursera 財務補助、Kaggle、NVIDIA DLI
- 影音折扣：Spotify、Apple Music、YouTube Premium 學生方案

## 台灣學生申請小提醒

- **`.edu.tw` 信箱**是申請大部分服務的關鍵，請確認信箱仍然有效
- **GitHub Student Pack** 用 `.edu.tw` 通常很快通過，如果被拒絕，試試上傳更清晰的學生證照片
- **SheerID 驗證**（Spotify、Apple Music 等）支援大部分台灣大學
- **Coursera 財務補助**台灣學生申請通過率很高，值得嘗試
- **Microsoft 365** 幾乎所有台灣大學都有提供，可向學校資訊處詢問
- **Cursor Pro** 台灣不在官方支援名單中，但可嘗試手動驗證

## 系統需求

- 有效的 `.edu.tw` 電子信箱（在學中）
- **Windows 腳本**：PowerShell 5.1+（Windows 10/11 內建）
- **macOS/Linux 腳本**：bash + [jq](https://jqlang.github.io/jq/)
  - macOS：`brew install jq`
  - Ubuntu/Debian：`sudo apt install jq`

## 檔案結構

```
taiwan-student-benefits/
├── SKILL.md                          # Claude Code skill 定義
├── README.md                         # 正體中文說明（本檔案）
├── README.en.md                      # English README
├── tracker_template.json             # 37 項福利追蹤模板
├── references/
│   └── benefits-catalog.md           # 完整福利目錄（含網址與注意事項）
└── scripts/
    ├── check_benefits.ps1            # Windows 提醒腳本
    ├── check_benefits.sh             # macOS/Linux 提醒腳本
    ├── setup_schedule.ps1            # Windows 排程設定
    └── setup_schedule_macos.sh       # macOS 排程設定
```

## 貢獻

發現新的學生福利？網址有變更？歡迎發 PR！

新增福利的步驟：
1. 在 `tracker_template.json` 加入新項目
2. 在 `references/benefits-catalog.md` 加入說明
3. 提交 Pull Request

## 授權

MIT

## 參考資料

- 福利清單參考自 [2025-2026 台灣學生免費訂閱指南](https://claude-world.com/zh-tw/articles/taiwan-student-free-subscriptions-guide-2025-2026/)
- 使用 [Claude Code](https://claude.ai/claude-code) 建立
