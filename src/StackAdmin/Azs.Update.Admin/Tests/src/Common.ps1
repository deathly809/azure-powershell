
$global:Provider = "Microsoft.Update.Admin"

if (-not $RunRaw) {
    $scriptBlock = {
        Get-MockClient -ClassName 'UpdateAdminClient' -TestName $global:TestName -Verbose
    }
    Mock New-ServiceClient $scriptBlock -ModuleName $global:ModuleName
}
