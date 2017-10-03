
$rpName = "gallery"
$location = pwd
$psswagger = "E:\github\PSswagger"
$module = "Module"
. ..\..\..\tools\GeneratePSSwagger.ps1 -RPName $rpName -Location $location -Admin -ModuleDirectory $module -AzureStack -PSSwaggerLocation $psswagger -Repo "deathly809" -Branch "feature/azs.gallery.admin"