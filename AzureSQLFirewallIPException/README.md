# AzureSQLFirewallIPException
Script for temporary AzureSQL Firewall IP exception. 

Allowing all services to access our database is not good idea nor adding exception for all Azure services.
What if you need to backup your database or run T-SQL scripts in deployment pipeline and your agent is not able to connect to server?
Add this script as PowerShell script to your job.

- *Add RBAC permission for your service connection on AzureSQL server - (at least SQL security manager role)*

- *Add step*
```YAML
steps:
- task: AzurePowerShell@5
  displayName: 'Azure PS: Add SQL Agent IP exception'
  inputs:
    azureSubscription: '(RG-NAME) Subscription-Name'
    ScriptPath: '$(System.DefaultWorkingDirectory)/_DeploymentUtilities/PowerShellScripts/AzureSQLFirewallIPException.ps1'
    ScriptArguments: '-ResourceGroup "RG-NAME" -SQLServerName "db-srv-test" -Action "Add"'
    azurePowerShellVersion: LatestVersion
  enabled: false
```
  
- *Remove step*
```YAML
steps:
- task: AzurePowerShell@5
  displayName: 'Azure PS: Remove SQL Agent IP exception'
  inputs:
    azureSubscription: '(RG-NAME) Subscription-Name'
    ScriptPath: '$(System.DefaultWorkingDirectory)/_DeploymentUtilities/PowerShellScripts/AzureSQLFirewallIPException.ps1'
    ScriptArguments: '-ResourceGroup "RG-NAME" -SQLServerName "db-srv-test" -Action "Remove"'
    azurePowerShellVersion: LatestVersion
  enabled: false
```
