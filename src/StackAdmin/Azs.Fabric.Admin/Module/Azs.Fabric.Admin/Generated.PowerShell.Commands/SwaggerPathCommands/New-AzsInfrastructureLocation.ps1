<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Creates or updates a fabric location.  This will fail if called outside deployment.

.PARAMETER Id
    URI of the resource.

.PARAMETER Type
    Type of resource.

.PARAMETER Tags
    List of key value pairs.

.PARAMETER Name
    Name of the resource.

.PARAMETER ResourceGroupName
    Name of the resource group.

.PARAMETER Location
    Region Location of resource.

.PARAMETER Properties
    Empty object.

#>
function New-AzsInfrastructureLocation
{
    [OutputType([Microsoft.AzureStack.Management.Fabric.Admin.Models.FabricLocation])]
    [CmdletBinding(DefaultParameterSetName='FabricLocations_Create')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'FabricLocations_Create')]
        [string]
        $Id,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'FabricLocations_Create')]
        [string]
        $Type,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'FabricLocations_Create')]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $Tags,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'FabricLocations_Create')]
        [string]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'FabricLocations_Create')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'FabricLocations_Create')]
        [string]
        $Location,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'FabricLocations_Create')]
        [object]
        $Properties
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

        
    $flattenedParameters = @('Id', 'Type', 'Tags', 'Name', 'Location', 'Properties')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $FabricObject = New-FabricLocationObject @utilityCmdParams



    if ('FabricLocations_Create' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.FabricLocations.CreateWithHttpMessagesAsync($ResourceGroupName, $FabricObject)
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

