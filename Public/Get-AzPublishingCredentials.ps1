function Get-AzPublishingCredentials {
    [CmdletBinding()]
    param (
        [string]
        $ResourceGroupName,

        [string]
        $ResourceName,

        [string]
        $ApiVersion = '2018-02-01',

        [switch]
        $AsBase64EncodedString
    )

    $invokeAzResourceActionSplat = @{
        ResourceGroupName = $ResourceGroupName
        ResourceType      = 'Microsoft.Web/sites/config'
        ResourceName      = "{0}/publishingcredentials" -f $ResourceName
        Action            = 'list'
        ApiVersion        = $ApiVersion
    }

    $publishingCreds = Invoke-AzResourceAction @invokeAzResourceActionSplat -Force |
    Select-Object -ExpandProperty Properties |
    Select-Object publishingUserName, publishingPassword
    
    if ($AsBase64EncodedString) {
        [System.Convert]::ToBase64String(
            [System.Text.Encoding]::ASCII.GetBytes(
                ("{0}:{1}" -f $publishingCreds.publishingUserName, $publishingCreds.publishingPassword)
            )
        )
    }
    else {
        $publishingCreds
    }
}