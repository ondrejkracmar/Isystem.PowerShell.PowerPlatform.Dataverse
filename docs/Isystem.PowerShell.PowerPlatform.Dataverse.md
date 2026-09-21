---
document type: module
Help Version: 1.0.0.0
HelpInfoUri: 
Locale: en-US
Module Guid: 4f78bc29-fd8d-444c-a449-a244eeb23a79
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/21/2026
PlatyPS schema version: 2024-05-01
title: Isystem.PowerShell.PowerPlatform.Dataverse Module
---

# Isystem.PowerShell.PowerPlatform.Dataverse Module

## Description

Session-based cmdlets for Microsoft Dataverse (Power Platform, Dynamics 365): CRUD, upsert by alternate key, batches, transactions, FetchXML and paging. Authenticates with connection string, client secret, certificate, managed identity, Isystem.AzAuth modes, or a delegated user sign-in whose token cache the caller stores (Key Vault) for environments without application users.

## Isystem.PowerShell.PowerPlatform.Dataverse

### [Connect-PSDataverse](Connect-PSDataverse.md)

Connects to a Microsoft Dataverse environment.

### [Disconnect-PSDataverse](Disconnect-PSDataverse.md)

Disconnects from the current Dataverse environment.

### [Find-PSDataverseRecord](Find-PSDataverseRecord.md)

Searches for Dataverse records matching filter criteria.

### [Get-PSDataverseConnection](Get-PSDataverseConnection.md)

Gets the current Dataverse connection information.

### [Get-PSDataverseRecord](Get-PSDataverseRecord.md)

Gets a Dataverse record by ID or alternate key.

### [Get-PSDataverseRecordCount](Get-PSDataverseRecordCount.md)

Gets the total count of records in a Dataverse table.

### [Get-PSDataverseTokenCache](Get-PSDataverseTokenCache.md)

Exports the delegated token cache of the current (or last) session.

### [Invoke-PSDataverseBatch](Invoke-PSDataverseBatch.md)

Executes a batch of Dataverse operations (create/update/upsert/delete).

### [Invoke-PSDataverseFetchXml](Invoke-PSDataverseFetchXml.md)

Queries Dataverse records using FetchXML.

### [Invoke-PSDataverseTransaction](Invoke-PSDataverseTransaction.md)

Executes Dataverse operations in a single atomic transaction.

### [New-PSDataverseRecord](New-PSDataverseRecord.md)

Creates a new record in a Dataverse table.

### [Remove-PSDataverseRecord](Remove-PSDataverseRecord.md)

Deletes a record from a Dataverse table.

### [Set-PSDataverseRecord](Set-PSDataverseRecord.md)

Updates an existing Dataverse record, or upserts it by alternate key.

### [Test-PSDataverseRecord](Test-PSDataverseRecord.md)

Tests whether a Dataverse record exists.

