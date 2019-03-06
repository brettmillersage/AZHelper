function Copy-AzBearerTokenToClipBoard {
    <#
    .SYNOPSIS
    Copy the bearer token to the clipboard

    .DESCRIPTION
    Copy the current bearer token string to the clipboard. To be used in headers of API calls

    .EXAMPLE
    Copy-AzBearertokenToClipBoard
    #>
    [CmdletBinding()]
    param ()
    Get-AzBearerToken | Set-Clipboard
}