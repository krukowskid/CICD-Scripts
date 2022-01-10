param (
    [Parameter(Mandatory = $true)]
    [string]$VariableGroupId,
    [Parameter(Mandatory = $true)]
    [string]$VariableName,
    [Parameter(Mandatory = $true)]
    [string]$NewValue
)

Write-Output "NewValue: $NewValue"

$url = "$($env:System_TeamFoundationCollectionUri)$($env:System_TeamProject)/_apis/distributedtask/variablegroups/$($VariableGroupId)?api-version=5.1-preview.1"

$authHeader = @{Authorization = "Bearer $env:SYSTEM_ACCESSTOKEN"}
$definition = Invoke-RestMethod -Uri $url `
                                -Headers $authHeader

$definition.variables.$VariableName.Value = "$($NewValue)"
$definitionJson = $definition `
                    | ConvertTo-Json -Depth 100 `
                                     -Compress

Invoke-RestMethod -Method PUT `
                  -Uri $url `
                  -Headers $authHeader `
                  -ContentType "application/json" `
                  -Body ([System.Text.Encoding]::UTF8.GetBytes($definitionJson)) `
                    | Out-Null
