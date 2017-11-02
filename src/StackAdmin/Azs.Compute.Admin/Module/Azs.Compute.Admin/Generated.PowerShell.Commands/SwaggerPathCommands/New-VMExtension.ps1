<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Create a platform images.

.DESCRIPTION
    Create a new platform image.

.PARAMETER VmScaleSetEnabled
    value indicating whether the extension is enabled for virtual machine scale set support

.PARAMETER VmOsType
    Target virtaul machine operating system type necessary for deploying the extension handler

.PARAMETER SupportMultipleExtensions
    True if supports multiple extensions.

.PARAMETER IsSystemExtension
    Denotes if extension is for system or not.

.PARAMETER ComputeRole
    Compute role

.PARAMETER SourceBlob
    URI to azure blob.

.PARAMETER Publisher
    Name of the publisher.

.PARAMETER Version
    The version of the resource.

.PARAMETER Location
    Location of the resource.

#>
function New-VMExtension {
    [OutputType([Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension])]
    [CmdletBinding(DefaultParameterSetName = 'VMExtensions_Create')]
    param(
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [switch]
        $VmScaleSetEnabled,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Microsoft.AzureStack.Management.Compute.Admin.Models.OsType]
        $VmOsType,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [switch]
        $SupportMultipleExtensions,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [switch]
        $IsSystemExtension,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [string]
        $ComputeRole,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Microsoft.AzureStack.Management.Compute.Admin.Models.AzureBlob]
        $SourceBlob,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Publisher,
            
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Type,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Version,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [string]
        $Location
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.Compute.Admin.ComputeAdminClient'
        }

        $GlobalParameterHashtable = @{}      
        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }
 
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable 
        $ComputeAdminClient = New-ServiceClient @NewServiceClient_params
    
    
        
        $flattenedParameters = @('SourceBlob', 'ComputeRole', 'VmOsType', 'SupportMultipleExtensions', 'IsSystemExtension', 'VmScaleSetEnabled')
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }
        $Extension = New-VMExtensionObject @utilityCmdParams


        $skippedCount = 0
        $returnedCount = 0
        if ('VMExtensions_Create' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CreateWithHttpMessagesAsync on $ComputeAdminClient.'
            $taskResult = $ComputeAdminClient.VMExtensions.CreateWithHttpMessagesAsync($Location, $Publisher, $Type, $Version, $Extension)
        }
        else {
            Write-Verbose -Message 'Failed to map parameter set to operation method.'
            throw 'Module failed to find operation to execute.'
        }

        if ($TaskResult) {
            $result = $null
            $ErrorActionPreference = 'Stop'
                    
            $null = $taskResult.AsyncWaitHandle.WaitOne()
                    
            Write-Debug -Message "$($taskResult | Out-String)"


            if ((Get-Member -InputObject $taskResult -Name 'Result') -and
                $taskResult.Result -and
                (Get-Member -InputObject $taskResult.Result -Name 'Body') -and
                $taskResult.Result.Body) {
                Write-Verbose -Message 'Operation completed successfully.'
                $result = $taskResult.Result.Body
                Write-Debug -Message "$($result | Out-String)"
                $result
            }
            elseif ($taskResult.IsFaulted) {
                Write-Verbose -Message 'Operation failed.'
                if ($taskResult.Exception) {
                    if ((Get-Member -InputObject $taskResult.Exception -Name 'InnerExceptions') -and $taskResult.Exception.InnerExceptions) {
                        foreach ($ex in $taskResult.Exception.InnerExceptions) {
                            Write-Error -Exception $ex
                        }
                    }
                    elseif ((Get-Member -InputObject $taskResult.Exception -Name 'InnerException') -and $taskResult.Exception.InnerException) {
                        Write-Error -Exception $taskResult.Exception.InnerException
                    }
                    else {
                        Write-Error -Exception $taskResult.Exception
                    }
                }
            } 
            elseif ($taskResult.IsCanceled) {
                Write-Verbose -Message 'Operation got cancelled.'
                Throw 'Operation got cancelled.'
            }
            else {
                Write-Verbose -Message 'Operation completed successfully.'
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
