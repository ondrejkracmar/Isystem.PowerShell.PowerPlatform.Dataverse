---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 10/02/2026
PlatyPS schema version: 2024-05-01
title: New-PSDataverseLookup
---

# New-PSDataverseLookup

## SYNOPSIS

Creates a lookup column and the relationship behind it.

## SYNTAX

### __AllParameterSets

```
New-PSDataverseLookup [-LogicalName] <string> [-TargetLogicalName] <string> [-SchemaName] <string>
 [-DisplayName <string>] [-Description <string>] [-RelationshipSchemaName <string>] [-Required]
 [-PassThru] [-SolutionUniqueName <string>] [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The New-PSDataverseLookup cmdlet creates a lookup.
A lookup in Dataverse is a one-to-many RELATIONSHIP; the column on the child table appears as a side effect of creating it.
That is why this is not New-PSDataverseColumn.

The relationship schema name is what the Web API navigation property and the OData bind annotation are built from.
Left to the platform it becomes child_lookupcolumn_parent, which is the detail that trips people up when they hand-write OData; -RelationshipSchemaName names it deliberately instead.

-LogicalName is the child - the table the lookup column lives on.
-TargetLogicalName is the parent it points at.

Without -SolutionUniqueName the component lands in the Default solution, where it works but cannot be exported cleanly - which is discovered much later, when someone tries to move the tables to another environment and finds there is nothing to move.

## EXAMPLES

### Point a link table at both of its parents

New-PSDataverseLookup -LogicalName it3c_personidentity -TargetLogicalName it3c_person -SchemaName it3c_personid

Creates it3c_personid on the link table and the relationship it3c_personidentity_it3c_personid_it3c_person.

### Name the relationship yourself

New-PSDataverseLookup it3c_space it3c_aaduser it3c_ownerid -RelationshipSchemaName it3c_space_owner

Worth doing when something else will hand-write the OData bind for this lookup.

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
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DisplayName

Display name of the lookup column.
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
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -LogicalName

Logical name of the table the lookup column lives on - the child, or many side.

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

Return the created lookup column metadata instead of nothing.

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

### -RelationshipSchemaName

Schema name of the relationship, which is what the Web API navigation property and the OData bind annotation are built from.
Defaults to child_lookupcolumn_parent.

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
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Required

Make the lookup business required rather than optional.

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
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SchemaName

Schema name of the lookup column, for example it3c_personid.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SolutionUniqueName

Unique name of the solution to add the relationship to.
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

### -TargetLogicalName

Logical name of the table the lookup points at - the parent, or one side.

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
  ValueFromPipelineByPropertyName: true
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

### System.Management.Automation.SwitchParameter

{{ Fill in the Description }}

## OUTPUTS

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseColumnInfo

With -PassThru, the metadata of the created lookup column.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

