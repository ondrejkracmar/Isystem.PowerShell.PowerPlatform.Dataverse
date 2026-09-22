---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: Remove-PSDataverseRecord
---

# Remove-PSDataverseRecord

## SYNOPSIS

Deletes a record from a Dataverse table.

## SYNTAX

### ByProperties (Default)

```
Remove-PSDataverseRecord [-LogicalName] <string> [-Id] <guid> [-PassThru] [-WhatIf] [-Confirm]
```

### ByKey

```
Remove-PSDataverseRecord [-LogicalName] <string> -Key <hashtable> [-PassThru] [-WhatIf] [-Confirm]
```

### ByInputObject

```
Remove-PSDataverseRecord -InputObject <Entity> [-PassThru] [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Remove-PSDataverseRecord cmdlet deletes a record from a Dataverse table by its logical name and ID.
This cmdlet supports ShouldProcess with a high confirm impact, so it prompts for confirmation by default.

## EXAMPLES

### Delete a record

Remove-PSDataverseRecord -LogicalName "account" -Id $accountId -Confirm:$false

Deletes an account record, suppressing the confirmation prompt.

### Preview deletion with WhatIf

Remove-PSDataverseRecord -LogicalName "contact" -Id $contactId -WhatIf

Shows what would happen without actually deleting the contact.

### Pipeline from Find-PSDataverseRecord

Find-PSDataverseRecord "account" -Filter @{ statecode = 1 } | Remove-PSDataverseRecord -Confirm:$false

Finds all inactive accounts and deletes them.
Entity objects bind to -InputObject via pipeline by value.

### Pipeline from Invoke-PSDataverseFetchXml

Invoke-PSDataverseFetchXml $fetchXml | Remove-PSDataverseRecord -Confirm:$false

Queries records with FetchXML and deletes all results.
Entity objects bind to -InputObject via pipeline.

### Delete with PassThru for logging

Find-PSDataverseRecord "account" -Filter @{ statecode = 1 } | Remove-PSDataverseRecord -PassThru -Confirm:$false | ForEach-Object { Write-Host "Deleted: $_" }

Deletes inactive accounts and uses -PassThru to confirm each deletion in the pipeline.

## PARAMETERS

### -Confirm

Prompts for confirmation before deleting the record.

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

The unique identifier (GUID) of the record to delete.
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

An Entity object identifying the record to delete.
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

When specified, the cmdlet returns $true after a successful deletion.

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

Shows what would happen if the cmdlet runs without actually deleting the record.

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

### None / System.Boolean

By default this cmdlet does not produce output.
When -PassThru is specified, returns $true after a successful deletion.

### System.Void

{{ Fill in the Description }}

### System.Boolean

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

