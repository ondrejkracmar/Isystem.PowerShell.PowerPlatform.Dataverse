---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/24/2026
PlatyPS schema version: 2024-05-01
title: Get-PSDataverseTable
---

# Get-PSDataverseTable

## SYNOPSIS

Gets Dataverse table metadata: logical name, primary key and name columns, entity set.

## SYNTAX

### __AllParameterSets

```
Get-PSDataverseTable [[-LogicalName] <string>] [-IncludeSystem]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Every other cmdlet takes the LOGICAL name of a table, which is neither the display name the maker portal shows nor the plural collection name.
This cmdlet finds it, and tells the two causes of the SDK error "the entity with a name = X was not found in the MetadataCache" apart: the table is not in this environment, or the name is spelled differently.
An exact name costs one metadata request; a wildcard has to read the whole catalogue, because the metadata service has no server-side name filter.
Only custom tables are listed unless -IncludeSystem is given.

## EXAMPLES

### EXAMPLE 1

PS C:\> Get-PSDataverseTable it3c_*

Lists every custom table whose logical name starts with the publisher prefix.

### EXAMPLE 2

PS C:\> Get-PSDataverseTable -LogicalName it3c_person

One table, without reading the catalogue: logical name, primary id and name columns, entity set name for Web API URLs.

### EXAMPLE 3

PS C:\> Get-PSDataverseTable it3c_* | Find-PSDataverseRecord -Top 5

Pipes each table into a query: the first five rows of every custom table.
The table name binds by property name.

### EXAMPLE 4

PS C:\> Get-PSDataverseTable it3c_* | Get-PSDataverseRecordCount

Row counts for every custom table.
The primary id column travels with the object, so tables that break the {name}id convention are counted correctly.

## PARAMETERS

### -IncludeSystem

Include the tables that ship with the platform (~1,300 of them).
Without it only custom tables - the ones with a publisher prefix - are listed.

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

Logical name of the table; wildcards are allowed (it3c_*).
Omitted, every table is returned - custom ones only, unless -IncludeSystem is given.
An exact name costs one metadata request; a wildcard reads the whole catalogue, because the metadata service has no server-side name filter.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
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

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseTableInfo

One object per table: logical name, display name, primary id and name columns, entity set name.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

