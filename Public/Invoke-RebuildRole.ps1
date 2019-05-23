function Invoke-RebuildRole {
    [CmdletBinding(DefaultParameterSetName = 'SubscriptionId',
        SupportsShouldProcess)]
    param (
        [Parameter(Mandatory,
        ParameterSetName = 'SubscriptionName')]
        [string]
        $SubscriptionName,

        [Parameter(Mandatory,
            ParameterSetName = 'SubscriptionId')]
        $SubscriptionId,

        [Parameter(Mandatory)]
        $CloudServiceName,

        [Parameter(Mandatory)]
        [ValidateSet('Production','Staging')]
        $DeploymentSlot,

        [Parameter(Mandatory)]
        $RoleInstanceName
    )

    begin {
        $uri = Build-ManagementApiUri @PSBoundParameters
        $requestHeaders = @{
            'Content-Type' = 'application/xml'
            'x-ms-version' = '2014-05-01'
            ContentLength  = 0
            Authorization  = (Get-AzBearerToken)
        }
    }

    process {
        if ($pscmdlet.ShouldProcess("$RoleInstanceName", "Sending Rebuild API call")) {
            try {
                $invokeRestMethodSplat = @{
                    Uri     = $uri
                    Method  = 'Post'
                    Headers = $requestHeaders
                }

                Invoke-RestMethod @invokeRestMethodSplat -ErrorAction Stop
            }
            catch {
                throw $_
            }
        }
    }
}