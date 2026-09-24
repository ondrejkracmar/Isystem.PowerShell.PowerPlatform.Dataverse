---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/24/2026
PlatyPS schema version: 2024-05-01
title: Get-PSDataverseRecord
---

# Get-PSDataverseRecord

## SYNOPSIS

Gets a Dataverse record by ID or alternate key.

## SYNTAX

### ByProperties (Default)

```
Get-PSDataverseRecord [-LogicalName] <string> [-Id] <guid> [-Columns <string[]>]
```

### ByKey

```
Get-PSDataverseRecord [-LogicalName] <string> -Key <hashtable> [-Columns <string[]>]
```

### ByInputObject

```
Get-PSDataverseRecord -InputObject <Entity> [-Columns <string[]>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Get-PSDataverseRecord cmdlet retrieves a single record from a Dataverse table by its logical name and unique identifier.
You can optionally specify which columns to retrieve.

## EXAMPLES

### Get a record with all columns

Get-PSDataverseRecord -LogicalName "account" -Id "00000000-0000-0000-0000-000000000001"

Retrieves an account record by its ID with all columns.

### Get specific columns

Get-PSDataverseRecord "account" "00000000-0000-0000-0000-000000000001" -Columns "name", "emailaddress1"

Retrieves only the name and emailaddress1 columns of the account record.

### Pipeline via InputObject

Find-PSDataverseRecord "account" -Filter @{ statecode = 0 } | Get-PSDataverseRecord -Columns "name", "revenue"

Finds active accounts and re-retrieves them with specific columns.
Entity objects bind to -InputObject via pipeline by value.

### Pipeline raw Guid from New-PSDataverseRecord

New-PSDataverseRecord "account" @{ name = "Test" } | Get-PSDataverseRecord "account"

Creates a new account and immediately retrieves it.
The raw Guid output binds to -Id via pipeline by value (ByProperties set).

## PARAMETERS

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

### -Id

The unique identifier (GUID) of the record to retrieve.
Accepts pipeline input by value (e.g., raw Guid from New-PSDataverseRecord) or by property name.
Used in the ByProperties parameter set.

```yaml
Type: System.Guid
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByProperties
  Position: 1
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -InputObject

An Entity object to re-retrieve.
The LogicalName and Id are extracted from the entity.
Used in the ByInputObject parameter set.
Accepts pipeline input from Find-PSDataverseRecord or Invoke-PSDataverseFetchXml.

```yaml
Type: Microsoft.Xrm.Sdk.Entity
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByInputObject
  Position: Named
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Key

Alternate key (attribute name = value hashtable) identifying the record instead of -Id, e.g.
@{ accountnumber = 'A-1' }.

```yaml
Type: System.Collections.Hashtable
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByKey
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -LogicalName

The logical name of the Dataverse table (e.g., "account", "contact").
Used in the ByProperties parameter set.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByProperties
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
- Name: ByKey
  Position: 0
  IsRequired: true
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

### System.Guid

{{ Fill in the Description }}

### Microsoft.Xrm.Sdk.Entity

{{ Fill in the Description }}

## OUTPUTS

### Microsoft.Xrm.Sdk.Entity

The Dataverse record as an Entity object.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

