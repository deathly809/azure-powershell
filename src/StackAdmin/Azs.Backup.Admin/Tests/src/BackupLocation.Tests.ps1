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

		It "TestSetBackupLocationByName" {
			$global:TestName = 'TestUpdateBackupLocation'
			
			[String]$username = "azurestack\AzureStackAdmin"
			[SecureString]$password = ConvertTo-SecureString -String "password" -AsPlainText -Force
			[String]$path = "\\192.168.1.1\Share"
			[SecureString]$encryptionKey = ConvertTo-SecureString -String "YVVOa0J3S2xTamhHZ1lyRU9wQ1pKQ0xWanhjaHlkaU5ZQnNDeHRPTGFQenJKdWZsRGtYT25oYmlaa1RMVWFKeQ==" -AsPlainText -Force

			$backup = Set-AzsBackupShare -ResourceGroup System.local -BackupLocation local -Username $username -Password $password -BackupShare $path -EncryptionKey $encryptionKey
			
			$backup 					| Should Not Be $Null
			$backup.Path 				| Should Be $path
			$backup.Username 			| Should be $username
			$backup.Password 			| Should be ""
			$backup.EncryptionKeyBase64 | Should be ""
			
		}
	}
}