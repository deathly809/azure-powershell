
$global:SkippedTests = $('TestListSubscriberUsageAggregatesFromLastTwoDays')

[DateTime]$global:Start = "2017-09-06T00:00:00Z"
[DateTime]$global:End = "2017-09-07T00:00:00Z"
$global:Granularity = 'Hourly'

if (-not $RunRaw) {
    $scriptBlock = {
        Get-MockClient -ClassName 'CommerceAdminClient' -TestName $global:TestName -Verbose
    }
    Mock New-ServiceClient $scriptBlock -ModuleName $global:ModuleName
}
