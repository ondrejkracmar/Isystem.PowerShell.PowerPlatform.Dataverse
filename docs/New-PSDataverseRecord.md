---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: New-PSDataverseRecord
---

# New-PSDataverseRecord

## SYNOPSIS

Creates a new record in a Dataverse table.

## SYNTAX

### __AllParameterSets

```
New-PSDataverseRecord [-LogicalName] <string> [-Attributes] <hashtable> [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The New-PSDataverseRecord cmdlet creates a new record in the specified Dataverse table with the given attributes and returns the GUID of the created record.
This cmdlet supports ShouldProcess, so you can use -WhatIf and -Confirm.

## EXAMPLES

### Create an account

New-PSDataverseRecord -LogicalName "account" -Attributes @{ name = "Contoso Ltd"; emailaddress1 = "info@contoso.com" }

Creates a new account record and returns its GUID.

### Store the new record ID

$id = New-PSDataverseRecord "contact" @{ firstname = "John"; lastname = "Doe" }
Write-Host "Created contact: $id"

Creates a contact and stores the returned GUID in a variable.

## PARAMETERS

### -Attributes

A hashtable of attribute logical names and their values for the new record.

```yaml
Type: System.Collections.Hashtable
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Confirm

Prompts for confirmation before creating the record.

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

### -LogicalName

The logical name of the Dataverse table to create the record in.

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

### -WhatIf

Shows what would happen if the cmdlet runs without actually creating the record.

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

### System.Guid

The unique identifier of the newly created record.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

