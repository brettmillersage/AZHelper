function Build-ManagementApiUri {
    [CmdletBinding(DefaultParameterSetName = 'SubscriptionId',
        SupportsShouldProcess)]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseApprovedVerbs', '')]
    [OutputType([String])]
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

    $BaseUri = 'https://management.core.windows.net'
    $Resources = 'allLocalDrives'

    if ($PSCmdlet.ParameterSetName -eq 'SubscriptionName') {
        $SubscriptionId = Get-AzSubscription -SubscriptionName $SubscriptionName | Select-Object -ExpandProperty Id
    }
    
    $array = @(
        $BaseUri
        $SubscriptionId
        "services"
        "hostedservices"
        $CloudServiceName
        "deploymentslots"
        $DeploymentSlot
        "roleinstances"
        $RoleInstanceName
        ) -join '/'
        
        $array += "?comp=rebuild"
        $array += "&resources={0}" -f $Resources
        
    if ($PSCmdlet.ShouldProcess("$RoleInstanceName", "Generating Rebuild API URI")) {
        $array
    }
}