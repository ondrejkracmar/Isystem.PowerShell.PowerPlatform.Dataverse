---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 10/01/2026
PlatyPS schema version: 2024-05-01
title: New-PSDataverseKey
---

# New-PSDataverseKey

## SYNOPSIS

Creates an alternate key on a Dataverse table.

## SYNTAX

### __AllParameterSets

```
New-PSDataverseKey [-LogicalName] <string> [-SchemaName] <string> [-KeyAttribute] <string[]>
 [-DisplayName <string>] [-Wait] [-TimeoutSeconds <int>] [-PassThru] [-SolutionUniqueName <string>]
 [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The New-PSDataverseKey cmdlet creates an alternate key - the thing that makes an idempotent upsert possible, because it lets a row be addressed by a natural identifier instead of a GUID nobody outside Dataverse knows.

The unique index behind the key is built asynchronously, so the request returning does not mean the key works.
Until the index reports Active, an upsert addressed by that key fails with a message that never mentions the index.
Use -Wait in a script that creates the key and then writes through it.

A key whose index reports Failed usually means the existing rows contain a duplicate of the key columns.

Without -SolutionUniqueName the component lands in the Default solution, where it works but cannot be exported cleanly - which is discovered much later, when someone tries to move the tables to another environment and finds there is nothing to move.

## EXAMPLES

### Key a mirrored table by its source identifier

New-PSDataverseKey -LogicalName it3c_person -SchemaName it3c_sourceidkey -KeyAttribute it3c_sourceid -Wait

Blocks until the index is Active, so the very next upsert through it succeeds.

### A composite key

New-PSDataverseKey it3c_userlicense it3c_userskukey it3c_userid, it3c_sku -Wait -TimeoutSeconds 900

A larger table takes longer to index; the default timeout is five minutes.

## PARAMETERS

### -Confirm

Prompts for confirmation before creating the record.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
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

### -DisplayName

Display name.
Defaults to the schema name.

```yaml
Type: System.String
DefaultValue: ''
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

### -KeyAttribute

The column or columns the key is made of.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -LogicalName

Logical name of the table the key belongs to.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PassThru

Return the created key metadata, including its index status.

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

### -SchemaName

Schema name of the key, for example it3c_sourceidkey.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SolutionUniqueName

Unique name of the solution to add the key to.
Omitted, it lands in the Default solution.

```yaml
Type: System.String
DefaultValue: ''
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

### -TimeoutSeconds

How long -Wait waits before giving up.
Defaults to 300.

```yaml
Type: System.Int32
DefaultValue: ''
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

### -Wait

Block until the unique index reports Active, rather than returning while it is still building.
Use this whenever the script writes through the key afterwards.

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

### -WhatIf

Shows what would happen if the cmdlet runs without actually creating the record.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
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

### System.String

{{ Fill in the Description }}

## OUTPUTS

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseKeyInfo

With -PassThru, the metadata of the created key including its index status.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

