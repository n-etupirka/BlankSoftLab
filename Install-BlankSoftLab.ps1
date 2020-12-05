# ----------------------------------------------------------
# Global Settings
# ----------------------------------------------------------
$LabName = "BlankSoftLab"
$DomainName = "blank-software.local"
$DomainAdminUser = "sysadmin"
$DomainAdminPassword = "P@ssw0rd123!"
$ServerMemory = 2GB
$ClientMemory = 4GB

# ----------------------------------------------------------
# Lab Install
# ----------------------------------------------------------
New-LabDefinition -Name $LabName -DefaultVirtualizationEngine HyperV

Set-LabInstallationCredential -Username $DomainAdminUser -Password $DomainAdminPassword

Add-LabDomainDefinition -Name $DomainName -AdminUser $DomainAdminUser -AdminPassword $DomainAdminPassword

Add-LabMachineDefinition `
        -Name "DC01" `
        -DomainName $DomainName `
        -Roles RootDC `
        -OperatingSystem 'Windows Server 2019 Standard Evaluation (Desktop Experience)' `
        -Memory $ServerMemory

Add-LabMachineDefinition `
        -Name "WS01" `
        -DomainName $DomainName `
        -OperatingSystem 'Windows 10 Enterprise Evaluation' `
        -Memory $ClientMemory

Install-Lab

Show-LabDeploymentSummary -Detailed