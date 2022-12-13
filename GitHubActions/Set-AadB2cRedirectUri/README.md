Useful when you need to quickly update redirect URI in your Azure Active Directory B2C (works in standard tenant too) for example if you are creating preview slots on pull requests

## How to use

Below step will add uri passed in Uri parameter if ${{ github.event.action }} is different than "Closed". On PR close it will remove passed redirect uri from app registration.

```
- name: Update b2c
  id: update-b2c
  run: |
    . ".\infrastructure\scripts\Set-AadB2cRedirectUri.ps1"  -Uri "${{ steps.set-variables.outputs.websiteUrl }}" `
                                                            -ApplicationObjectId "${{ inputs.b2cApplicationObjectId }}" `
                                                            -GithubEventAction "${{ github.event.action }}"
```  
