
$global:SkippedTests = @(
    'TestListInvalidLocation',
    'TestCreateQuotaOnInvalidLocation'
)

$global:Location = "local"
$global:Provider = "Microsoft.Compute.Admin"
$global:VHDUri = "https://test.blob.local.azurestack.external/test/xenial-server-cloudimg-amd64-disk1.vhd"


if (-not $RunRaw) {
    $scriptBlock = {
        Get-MockClient -ClassName 'ComputeAdminClient' -TestName $global:TestName -Verbose
    }
    Mock New-ServiceClient $scriptBlock -ModuleName $global:ModuleName
}
