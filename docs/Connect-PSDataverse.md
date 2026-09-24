---
document type: cmdlet
external help file: Isystem.PowerShell.PowerPlatform.Dataverse.dll-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Isystem.PowerShell.PowerPlatform.Dataverse
ms.date: 09/24/2026
PlatyPS schema version: 2024-05-01
title: Connect-PSDataverse
---

# Connect-PSDataverse

## SYNOPSIS

Connects to a Microsoft Dataverse environment.

## SYNTAX

### ConnectionString (Default)

```
Connect-PSDataverse [-ConnectionString] <securestring> [-MaxRetryCount <int>]
 [-RetryPauseSeconds <int>]
```

### ClientSecret

```
Connect-PSDataverse [-Url] <string> [-ClientId] <string> [-ClientSecret] <securestring>
 [-TenantId <string>] [-MaxRetryCount <int>] [-RetryPauseSeconds <int>]
```

### Certificate

```
Connect-PSDataverse [-Url] <string> [-ClientId] <string> [-CertificateThumbprint] <string>
 [-TenantId <string>] [-MaxRetryCount <int>] [-RetryPauseSeconds <int>]
```

### ManagedIdentity

```
Connect-PSDataverse [-Url] <string> -ManagedIdentity [-ManagedIdentityId <string>]
 [-MaxRetryCount <int>] [-RetryPauseSeconds <int>]
```

### AzAuth

```
Connect-PSDataverse [-Url] <string> -AuthMode <DataverseAuthMode> [-ClientId <string>]
 [-ClientSecret <securestring>] [-CertificateThumbprint <string>] [-CertificatePath <string>]
 [-Certificate <X509Certificate2>] [-TenantId <string>] [-TokenCacheName <string>]
 [-Username <string>] [-ExternalToken <securestring>] [-TimeoutSeconds <int>] [-MaxRetryCount <int>]
 [-RetryPauseSeconds <int>]
```

### Delegated

```
Connect-PSDataverse [-Url] <string> -Delegated [-ClientId <string>] [-TenantId <string>]
 [-TokenCache <string>] [-LoginMode <DataverseLoginMode>] [-RedirectUri <string>]
 [-MaxRetryCount <int>] [-RetryPauseSeconds <int>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Connect-PSDataverse cmdlet establishes a connection to a Microsoft Dataverse environment using one of several authentication methods: connection string, client secret, certificate, managed identity, Isystem.AzAuth (-AuthMode, the same modes PSDataRepository uses, including WorkloadIdentity, NonInteractive, Interactive and DeviceCode with a named on-disk cache), or a delegated user sign-in with a portable in-memory token cache (-Delegated, for environments without application users).
The connection is stored in the current PowerShell runspace and used by all subsequent Dataverse cmdlets.

## EXAMPLES

### Connect using a connection string

$cs = ConvertTo-SecureString "AuthType=ClientSecret;Url=https://org.crm.dynamics.com;ClientId=...;ClientSecret=..." -AsPlainText -Force
Connect-PSDataverse $cs

Connects to Dataverse using a connection string stored as a SecureString.

### Connect using client secret

$secret = ConvertTo-SecureString "my-secret" -AsPlainText -Force
Connect-PSDataverse -Url "https://org.crm.dynamics.com" -ClientId "app-id" -ClientSecret $secret -TenantId "tenant-id"

Connects using explicit client ID and secret parameters.

### Connect using managed identity

Connect-PSDataverse -Url "https://org.crm.dynamics.com" -ManagedIdentity

Connects using the system-assigned managed identity of the Azure host.

### Connect with custom retry policy

Connect-PSDataverse -Url "https://org.crm.dynamics.com" -ManagedIdentity -MaxRetryCount 5 -RetryPauseSeconds 10

Connects and configures a retry policy with up to 5 retries and a 10-second pause between attempts.

## PARAMETERS

### -AuthMode

Isystem.AzAuth authentication mode.
Names match PSDataRepository -AuthMode: ClientSecret, ClientCertificate, ManagedIdentity, WorkloadIdentity, NonInteractive (Azure.Identity default chain), Interactive (browser), DeviceCode, Cache (silent from a named on-disk cache).

```yaml
Type: Isystem.PowerShell.PowerPlatform.Dataverse.Base.DataverseAuthMode
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzAuth
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Certificate

