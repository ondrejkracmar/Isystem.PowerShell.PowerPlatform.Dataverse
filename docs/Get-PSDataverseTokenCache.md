---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: Get-PSDataverseTokenCache
---

# Get-PSDataverseTokenCache

## SYNOPSIS

Exports the delegated token cache of the current (or last) session.

## SYNTAX

### __AllParameterSets

```
Get-PSDataverseTokenCache
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Get-PSDataverseTokenCache cmdlet returns the serialized MSAL token cache of a session opened with Connect-PSDataverse -Delegated, as one opaque string (prefix PSDVTC1: followed by base64).
The refresh token lives inside that cache and MSAL may rotate it during a session, so persist the value after the work is done - to Azure Key Vault (for example through PSDataRepository), a file, or any other secret store - and pass it back through Connect-PSDataverse -TokenCache on the next run.
The value stays available after Disconnect-PSDataverse until the next Connect-PSDataverse.
Treat it as a credential.

## EXAMPLES

### Persist the cache to Key Vault after a sync

Get-PSDataverseTokenCache | Set-PSDataRepositoryItem -Name 'dataverse-tokencache'

Stores the (possibly rotated) cache so the next unattended run can sign in silently.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

The serialized token cache envelope.

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

