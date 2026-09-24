---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/24/2026
PlatyPS schema version: 2024-05-01
title: Find-PSDataverseRecord
---

# Find-PSDataverseRecord

## SYNOPSIS

Searches for Dataverse records matching filter criteria.

## SYNTAX

### __AllParameterSets

```
Find-PSDataverseRecord [-LogicalName] <string> [-Filter <hashtable>] [-LikeFilter <hashtable>]
 [-Columns <string[]>] [-OrderBy <string>] [-Descending] [-Top <int>] [-All]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Find-PSDataverseRecord cmdlet queries a Dataverse table using optional equality filters, LIKE filters, column selection, ordering, and paging.
Use -All to retrieve all pages of results, or -Top to limit the number of records returned.

## EXAMPLES

### Find records with equality filter

Find-PSDataverseRecord -LogicalName "account" -Filter @{ statecode = 0 }

Returns up to 50 active account records.

### Find records with LIKE filter

Find-PSDataverseRecord -LogicalName "contact" -LikeFilter @{ fullname = "%Smith%" } -Columns "fullname", "emailaddress1"

Finds contacts whose full name contains "Smith", returning only name and email.

### Get all records with sorting

Find-PSDataverseRecord -LogicalName "account" -All -OrderBy "createdon" -Descending

Retrieves all account records sorted by creation date in descending order.

## PARAMETERS

### -All

Retrieves all matching records across all pages.
Overrides -Top.

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

### -Columns

An array of column logical names to retrieve.
If omitted, all columns are returned.

```yaml
Type: System.String[]
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

### -Descending

When specified with -OrderBy, sorts results in descending order.

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

### -Filter

A hashtable of attribute-value pairs for equality filtering.
Null values produce an "is null" condition.

```yaml
Type: System.Collections.Hashtable
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

### -LikeFilter

A hashtable of attribute-value pairs for LIKE (wildcard) filtering.
Use % as the wildcard character.

```yaml
Type: System.Collections.Hashtable
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

### -LogicalName

The logical name of the Dataverse table to query.

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

### -OrderBy

The logical name of the column to sort results by.

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

### -Top

Maximum number of records to return.
Valid range: 1-5000.
Default: 50.
Ignored when -All is specified.

```yaml
Type: System.Int32
DefaultValue: 50
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

### System.String

{{ Fill in the Description }}

## OUTPUTS

### Microsoft.Xrm.Sdk.Entity

Zero or more Entity objects matching the query criteria.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