An X509Certificate2 instance for AzAuth ClientCertificate mode.
Alternative to -CertificateThumbprint and -CertificatePath.

```yaml
Type: System.Security.Cryptography.X509Certificates.X509Certificate2
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CertificatePath

Path to a certificate file (PFX/PEM) for AzAuth ClientCertificate mode.
Alternative to -CertificateThumbprint and -Certificate.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CertificateThumbprint

The thumbprint of the certificate used for certificate-based authentication (Certificate set, or AzAuth -AuthMode ClientCertificate).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Certificate
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ClientId

The Microsoft Entra application (client) ID.
Mandatory for ClientSecret and Certificate; optional for AzAuth (mode dependent) and Delegated, where it defaults to the well-known public Dataverse client 51f81489-12ee-4a9e-aaae-a2591f45987d.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ClientSecret
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Certificate
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Delegated
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ClientSecret

The client secret for app-based authentication (ClientSecret set, or AzAuth -AuthMode ClientSecret), provided as a SecureString.

```yaml
Type: System.Security.SecureString
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ClientSecret
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ConnectionString

A Dataverse connection string provided as a SecureString.
Used in the ConnectionString parameter set.

```yaml
Type: System.Security.SecureString
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ConnectionString
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Delegated

Delegated (user) sign-in with an in-memory MSAL token cache that the caller persists wherever it wants (Key Vault, file).
Use when the environment has no application users, such as Dataverse for Teams without a premium licence.
Export the cache with Get-PSDataverseTokenCache and pass it back through -TokenCache on the next run.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Delegated
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ExternalToken

Federated token for AzAuth WorkloadIdentity mode (for example the AKS or GitHub Actions identity token), as a SecureString.

```yaml
Type: System.Security.SecureString
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -LoginMode

What to do when the token cache holds no usable refresh token: Auto (silent, then browser), Silent (fail - for unattended runs), Interactive (silent, then browser), DeviceCode (silent, then device-code prompt for headless hosts).
Default: Auto.

```yaml
Type: Isystem.PowerShell.PowerPlatform.Dataverse.Base.DataverseLoginMode
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Delegated
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ManagedIdentity

Indicates that managed identity authentication should be used.
Typically used when running in Azure.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ManagedIdentity
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ManagedIdentityId

The client ID of a user-assigned managed identity.
If omitted, the system-assigned identity is used.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ManagedIdentity
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MaxRetryCount

Maximum number of retry attempts for transient failures.
Valid range: 0-10.
Default: 3.

```yaml
Type: System.Int32
DefaultValue: 3
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

### -RedirectUri

Redirect URI of the public client application used by -Delegated.
Default: http://localhost.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Delegated
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -RetryPauseSeconds

Pause in seconds between retry attempts.
Valid range: 1-60.
Default: 5.

```yaml
Type: System.Int32
DefaultValue: 5
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

### -TenantId

The Microsoft Entra tenant ID.
Optional; when omitted, delegated flows use the organizations authority.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ClientSecret
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Certificate
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Delegated
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

Timeout for interactive and managed-identity token acquisition in AzAuth modes.
Valid range: 10-600.
Default: 120.

```yaml
Type: System.Int32
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TokenCache

Serialized token cache produced by Get-PSDataverseTokenCache in an earlier session.
Seeds the in-memory MSAL cache so the sign-in is silent.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Delegated
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TokenCacheName

Name of the on-disk MSAL token cache used by AzAuth Interactive, DeviceCode and Cache modes.
The cache is protected by DPAPI/keychain and bound to the current user and machine.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzAuth
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Url

The URL of the Dataverse environment (e.g., https://org.crm.dynamics.com).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ClientSecret
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Certificate
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ManagedIdentity
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: AzAuth
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: Delegated
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Username

Account (UPN or object id) to select from the named cache in AzAuth Cache mode.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: AzAuth
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

### System.Void

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

