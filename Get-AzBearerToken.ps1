function Get-AzBearerToken {
    <#
    .SYNOPSIS
    Get Access token as a Bearer token string
    
    .DESCRIPTION
    Get the access token from the current Az Context and present as a bearer token string. To be used in headers of API calls
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    
    [CmdletBinding()]
    param ()
    ('Bearer {0}' -f (Get-AzCachedAccessToken))
}
