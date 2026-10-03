---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 10/03/2026
PlatyPS schema version: 2024-05-01
title: New-PSDataverseTable
---

# New-PSDataverseTable

## SYNOPSIS

Creates a custom Dataverse table.

## SYNTAX

### __AllParameterSets

```
New-PSDataverseTable [-SchemaName] <string> [[-DisplayName] <string>]
 [-DisplayCollectionName <string>] [-Description <string>] [-PrimaryNameColumn <string>]
 [-PrimaryNameDisplayName <string>] [-PrimaryNameMaxLength <int>] [-PassThru]
 [-SolutionUniqueName <string>] [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The New-PSDataverseTable cmdlet creates a custom table.
Dataverse creates a table and its primary NAME column in one operation, so both are described here; the primary id column is named by the platform and is not yours to choose.

The schema name carries the publisher customization prefix (it3c_person).
Everything else in this module addresses tables by the LOGICAL name, which is the schema name lower-cased.

The primary name column defaults to the table prefix plus name, so it3c_person gets it3c_name.

Without -SolutionUniqueName the component lands in the Default solution, where it works but cannot be exported cleanly - which is discovered much later, when someone tries to move the tables to another environment and finds there is nothing to move.

## EXAMPLES

### Create a mirrored table

New-PSDataverseTable -SchemaName it3c_person -DisplayName Person -SolutionUniqueName it3cM365Mirror

Creates it3c_person with the primary name column it3c_name, inside the named solution.

### Name the primary column explicitly

New-PSDataverseTable it3c_space Space -PrimaryNameColumn it3c_displayname -PassThru

Useful when the name column should not follow the prefix convention.

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

### -Description

Description shown in the maker portal.

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

### -DisplayCollectionName

Plural display name.
Defaults to the display name with an s.

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

### -DisplayName

Display name shown in the maker portal.
Defaults to the schema name.

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

### -PassThru

Return the created table metadata instead of nothing.

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

### -PrimaryNameColumn

Schema name of the primary name column.
Defaults to the table prefix plus name, so it3c_person gets it3c_name.

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

### -PrimaryNameDisplayName

Display name of the primary name column.
Defaults to Name.

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

### -PrimaryNameMaxLength

Length of the primary name column.
Defaults to 200.

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

### -SchemaName

Schema name including the publisher customization prefix, for example it3c_person.
The logical name every other cmdlet takes is this name lower-cased.

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
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SolutionUniqueName

Unique name of the solution to add the table to, not its display name.
Omitted, the table lands in the Default solution and cannot be exported cleanly.

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

## OUTPUTS

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseTableInfo

With -PassThru, the metadata of the created table.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

