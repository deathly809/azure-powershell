<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Get the list of update runs.

.PARAMETER Name
    Update run identifier.

.PARAMETER UpdateLocation
    The name of the update location.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun.

.PARAMETER Update
    Name of the update.

#>
function Get-UpdateRun
{
    [OutputType([Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun])]
    [CmdletBinding(DefaultParameterSetName='UpdateRuns_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_Get')]
        [Alias('RunId')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_Get')]
        [System.String]
        $UpdateLocation,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_List')]
        [int]
        $Skip = -1,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'UpdateRuns_List')]
        [int]
        $Top = -1,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_UpdateRuns_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_Get')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_UpdateRuns_Get')]
        [Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun]
        $InputObject,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateRuns_Get')]
        [System.String]
        $Update
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Update.Admin.UpdateAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $UpdateAdminClient = New-ServiceClient @NewServiceClient_params

    $RunId = $Name

 
    if('InputObject_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.Update.Admin/updateLocations/{updateLocation}/updates/{update}/updateRuns/{runId}'
        }

        if('ResourceId_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroup = $ArmResourceIdParameterValues['resourceGroup']

        $updateLocation = $ArmResourceIdParameterValues['updateLocation']

        $update = $ArmResourceIdParameterValues['update']

        $runId = $ArmResourceIdParameterValues['runId']
    }


    if ('UpdateRuns_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $UpdateAdminClient.'
        $TaskResult = $UpdateAdminClient.UpdateRuns.ListWithHttpMessagesAsync($ResourceGroup, $UpdateLocation, $Update)
    } elseif ('UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_UpdateRuns_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $UpdateAdminClient.'
        $TaskResult = $UpdateAdminClient.UpdateRuns.GetWithHttpMessagesAsync($ResourceGroup, $UpdateLocation, $Update, $RunId)
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
        $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Update.Admin.Models.UpdateRun]' -as [Type]            
        Get-TaskResult @GetTaskResult_params
            
        Write-Verbose -Message 'Flattening paged results.'
        while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
            $PageResult.Result = $null
            Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
            $TaskResult = $UpdateAdminClient.UpdateRuns.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

