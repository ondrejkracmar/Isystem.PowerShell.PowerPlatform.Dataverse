---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: Invoke-PSDataverseBatch
---

# Invoke-PSDataverseBatch

## SYNOPSIS

Executes a batch of Dataverse operations (create/update/upsert/delete).

## SYNTAX

### __AllParameterSets

```
Invoke-PSDataverseBatch [-Operations] <hashtable[]> [-ContinueOnError] [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Invoke-PSDataverseBatch cmdlet sends multiple create, update, upsert, and delete operations to Dataverse in a single ExecuteMultiple request.
Each operation is a hashtable with Action (Create, Update, Upsert, Delete), LogicalName, and Id or Key (alternate key hashtable) plus Attributes; lookups are written as nested hashtables @{ LogicalName = ...; Id = ...
} or @{ LogicalName = ...; Key = @{ ...
} }.
The cmdlet returns a typed DataverseBatchResult with success and failure counts and one Items entry per operation (Index, Action, LogicalName, Id, Succeeded, RecordCreated, ErrorCode, Message).
The cmdlet supports ShouldProcess with medium confirm impact.

## EXAMPLES

### Batch create and update

$ops = @(
    @{ Action = "Create"; LogicalName = "account"; Attributes = @{ name = "Contoso" } }
    @{ Action = "Update"; LogicalName = "contact"; Id = $contactId; Attributes = @{ lastname = "Smith" } }
    @{ Action = "Delete"; LogicalName = "account"; Id = $oldAccountId }
)
$result = Invoke-PSDataverseBatch -Operations $ops -ContinueOnError
$result.SuccessCount

Executes a batch of mixed operations and checks the success count.

## PARAMETERS

### -Confirm

Prompts for confirmation before executing the batch.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
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

### -ContinueOnError

When specified, the batch continues processing remaining operations even if one fails.

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

### -Operations

An array of hashtables defining the operations.
Each hashtable must contain: Action (Create/Update/Delete), LogicalName, and optionally Id (required for Update/Delete) and Attributes (a nested hashtable of column values).

```yaml
Type: System.Collections.Hashtable[]
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

### -WhatIf

Shows what would happen if the cmdlet runs without actually executing the batch.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
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

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseBatchResult

A typed object with TotalRequests, SuccessCount, FailureCount, IsFullSuccess, Items (per-operation outcome with the record Id, ErrorCode and Message) and optionally Errors.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

