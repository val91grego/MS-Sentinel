# Use this script to export Azure Sentinel Configuration
# Based on https://gist.github.com/pkhabazi/24609dc792c0a73237e2ad1f7fac921c script
# Set Kind = All to export AnalyticRules, HuntingQueries, Templates in JSON format

# Parameters Initialization
param(

[Parameter(Mandatory=$true)]$SubscriptionId,
[Parameter(Mandatory=$true)]$Workspace,
[Parameter(Mandatory=$true)]$Kind,
[Parameter(Mandatory=$true)]$outputfolder
)

# Add AzSentinel Modules
Install-Module AzSentinel -Scope CurrentUser -Force
Import-Module AzSentinel

# Connect to Azure AD 
Connect-AzAccount

# Select Subscription
Set-AzContext -SubscriptionId $SubscriptionId

# Export Configuration
Write-Output "Export kind has been set to "$kind""
Write-Output "Exporting "$Workspace" Azure Sentinel Configuration in the specified folder..."
Write-Output "################"

Export-AzSentinel -SubscriptionId $SubscriptionId -WorkspaceName $Workspace -OutputFolder $outputfolder -Kind $Kind
