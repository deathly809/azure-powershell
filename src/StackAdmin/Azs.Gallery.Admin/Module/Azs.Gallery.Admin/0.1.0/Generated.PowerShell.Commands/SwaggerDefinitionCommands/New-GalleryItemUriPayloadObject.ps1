<#
Code generated by Microsoft (R) PSSwagger 0.3.0
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Gallery item uri

.DESCRIPTION
    Gallery item uri

.PARAMETER GalleryItemUri
    Gets or sets the gallery item URI.

#>
function New-GalleryItemUriPayloadObject
{
    param(    
        [Parameter(Mandatory = $false)]
        [string]
        $GalleryItemUri
    )
    
    $Object = New-Object -TypeName Microsoft.PowerShell.Azs.Gallery.Admin.v010.Models.GalleryItemUriPayload

    $PSBoundParameters.GetEnumerator() | ForEach-Object { 
        if(Get-Member -InputObject $Object -Name $_.Key -MemberType Property)
        {
            $Object.$($_.Key) = $_.Value
        }
    }

    if(Get-Member -InputObject $Object -Name Validate -MemberType Method)
    {
        $Object.Validate()
    }

    return $Object
}
