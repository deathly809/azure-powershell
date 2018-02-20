<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns a list of all edge gateway pools at a location.

.PARAMETER Name
    Name of the edge gateway pool.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceGroupName
    Name of the resource group.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Location
    Location of the resource.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Fabric.Admin.Models.EdgeGatewayPool.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

#>
function Get-AzsEdgeGatewayPool
{
    [OutputType([Microsoft.AzureStack.Management.Fabric.Admin.Models.EdgeGatewayPool])]
    [CmdletBinding(DefaultParameterSetName='EdgeGatewayPools_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'EdgeGatewayPools_Get')]
        [Alias('EdgeGatewayPool')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'EdgeGatewayPools_List')]
        [string]
        $Filter,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'EdgeGatewayPools_List')]
        [int]
        $Skip = -1,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'EdgeGatewayPools_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'EdgeGatewayPools_Get')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_EdgeGatewayPools_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'EdgeGatewayPools_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'EdgeGatewayPools_Get')]
        [System.String]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_EdgeGatewayPools_Get')]
        [Microsoft.AzureStack.Management.Fabric.Admin.Models.EdgeGatewayPool]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'EdgeGatewayPools_List')]
        [int]
        $Top = -1
    )

    Begin 
    {
	    Initialize-PSSwaggerDependencies -Azure
        $tracerObject = $null
        if (('continue' -eq $DebugPreference) -or ('inquire' -eq $DebugPreference)) {
            $oldDebugPreference = $global:DebugPreference
			$global:DebugPreference = "continue"
            $tracerObject = New-PSSwaggerClientTracing
            Register-PSSwaggerClientTracing -TracerObject $tracerObject
        }
	}

    Process {
    
    $ErrorActionPreference = 'Stop'

    $NewServiceClient_params = @{
        FullClientTypeName = 'Microsoft.AzureStack.Management.Fabric.Admin.FabricAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $FabricAdminClient = New-ServiceClient @NewServiceClient_params

    

    $oDataQuery = ""
    if ($Filter) { $oDataQuery += "&`$Filter=$Filter" }
    $oDataQuery = $oDataQuery.Trim("&")
 
    $EdgeGatewayPool = $Name

 
    if('InputObject_EdgeGatewayPools_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_EdgeGatewayPools_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fabric.Admin/fabricLocations/{location}/edgeGatewayPools/{edgeGatewayPool}'
        }

        if('ResourceId_EdgeGatewayPools_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $location = $ArmResourceIdParameterValues['location']

        $edgeGatewayPool = $ArmResourceIdParameterValues['edgeGatewayPool']
    }

$filterInfos = @(
@{
    'Type' = 'powershellWildcard'
    'Value' = $EdgeGatewayPool
    'Property' = 'Name' 
})
$applicableFilters = Get-ApplicableFilters -Filters $filterInfos
if ($applicableFilters | Where-Object { $_.Strict }) {
    Write-Verbose -Message 'Performing server-side call ''Get-AzsEdgeGatewayPool -'''
    $serverSideCall_params = @{

}

$serverSideResults = Get-AzsEdgeGatewayPool @serverSideCall_params
foreach ($serverSideResult in $serverSideResults) {
    $valid = $true
    foreach ($applicableFilter in $applicableFilters) {
        if (-not (Test-FilteredResult -Result $serverSideResult -Filter $applicableFilter.Filter)) {
            $valid = $false
            break
        }
    }

    if ($valid) {
        $serverSideResult
    }
}
return
}
    if ('EdgeGatewayPools_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_EdgeGatewayPools_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_EdgeGatewayPools_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.EdgeGatewayPools.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $EdgeGatewayPool)
    } elseif ('EdgeGatewayPools_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.EdgeGatewayPools.ListWithHttpMessagesAsync($ResourceGroupName, $Location, $(if ($oDataQuery) { New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.Fabric.Admin.Models.EdgeGatewayPool]" -ArgumentList $oDataQuery } else { $null }))
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    if ($TaskResult) {
        $GetTaskResult_params = @{
            TaskResult = $TaskResult
        }

        $TopInfo = @{
            'Count' = 0
            'Max' = $Top
        }
        $GetTaskResult_params['TopInfo'] = $TopInfo 
        $SkipInfo = @{
            'Count' = 0
            'Max' = $Skip
        }
        $GetTaskResult_params['SkipInfo'] = $SkipInfo 
        $PageResult = @{
            'Result' = $null
        }
        $GetTaskResult_params['PageResult'] = $PageResult 
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Fabric.Admin.Models.EdgeGatewayPool]' -as [Type]            
        Get-TaskResult @GetTaskResult_params
            
        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $FabricAdminClient.EdgeGatewayPools.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
            $GetTaskResult_params['TaskResult'] = $TaskResult
            $GetTaskResult_params['PageResult'] = $PageResult
            Get-TaskResult @GetTaskResult_params
        }
    }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

