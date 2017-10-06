
$rpName = "backup"
$location = pwd
$moduleName = "Backup"
$namespace = "Microsoft.AzureStack.Management.Backup.Admin"
$dll = "$namespace.dll"
$client = "$namespace.BackupAdminClient"

. ..\..\..\tools\GeneratePSSwagger.ps1 -RPName $rpName -Location $location -Name $moduleName -Admin -DLLName "$dll" -ClientName $client -AzureStack -Repo deathly809 -Branch "azs.backup.admin" -PSSwaggerLocation "E:\github\PSswagger"