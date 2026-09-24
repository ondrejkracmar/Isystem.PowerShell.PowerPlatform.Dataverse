---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/24/2026
PlatyPS schema version: 2024-05-01
title: Set-PSDataverseRecord
---

# Set-PSDataverseRecord

## SYNOPSIS

Updates an existing Dataverse record, or upserts it by alternate key.

## SYNTAX

### ByProperties (Default)

```
Set-PSDataverseRecord [-LogicalName] <string> [-Id] <guid> [-Attributes] <hashtable> [-Upsert]
 [-PassThru] [-WhatIf] [-Confirm]
```

### ByKey

```
Set-PSDataverseRecord [-LogicalName] <string> [-Attributes] <hashtable> -Key <hashtable> [-Upsert]
 [-PassThru] [-WhatIf] [-Confirm]
```

### ByInputObject

```
Set-PSDataverseRecord [-Attributes] <hashtable> -InputObject <Entity> [-Upsert] [-PassThru]
 [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Set-PSDataverseRecord cmdlet updates the specified attributes of an existing record in a Dataverse table, addressed by Id, by alternate -Key, or by a piped Entity.
With -Upsert the record is created when it does not exist.
Lookup attributes can be given as nested hashtables @{ LogicalName = ...; Id = ...
} or @{ LogicalName = ...; Key = @{ ...
} }.
Failures are non-terminating errors, so a pipeline of records continues and -ErrorAction decides.
This cmdlet supports ShouldProcess, so you can use -WhatIf and -Confirm.

## EXAMPLES

### Update an account name

Set-PSDataverseRecord -LogicalName "account" -Id $accountId -Attributes @{ name = "Contoso Inc" }

Updates the name of an existing account record.

### Update multiple attributes

Set-PSDataverseRecord "contact" $contactId @{ firstname = "Jane"; lastname = "Smith"; emailaddress1 = "jane@contoso.com" }

Updates multiple attributes of a contact record using positional parameters.

### Pipeline from Find-PSDataverseRecord

Find-PSDataverseRecord "account" -Filter @{ statecode = 0 } | Set-PSDataverseRecord -Attributes @{ description = "Active account" }

Finds all active accounts and updates their description.
Entity objects bind to -InputObject via pipeline by value.

### Update and return the updated entity

$updated = Set-PSDataverseRecord "account" $accountId @{ name = "New Name" } -PassThru
$updated.name

Updates the account name and returns the full updated entity using -PassThru.

## PARAMETERS

### -Attributes

A hashtable of attribute logical names and their new values.

```yaml
Type: System.Collections.Hashtable
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

### -Confirm

Prompts for confirmation before updating the record.

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

### -Id

The unique identifier (GUID) of the record to update.
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
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -InputObject

An Entity object identifying the record to update.
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

Alternate key (attribute name = value hashtable) identifying the record instead of -Id, e.g.
@{ it3c_objectid = $oid }.

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

The logical name of the Dataverse table containing the record.
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

### -PassThru

When specified, the cmdlet retrieves and returns the updated entity after the update operation.

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

### -Upsert

Create the record when it does not exist (UpsertRequest).
Outputs a DataverseUpsertResult with the record Id and RecordCreated; with -PassThru the full record is retrieved instead.

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

Shows what would happen if the cmdlet runs without actually updating the record.

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

### System.Guid

{{ Fill in the Description }}

### Microsoft.Xrm.Sdk.Entity

{{ Fill in the Description }}

## OUTPUTS

### None / Microsoft.Xrm.Sdk.Entity

By default this cmdlet does not produce output.
When -PassThru is specified, returns the updated Entity object.

### System.Void

{{ Fill in the Description }}

### Microsoft.Xrm.Sdk.Entity

{{ Fill in the Description }}

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseUpsertResult

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

