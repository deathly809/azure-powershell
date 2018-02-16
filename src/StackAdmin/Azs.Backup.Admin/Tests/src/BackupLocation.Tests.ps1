# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.SYNOPSIS
    Run AzureStack Backup admin backup location test

.DESCRIPTION
    Run AzureStack Backup admin backup location tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.EXAMPLE
    C:\PS> .\src\BackupLocation.Tests.ps1
    Describing BackupLocations
  		[+] TestListBackupLocation 630ms
  		[!] TestSetBackupLocationByName 11ms

.NOTES
    Author: Jeffrey Robinson
	Copyright: Microsoft
    Date:   August 24, 2017
#>
param(
	[bool]$RunRaw = $false
)

$global:RunRaw = $RunRaw

. $PSScriptRoot\CommonModules.ps1

$global:TestName = ""

InModuleScope Azs.Backup.Admin {

	Describe "BackupLocations" -Tags @('BackupLocation', 'Azs.Backup.Admin') {
	
		BeforeEach  {

			. $PSScriptRoot\Common.ps1

			function ValidateBackupLocation {
				param(
					[Parameter(Mandatory=$true)]
					$BackupLocation
				)

				$BackupLocation          | Should Not Be $null

				# Resource
				$BackupLocation.Id       | Should Not Be $null
				$BackupLocation.Name     | Should Not Be $null
				$BackupLocation.Type     | Should Not Be $null
				
				# Subscriber Usage Aggregate
				$BackupLocation.Password    			| Should Be $null
				$BackupLocation.EncryptionKeyBase64     | Should Be $null
			}
		}

		It "TestListBackupLocation" {
			$global:TestName = 'TestListBackupLocations'
			
			$backupLocations = Get-AzsBackupLocation -ResourceGroup System.local
			$backupLocations  | Should Not Be $null
			foreach($backupLocation in $backupLocations) {
				ValidateBackupLocation -BackupLocation $backupLocation
			}
		}

		It "TestSetBackupLocationByName" -Skip {
			$global:TestName = 'TestCreateBackupLocation'
			
			[String]$username = "azurestack\AzureStackAdmin"
			[SecureString]$password = "!!123abc"
			[String]$path = ""
			[SecureString]$encryptionKey = "YVVOa0J3S2xTamhHZ1lyRU9wQ1pKQ0xWanhjaHlkaU5ZQnNDeHRPTGFQenJKdWZsRGtYT25oYmlaa1RMVWFKeQ=="

			$backup = Set-AzsBackupLocation -ResourceGroupName System.local -Location local -Username $username -Password $password -BackupShare $path -EncryptionKey $encryptionKey
			
			$backup 					| Should Not Be $Null
			$backup.Path 				| Should Be $path
			$backup.Username 			| Should be $null
			$backup.Password 			| Should be $null
			$backup.EncryptionKeyBase64 | Should be $null

			$backup = $backup | Set-AzsBackupLocation -Location local -Username $null -Password $null -BackupShare $null -EncryptionKey $null

			$backup 					| Should Not Be $Null
			$backup.Path 				| Should Be $null
			$backup.Username 			| Should be $null
			$backup.Password 			| Should be $null
			$backup.EncryptionKeyBase64 | Should be $null
			
		}
	}
}