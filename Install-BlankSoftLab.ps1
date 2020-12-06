# ----------------------------------------------------------
# Global Settings
# ----------------------------------------------------------
# Lab Environment
$LabName = "BlankSoftLab"
$ServerMemory = 2GB
$ClientMemory = 4GB

# blank-software.local
$B_DomainName = "blank-software.local"
$B_DomainAdminUser = "sysadmin"
$B_DomainAdminPassword = "P@ssw0rd#123"
$B_LocalAdminUser = "setupadmin"
$B_LocalAdminPassword = "Adm1n#123"

# ----------------------------------------------------------
# Lab Install
# ----------------------------------------------------------
New-LabDefinition -Name $LabName -DefaultVirtualizationEngine HyperV

# ----------------------------------------------------------
# blank-software.local
# ----------------------------------------------------------
Set-LabInstallationCredential -Username $B_DomainAdminUser -Password $B_DomainAdminPassword

Add-LabDomainDefinition -Name $B_DomainName -AdminUser $B_DomainAdminUser -AdminPassword $B_DomainAdminPassword

# Domain Controller
Add-LabMachineDefinition `
        -Name "DC01" `
        -DomainName $B_DomainName `
        -Roles RootDC `
        -OperatingSystem 'Windows Server 2019 Standard Evaluation (Desktop Experience)' `
        -Memory $ServerMemory

# Workstation
$Password = $B_LocalAdminPassword | ConvertTo-SecureString -AsPlainText -Force
$Creds = New-Object System.Management.Automation.PSCredential $B_LocalAdminUser, $Password

Add-LabMachineDefinition `
        -Name "WS01" `
        -DomainName $B_DomainName `
        -OperatingSystem 'Windows 10 Enterprise Evaluation' `
        -Memory $ClientMemory `
        -InstallationUserCredential $Creds

Install-Lab

Show-LabDeploymentSummary -Detailed