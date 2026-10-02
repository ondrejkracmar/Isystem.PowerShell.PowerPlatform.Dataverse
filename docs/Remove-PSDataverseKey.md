---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 10/02/2026
PlatyPS schema version: 2024-05-01
title: Remove-PSDataverseKey
---

# Remove-PSDataverseKey

## SYNOPSIS

Removes an alternate key from a Dataverse table.

## SYNTAX

### __AllParameterSets

```
Remove-PSDataverseKey [-LogicalName] <string> [-Name] <string> [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Remove-PSDataverseKey cmdlet deletes an alternate key.
It is the counterpart to New-PSDataverseKey and the way out of a key whose unique index never became active.

That state is easy to reach: the index is unique, so a column holding more than one blank cannot carry one.
Create a key on a column that has not been populated yet and it is created, never activates, and cannot be used - while on Dataverse for Teams the maker portal does not show keys at all, so there was no way to clear it.

The order that works is column, data, key.
Where a key has already been left behind, try Enable-PSDataverseKey first - it rebuilds the index and keeps the key - and remove it here only if that fails.

Only the key is removed.
The column it was made of and the data in it are untouched.

## EXAMPLES

### Clear a key that never became usable

Remove-PSDataverseKey -LogicalName it3c_aaduser -Name it3c_sourceidkey

Removes the key and leaves the column and its data alone.
Prompts first - this is a schema change.

### Replace the key after filling the column

PS C:\> Remove-PSDataverseKey it3c_aaduser it3c_sourceidkey -Confirm:$false
PS C:\> New-PSDataverseKey -LogicalName it3c_aaduser -SchemaName it3c_sourceidkey -KeyAttribute it3c_sourceid -Wait

With the column populated, the new index has nothing duplicate to trip over and activates.

## PARAMETERS

### -Confirm

Prompts for confirmation before removing the key.
This cmdlet prompts by default because removing a key is a schema change.

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

Logical or schema name of the key itself, for example it3c_sourceidkey.
This is the key's own name, not the column it is made of.

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

### -WhatIf

Shows what the cmdlet would remove without sending anything.

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

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

