
param(
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroup,

    [Parameter(Mandatory=$true)]
    [string]$SQLServerName,

    [Parameter(Mandatory=$true)]
    [ValidateSet('Add','Remove')]
    [string]$Action
)

$ip = Invoke-RestMethod https://ipinfo.io/json `
        | Select-Object -ExpandProperty ip

if ($Action -eq "Add")
{
    New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroup `
                                -ServerName $SQLServerName `
                                -FirewallRuleName "temp_devops_agent_$($ip)" `
                                -StartIpAddress $ip `
                                -EndIpAddress $ip

    Write-Host "Added temp_devops_agent_$($ip) rule to $($SQLServerName)"
}
elseif ($Action -eq "Remove")
{
    Remove-AzSqlServerFirewallRule  -FirewallRuleName "temp_devops_agent_$($ip)" `
                                    -ResourceGroupName $ResourceGroup `
                                    -ServerName $SQLServerName

    Write-Host "Removed temp_devops_agent_$($ip) rule from $($SQLServerName)"
}
