<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Deletes a specific gallery registration

.DESCRIPTION
    

.PARAMETER GalleryItemName
    Identity of the gallery item. Includes publisher name, item name and may include version separated by period character.

#>
function Remove-Registration
{
    [CmdletBinding(DefaultParameterSetName='Registrations_Delete')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Registrations_Delete')]
        [System.String]
        $GalleryItemName
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Gallery.Admin.GalleryAdminClient'
    }

    $GlobalParameterHashtable = @{}      
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }
 
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable 
    $GalleryAdminClient = New-ServiceClient @NewServiceClient_params
    
    
    

    $skippedCount = 0
    $returnedCount = 0
    if ('Registrations_Delete' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $GalleryAdminClient.'
        $taskResult = $GalleryAdminClient.Registrations.DeleteWithHttpMessagesAsync($GalleryItemName)
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    if ($TaskResult) {
        $result = $null
        $ErrorActionPreference = 'Stop'
                    
        $null = $taskResult.AsyncWaitHandle.WaitOne()
                    
        Write-Debug -Message "$($taskResult | Out-String)"


        if((Get-Member -InputObject $taskResult -Name 'Result') -and
           $taskResult.Result -and
           (Get-Member -InputObject $taskResult.Result -Name 'Body') -and
           $taskResult.Result.Body)
        {
            Write-Verbose -Message 'Operation completed successfully.'
            $result = $taskResult.Result.Body
            Write-Debug -Message "$($result | Out-String)"
            $result
        }
        elseif($taskResult.IsFaulted)
        {
            Write-Verbose -Message 'Operation failed.'
            if ($taskResult.Exception)
            {
                if ((Get-Member -InputObject $taskResult.Exception -Name 'InnerExceptions') -and $taskResult.Exception.InnerExceptions)
                {
                    foreach ($ex in $taskResult.Exception.InnerExceptions)
                    {
                        Write-Error -Exception $ex
                    }
                } elseif ((Get-Member -InputObject $taskResult.Exception -Name 'InnerException') -and $taskResult.Exception.InnerException)
                {
                    Write-Error -Exception $taskResult.Exception.InnerException
                } else {
                    Write-Error -Exception $taskResult.Exception
                }
            }
        } 
        elseif ($taskResult.IsCanceled)
        {
            Write-Verbose -Message 'Operation got cancelled.'
            Throw 'Operation got cancelled.'
        }
        else
        {
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
