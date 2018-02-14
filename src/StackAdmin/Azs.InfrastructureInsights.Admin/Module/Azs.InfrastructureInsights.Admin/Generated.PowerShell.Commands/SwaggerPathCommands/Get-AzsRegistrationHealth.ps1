<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns a list of each resource's health under a service.

.PARAMETER ServiceRegistrationId
    Service registration id.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Region
    Name of the region

.PARAMETER ResourceGroupName
    resourceGroupName.

.PARAMETER Name
    Resource registration id.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

#>
function Get-AzsRegistrationHealth
{
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth])]
    [CmdletBinding(DefaultParameterSetName='ResourceHealths_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceHealths_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceHealths_List')]
        [System.String]
        $ServiceRegistrationId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceHealths_Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceHealths_List')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_ResourceHealths_Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_ResourceHealths_Get')]
        [string]
        $Filter,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceHealths_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceHealths_List')]
        [System.String]
        $Region,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceHealths_Get')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceHealths_List')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceHealths_Get')]
        [Alias('ResourceRegistrationId')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_ResourceHealths_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_ResourceHealths_Get')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceHealths_List')]
        [int]
        $Top = -1,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceHealths_List')]
        [int]
        $Skip = -1
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.InfrastructureInsights.Admin.InfrastructureInsightsAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $InfrastructureInsightsAdminClient = New-ServiceClient @NewServiceClient_params

    

    $oDataQuery = ""
    if ($Filter) { $oDataQuery += "&`$Filter=$Filter" }
    $oDataQuery = $oDataQuery.Trim("&")
 
    $ResourceRegistrationId = $Name

 
    if('InputObject_ResourceHealths_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_ResourceHealths_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/serviceHealths/{serviceRegistrationId}/resourceHealths/{resourceRegistrationId}'
        }

        if('ResourceId_ResourceHealths_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $region = $ArmResourceIdParameterValues['region']

        $serviceRegistrationId = $ArmResourceIdParameterValues['serviceRegistrationId']

        $resourceRegistrationId = $ArmResourceIdParameterValues['resourceRegistrationId']
    }

$filterInfos = @(
@{
    'Type' = 'powershellWildcard'
    'Value' = $ResourceRegistrationId
    'Property' = 'Name' 
})
$applicableFilters = Get-ApplicableFilters -Filters $filterInfos
if ($applicableFilters | Where-Object { $_.Strict }) {
    Write-Verbose -Message 'Performing server-side call ''Get-AzsRegistrationHealth -'''
    $serverSideCall_params = @{

}

$serverSideResults = Get-AzsRegistrationHealth @serverSideCall_params
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
    if ('ResourceHealths_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
        $TaskResult = $InfrastructureInsightsAdminClient.ResourceHealths.ListWithHttpMessagesAsync($ResourceGroupName, $Region, $ServiceRegistrationId, $(if ($oDataQuery) { New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth]" -ArgumentList $oDataQuery } else { $null }))
    } elseif ('ResourceHealths_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_ResourceHealths_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_ResourceHealths_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
        $TaskResult = $InfrastructureInsightsAdminClient.ResourceHealths.GetWithHttpMessagesAsync($ResourceGroupName, $Region, $ServiceRegistrationId, $ResourceRegistrationId, $(if ($PSBoundParameters.ContainsKey('Filter')) { $Filter } else { [NullString]::Value }))
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
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ResourceHealth]' -as [Type]            
        Get-TaskResult @GetTaskResult_params
            
        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $InfrastructureInsightsAdminClient.ResourceHealths.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

