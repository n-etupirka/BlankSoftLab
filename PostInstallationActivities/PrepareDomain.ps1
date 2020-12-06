Start-Transcript -Path C:\Windows\Temp\postinstallation.log -append

$CurrentFolder = (Split-Path $myInvocation.MyCommand.path -Parent)
$CurrentDomain = (Get-ADDomain).DNSRoot
$WorkFolder = "$CurrentFolder\$CurrentDomain"
$Users = Import-Csv -Path "$WorkFolder\users.csv" -Encoding UTF8

ForEach ($User in $Users) {
    $Password = $User.Password | ConvertTo-SecureString -AsPlainText -Force
    New-ADUser -Name $User.Name `
            -AccountPassword $Password `
            -PasswordNeverExpires $true `
            -Enabled $true
}

Stop-Transcript