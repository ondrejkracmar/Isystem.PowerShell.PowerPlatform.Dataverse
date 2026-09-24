---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/24/2026
PlatyPS schema version: 2024-05-01
title: Get-PSDataverseColumn
---

# Get-PSDataverseColumn

## SYNOPSIS

Gets the columns of a Dataverse table, with their types and writability.

## SYNTAX

### __AllParameterSets

```
Get-PSDataverseColumn [-LogicalName] <string> [[-Name] <string>] [-Writable] [-CustomOnly]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

A retrieved record shows only the columns that have a value; this shows the table as it is defined.
IsValidForCreate and IsValidForUpdate are worth reading before a mapping is blamed: calculated, rollup and system columns read perfectly well and are rejected on write.
The table name is exact - use Get-PSDataverseTable to find it - while -Name filters the columns and accepts wildcards.

## EXAMPLES

### EXAMPLE 1

PS C:\> Get-PSDataverseColumn it3c_person

Every column of the table, sorted by logical name.

### EXAMPLE 2

PS C:\> Get-PSDataverseColumn it3c_person -Writable -CustomOnly

Only the custom columns that can actually be written - the set a mirror or an import may fill.

### EXAMPLE 3

PS C:\> Get-PSDataverseColumn it3c_person it3c_*id | Where-Object Targets

Lookup columns and the tables they point at.

## PARAMETERS

### -CustomOnly

Only custom columns - the ones carrying a publisher prefix.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -LogicalName

Logical name of the table.
Exact, not a search: use Get-PSDataverseTable to find it, or pipe that cmdlet's output in.

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

### -Name

Column name filter; wildcards are allowed (it3c_*).
Omitted, every column of the table is returned.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Writable

Only columns that can be written on create or update.
Calculated, rollup and system columns read perfectly well and are rejected on write, which is what this filters out.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
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

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseColumnInfo

One object per column: logical name, type, required level, writability, length or lookup targets.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

