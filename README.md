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
| [GitHub Copilot](https://github.com/settings/copilot) | C | 否 | 可保留 | AI 程式碼補完與對話，可在 IDE / 終端機（`copilot` CLI）使用。模型可切 OpenAI GPT-5.x、Claude Sonnet 5、Gemini 3.x、Grok 4.5 等 17 種（[實測清單與計費](#github-copilot-學生方案實測2026-08-08)） |
| [GitHub Pro](https://education.github.com/pack) | C | 否 | 可保留 | 無限私有 repo、3000 分鐘 Actions、180 小時 Codespaces 雲端開發 |
| [GitKraken Pro](https://www.gitkraken.com/github-student-developer-pack) | C | 否 | 可保留 | Git 圖形化介面，視覺化管理版本控制，適合 Git 指令不熟的同學 |
| [Educative](https://education.github.com/pack#educative) | C | 否 | 可保留 | 70+ 門互動式程式課程，瀏覽器直接寫程式，適合面試刷題 |
| [Frontend Masters](https://frontendmasters.com/welcome/github-student-developers/) | C | 否 | 可保留 | 6 個月免費學 React、TypeScript、Node.js，業界講師授課 |
| [1Password](https://1password.com/developers/students) | C | 否 | 可保留 | 密碼管理 + SSH 金鑰管理，開發和日常生活都實用 |
| [DigitalOcean](https://www.digitalocean.com/github-students) | C | 否 | 可保留 | $200 雲端額度，架個人網站、API 伺服器、練 Linux（需信用卡） |
| [MongoDB Atlas](https://www.mongodb.com/students) | C | 否 | 可保留 | $50 雲端 NoSQL 資料庫，搭 Node.js 做全端專案（90 天內兌換） |
| [Namecheap (.me)](https://nc.me/) | C | 否 | 可保留 | 免費 .me 網域，架作品集網站（`.edu.tw` 可能不支援，改用 Name.com） |
| [Name.com](https://www.name.com/partner/github-students) | C | 否 | 可保留 | 免費網域 1 年，25+ 頂級域名可選，架個人網站面試加分 |
| [Heroku](https://www.heroku.com/github-students/) | C | 否 | 可保留 | 每月 $13 x 24 個月，快速部署 Web 應用，展示專題成果 |
| [Stripe](https://education.github.com/pack#stripe) | C | 否 | 可保留 | $1,000 手續費免除，做電商專題不用自掏腰包付手續費 |

### 開發工具（獨立申請）

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [JetBrains 全家桶](https://www.jetbrains.com/community/education/#students) | A | 否（連結 GitHub Pack） | 可保留 | IntelliJ 寫 Java、PyCharm 寫 Python、WebStorm 寫前端，強大重構和除錯 |
| [Cursor Pro](https://cursor.com/students) | B | **是**（帳號信箱需一致） | 需遷移 | AI 驅動編輯器，類似 VS Code 但可用中文對話寫程式（台灣需人工審核） |
| [Postman Student Expert](https://www.postman.com/students) | A | 否 | 可保留 | API 測試認證，取得官方徽章放 LinkedIn，永久有效 |

### 雲端服務

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Microsoft Azure](https://azure.microsoft.com/en-us/free/students/) | B | **是** | 失去存取 | $100 額度，不需信用卡，開虛擬機、架網站、玩 AI 服務（可嘗試用 Pack 繞過） |
| [AWS Educate](https://aws.amazon.com/education/awseducate/) | A | 偏好（個人信箱需補件） | 可保留 | 免費實驗室練雲端架構，業界市佔最高的雲端平台 |
| [Google Cloud $300](https://cloud.google.com/edu/students) | D | 否（coupon 套用任何帳號） | 可保留 | BigQuery 資料分析、Vertex AI 訓練模型，適合資料科學系所 |
| [Netlify](https://www.netlify.com/) | A | 否 | 可保留 | 靜態網站一鍵部署，React/Vue 作品集首選 |
| [Oracle Cloud Free Tier](https://www.oracle.com/tw/cloud/free/) | A | 否 | 可保留 | 2 台 ARM VM + 24GB RAM 永久免費，長期運行專案最划算 |

### 資料庫

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Supabase](https://supabase.com/pricing) | A | 否 | 可保留 | 開源 Firebase 替代，500MB PostgreSQL + 即時 API，快速開發全端應用 |
| [Neon](https://neon.tech/pricing) | A | 否 | 可保留 | Serverless PostgreSQL，用多少算多少，適合小型專案和原型開發 |

### 設計工具

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Figma Education](https://www.figma.com/education/) | B | **是**（強烈偏好） | 需遷移 | UI/UX 設計、簡報、團隊協作設計稿（被拒可寄信 education@figma.com） |
| [Autodesk Education](https://www.autodesk.com/education/edu-software/overview) | A | 否（SheerID 驗證） | 可保留 | AutoCAD 工程圖、Maya 3D 動畫、Fusion 360 產品設計 |
| [Miro Education](https://miro.com/education/) | A | 否（可用學生證） | 可保留 | 線上白板，團隊腦力激盪、流程圖、使用者旅程地圖 |
| [Blender](https://www.blender.org/download/) | A | 否 | 可保留 | 開源 3D 建模與動畫，做遊戲素材、3D 列印模型、動畫短片 |
| [Canva Education](https://www.canva.com/education/) | D | 否（透過學校訂閱） | 失去存取 | 快速做簡報、海報、社群貼文（需學校有訂閱 Campus 方案） |

### 學習平台

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Coursera 助學金](https://www.coursera.org/apply-for-aid) | A | 否 | 可保留 | 免費修 Stanford、Google 等名校課程並取得證書，台灣核准率高 |
| [edX](https://www.edx.org/) | A | 否 | 可保留 | 免費旁聽 MIT、Harvard 課程，深入特定領域的好資源 |
| [Kaggle Learn](https://www.kaggle.com/learn) | A | 否 | 可保留 | 免費學 Python、SQL、ML 並取得證書，AI 入門首選 |
| [IBM SkillsBuild](https://skillsbuild.org/students) | A | 否 | 可保留 | AI、雲端、資安課程，取得 IBM 數位徽章放履歷 |
| [HackerRank](https://www.hackerrank.com/skills-verification) | A | 否 | 可保留 | Python、Java、SQL 認證，求職展示程式能力 |
| [NVIDIA DLI](https://www.nvidia.com/training) | A | 否 | 可保留 | 免費學 GPU 運算和深度學習，取得 NVIDIA 官方證照 |

### 生產力工具

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Notion Plus](https://www.notion.com/product/notion-for-education) | B | **是** | 需遷移 | 全能筆記與專案管理，課堂筆記、專題進度、知識庫（學校需在 WHED） |
| [Microsoft 365](https://www.microsoft.com/zh-tw/education/products/office) | B | **是** | 失去存取 | Word 寫報告、Excel 資料分析、PPT 簡報、Teams 線上開會 |
| [Obsidian](https://obsidian.md/) | A | 否 | 可保留 | 本地 Markdown 筆記，雙向連結建知識網路，完全離線可用 |

### 影音串流

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Spotify 學生方案](https://www.spotify.com/tw/student/) | A | 否（SheerID） | 恢復原價 | 台灣學生價 NT$88/月（約半價），每年需重新驗證 |
| [Apple Music 學生方案](https://music.apple.com/tw/subscribe) | B | **是**（UNiDAYS） | 恢復原價 | 約 5 折，Apple 生態系用戶首選 |
| [YouTube Premium 學生方案](https://www.youtube.com/premium/student) | A | 否（SheerID） | 恢復原價 | 無廣告 + 背景播放，每年需重新驗證 |

### AI 工具

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Perplexity Pro](https://www.perplexity.ai/students) | A | 否（SheerID） | 恢復原價 | AI 搜尋引擎，學生免費最長 2 年（原價 $20/月 ≈ NT$6,664/年），推薦同學可再延長。[2025-07-15 起持續開放，無截止日](https://www.ithome.com.tw/news/170076)（調查日期：2026-03-22） |

### DevOps 與進階

| 服務 | 類型 | .edu.tw | 畢業後 | 用途與應用場景 |
|------|------|---------|--------|--------------|
| [Red Hat Developer](https://developers.redhat.com/register) | A | 否 | 可保留 | 免費 RHEL + OpenShift，學習企業級 Linux 系統管理 |

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

### Perplexity Pro 申請實務指南（2026-03-23 實測）

**申請流程**：
1. 到 [perplexity.ai/students](https://www.perplexity.ai/students) 用 **Google 帳號或任何 email 登入**（這是你的 Perplexity 帳號，不需要 .edu.tw）
2. 登入後會跳轉到 SheerID 驗證頁面，填寫姓名、學校等資訊
3. SheerID 自動比對資料庫，若無法自動驗證則要求上傳文件
4. 審核通過後收到 email，點連結啟用 Pro

**SheerID 文件驗證要點**（被退件的血淚教訓）：

文件**必須同時包含**三項資訊：
- 你的**全名**（與表格填寫一致）
- **學校名稱**（完整或縮寫皆可）
- **顯示當前就讀的日期**（當前學年內或距今 90 天內）

| 可接受的文件 | 不可接受的文件 |
|-------------|---------------|
| 包含到期日的學生證 | 無日期的學生證 |
| 課程表（本學期選課結果）| 電子郵件截圖 |
| 學費收據 | F1 或其他學生簽證 |
| 成績單 | 財政援助信函 |
| 註冊報名收據 | 入學考試卡 |
| 官方信函（在學證明等）| SSO 登入首頁截圖 |

> **推薦做法**：截圖學校「學生資訊系統」的**課程表**或**成績單**頁面，通常同時顯示姓名、校名、學期日期，一張搞定。

> **注意**：Cloudflare 會擋自動化工具，必須手動在瀏覽器操作。審核約需**半小時**。

**定價參考**（若非學生方案）：
- 原價 $20 USD/月 = $200 USD/年
- 以 2026-03-23 匯率 33.3204 換算約 **NT$6,664/年**
- 學生方案：**免費最長 2 年**，推薦朋友可再延 24 個月

### GitHub Copilot 學生方案實測（2026-08-08）

**先釐清三個常見誤解**：

| 誤解 | 事實 |
|------|------|
| 「Copilot 是 OpenAI 的模型」 | Copilot 是**產品**不是模型。背後可選 OpenAI、Anthropic、Google、xAI、Moonshot、Microsoft 六家 |
| 「Copilot CLI 就是 Codex CLI」 | 兩個不同東西。Copilot CLI 是 GitHub 的（指令 `copilot`），Codex CLI 是 OpenAI 的（指令 `codex`）。`GPT-5.3-Codex` 只是可在 Copilot 裡選用的**模型名稱** |
| 「要另開 GitHub 帳號才能用 .edu.tw 申請」 | 不用。把 `.edu.tw` 加成現有帳號的次要信箱去驗證即可，原帳號的 repo / star / 貢獻紀錄全部保留 |

**怎麼確認學生方案真的生效**（這裡有個很容易踩的坑）：

驗證狀態在 `github.com/settings/education/benefits`，會顯示 `Verified (benefits available) on <日期>` 與到期日（通常給 2 年）。

但**通過驗證不等於每一項都自動變免費**。在 `github.com/settings/billing` 的 Subscriptions 卡片上，
真正被折抵的項目會有綠色的 `$X off` 標記：

| 訂閱 | 顯示 | 判讀 |
|------|------|------|
| GitHub Pro | ~~$4.00~~ **$0.00**/月（`$4.00 off · 2 years remaining`） | ✅ 學生折扣已套用 |
| Copilot Pro | $10.00/月，**沒有任何 off 標記** | ❌ 仍在自費 |

> ⚠️ **不要用 `Next payment due` 判斷有沒有在扣款。** 這個欄位可能顯示 `–`，
> 但實際每月照扣——本專案作者就這樣誤判過。唯一可信的是
> `github.com/account/billing/history` 的實際扣款紀錄。
>
> 若你在成為學生**之前**就已經自費訂閱 Copilot Pro，學生福利**不會自動接管**它：
> 通過驗證後 GitHub Pro 會變 $0，但 Copilot Pro 那 $10/月仍會繼續扣。
> 此時 `github.com/github-copilot/signup` 會因為偵測到既有訂閱而直接跳轉回設定頁，
> 不會給你免費方案。**必須先取消自費訂閱，再重新以學生身分領取。**

#### Copilot Pro 實際可用的 17 個模型

> 注意：**官方文件與 github.com 網頁版選單都不準**。文件會漏列（如 Kimi 系列），
> 網頁版選單則少了 Gemini 全系列和 Grok 4.5——但這些在 Copilot CLI 裡可以用。

| 模型 | input | output | cache 讀 |
|------|------:|-------:|--------:|
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

（單位：AI credits / 百萬 token）

**鎖住需 Pro+ / Business / Enterprise / Max**：`claude-opus-5`、`claude-opus-4.8`、`claude-opus-4.8-fast`、
`claude-opus-4.7`、`claude-opus-4.5`、`claude-fable-5`、`gpt-5.5`、`gpt-5.6-sol`。
**Anthropic 這邊學生方案的天花板是 Sonnet 5，所有 Opus 與 Fable 5 都要付費升級。**

#### AI credits 是共用池，不是每個模型各有額度

每月 1,500 credits 由所有模型**共用**，差別在扣率——最貴與最便宜差 **15 倍**。

```
credits = tokens × 單價 ÷ 1,000,000     （input / output 分開算，cache 讀取另有折扣價）
```

實測驗證（Copilot CLI 起手系統 prompt 約 21k tokens）：

| 模型 | 實測消耗 | 用單價驗算 |
|------|---------:|-----------|
| `grok-4.5` | 4.42 | 21.7k×200 + 1.4k×50(cached) + 12×600 = 4.42 ✅ |
| `gemini-3.6-flash` | 3.23 | 21.6k×150 ÷ 1M = 3.24 ✅ |
| `kimi-k3` | 6.32 | 21.0k×300 ÷ 1M = 6.30 ✅ |

換算成一個月實際可跑的次數：

| 用什麼 | 每次 | 1,500 credits 可跑 |
|--------|-----:|------------------:|
| `gpt-5.6-luna` | 0.42 | **~3,500 次** |
| `claude-haiku-4.5` | 2.1 | ~700 次 |
| `gemini-3.6-flash` | 3.2 | ~470 次 |
| `claude-sonnet-5` | 4.2 | ~350 次 |
| `claude-sonnet-4.5` / `4.6` / `kimi-k3` | 6.3 | **~240 次** |

實際會更少：對話越長 input 越大（每輪重送全部 context），且 output 單價是 input 的 5–6 倍。

**省 credits 三招**：
1. 雜事用 `gpt-5.6-luna`（比 Sonnet 便宜 15 倍），難的才切 `claude-sonnet-5`
2. cache 讀取只要 1/10 價，同一 session 連續問比每次重開省很多
3. 要長輸出用 `grok-4.5`（output 僅 600，同級距最便宜），但 cache 讀 50 偏貴，不適合長對話

額度用完不會自動扣錢：`Additional usage` 預設 `Not enabled`、budget `$0`，超過就停用到下個月。

#### 怎麼查「自己帳號」實際能用哪些模型

官方文件會過時、網頁選單會少列，最準的是直接看 Copilot API 回應：

```bash
npm install -g @github/copilot
export GH_TOKEN=$(gh auth token)   # 吃 gh 的 token，不必另外 copilot login

copilot --model bogus --log-level debug --log-dir ./cplog -p "hi" --allow-all-tools
# log 裡搜 'fetched models from CAPI /models'，該行的 "models" 是完整 JSON（50 筆）
# 每筆的 billing.restricted_to 就是方案白名單：
#   free / edu / pro / pro_plus / individual_trial / business / enterprise / max
# billing.token_prices.default 則是上表的單價
```

解析時 `"models"` 是巢狀 JSON 字串，要用 `json.JSONDecoder().raw_decode()` 先取出外層字串再 `json.loads`；
直接用 `unicode_escape` 會炸在反斜線上。

#### 完全不吃 credits 的做法（BYOK）

Copilot CLI 支援自帶模型供應商，可接 OpenAI 相容端點、Azure OpenAI、Anthropic，或本機 Ollama / vLLM：

| 環境變數 | 說明 |
|----------|------|
| `COPILOT_PROVIDER_BASE_URL` | 供應商 API 端點 |
| `COPILOT_PROVIDER_TYPE` | `openai`（預設，相容 Ollama / vLLM）、`azure`、`anthropic` |
| `COPILOT_PROVIDER_API_KEY` | API key（本機 Ollama 不需要） |
| `COPILOT_MODEL` | 模型名稱（用自訂供應商時必填） |

模型必須支援 **tool calling** 與 **streaming**，建議 context window 至少 128k。細節執行 `copilot help providers`。

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

### 必須成對修改的檔案

本專案有**四組雙語檔案**，改動時務必成對更新，否則兩版會逐漸脫節
（曾經發生過：英文版開頭寫 50+ 項但表格總計是 37+、`建議申請順序` 中文是表格英文是列表、
`檔案結構` 漏列一半檔案）。

| 中文 | 英文 | 內容 |
|------|------|------|
| `README.md` | `README.en.md` | 主說明文件 |
| `references/benefits-catalog.zh-TW.md` | `references/benefits-catalog.md` | 完整福利目錄 |

`tracker_template.json` 是**單一來源**（無雙語版本），新增福利時必須同步在此登錄。

### 新增福利的步驟

1. 在 `tracker_template.json` 加入新項目
2. 在 `README.md` 的「帳號類型速查表」對應分類加一列，**同時**在 `README.en.md` 的
   `Account Type Quick Reference` 加對應的英文列
3. 在 `references/benefits-catalog.zh-TW.md` 和 `references/benefits-catalog.md` 各加一列
4. 若改動了福利總數，記得更新兩份 README 開頭的數字與「包含哪些福利」表格的合計
5. 執行下方對照指令確認沒漏
6. 提交 Pull Request

### 送 PR 前的對照指令

兩份 README 的章節數、表格列數、外部連結數應完全一致：

```bash
printf "章節  zh:%s en:%s\n表格  zh:%s en:%s\n連結  zh:%s en:%s\n" \
  "$(grep -c '^#\{2,4\} ' README.md)"            "$(grep -c '^#\{2,4\} ' README.en.md)" \
  "$(grep -c '^|' README.md)"                    "$(grep -c '^|' README.en.md)" \
  "$(grep -o 'https\?://[^)]*' README.md | sort -u | wc -l)" \
  "$(grep -o 'https\?://[^)]*' README.en.md | sort -u | wc -l)"
```

三行的兩個數字都相同才算同步。連結若對不上，用這行找出差在哪：

```bash
diff <(grep -o 'https\?://[^)]*' README.md | sort -u) \
     <(grep -o 'https\?://[^)]*' README.en.md | sort -u)
```

> 預期會有兩處**刻意**的差異：`microsoft.com/zh-tw/...` 與 `oracle.com/tw/...`
> 在英文版移除了語系路徑。除此之外的差異都是漏改。

### 換行格式

`.gitattributes` 已將所有檔案鎖為 LF（`*.ps1` 除外，維持 CRLF）。
Windows 使用者不需要調整 `core.autocrlf`——若 `git status` 出現整檔變更，
執行 `git add --renormalize .` 即可。

## 授權

MIT

## 參考資料

- 福利清單參考自 [2025-2026 台灣學生免費訂閱指南](https://claude-world.com/zh-tw/articles/taiwan-student-free-subscriptions-guide-2025-2026/)
- 使用 [Claude Code](https://claude.ai/claude-code) 建立
