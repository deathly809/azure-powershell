<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Closes the given alert.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Region
    Name of the region

.PARAMETER ResourceGroupName
    resourceGroupName.

.PARAMETER Alert
    Updated Alert Parameter.

.PARAMETER Name
    Name of the alert.

.PARAMETER User
    The username used to perform the operation.

#>
function Close-AzsAlert
{
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert])]
    [CmdletBinding(DefaultParameterSetName='Alerts_Close')]
    param(    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Alerts_Close')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]
        $InputObject,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Alerts_Close')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Close')]
        [System.String]
        $Region,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Close')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_Alerts_Close')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_Alerts_Close')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Close')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]
        $Alert,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Close')]
        [Alias('AlertName')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_Alerts_Close')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_Alerts_Close')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Alerts_Close')]
        [System.String]
        $User
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

    $AlertName = $Name

 
    if('InputObject_Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/alerts/{alertName}'
        }

        if('ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
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


    if ('Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CloseWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
        $TaskResult = $InfrastructureInsightsAdminClient.Alerts.CloseWithHttpMessagesAsync($ResourceGroupName, $Region, $AlertName, $User, $Alert)
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    if ($TaskResult) {
        $GetTaskResult_params = @{
            TaskResult = $TaskResult
        }
            
        Get-TaskResult @GetTaskResult_params
        
    }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

