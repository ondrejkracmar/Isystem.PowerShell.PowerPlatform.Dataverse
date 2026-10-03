---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 10/03/2026
PlatyPS schema version: 2024-05-01
title: Enable-PSDataverseKey
---

# Enable-PSDataverseKey

## SYNOPSIS

Asks Dataverse to build an alternate key's unique index again.

## SYNTAX

### __AllParameterSets

```
Enable-PSDataverseKey [-LogicalName] <string> [-Name] <string> [-Wait] [-TimeoutSeconds <int>]
 [-PassThru] [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Enable-PSDataverseKey cmdlet reactivates the unique index behind an alternate key.
A key whose index never became active is created but unusable, and an upsert addressed by it fails with a message that never mentions the index.

The usual cause is the column rather than the key: the index is unique, so more than one blank cannot be indexed - a new column on a table of sixteen thousand rows is sixteen thousand duplicate blanks, and the index stays Pending until it fails.
Populate the column first, then reactivate.

This is cheaper than removing the key and creating it again, and on Dataverse for Teams it is the only route at all, because the maker portal there does not show alternate keys.
The rebuild is asynchronous just as the first attempt was, so use -Wait in a script that reactivates a key and then writes through it.

An index reporting Failed is reported as an error immediately instead of being waited on: Failed means the rows are wrong, and no amount of waiting changes that.

## EXAMPLES

### Rebuild the index once the column has values

Enable-PSDataverseKey -LogicalName it3c_aaduser -Name it3c_sourceidkey -Wait

Blocks until the index is Active, so the very next upsert through the key succeeds.

### Every key that is not usable yet

PS C:\> Get-PSDataverseKey it3c_aaduser | Where-Object IndexStatus -ne Active | Enable-PSDataverseKey -Wait -Confirm:$false

Reactivates each one in turn.
On Dataverse for Teams the metadata read returns no keys, so name them instead of discovering them.

## PARAMETERS

### -Confirm

Prompts for confirmation before reactivating the index.

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

### -LogicalName

Logical name of the table the key is on.

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

### -Name

Logical name of the key itself, for example it3c_sourceidkey.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- SchemaName
- KeyName
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

### -PassThru

Returns whether the index is Active.
Without -Wait that is rarely true yet.

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

### -TimeoutSeconds

How long -Wait waits before giving up.
Five minutes by default; a large table takes longer to index.

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

### -Wait

Waits until the index reports Active instead of returning as soon as the rebuild is asked for.

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

Shows what the cmdlet would reactivate without sending anything.

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

### System.String

LogicalName and Name bind by property name, so the output of Get-PSDataverseKey can be piped in.

## OUTPUTS

### System.Boolean

With -PassThru, whether the index reports Active.
Without -Wait that is rarely true yet.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

