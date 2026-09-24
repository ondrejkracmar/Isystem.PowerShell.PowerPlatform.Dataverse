---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/24/2026
PlatyPS schema version: 2024-05-01
title: Get-PSDataverseKey
---

# Get-PSDataverseKey

## SYNOPSIS

Gets the alternate keys of a Dataverse table and the state of their indexes.

## SYNTAX

### __AllParameterSets

```
Get-PSDataverseKey [-LogicalName] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Everything that upserts by key - Set-PSDataverseRecord -Key, an Upsert operation in Invoke-PSDataverseBatch - depends on a key whose index status is Active.
A key whose index is Pending or Failed fails at runtime with a message that never mentions the index, which makes this the first thing to check when an upsert that worked yesterday stops working.

## EXAMPLES

### EXAMPLE 1

PS C:\> Get-PSDataverseKey it3c_person

The alternate keys of the table, their columns and index status.

### EXAMPLE 2

PS C:\> Get-PSDataverseTable it3c_* | Get-PSDataverseKey | Where-Object IndexStatus -ne Active

Across every custom table, the keys that are not usable for an upsert yet.

## PARAMETERS

### -LogicalName

Logical name of the table.
Exact; pipe Get-PSDataverseTable in to walk several.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseTableInfo

Table metadata, so the output of Get-PSDataverseTable can be piped in by property name.

### System.String

{{ Fill in the Description }}

## OUTPUTS

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseKeyInfo

One object per alternate key: its columns and the state of its index.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

