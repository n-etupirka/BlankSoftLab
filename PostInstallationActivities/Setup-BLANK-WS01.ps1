Start-Transcript -Path C:\Windows\Temp\postinstallation.log -append

# Add oka_sakura to Administrators
Add-LocalGroupMember -Group Administrators -Member blank-software\oka_sakura

Stop-Transcript