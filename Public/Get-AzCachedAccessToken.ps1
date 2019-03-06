function Get-AzCachedAccessToken {
    <#
    .SYNOPSIS
    Get the Bearer token from the currently set AzContext

    .DESCRIPTION
    Get the Bearer token from the currently set AzContext. Retrieves from Get-AzContext

    .EXAMPLE
    Get-AzCachedAccesstoken

    .EXAMPLE
    Get-AzCachedAccesstoken -Verbose

    #>
    [cmdletbinding()]
    param()

    $currentAzureContext = Get-AzContext

    $azureRmProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
    $profileClient = New-Object Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient($azureRmProfile)
    
    Write-Verbose ("Tenant: {0}" -f  $currentAzureContext.Subscription.Name)
    
    $token = $profileClient.AcquireAccessToken($currentAzureContext.Tenant.TenantId)
    $token.AccessToken
}