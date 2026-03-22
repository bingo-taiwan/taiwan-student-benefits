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

## 帳號類型速查表

> 類型定義：
> - **A 類**：可用個人信箱，另外驗證學生身份（SheerID 等）
> - **B 類**：必須用 `.edu.tw` 信箱（表格中以 **粗體** 標示）
> - **C 類**：透過 GitHub Pack 兌換（可用個人信箱）
> - **D 類**：透過學校入口

### GitHub Pack 相關（C 類：透過 GitHub 帳號兌換，不需 .edu.tw）

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| GitHub Copilot | C | 否 | 可保留 | AI 程式碼補完，寫程式自動建議下一行，加速開發效率 |
| GitHub Pro | C | 否 | 可保留 | 無限私有 repo、3000 分鐘 Actions、180 小時 Codespaces 雲端開發 |
| GitKraken Pro | C | 否 | 可保留 | Git 圖形化介面，視覺化管理版本控制，適合 Git 指令不熟的同學 |
| Educative | C | 否 | 可保留 | 70+ 門互動式程式課程，瀏覽器直接寫程式，適合面試刷題 |
| Frontend Masters | C | 否 | 可保留 | 6 個月免費學 React、TypeScript、Node.js，業界講師授課 |
| 1Password | C | 否 | 可保留 | 密碼管理 + SSH 金鑰管理，開發和日常生活都實用 |
| DigitalOcean | C | 否 | 可保留 | $200 雲端額度，架個人網站、API 伺服器、練 Linux（需信用卡） |
| MongoDB Atlas | C | 否 | 可保留 | $50 雲端 NoSQL 資料庫，搭 Node.js 做全端專案（90 天內兌換） |
| Namecheap (.me) | C | 否 | 可保留 | 免費 .me 網域，架作品集網站（`.edu.tw` 可能不支援，改用 Name.com） |
| Name.com | C | 否 | 可保留 | 免費網域 1 年，25+ 頂級域名可選，架個人網站面試加分 |
| Heroku | C | 否 | 可保留 | 每月 $13 x 24 個月，快速部署 Web 應用，展示專題成果 |
| Stripe | C | 否 | 可保留 | $1,000 手續費免除，做電商專題不用自掏腰包付手續費 |

### 開發工具（獨立申請）

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| JetBrains 全家桶 | A | 否（連結 GitHub Pack） | 可保留 | IntelliJ 寫 Java、PyCharm 寫 Python、WebStorm 寫前端，強大重構和除錯 |
| Cursor Pro | B | **是**（帳號信箱需一致） | 需遷移 | AI 驅動編輯器，類似 VS Code 但可用中文對話寫程式（台灣需人工審核） |
| Postman Student Expert | A | 否 | 可保留 | API 測試認證，取得官方徽章放 LinkedIn，永久有效 |

### 雲端服務

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Microsoft Azure | B | **是** | 失去存取 | $100 額度，不需信用卡，開虛擬機、架網站、玩 AI 服務（可嘗試用 Pack 繞過） |
| AWS Educate | A | 偏好（個人信箱需補件） | 可保留 | 免費實驗室練雲端架構，業界市佔最高的雲端平台 |
| Google Cloud $300 | D | 否（coupon 套用任何帳號） | 可保留 | BigQuery 資料分析、Vertex AI 訓練模型，適合資料科學系所 |
| Netlify | A | 否 | 可保留 | 靜態網站一鍵部署，React/Vue 作品集首選 |
| Oracle Cloud Free Tier | A | 否 | 可保留 | 2 台 ARM VM + 24GB RAM 永久免費，長期運行專案最划算 |

### 資料庫

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Supabase | A | 否 | 可保留 | 開源 Firebase 替代，500MB PostgreSQL + 即時 API，快速開發全端應用 |
| Neon | A | 否 | 可保留 | Serverless PostgreSQL，用多少算多少，適合小型專案和原型開發 |

### 設計工具

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Figma Education | B | **是**（強烈偏好） | 需遷移 | UI/UX 設計、簡報、團隊協作設計稿（被拒可寄信 education@figma.com） |
| Autodesk Education | A | 否（SheerID 驗證） | 可保留 | AutoCAD 工程圖、Maya 3D 動畫、Fusion 360 產品設計 |
| Miro Education | A | 否（可用學生證） | 可保留 | 線上白板，團隊腦力激盪、流程圖、使用者旅程地圖 |
| Blender | A | 否 | 可保留 | 開源 3D 建模與動畫，做遊戲素材、3D 列印模型、動畫短片 |
| Canva Education | D | 否（透過學校訂閱） | 失去存取 | 快速做簡報、海報、社群貼文（需學校有訂閱 Campus 方案） |

