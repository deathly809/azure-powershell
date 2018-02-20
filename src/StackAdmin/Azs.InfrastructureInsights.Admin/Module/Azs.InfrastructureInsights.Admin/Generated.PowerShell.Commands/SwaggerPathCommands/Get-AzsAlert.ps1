<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns the list of all alerts in a given region.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER Region
    Name of the region

.PARAMETER ResourceGroupName
    resourceGroupName.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Name
    Name of the alert.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

#>
function Get-AzsAlert
{
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert])]
    [CmdletBinding(DefaultParameterSetName='Alerts_List')]
    param(    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Alerts_Get')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
        [string]
        $Filter,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Get')]
        [System.String]
        $Region,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Get')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Alerts_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Get')]
        [Alias('AlertName')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
        [int]
        $Top = -1,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Alerts_List')]
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
 
    $AlertName = $Name

 
    if('InputObject_Alerts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/alerts/{alertName}'
        }

        if('ResourceId_Alerts_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $region = $ArmResourceIdParameterValues['region']

        $alertName = $ArmResourceIdParameterValues['alertName']
    }

$filterInfos = @(
@{
    'Type' = 'powershellWildcard'
    'Value' = $AlertName
    'Property' = 'Name' 
})
$applicableFilters = Get-ApplicableFilters -Filters $filterInfos
if ($applicableFilters | Where-Object { $_.Strict }) {
    Write-Verbose -Message 'Performing server-side call ''Get-AzsAlert -'''
    $serverSideCall_params = @{

}

$serverSideResults = Get-AzsAlert @serverSideCall_params
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
    if ('Alerts_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
        $TaskResult = $InfrastructureInsightsAdminClient.Alerts.ListWithHttpMessagesAsync($ResourceGroupName, $Region, $(if ($oDataQuery) { New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]" -ArgumentList $oDataQuery } else { $null }))
    } elseif ('Alerts_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Alerts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
        $TaskResult = $InfrastructureInsightsAdminClient.Alerts.GetWithHttpMessagesAsync($ResourceGroupName, $Region, $AlertName)
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
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]' -as [Type]            
        Get-TaskResult @GetTaskResult_params
            
        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $InfrastructureInsightsAdminClient.Alerts.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

