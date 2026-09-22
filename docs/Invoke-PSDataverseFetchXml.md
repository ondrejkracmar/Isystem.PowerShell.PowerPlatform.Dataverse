---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: Invoke-PSDataverseFetchXml
---

# Invoke-PSDataverseFetchXml

## SYNOPSIS

Queries Dataverse records using FetchXML.

## SYNTAX

### __AllParameterSets

```
Invoke-PSDataverseFetchXml [-FetchXml] <string> [-All]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Invoke-PSDataverseFetchXml cmdlet executes a FetchXML query against Dataverse and returns the matching Entity objects.
The FetchXML is validated for well-formedness before execution.
Use -All to automatically page through all results.

## EXAMPLES

### Execute a FetchXML query

$fetchXml = @"
<fetch top="10">
  <entity name="account">
    <attribute name="name" />
    <attribute name="emailaddress1" />
  </entity>
</fetch>
"@
Invoke-PSDataverseFetchXml -FetchXml $fetchXml

Retrieves the top 10 accounts with name and email columns.

### Retrieve all pages

Invoke-PSDataverseFetchXml -FetchXml $fetchXml -All

Retrieves all matching records across multiple pages.

### Pipeline input

Get-Content "query.xml" -Raw | Invoke-PSDataverseFetchXml

Reads FetchXML from a file and pipes it to the cmdlet.

## PARAMETERS

### -All

Retrieves all matching records across all pages using paging cookies.

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

### -FetchXml

The FetchXML query string.
Must be well-formed XML.

```yaml
Type: System.String
DefaultValue: ''
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

### System.String

{{ Fill in the Description }}

## OUTPUTS

### Microsoft.Xrm.Sdk.Entity

Zero or more Entity objects matching the FetchXML query.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

