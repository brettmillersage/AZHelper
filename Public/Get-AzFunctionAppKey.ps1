function Get-AzFunctionAppKey {
    [CmdletBinding()]
    param (
        [string]
        $FunctionAppName,

        [string]
        $functionName,

        [string]
        $Token
    )

    $invokeRestMethodSplat = @{
        Method  = 'GET'
        Headers = @{
            Authorization = "Bearer {0}" -f $Token
        }
        Uri     = 'https://{0}.azurewebsites.net/admin/functions/{1}/keys' -f $FunctionAppName, $FunctionName
    }

    Invoke-RestMethod @invokeRestMethodSplat | Select-Object -ExpandProperty keys
}