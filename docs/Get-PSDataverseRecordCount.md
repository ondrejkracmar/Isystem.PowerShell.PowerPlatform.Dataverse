---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: Get-PSDataverseRecordCount
---

# Get-PSDataverseRecordCount

## SYNOPSIS

Gets the total count of records in a Dataverse table.

## SYNTAX

### __AllParameterSets

```
Get-PSDataverseRecordCount [-LogicalName] <string> [-Filter <hashtable>]
 [-PrimaryIdAttribute <string>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Get-PSDataverseRecordCount cmdlet returns the number of records in a Dataverse table using an aggregate FetchXML query.
An optional filter can be applied to count only matching records.

## EXAMPLES

### Count all records

Get-PSDataverseRecordCount -LogicalName "account"

Returns the total number of account records.

### Count with filter

Get-PSDataverseRecordCount -LogicalName "contact" -Filter @{ statecode = 0 }

Returns the number of active contact records.

## PARAMETERS

### -Filter

A hashtable of attribute-value pairs used to filter which records are counted.
Null values produce an "is null" condition; other values produce an "equals" condition.

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

The logical name of the Dataverse table to count records in.

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

### -PrimaryIdAttribute

Primary key attribute to count.
Defaults to the Dataverse convention {LogicalName}id; override for tables that break it (e.g.
activitypointer uses activityid).

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Int32

The number of matching records.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

