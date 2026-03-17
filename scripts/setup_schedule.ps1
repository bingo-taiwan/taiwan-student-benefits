# Set up Windows Task Scheduler for Student Benefits reminders
# Run this script once with: powershell -ExecutionPolicy Bypass -File setup_schedule.ps1

param(
    [string]$ScriptPath = ""
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $ScriptPath) {
    $ScriptPath = Join-Path $ScriptDir "check_benefits.ps1"
}

if (-not (Test-Path $ScriptPath)) {
    Write-Host "[ERROR] Script not found: $ScriptPath" -ForegroundColor Red
    exit 1
}

$runArg = "-NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$ScriptPath`""

# Task 1: Daily reminder at 09:00
$a1 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $runArg
$t1 = New-ScheduledTaskTrigger -Daily -At "09:00AM"
$s1 = New-ScheduledTaskSettingsSet -StartWhenAvailable -DontStopOnIdleEnd
Register-ScheduledTask -TaskName "StudentBenefits_DailyReminder" -Action $a1 -Trigger $t1 -Settings $s1 -RunLevel Highest -Force
Write-Host "[OK] Task 1: DailyReminder (every day 09:00)" -ForegroundColor Green

# Task 2: Weekly Monday reminder to update tracker
$a2 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $runArg
$t2 = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Monday -At "09:00AM"
Register-ScheduledTask -TaskName "StudentBenefits_WeeklyUpdate" -Action $a2 -Trigger $t2 -RunLevel Highest -Force
Write-Host "[OK] Task 2: WeeklyUpdate (every Monday 09:00)" -ForegroundColor Green

# Verify
Write-Host ""
Write-Host "=== Registered Tasks ===" -ForegroundColor Cyan
Get-ScheduledTask | Where-Object { $_.TaskName -like "StudentBenefits_*" } | Select-Object TaskName, State | Format-Table -AutoSize

Write-Host ""
Write-Host "To remove all tasks:" -ForegroundColor Yellow
Write-Host "  Get-ScheduledTask 'StudentBenefits_*' | Unregister-ScheduledTask -Confirm" -ForegroundColor Yellow
