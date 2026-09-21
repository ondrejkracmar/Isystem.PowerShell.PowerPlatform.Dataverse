---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/21/2026
PlatyPS schema version: 2024-05-01
title: Invoke-PSDataverseTransaction
---

# Invoke-PSDataverseTransaction

## SYNOPSIS

Executes Dataverse operations in a single atomic transaction.

## SYNTAX

### __AllParameterSets

```
Invoke-PSDataverseTransaction [-Operations] <hashtable[]> [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Invoke-PSDataverseTransaction cmdlet sends multiple create, update, upsert, and delete operations to Dataverse as a single atomic transaction using ExecuteTransaction.
If any operation fails, all operations are rolled back.
Each operation is a hashtable with Action (Create, Update, Upsert, Delete), LogicalName, and Id or Key (alternate key hashtable) plus Attributes; lookups are written as nested hashtables @{ LogicalName = ...; Id = ...
} or @{ LogicalName = ...; Key = @{ ...
} }.
The cmdlet supports ShouldProcess with medium confirm impact.

## EXAMPLES

### Execute operations in a transaction

$ops = @(
    @{ Action = "Create"; LogicalName = "account"; Attributes = @{ name = "Contoso" } }
    @{ Action = "Create"; LogicalName = "contact"; Attributes = @{ firstname = "John"; lastname = "Doe" } }
)
Invoke-PSDataverseTransaction -Operations $ops

Creates an account and a contact atomically.
If either fails, both are rolled back.

### Preview with WhatIf

Invoke-PSDataverseTransaction -Operations $ops -WhatIf

Shows the number of operations that would be executed without committing.

## PARAMETERS

### -Confirm

Prompts for confirmation before executing the transaction.

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

Shows what would happen if the cmdlet runs without actually executing the transaction.

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

### System.Int32

The number of operations that were committed in the transaction.

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseBatchResult

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

