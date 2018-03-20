<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Removes the offer delegation

.DESCRIPTION
    Removes the offer delegation

.PARAMETER OfferName
    Name of an offer.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Name
    Name of a offer delegation.

.PARAMETER ResourceGroup
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation.

.PARAMETER Force
    Flag to remove the item without confirmation.

.EXAMPLE
    Remove-AzsOfferDelegation -Offer offer1 -ResourceGroupName rg1 -Name delegation1

#>
function Remove-AzsOfferDelegation
{
    [CmdletBinding(DefaultParameterSetName='OfferDelegations_Delete')]
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_Delete')]
        [string]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_Delete')]
        [System.String]
        $OfferName,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'OfferDelegations_Delete')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_OfferDelegations_Delete')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_OfferDelegations_Delete')]
        [Microsoft.AzureStack.Management.Subscriptions.Admin.Models.OfferDelegation]
        $InputObject,

        [Parameter(Mandatory = $false)]
        [switch]
        $Force
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

    $OfferDelegationName = $Name

    if('InputObject_OfferDelegations_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_OfferDelegations_Delete' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Subscriptions.Admin/offers/{offer}/offerDelegations/{offerDelegationName}'
        }

        if('ResourceId_OfferDelegations_Delete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $offer = $ArmResourceIdParameterValues['offer']

        $offerDelegationName = $ArmResourceIdParameterValues['offerDelegationName']
    }
    
    if ($PSCmdlet.ShouldProcess("$offerDelegationName" , "Delete offer delegation")) {
        if (($Force.IsPresent -or $PSCmdlet.ShouldContinue("Delete offer delegation?", "Performing operation DeleteWithHttpMessagesAsync on $offerDelegationName."))) {

            if ('OfferDelegations_Delete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_OfferDelegations_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_OfferDelegations_Delete' -eq $PsCmdlet.ParameterSetName) {
                Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $SubscriptionsAdminClient.'
                $TaskResult = $SubscriptionsAdminClient.OfferDelegations.DeleteWithHttpMessagesAsync($ResourceGroupName, $OfferName,  $OfferDelegationName)
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
        }
    }
    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}
