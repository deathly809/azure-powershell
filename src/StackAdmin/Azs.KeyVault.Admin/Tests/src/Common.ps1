
$global:Location = 'local'

if(-not $RunRaw) {
	$scriptBlock = {
		Get-MockClient -ClassName 'KeyVaultAdminClient' -TestName $global:TestName -Verbose
	}
	Mock New-ServiceClient $scriptBlock -ModuleName $global:ModuleName
}
