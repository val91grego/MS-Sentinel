# This script performs the following actions:
# 1. Clones Microsoft Azure Sentinel Official Githup repo
# 2. Install Wortell AzSentinel Powershell Module
# 3. After connecting to an Azure Tenant and selecting the correct Subscription, imports specific Analytic Rules
# 4. Validates Rules Imported Succesfully.

# Parameters Initialization
param(

[Parameter(Mandatory=$true)]$SubscriptionId,
[Parameter(Mandatory=$true)]$Workspace
)

# Choose Location
Set-Location -Path C:\Users\g.valtas\GitProjects\Sentinel

# Clone Azure Sentinel GitHub Repo
git clone https://github.com/Azure/Azure-Sentinel.git

# PS Modules Installation
Install-Module AzSentinel -Scope CurrentUser -Force
Install-Module -Name powershell-yaml
Import-Module AzSentinel

# Connect Azure AD
Connect-AzAccount

# Select Subscription with Azure Sentinel/Log Analytics 
Set-AzContext -SubscriptionId $SubscriptionId

# Import Analytic Rules from .yaml files inside the "Detections" folder
Get-Item .\Azure-Sentinel\Detections\SigninLogs\*.yaml | Import-AzSentinelAlertRule -WorkspaceName $Workspace
Get-Item .\Azure-Sentinel\Detections\AuditLogs\*.yaml | Import-AzSentinelAlertRule -WorkspaceName $Workspace
Get-Item .\Azure-Sentinel\Detections\AzureActivity\*.yaml | Import-AzSentinelAlertRule -WorkspaceName $Workspace
Get-Item .\Azure-Sentinel\Detections\OfficeActivity\*.yaml | Import-AzSentinelAlertRule -WorkspaceName $Workspace

# Import Rule Verification
Get-AzSentinelAlertRule -WorkspaceName $Workspace | Select "displayName"