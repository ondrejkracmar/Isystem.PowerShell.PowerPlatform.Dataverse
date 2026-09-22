---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: Test-PSDataverseRecord
---

# Test-PSDataverseRecord

## SYNOPSIS

Tests whether a Dataverse record exists.

## SYNTAX

### ByProperties (Default)

```
Test-PSDataverseRecord [-LogicalName] <string> [-Id] <guid>
```

### ByKey

```
Test-PSDataverseRecord [-LogicalName] <string> -Key <hashtable>
```

### ByInputObject

```
Test-PSDataverseRecord -InputObject <Entity>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Test-PSDataverseRecord cmdlet checks if a record with the specified logical name and ID exists in Dataverse.
Returns $true if the record exists, $false otherwise.

## EXAMPLES

### Test if a record exists

Test-PSDataverseRecord -LogicalName "account" -Id "00000000-0000-0000-0000-000000000001"

Returns $true if the account exists, $false otherwise.

### Use in a condition

if (Test-PSDataverseRecord "contact" $contactId) {
    Write-Host "Contact exists."
}

Checks for the existence of a contact before proceeding.

### Pipeline from Find-PSDataverseRecord

Find-PSDataverseRecord "account" -Filter @{ statecode = 0 } | Test-PSDataverseRecord

Tests whether each found account still exists.
Entity objects bind to -InputObject via pipeline by value.

## PARAMETERS

### -Id

The unique identifier (GUID) of the record to test.
Accepts pipeline input by value or by property name.
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

An Entity object to test for existence.
The LogicalName and Id are extracted from the entity.
Used in the ByInputObject parameter set.

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

Alternate key (attribute name = value hashtable) identifying the record instead of -Id.

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

The logical name of the Dataverse table.
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

### System.Boolean

$true if the record exists; $false otherwise.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

