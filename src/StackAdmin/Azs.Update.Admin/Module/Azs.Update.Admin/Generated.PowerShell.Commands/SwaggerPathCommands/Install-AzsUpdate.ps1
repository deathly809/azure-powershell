<#
Copyright (c) Microsoft and contributors.  All rights reserved.

Licensed under the Apache License, Version 2.0 (the ""License"");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

See the License for the specific language governing permissions and
limitations under the License.

Code generated by Microsoft (R) PSSwagger 0.3.0
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Apply a specific update at an update location.

.PARAMETER UpdateLocation
    The name of the update location.

.PARAMETER Location
    Location of the Azure Stack instance.

.PARAMETER Update
    Name of the update.

#>
function Install-AzsUpdate {
    [OutputType([Microsoft.AzureStack.Management.Update.Admin.Models.Update])]
    [CmdletBinding(DefaultParameterSetName = 'Updates_Apply')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Updates_Apply')]
        [System.String]
        $UpdateLocation,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Updates_Apply')]
        [System.String]
        $Location,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Updates_Apply')]
        [System.String]
        $Update
    )

    Begin {
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
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $UpdateAdminClient = New-ServiceClient @NewServiceClient_params


        if ('Updates_Apply' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ApplyWithHttpMessagesAsync on $UpdateAdminClient.'
            $TaskResult = $UpdateAdminClient.Updates.ApplyWithHttpMessagesAsync($Location, $UpdateLocation, $Update)
        }
        else {
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

