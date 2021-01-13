# Frank Maxwitat Jan 2021, version 1.0
# Mind that the script below will create a scheduled task that deletes any IIS logs older than 30 days (therefore -30)

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -command "& {Get-ChildItem -Path c:\inetpub\logs\logfiles\w3svc*\*.log | where {$_.LastWriteTime -lt (get-date).AddDays(-30)} | Remove-Item}"'
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday -At 5am
$settingsSet = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 5)
Register-ScheduledTask -User 'System' -Force -Action $action -Trigger $trigger -Settings $settingsSet -TaskName "CleanIISLogs" -Description "Weekly cleanup of IIS log"