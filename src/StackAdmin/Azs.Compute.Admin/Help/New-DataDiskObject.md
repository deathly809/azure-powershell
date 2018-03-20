---
external help file: Azs.Compute.Admin-help.xml
Module Name: Azs.Compute.Admin
online version:
schema: 2.0.0
---

# New-DataDiskObject

## SYNOPSIS
Creates a data disk which is used to create a new virtual machine platform image.

## SYNTAX

```
New-DataDiskObject [[-Lun] <Int32>] [[-Uri] <String>]
```

## DESCRIPTION
Creates an object holding information about a data disk.

## EXAMPLES

### Example 1
```
PS C:\> New-DataDiskObject -Lun 5 -URI test.blob.windows.net/disks/datadisk5.vhd
```

Create a new data disk.

## PARAMETERS

### -Lun
Logical unit number.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
Location of the disk template.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
