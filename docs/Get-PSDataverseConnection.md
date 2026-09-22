---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/22/2026
PlatyPS schema version: 2024-05-01
title: Get-PSDataverseConnection
---

# Get-PSDataverseConnection

## SYNOPSIS

Gets the current Dataverse connection information.

## SYNTAX

### __AllParameterSets

```
Get-PSDataverseConnection
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Get-PSDataverseConnection cmdlet returns an object with properties indicating whether a Dataverse connection is active in the current runspace, along with the organization URL and user ID if connected.

## EXAMPLES

### Check connection status

Get-PSDataverseConnection

Returns the current connection state including IsConnected, OrganizationUrl, and UserId.

### Use in a condition

if ((Get-PSDataverseConnection).IsConnected) {
    Write-Host "Connected!"
}

Checks whether a connection is currently active.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSObject

An object with IsConnected (bool), OrganizationUrl (string), and UserId (Guid) properties.

### Isystem.PowerShell.PowerPlatform.Dataverse.Models.DataverseConnectionInfo

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

