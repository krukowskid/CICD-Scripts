param(
    [Parameter(Mandatory=$true)]
    [string]$Uri,
    [Parameter(Mandatory=$true)]
    [string]$ApplicationObjectId,
    [Parameter(Mandatory=$false)]
    [string]$GithubEventAction
)

if ($GithubEventAction -eq 'closed')
{
    $redirectUri = (Get-AzADApplication -objectId $ApplicationObjectId).Spa.RedirectUri `
                        | Where-Object { 
                            $_ -ne "$Uri" 
                        } | select -unique

    Update-AzADApplication  -objectId $ApplicationObjectId `
                            -SPARedirectUri $redirectUri
}
else 
{
    $redirectUri = (Get-AzADApplication -objectId $ApplicationObjectId).Spa.RedirectUri
    $redirectUri += $Uri
    $redirectUri = $redirectUri | select -unique
    Update-AzADApplication  -objectId $ApplicationObjectId `
                            -SPARedirectUri $redirectUri
}