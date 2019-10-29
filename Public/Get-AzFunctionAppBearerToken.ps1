function Get-AzFunctionAppBearerToken {
    [CmdletBinding()]
    param (
        [string]
        $FunctionAppName,
        
        [PSCustomObject]
        $EncodedCredentials
    )

    $Headers = @{
        Authorization = "Basic {0}" -f $EncodedCredentials
    }

    $invokeRestMethodSplat = @{
        Uri     = 'https://{0}.scm.azurewebsites.net/api/functions/admin/token' -f $FunctionAppName
        Method  = 'GET'
        Headers = $Headers
    }

    Invoke-RestMethod @invokeRestMethodSplat
}