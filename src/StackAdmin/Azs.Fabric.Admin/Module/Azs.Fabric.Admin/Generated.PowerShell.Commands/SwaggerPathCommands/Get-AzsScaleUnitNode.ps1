<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns a list of all scale unit nodes in a location.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceGroupName
    Name of the resource group.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Name
    Name of the scale unit node.

.PARAMETER Location
    Location of the resource.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Fabric.Admin.Models.ScaleUnitNode.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

#>
function Get-AzsScaleUnitNode
{
    [OutputType([Microsoft.AzureStack.Management.Fabric.Admin.Models.ScaleUnitNode])]
    [CmdletBinding(DefaultParameterSetName='ScaleUnitNodes_List')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'ScaleUnitNodes_List')]
        [string]
        $Filter,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'ScaleUnitNodes_List')]
        [int]
        $Skip = -1,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_Get')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_ScaleUnitNodes_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_Get')]
        [Alias('ScaleUnitNode')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_Get')]
        [System.String]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_ScaleUnitNodes_Get')]
        [Microsoft.AzureStack.Management.Fabric.Admin.Models.ScaleUnitNode]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'ScaleUnitNodes_List')]
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
 
    $ScaleUnitNode = $Name

 
    if('InputObject_ScaleUnitNodes_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_ScaleUnitNodes_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fabric.Admin/fabricLocations/{location}/scaleUnitNodes/{scaleUnitNode}'
        }

        if('ResourceId_ScaleUnitNodes_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $location = $ArmResourceIdParameterValues['location']

        $scaleUnitNode = $ArmResourceIdParameterValues['scaleUnitNode']
    }

$filterInfos = @(
@{
    'Type' = 'powershellWildcard'
    'Value' = $ScaleUnitNode
    'Property' = 'Name' 
})
$applicableFilters = Get-ApplicableFilters -Filters $filterInfos
if ($applicableFilters | Where-Object { $_.Strict }) {
    Write-Verbose -Message 'Performing server-side call ''Get-AzsScaleUnitNode -'''
    $serverSideCall_params = @{

}

$serverSideResults = Get-AzsScaleUnitNode @serverSideCall_params
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
    if ('ScaleUnitNodes_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_ScaleUnitNodes_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_ScaleUnitNodes_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.ScaleUnitNodes.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $ScaleUnitNode)
    } elseif ('ScaleUnitNodes_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.ScaleUnitNodes.ListWithHttpMessagesAsync($ResourceGroupName, $Location, $(if ($oDataQuery) { New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.Fabric.Admin.Models.ScaleUnitNode]" -ArgumentList $oDataQuery } else { $null }))
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
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Fabric.Admin.Models.ScaleUnitNode]' -as [Type]            
        Get-TaskResult @GetTaskResult_params
            
        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $FabricAdminClient.ScaleUnitNodes.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

