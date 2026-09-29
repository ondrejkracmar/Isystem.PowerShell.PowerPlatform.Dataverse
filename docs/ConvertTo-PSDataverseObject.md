---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/29/2026
PlatyPS schema version: 2024-05-01
title: ConvertTo-PSDataverseObject
---

# ConvertTo-PSDataverseObject

## SYNOPSIS

Converts Dataverse records into flat PowerShell objects.

## SYNTAX

### __AllParameterSets

```
ConvertTo-PSDataverseObject [-InputObject] <psobject[]> [-IncludeFormattedValues]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The ConvertTo-PSDataverseObject cmdlet applies the same conversion the query cmdlets perform with -AsObject, to records you already have: the items of an Invoke-PSDataverseBatch result, entities kept in a variable, anything that came back as an SDK Entity.

A Dataverse row is a sparse bag of typed values rather than a record with fixed fields, and the values are SDK objects.
This flattens them: a lookup becomes its id, an option set its number, money its decimal, a multi-select an array of numbers, and an aliased value (a FetchXML join or aggregate) reads like an ordinary column.
LogicalName and Id come first so a table of mixed rows still lines up.

No connection is needed - the cmdlet touches nothing but the objects piped into it.
Anything that is not an Entity passes through untouched, so it stays usable mid-pipeline.

To write a flattened row back, use the hashtable forms the module accepts on input: @{ LogicalName = 'account'; Id = $guid } for a lookup, @{ OptionSet = 1 } for a choice, @{ Money = 12.50 } for an amount.

## EXAMPLES

### Export records kept in a variable

$rows | ConvertTo-PSDataverseObject | Export-Csv accounts.csv -NoTypeInformation

Export-Csv cannot serialize an SDK Entity; the flattened rows export as ordinary columns.

### Read the rows a batch returned, with display text

$result = Invoke-PSDataverseBatch -Operations $operations
$result.Items | ConvertTo-PSDataverseObject -IncludeFormattedValues | Format-Table

Items that are not records pass through, so nothing is lost from the result.

## PARAMETERS

### -IncludeFormattedValues

Add the display text beside each value: {column}_name for a lookup, {column}_display for the label the service formatted for a choice, date or amount.

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

### -InputObject

The records to convert.
Anything that is not an SDK Entity is passed through untouched.

```yaml
Type: System.Management.Automation.PSObject[]
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
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

### System.Management.Automation.PSObject

Records, typically Microsoft.Xrm.Sdk.Entity instances.

### System.Management.Automation.PSObject[]

{{ Fill in the Description }}

## OUTPUTS

### System.Management.Automation.PSObject

One flat object per record, typed Dataverse.Record and Dataverse.Record.<table>.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

