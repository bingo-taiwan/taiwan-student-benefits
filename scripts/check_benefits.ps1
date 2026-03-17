# Student Benefits Reminder (Windows)
# Reads tracker.json and shows pending benefits with desktop notification
# All output in English to avoid PowerShell encoding issues

param(
    [string]$TrackerPath = "",
    [string]$LogPath = ""
)

# --- Resolve paths ---
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BaseDir   = Split-Path -Parent $ScriptDir

if (-not $TrackerPath) { $TrackerPath = Join-Path $BaseDir "student_benefits_tracker.json" }
if (-not $LogPath)     { $LogPath     = Join-Path $BaseDir "reminder.log" }

$Now = Get-Date

# --- Logging ---
function Log($msg) {
    $msg | Tee-Object -FilePath $LogPath -Append
}

# --- Load tracker ---
if (-not (Test-Path $TrackerPath)) {
    Log "[ERROR] Tracker not found: $TrackerPath"
    Log "Run the skill first to generate student_benefits_tracker.json"
    exit 1
}

try {
    $raw = Get-Content $TrackerPath -Raw -Encoding UTF8
    $tracker = $raw | ConvertFrom-Json
} catch {
    Log "[ERROR] Failed to parse tracker: $_"
    exit 1
}

# --- Header ---
$Divider = "=" * 55
$ts = $Now.ToString("yyyy-MM-dd HH:mm")
Log $Divider
Log "Student Benefits Reminder - $ts"
Log $Divider

# --- Check GitHub Pack status ---
$packStatus = $tracker.github_pack_status
$packDate   = $tracker.github_pack_approved_date

Log ""
Log "[GitHub Student Pack] Status: $packStatus"

if ($packStatus -eq "not_applied") {
    Log "  >>> Apply now: https://education.github.com/pack"
    Log "  This unlocks 12+ premium services worth ~$2,200/yr"
}

# --- Categorize benefits ---
$pending   = @()
$packWait  = @()
$done      = @()
$expiring  = @()

foreach ($b in $tracker.benefits) {
    if ($b.status -eq "done") {
        # Check expiry
        if ($b.expiry_date) {
            $exp = [datetime]$b.expiry_date
            $daysLeft = ($exp - $Now).TotalDays
            if ($daysLeft -le 30 -and $daysLeft -gt 0) {
                $expiring += $b
            }
        }
        $done += $b
        continue
    }
    if ($b.status -eq "skipped") { continue }

    # pending
    if ($b.requires_pack -and $packStatus -ne "approved") {
        $packWait += $b
    } else {
        $pending += $b
    }
}

# --- Show actionable items ---
if ($pending.Count -gt 0) {
    Log ""
    Log "[ACTION REQUIRED] $($pending.Count) benefits ready to claim:"
    foreach ($b in $pending) {
        $val = if ($b.value) { " ($($b.value))" } else { "" }
        Log "  [ ] $($b.name)$val"
        Log "      $($b.url)"
    }
}

# --- Show Pack-dependent items ---
if ($packWait.Count -gt 0) {
    Log ""
    Log "[WAITING FOR PACK] $($packWait.Count) benefits need GitHub Pack approval first:"
    foreach ($b in $packWait) {
        $val = if ($b.value) { " ($($b.value))" } else { "" }
        Log "  [~] $($b.name)$val"
    }
}

# --- Show expiring items ---
if ($expiring.Count -gt 0) {
    Log ""
    Log "[EXPIRING SOON] $($expiring.Count) benefits need renewal:"
    foreach ($b in $expiring) {
        $exp = [datetime]$b.expiry_date
        $daysLeft = [math]::Floor(($exp - $Now).TotalDays)
        Log "  [!] $($b.name) - expires in $daysLeft days ($($b.expiry_date))"
        Log "      $($b.url)"
    }
}

# --- Summary ---
Log ""
Log "Summary: $($pending.Count) actionable | $($packWait.Count) waiting for Pack | $($done.Count) done | $($expiring.Count) expiring"
Log "Tracker: $TrackerPath"
Log $Divider

# --- Desktop notification ---
$totalAction = $pending.Count + $expiring.Count
if ($totalAction -gt 0) {
    try {
        Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
        $notify = New-Object System.Windows.Forms.NotifyIcon
        $notify.Icon = [System.Drawing.SystemIcons]::Information
        $notify.Visible = $true
        $notify.ShowBalloonTip(
            8000,
            "Student Benefits",
            "$totalAction items need your attention. Check reminder.log",
            [System.Windows.Forms.ToolTipIcon]::Info
        )
        Start-Sleep -Seconds 9
        $notify.Dispose()
    } catch {
        # No GUI available (headless/SSH) - skip silently
    }
}
