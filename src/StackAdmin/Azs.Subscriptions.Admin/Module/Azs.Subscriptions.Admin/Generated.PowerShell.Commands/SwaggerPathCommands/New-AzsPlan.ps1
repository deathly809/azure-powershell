<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Creates a new plan

.DESCRIPTION
    Creates a new plan

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER DisplayName
    Display name.

.PARAMETER QuotaIds
    Quota identifiers under the plan.

.PARAMETER SkuIds
    SKU identifiers.

.PARAMETER ExternalReferenceId
    External reference identifier.

.PARAMETER Description
    Description of the plan.

.PARAMETER Location
    Location of the resource.

.PARAMETER Name
    Name of the plan.

.PARAMETER SubscriptionCount
    Subscription count.

.EXAMPLE
    PS C:\> New-AzsPlan -Name "plan1" -ResourceGroupName "rg1" -QuotaIds "/subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/providers/Microsoft.Subscriptions.Admin/locations/local/quotas/delegatedProviderQuota" -Location "local" -DisplayName "plan1" -Description "asda"

    Description         : asda
    DisplayName         : plan1
    ExternalReferenceId : 
    QuotaIds            : {/subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/providers/Microsoft.Subscriptions.Admin/locations/local/quotas/delegatedProviderQuota}
    PlanName            : plan1
    SubscriptionCount   : 0
    SkuIds              : 
    Id                  : /subscriptions/0a823c45-d9e7-4812-a138-74e22213693a/resourceGroups/rg1/providers/Microsoft.Subscriptions.Admin/plans/plan1
    Name                : plan1
    Type                : Microsoft.Subscriptions.Admin/plans
    Location            : local
    Tags                : 

#>
[CmdletBinding]
function New-AzsPlan
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Admin.Models.Plan])]
    [CmdletBinding(DefaultParameterSetName='Plans_CreateOrUpdate')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_CreateOrUpdate')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_CreateOrUpdate')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_CreateOrUpdate')]
        [string]
        $DisplayName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Plans_CreateOrUpdate')]
        [string[]]
        $QuotaIds,

        [Parameter(Mandatory = $false, ParameterSetName = 'Plans_CreateOrUpdate')]
        [string]
        $Description,

        [Parameter(Mandatory = $false, ParameterSetName = 'Plans_CreateOrUpdate')]
        [string[]]
        $SkuIds,

        [Parameter(Mandatory = $false, ParameterSetName = 'Plans_CreateOrUpdate')]
        [string]
        $ExternalReferenceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Plans_CreateOrUpdate')]
        [string]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Plans_CreateOrUpdate')]
        [int64]
        $SubscriptionCount
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.Admin.SubscriptionsAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $SubscriptionsAdminClient = New-ServiceClient @NewServiceClient_params
    
    if (-not $PSBoundParameters.ContainsKey('Location'))
    {
         $Location = (Get-AzureRMLocation).Location
         $PSBoundParameters.Add("Location", $Location)
    }

    $flattenedParameters = @('Description', 'Id', 'Type', 'SkuIds', 'Tags', 'ExternalReferenceId', 'DisplayName', 'Name', 'Location', 'QuotaIds', 'SubscriptionCount')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $NewPlan = New-PlanObject @utilityCmdParams

    $Plan = $Name

    if('InputObject_Plans_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Plans_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/plans/{plan}'
        }

        if('ResourceId_Plans_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $plan = $ArmResourceIdParameterValues['plan']
    }


    if ('Plans_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Plans_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Plans_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsAdminClient.'
        $TaskResult = $SubscriptionsAdminClient.Plans.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Plan, $NewPlan)
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