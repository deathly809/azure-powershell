<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns a list of all fabric file shares at a certain location.

.PARAMETER Filter
    OData filter parameter.

.PARAMETER ResourceGroupName
    Name of the resource group.

.PARAMETER Name
    Fabric file share name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Location
    Location of the resource.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Fabric.Admin.Models.FileShare.

#>
function Get-AzsInfrastructureShare
{
    [OutputType([Microsoft.AzureStack.Management.Fabric.Admin.Models.FileShare])]
    [CmdletBinding(DefaultParameterSetName='FileShares_List')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'FileShares_List')]
        [string]
        $Filter,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_Get')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_Get')]
        [Alias('FileShare')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_FileShares_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'FileShares_Get')]
        [System.String]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_FileShares_Get')]
        [Microsoft.AzureStack.Management.Fabric.Admin.Models.FileShare]
        $InputObject
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
 
    $FileShare = $Name

 
    if('InputObject_FileShares_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_FileShares_Get' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fabric.Admin/fabricLocations/{location}/fileShares/{fileShare}'
        }

        if('ResourceId_FileShares_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $location = $ArmResourceIdParameterValues['location']

        $fileShare = $ArmResourceIdParameterValues['fileShare']
    }

$filterInfos = @(
@{
    'Type' = 'powershellWildcard'
    'Value' = $FileShare
    'Property' = 'Name' 
})
$applicableFilters = Get-ApplicableFilters -Filters $filterInfos
if ($applicableFilters | Where-Object { $_.Strict }) {
    Write-Verbose -Message 'Performing server-side call ''Get-AzsInfrastructureShare -'''
    $serverSideCall_params = @{

}

$serverSideResults = Get-AzsInfrastructureShare @serverSideCall_params
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
    if ('FileShares_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_FileShares_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_FileShares_Get' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.FileShares.GetWithHttpMessagesAsync($ResourceGroupName, $Location, $FileShare)
    } elseif ('FileShares_List' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.FileShares.ListWithHttpMessagesAsync($ResourceGroupName, $Location, $(if ($oDataQuery) { New-Object -TypeName "Microsoft.Rest.Azure.OData.ODataQuery``1[Microsoft.AzureStack.Management.Fabric.Admin.Models.FileShare]" -ArgumentList $oDataQuery } else { $null }))
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