### 學習平台

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Coursera 助學金 | A | 否 | 可保留 | 免費修 Stanford、Google 等名校課程並取得證書，台灣核准率高 |
| edX | A | 否 | 可保留 | 免費旁聽 MIT、Harvard 課程，深入特定領域的好資源 |
| Kaggle Learn | A | 否 | 可保留 | 免費學 Python、SQL、ML 並取得證書，AI 入門首選 |
| IBM SkillsBuild | A | 否 | 可保留 | AI、雲端、資安課程，取得 IBM 數位徽章放履歷 |
| HackerRank | A | 否 | 可保留 | Python、Java、SQL 認證，求職展示程式能力 |
| NVIDIA DLI | A | 否 | 可保留 | 免費學 GPU 運算和深度學習，取得 NVIDIA 官方證照 |

### 生產力工具

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Notion Plus | B | **是** | 需遷移 | 全能筆記與專案管理，課堂筆記、專題進度、知識庫（學校需在 WHED） |
| Microsoft 365 | B | **是** | 失去存取 | Word 寫報告、Excel 資料分析、PPT 簡報、Teams 線上開會 |
| Obsidian | A | 否 | 可保留 | 本地 Markdown 筆記，雙向連結建知識網路，完全離線可用 |

### 影音串流

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Spotify 學生方案 | A | 否（SheerID） | 恢復原價 | 台灣學生價 NT$88/月（約半價），每年需重新驗證 |
| Apple Music 學生方案 | B | **是**（UNiDAYS） | 恢復原價 | 約 5 折，Apple 生態系用戶首選 |
| YouTube Premium 學生方案 | A | 否（SheerID） | 恢復原價 | 無廣告 + 背景播放，每年需重新驗證 |

### AI 工具

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Perplexity Pro | A | 否（SheerID） | 恢復原價 | AI 搜尋引擎 5 折，寫報告快速查找整理資料，附引用來源 |

### DevOps 與進階

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| Red Hat Developer | A | 否 | 可保留 | 免費 RHEL + OpenShift，學習企業級 Linux 系統管理 |

## .edu.tw 信箱有效期限提醒

### 信箱失效時程

大多數台灣大學的 `.edu.tw` 信箱會在畢業後 **1 至 6 個月**內停用，實際時間依各校政策而定。部分學校（如台大）提供較長的保留期，但多數學校會在學期結束後不久關閉信箱。**請務必向學校資訊處確認你的信箱保留期限。**

### B 類服務的應對策略

B 類服務（帳號綁定 `.edu.tw` 信箱的服務）是畢業後受影響最大的。以下是建議的應對方式：

- **Notion Plus**：畢業前將所有重要頁面匯出為 Markdown 或 HTML，或轉移到用個人信箱註冊的新帳號
- **Microsoft 365**：將 OneDrive 檔案下載到本地或轉存到個人 Google Drive / iCloud
- **Figma Education**：將設計稿轉移到用個人信箱註冊的帳號，或匯出為 .fig 檔案備份
- **Cursor Pro**：效期內善用，畢業後改用免費版或自行訂閱
- **Azure for Students**：將重要資源遷移到個人帳號的付費方案，或匯出資料

### 需要定期重新驗證的服務

以下服務即使用個人信箱註冊（A 類），仍需**每年重新驗證**學生身份，畢業後將無法通過驗證而恢復原價：

- **Spotify 學生方案**：每 12 個月透過 SheerID 重新驗證
- **YouTube Premium 學生方案**：每年重新驗證
- **Apple Music 學生方案**：透過 UNiDAYS 每年驗證
- **Perplexity Pro**：依 SheerID 驗證週期

### 畢業前必做清單

1. **設定信箱轉寄**：將 `.edu.tw` 信箱的信件轉寄到個人信箱（Gmail 等），確保不漏接任何續約或安全通知
2. **匯出 B 類服務資料**：Notion 筆記、OneDrive 檔案、Figma 設計稿等，全部備份或遷移
3. **更新帳號聯絡信箱**：能改成個人信箱的服務，盡早更改（A 類和 C 類通常可以）
4. **截圖保存證照與認證**：Coursera 證書、HackerRank 認證、Postman 徽章等，下載 PDF 備份
5. **用完雲端額度**：Azure $100、DigitalOcean $200、Google Cloud $300 等，把握在學期間用完
6. **確認 GitHub Pack 狀態**：Pack 效期通常到畢業，C 類服務在效期內兌換的福利不受影響
7. **記錄所有已申請的服務**：用 `student_benefits_tracker.json` 記錄清楚，避免遺忘

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
│   ├── benefits-catalog.md           # 完整福利目錄（英文版，含網址與注意事項）
│   └── benefits-catalog.zh-TW.md     # 完整福利目錄（正體中文版）
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
2. 在 `references/benefits-catalog.md`（英文）和 `references/benefits-catalog.zh-TW.md`（中文）加入說明
3. 提交 Pull Request

## 授權

MIT

## 參考資料

- 福利清單參考自 [2025-2026 台灣學生免費訂閱指南](https://claude-world.com/zh-tw/articles/taiwan-student-free-subscriptions-guide-2025-2026/)
- 使用 [Claude Code](https://claude.ai/claude-code) 建立
