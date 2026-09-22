# Isystem.PowerShell.PowerPlatform.Dataverse

PowerShell binary module for **Microsoft Dataverse** (Power Platform, Dynamics 365). Session-based connection, CRUD, **upsert by alternate key**, batches, transactions, FetchXML with paging - and an authentication model that also covers environments **without application users** (Dataverse for Teams, no premium licence) through a delegated sign-in whose token cache you keep in your own secret store.

Ships `net9.0` and `net10.0` builds; the loader picks the one matching your PowerShell (7.5 / 7.6+). Assemblies are strong-named. See [CHANGELOG.md](CHANGELOG.md), [SECURITY.md](SECURITY.md) and [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

> **Reading this on GitHub?** This repository is a published mirror: it carries the compiled
> module and its documentation, but no source and no build. Source, pipeline and issues live in
> Azure DevOps (`i-system/PSModules/Isystem.PowerShell.PowerPlatform`). Install from the
> PowerShell Gallery as shown below.

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Dataverse Environment Setup](#dataverse-environment-setup)
  - [Create a Dataverse Environment](#create-a-dataverse-environment)
  - [Dataverse for Microsoft Teams](#dataverse-for-microsoft-teams)
  - [Register an App for Authentication](#register-an-app-for-authentication)
  - [Service-to-Service (API) Setup — Detailed Procedure](#service-to-service-api-setup--detailed-procedure)
    - [Step 1 — Choose Authentication Mode](#step-1--choose-authentication-mode)
    - [Step 2 — Register App in Microsoft Entra ID](#step-2--register-app-in-microsoft-entra-id)
    - [Step 3 — Configure Secret or Certificate](#step-3--configure-secret-or-certificate)
    - [Step 4 — Configure Dataverse API Permissions](#step-4--configure-dataverse-api-permissions)
    - [Step 5 — Create Application User in Dataverse](#step-5--create-application-user-in-dataverse)
    - [Step 6 — Assign Security Role (Least Privilege)](#step-6--assign-security-role-least-privilege)
    - [Step 7 — Validate Connectivity from PowerShell](#step-7--validate-connectivity-from-powershell)
    - [Common API Setup Issues](#common-api-setup-issues)
- [Authentication](#authentication)
  - [Connection String (Interactive / OAuth)](#connection-string-interactive--oauth)
  - [Client Secret (Service Principal)](#client-secret-service-principal)
  - [Certificate](#certificate)
  - [Managed Identity](#managed-identity)
  - [Isystem.AzAuth Modes](#isystemazauth-modes)
  - [Delegated Sign-in with a Portable Token Cache](#delegated-sign-in-with-a-portable-token-cache)
- [Quick Start](#quick-start)
- [Module Documentation](#module-documentation)
- [Cmdlet Reference](#cmdlet-reference)
  - [Connection Management](#connection-management)
  - [Record Operations (CRUD)](#record-operations-crud)
  - [Query & Search](#query--search)
  - [Bulk Operations](#bulk-operations)
- [Advanced Usage](#advanced-usage)
  - [Pipeline Support](#pipeline-support)
  - [Paging (All Records)](#paging-all-records)
  - [Batch Operations](#batch-operations)
  - [Upsert by Alternate Key (idempotent sync)](#upsert-by-alternate-key-idempotent-sync)
  - [Transactions](#transactions)
  - [FetchXML](#fetchxml)
  - [Retry Configuration](#retry-configuration)
- [Development](#development)
- [License](#license)

---

## Features

- **Session-based connection** with per-runspace isolation (thread-safe)
- **Six ways to authenticate** — connection string, client secret, certificate, managed identity, [Isystem.AzAuth](#isystemazauth-modes) modes (`-AuthMode`, same names as PSDataRepository: WorkloadIdentity, NonInteractive, Interactive, DeviceCode, …), and a **delegated sign-in with a portable token cache** (`-Delegated`) for environments that have no application users
- **Full CRUD** — Create, Read, Update, Delete with pipeline and `InputObject` support
- **Upsert and alternate keys** — `Set-PSDataverseRecord -Key @{…} -Upsert`; `-Key` on Get/Set/Remove/Test; `Action = 'Upsert'` in batches
- **Lookups without SDK types** — `@{ LogicalName = 'account'; Id = $id }` or `@{ LogicalName = 'x'; Key = @{ … } }` becomes an `EntityReference` (the `@odata.bind` equivalent)
- **Bulk operations** — `Invoke-PSDataverseBatch` (`ContinueOnError`) and `Invoke-PSDataverseTransaction` (atomic rollback), both returning one structured result item per operation (id, error code, message)
- **Non-terminating per-record errors** — a pipeline of records keeps going; `-ErrorAction` decides
- **FetchXML** — `Invoke-PSDataverseFetchXml` with automatic paging
- **Automatic paging** — `-All` switch retrieves all records across pages (5 000 per page)
- **Record existence check** — `Test-PSDataverseRecord` returns `$true` / `$false`
- **Record count** — `Get-PSDataverseRecordCount` with optional filter
- **Like filters** — wildcard search via `-LikeFilter` on `Find-PSDataverseRecord`
- **ShouldProcess** — `Remove-PSDataverseRecord`, `Invoke-PSDataverseBatch`, and `Invoke-PSDataverseTransaction` support `-WhatIf` and `-Confirm`
- **SecureString** — `ConnectionString` and `ClientSecret` parameters accept `SecureString` only
- **Configurable retry** — `MaxRetryCount` (0-10) and `RetryPauseSeconds` (1-60) on connect
- **Graceful cancellation** — Ctrl+C stops paging loops cleanly
- **MAML help** — `Get-Help` works for every cmdlet with examples

---

## Requirements

| Requirement | Version |
|---|---|
| PowerShell | 7.5 (uses the `net9.0` build) or 7.6+ (uses the `net10.0` build) |
| .NET Runtime | 9.0 or 10.0 |
| Dataverse | Any environment (Production, Sandbox, Developer, Teams) |

No PowerShell module dependencies. The Dataverse SDK, MSAL and Isystem.AzAuth are bundled inside the module.

> **Side by side with PSSqlRepository / PSDataRepository on PowerShell 7.5:** import this module first. Its 9.x `Microsoft.Extensions.*` assemblies satisfy their 8.x references, not the other way round. On 7.6+ all three ship 10.x and order does not matter.

---

## Installation

### From the PowerShell Gallery

```powershell
Install-PSResource Isystem.PowerShell.PowerPlatform.Dataverse -Repository PSGallery   # or: Install-Module
Import-Module Isystem.PowerShell.PowerPlatform.Dataverse
```

The same package is published to the i-system Azure Artifacts feed for internal pipelines. The manifest's root module is a small `.psm1` loader that picks `bin/net9.0` or `bin/net10.0` for the running PowerShell.

### Verify Installation

```powershell
Get-Command -Module Isystem.PowerShell.PowerPlatform.Dataverse

# Should list all 14 cmdlets:
#   Connect-PSDataverse          Disconnect-PSDataverse
#   Get-PSDataverseConnection    Get-PSDataverseTokenCache
#   Get-PSDataverseRecord        Get-PSDataverseRecordCount
#   Find-PSDataverseRecord       Test-PSDataverseRecord
#   New-PSDataverseRecord        Set-PSDataverseRecord
#   Remove-PSDataverseRecord     Invoke-PSDataverseBatch
#   Invoke-PSDataverseTransaction Invoke-PSDataverseFetchXml
```

---

## Dataverse Environment Setup

Microsoft Dataverse is available in **two distinct variants**. Understanding the differences is critical before connecting from this module.

### Full Dataverse vs. Dataverse for Teams — Comparison

| Feature | Full Dataverse | Dataverse for Teams |
|---|---|---|
| **License required** | Power Apps, Power Automate, Dynamics 365, or standalone Dataverse plan | Included with Microsoft 365 / Office 365 (Teams license) |
| **Provisioning** | Power Platform Admin Center → New Environment | Automatically created when building a Power App in a Team |
| **Custom tables** | Unlimited | Up to 1 000 (simplified designer) |
| **API access (SDK / ServiceClient)** | Full — all CRUD, batch, transactions, FetchXML | **Limited** — basic CRUD works, but advanced features (batch, transactions, complex FetchXML, plug-ins) may not be available or may behave differently |
| **Application Users (S2S)** | Fully supported — Client Secret, Certificate, Managed Identity | **Not supported** until upgraded to full Dataverse |
| **Capacity** | Environment-specific storage (1 GB+) | 2 GB per team, 1 million rows |
| **Environment type in Admin Center** | `Production`, `Sandbox`, `Developer` | `Microsoft Teams` |
| **Upgrade path** | N/A | Can be upgraded to full Dataverse (one-way, irreversible) |

> **Recommendation for automation:** If you plan to use this module for service-to-service (S2S) integrations, CI/CD, or batch operations — use **full Dataverse**. Dataverse for Teams is designed for citizen developers building simple apps inside Teams.

### How to Identify Which Dataverse You Are Connecting To

Before connecting, verify the environment type:

1. **Power Platform Admin Center** — go to [admin.powerplatform.microsoft.com](https://admin.powerplatform.microsoft.com/) → **Environments**
2. Look at the **Type** column:
   - `Production` / `Sandbox` / `Developer` → **Full Dataverse** ✅
   - `Microsoft Teams` → **Dataverse for Teams** ⚠️
3. Click the environment → note the **Environment URL** (e.g. `https://org1a2b3c4d.crm4.dynamics.com`)

You can also verify programmatically after connecting:

```powershell
# Connect and check the environment
Connect-PSDataverse -ConnectionString $cs
$conn = Get-PSDataverseConnection
$conn | Format-List

# OrganizationUrl, OrganizationFriendlyName and EnvironmentId confirm which environment you are connected to.
# Cross-reference with the Admin Center to verify the environment type.
```

> **Tip:** The environment URL follows the pattern `https://<orgname>.<region>.dynamics.com`. The `<region>` depends on your datacenter — `crm` (North America), `crm4` (Europe), `crm5` (Asia-Pacific), etc. This URL alone does NOT tell you whether it's full Dataverse or Teams — always check the Admin Center.

### Create a Full Dataverse Environment

1. Go to the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/)
2. Select **Environments** > **+ New**
3. Fill in:
   - **Name** — e.g. `Dev-Automation`
   - **Type** — `Sandbox` (for development) or `Production`
   - **Region** — choose your region
   - **Add a Dataverse data store** — toggle **Yes**
4. Click **Next**, configure security group (optional), then **Save**
5. Wait for provisioning to complete (approximately 2-5 minutes)
6. Note the **Environment URL** — e.g. `https://org1a2b3c4d.crm4.dynamics.com`

### Dataverse for Microsoft Teams

Microsoft Teams automatically provisions a **Dataverse for Teams** environment when you create a Power App inside a team.

#### When to Use Dataverse for Teams with This Module

- ✅ **Interactive / delegated access** — connecting as a user (OAuth with `LoginPrompt=Auto`) works
- ✅ **Basic CRUD** — `New-PSDataverseRecord`, `Get-PSDataverseRecord`, `Set-PSDataverseRecord`, `Remove-PSDataverseRecord`
- ⚠️ **Find / queries** — basic queries work, but complex filters or ordering may be limited
- ❌ **Service-to-service (Client Secret / Certificate)** — Application Users are NOT supported until the environment is upgraded
- ❌ **Batch / Transaction** — `Invoke-PSDataverseBatch` and `Invoke-PSDataverseTransaction` may not be fully supported

#### Setup Steps

1. **Create the environment** — Open Teams, open any team, click **+**, select **Power Apps**, and create a simple app. This triggers environment provisioning.
2. **Find the environment URL**:
   - Go to [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/) > **Environments**
   - Locate the environment named after your team (e.g. `Contoso Team (default)`)
   - Verify the **Type** column shows `Microsoft Teams`
   - Click it and copy the **Environment URL**
3. **Connect from PowerShell** (interactive only):

```powershell
$url = "https://orgXXXXXXXX.crm4.dynamics.com"  # Your Teams environment URL

# Interactive login — the ONLY authentication method supported for Dataverse for Teams
$cs = ConvertTo-SecureString "AuthType=OAuth;Url=$url;LoginPrompt=Auto;AppId=51f81489-12ee-4a9e-aaae-a2591f45987d;RedirectUri=http://localhost" -AsPlainText -Force
Connect-PSDataverse -ConnectionString $cs
```

4. **Upgrade to full Dataverse** (recommended for automation):
   - In the Admin Center, select the Teams environment → **Upgrade to production**
   - This unlocks full API access, Application Users, batch/transactions, and all Dataverse features
   - ⚠️ **This is irreversible** — the environment becomes a full Dataverse environment and counts against your Dataverse capacity
   - After upgrade, the **Type** changes from `Microsoft Teams` to `Production` and all authentication methods become available

### Register an App for Authentication

For non-interactive automation (CI/CD, Azure Functions, scripts), register an app in Microsoft Entra ID:

1. Go to [Microsoft Entra ID](https://entra.microsoft.com/) > **App registrations** > **+ New registration**
2. Fill in:
   - **Name** — e.g. `Dataverse-Automation`
   - **Supported account types** — `Single tenant`
   - **Redirect URI** — leave empty for daemon/service apps
3. After creation, note the **Application (client) ID** and **Directory (tenant) ID**
4. **Create a Client Secret**:
   - Go to **Certificates & secrets** > **+ New client secret**
   - Note the **Value** (you cannot view it again later)
5. **Or upload a Certificate**:
   - Go to **Certificates & secrets** > **Certificates** > **Upload certificate**
   - Note the **Thumbprint**
6. **Grant Dataverse permissions**:
   - Go to **API permissions** > **+ Add a permission** > **Dynamics CRM** > **Delegated permissions** > **user_impersonation** > **Add**
   - Or for application-level access (no user context): register an **Application User** in Dataverse:
     1. Go to [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/) > **Environments** > select your environment > **Settings**
     2. Go to **Users + permissions** > **Application users** > **+ New app user**
     3. Select your Entra ID app and assign a **Security role** (e.g. `System Administrator` or a custom role)

### Service-to-Service (API) Setup — Detailed Procedure

Use this section when you want to run Dataverse integration as a background service (CI/CD, scheduled jobs, worker service, Azure Function, container).

#### Step 1 — Choose Authentication Mode

Pick one mode and keep it consistent per workload:

- **Client Secret** — easiest to start with; rotate often.
- **Certificate** — recommended for production long-running services.
- **Managed Identity** — recommended in Azure-hosted workloads (no secret handling).

#### Step 2 — Register App in Microsoft Entra ID

1. Open [Microsoft Entra Admin Center](https://entra.microsoft.com/).
2. Go to **App registrations** > **New registration**.
3. Use:
   - **Name**: e.g. `Dataverse-Integration-Prod`
   - **Supported account types**: `Single tenant`
   - **Redirect URI**: not required for daemon/service apps
4. Save and copy:
   - **Application (client) ID**
   - **Directory (tenant) ID**

#### Step 3 — Configure Secret or Certificate

Choose one credential type:

- **Client secret**
  1. Open **Certificates & secrets** > **Client secrets** > **New client secret**.
  2. Choose shortest acceptable expiration (security best practice).
  3. Copy and store the secret value in a secure store (Azure Key Vault, pipeline secret).
- **Certificate**
  1. Open **Certificates & secrets** > **Certificates** > **Upload certificate**.
  2. Upload public cert (`.cer`).
  3. Install the private key certificate on the runtime host and note the thumbprint.

#### Step 4 — Configure Dataverse API Permissions

1. In the same app registration open **API permissions** > **Add a permission**.
2. Select **Dynamics CRM**.
3. Add **user_impersonation**.
4. Click **Grant admin consent** for the tenant.

> Note: API permission alone is not enough. Dataverse authorization is controlled primarily by the Application User + Security Role inside the target environment.

#### Step 5 — Create Application User in Dataverse

1. Open [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/).
2. Select your environment.
3. Go to **Settings** > **Users + permissions** > **Application users**.
4. Click **+ New app user**.
5. Select the Entra app from Step 2.
6. Set **Business unit** (typically root BU unless you have strict BU partitioning).
7. Save the user.

#### Step 6 — Assign Security Role (Least Privilege)

Start with minimum required privileges. Avoid giving `System Administrator` in production unless truly needed.

Typical minimum role content for this module:

- Read/Create/Write/Delete on target tables used by your integration.
- Read on metadata-related tables if your workload relies on schema lookups.
- Privileges required for batch/transaction operations if used.

Recommended approach:

1. Clone an existing role.
2. Grant only required table privileges.
3. Assign the custom role to the Application User.
4. Test and expand only when you hit explicit `insufficient privileges` errors.

#### Step 7 — Validate Connectivity from PowerShell

Run a minimal smoke test before shipping:

```powershell
# 1) Connect (Client Secret example)
$secret = ConvertTo-SecureString "<client-secret>" -AsPlainText -Force
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" `
                    -ClientId "<client-id>" `
                    -ClientSecret $secret `
                    -TenantId "<tenant-id>"

# 2) Verify session
$conn = Get-PSDataverseConnection
$conn | Format-List

# 3) Verify read access (small table query)
Get-PSDataverseRecordCount -LogicalName "account"

# 4) Disconnect
Disconnect-PSDataverse
```

For certificate auth, replace connect command with:

```powershell
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" `
                    -ClientId "<client-id>" `
                    -CertificateThumbprint "<thumbprint>" `
                    -TenantId "<tenant-id>"
```

For managed identity auth, use:

```powershell
# System-assigned identity
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" -ManagedIdentity

# User-assigned identity
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" -ManagedIdentity -ManagedIdentityId "<mi-client-id>"
```

#### Common API Setup Issues

- **AADSTS / invalid_client** — wrong client ID, expired secret, or certificate private key not available on host.
- **Connected but operations fail with privilege errors** — Application User exists, but role is missing table privileges.
- **Wrong environment URL** — verify exact Dataverse org URL from Power Platform Admin Center.
- **Managed identity fails** — identity not enabled/assigned on resource, or missing Application User mapping in Dataverse.
- **Intermittent failures** — increase connect retry settings (`-MaxRetryCount`, `-RetryPauseSeconds`) for transient conditions.

---

## Authentication

### Connection String (Interactive / OAuth)

Best for interactive development and testing. Uses the Microsoft-published sample app ID:

```powershell
$url = "https://yourorg.crm4.dynamics.com"
$cs = ConvertTo-SecureString "AuthType=OAuth;Url=$url;LoginPrompt=Auto;AppId=51f81489-12ee-4a9e-aaae-a2591f45987d;RedirectUri=http://localhost" -AsPlainText -Force
Connect-PSDataverse -ConnectionString $cs
```

### Client Secret (Service Principal)

Best for CI/CD pipelines and automation:

```powershell
$secret = ConvertTo-SecureString "your-client-secret" -AsPlainText -Force
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" `
                    -ClientId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" `
                    -ClientSecret $secret `
                    -TenantId "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
```

### Certificate

Best for production service-to-service authentication:

```powershell
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" `
                    -ClientId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" `
                    -CertificateThumbprint "ABC123DEF456..." `
                    -TenantId "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
```

### Managed Identity

Best for Azure-hosted workloads (Azure Functions, VMs, Container Apps):

```powershell
# System-assigned managed identity
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" -ManagedIdentity

# User-assigned managed identity
Connect-PSDataverse -Url "https://yourorg.crm4.dynamics.com" -ManagedIdentity `
                    -ManagedIdentityId "zzzzzzzz-zzzz-zzzz-zzzz-zzzzzzzzzzzz"
```

### Isystem.AzAuth Modes

`-AuthMode` acquires tokens through Isystem.AzAuth with the same mode names PSDataRepository uses, so one configuration vocabulary covers both modules:

| Mode | Parameters | Typical host |
|---|---|---|
| `ClientSecret` | `-ClientId -TenantId -ClientSecret` | pipelines |
| `ClientCertificate` | `-ClientId -TenantId` + `-CertificateThumbprint` / `-CertificatePath` / `-Certificate` | pipelines, servers |
| `ManagedIdentity` | optional `-ClientId` (user-assigned) | Azure VM, Functions, Container Apps |
| `WorkloadIdentity` | `-ClientId -TenantId -ExternalToken` | AKS, GitHub Actions |
| `NonInteractive` | optional `-TenantId` | Azure.Identity default chain (env, MI, Azure CLI, Azure PowerShell) |
| `Interactive` / `DeviceCode` | optional `-TokenCacheName` | developer box / headless bootstrap |
| `Cache` | `-TokenCacheName -Username` | silent from a named on-disk cache |

```powershell
Connect-PSDataverse -Url $url -AuthMode WorkloadIdentity -ClientId $appId -TenantId $tenant -ExternalToken $federatedToken
Connect-PSDataverse -Url $url -AuthMode DeviceCode -TokenCacheName 'dataverse'
Connect-PSDataverse -Url $url -AuthMode Cache -TokenCacheName 'dataverse' -Username 'jane@contoso.com'
```

### Delegated Sign-in with a Portable Token Cache

For environments **without application users** - Dataverse for Teams, or any tenant where no premium licence allows a service principal - the only option is a user identity. `-Delegated` signs the user in through MSAL and keeps the token cache **in memory**; `Get-PSDataverseTokenCache` exports it as one opaque string that you store wherever you keep secrets, and `-TokenCache` seeds the next session with it. The refresh token never touches the disk through this module.

```powershell
# One-time bootstrap on a workstation (browser sign-in), then store the cache:
Connect-PSDataverse -Url $url -Delegated -LoginMode Interactive
Get-PSDataverseTokenCache | Set-PSDataRepositorySecret -Name 'dataverse-tokencache'   # Key Vault via PSDataRepository

# Every unattended run: seed, work, persist the (possibly rotated) cache:
$cache = Get-PSDataRepositorySecret -Name 'dataverse-tokencache'
Connect-PSDataverse -Url $url -Delegated -TokenCache $cache -LoginMode Silent
# ... sync ...
Get-PSDataverseTokenCache | Set-PSDataRepositorySecret -Name 'dataverse-tokencache'
Disconnect-PSDataverse
```

`-LoginMode Silent` makes an unusable cache (expired or revoked refresh token) fail immediately with a clear error instead of prompting; `DeviceCode` bootstraps on a headless host. `-ClientId` defaults to Microsoft's public Dataverse client (`51f81489-12ee-4a9e-aaae-a2591f45987d`), which needs no app registration. **Treat the exported cache as a credential** - see [SECURITY.md](SECURITY.md).

---

## Quick Start

```powershell
Import-Module Isystem.PowerShell.PowerPlatform.Dataverse

# 1. Connect
$cs = ConvertTo-SecureString "AuthType=OAuth;Url=https://yourorg.crm4.dynamics.com;LoginPrompt=Auto;AppId=51f81489-12ee-4a9e-aaae-a2591f45987d;RedirectUri=http://localhost" -AsPlainText -Force
Connect-PSDataverse -ConnectionString $cs

# 2. Check connection
Get-PSDataverseConnection

# 3. Create a record
$id = New-PSDataverseRecord -LogicalName "account" -Attributes @{
    name          = "Contoso Ltd"
    emailaddress1 = "info@contoso.com"
    telephone1    = "+420 123 456 789"
}

# 4. Read the record
$account = Get-PSDataverseRecord -LogicalName "account" -Id $id
$account.Attributes

# 5. Update the record
Set-PSDataverseRecord -LogicalName "account" -Id $id -Attributes @{
    telephone1 = "+420 987 654 321"
}

# 6. Find records
Find-PSDataverseRecord -LogicalName "account" -Filter @{ name = "Contoso Ltd" }

# 7. Check if record exists
Test-PSDataverseRecord -LogicalName "account" -Id $id

# 8. Count records
Get-PSDataverseRecordCount -LogicalName "account"

# 9. Delete the record
Remove-PSDataverseRecord -LogicalName "account" -Id $id -Confirm:$false

# 10. Disconnect
Disconnect-PSDataverse
```

---

## Module Documentation

- [Isystem.PowerShell.PowerPlatform.Dataverse Module Docs](docs/Isystem.PowerShell.PowerPlatform.Dataverse.md)

---

## Cmdlet Reference

### Connection Management

| Cmdlet | Description | Output |
|--------|-------------|--------|
| [`Connect-PSDataverse`](docs/Connect-PSDataverse.md) | Connects to a Dataverse environment | - |
| [`Disconnect-PSDataverse`](docs/Disconnect-PSDataverse.md) | Closes the active connection and releases resources | - |
| [`Get-PSDataverseConnection`](docs/Get-PSDataverseConnection.md) | Returns connection status, organization URL, and user ID | `DataverseConnectionInfo` |

### Record Operations (CRUD)

| Cmdlet | Description | Output |
|--------|-------------|--------|
| [`New-PSDataverseRecord`](docs/New-PSDataverseRecord.md) | Creates a new record | `Guid` (record ID) |
| [`Get-PSDataverseRecord`](docs/Get-PSDataverseRecord.md) | Retrieves a record by ID (supports `-Columns` filter) | `Entity` |
| [`Set-PSDataverseRecord`](docs/Set-PSDataverseRecord.md) | Updates an existing record | - |
| [`Remove-PSDataverseRecord`](docs/Remove-PSDataverseRecord.md) | Deletes a record (`-WhatIf` / `-Confirm` supported) | - |
| [`Test-PSDataverseRecord`](docs/Test-PSDataverseRecord.md) | Tests if a record exists | `bool` |

### Query & Search

| Cmdlet | Description | Output |
|--------|-------------|--------|
| [`Find-PSDataverseRecord`](docs/Find-PSDataverseRecord.md) | Searches records with `-Filter`, `-LikeFilter`, `-OrderBy`, `-Top`, `-All` | `Entity[]` |
| [`Get-PSDataverseRecordCount`](docs/Get-PSDataverseRecordCount.md) | Counts records in a table (with optional `-Filter`) | `int` |
| [`Invoke-PSDataverseFetchXml`](docs/Invoke-PSDataverseFetchXml.md) | Runs a FetchXML query (supports `-All` for paging) | `Entity[]` |

### Bulk Operations

| Cmdlet | Description | Output |
|--------|-------------|--------|
| [`Invoke-PSDataverseBatch`](docs/Invoke-PSDataverseBatch.md) | Runs up to 1 000 create/update/delete operations in parallel | `DataverseBatchResult` |
| [`Invoke-PSDataverseTransaction`](docs/Invoke-PSDataverseTransaction.md) | Runs operations in a single atomic transaction (all-or-nothing) | `int` (count) |

---

## Advanced Usage

### Pipeline Support

Cmdlets accept `Entity` objects from the pipeline via `InputObject`:

```powershell
# Update a record from pipeline
Get-PSDataverseRecord -LogicalName "account" -Id $id |
    Set-PSDataverseRecord -Attributes @{ name = "Updated Name" }

# Delete a record from pipeline
Get-PSDataverseRecord -LogicalName "account" -Id $id |
    Remove-PSDataverseRecord -Confirm:$false

# Test existence from pipeline
Get-PSDataverseRecord -LogicalName "account" -Id $id |
    Test-PSDataverseRecord
```

### Paging (All Records)

Use `-All` to automatically retrieve all records across pages (5 000 records per page). Supports Ctrl+C for cancellation:

```powershell
# Get all accounts
$allAccounts = Find-PSDataverseRecord -LogicalName "account" -All

# Get all accounts with specific columns only
$allAccounts = Find-PSDataverseRecord -LogicalName "account" -All -Columns @("name", "emailaddress1")
```

### Batch Operations

Execute up to 1 000 mixed create/update/delete operations in a single server round-trip:

```powershell
$ops = @(
    @{ Action = "create"; LogicalName = "account"; Attributes = @{ name = "Batch Co. 1" } }
    @{ Action = "create"; LogicalName = "account"; Attributes = @{ name = "Batch Co. 2" } }
    @{ Action = "update"; LogicalName = "account"; Id = $existingId; Attributes = @{ telephone1 = "555-0100" } }
    @{ Action = "delete"; LogicalName = "account"; Id = $deleteId }
)

$result = Invoke-PSDataverseBatch -Operations $ops -ContinueOnError
$result.SuccessCount   # Number of successful operations
$result.FailureCount   # Number of failed operations
$result.Items          # One entry per operation: Index, Action, LogicalName, Id, Succeeded, RecordCreated, ErrorCode, Message
$result.Items | Where-Object { -not $_.Succeeded }
```

### Upsert by Alternate Key (idempotent sync)

The building block of a re-runnable import: address rows by a business key, create them when missing, update them otherwise, and bind lookups by the target's alternate key - no GUID bookkeeping, no pre-read of the whole table.

```powershell
# One row
Set-PSDataverseRecord -LogicalName it3c_aaduser -Key @{ it3c_objectid = $user.ObjectId } -Upsert -Attributes @{
    it3c_name              = $user.DisplayName
    it3c_userprincipalname = $user.UserPrincipalName
    it3c_company           = @{ LogicalName = 'it3c_company'; Key = @{ it3c_name = $user.Company } }   # lookup by alternate key
}
# -> DataverseUpsertResult: LogicalName, Id, RecordCreated

# Many rows, one round-trip per 900 operations
$ops = foreach ($u in $users) {
    @{ Action = 'Upsert'; LogicalName = 'it3c_aaduser'; Key = @{ it3c_objectid = $u.ObjectId }; Attributes = @{ it3c_name = $u.DisplayName } }
}
$result = Invoke-PSDataverseBatch -Operations $ops -ContinueOnError
$result.Items | Where-Object { -not $_.Succeeded } | Format-Table Index, LogicalName, ErrorCode, Message
```

`-Key` also works on `Get-`, `Remove-` and `Test-PSDataverseRecord`. Alternate keys must be defined on the table (Maker portal → Keys).

### Transactions

Execute operations atomically. All succeed or all roll back:

```powershell
$ops = @(
    @{ Action = "create"; LogicalName = "account"; Attributes = @{ name = "Transaction Co." } }
    @{ Action = "update"; LogicalName = "contact"; Id = $contactId; Attributes = @{ lastname = "Updated" } }
)

$result = Invoke-PSDataverseTransaction -Operations $ops
$result.Items[0].Id    # id of the created account; throws on any failure (full rollback)
```

### FetchXML

Run complex queries using FetchXML syntax:

```powershell
$fetchXml = @"
<fetch top="10">
  <entity name="account">
    <attribute name="name" />
    <attribute name="emailaddress1" />
    <filter>
      <condition attribute="statecode" operator="eq" value="0" />
    </filter>
    <order attribute="name" />
  </entity>
</fetch>
"@

$results = Invoke-PSDataverseFetchXml -FetchXml $fetchXml

# Retrieve ALL matching records with automatic paging
$allResults = Invoke-PSDataverseFetchXml -FetchXml $fetchXml -All
```

### Retry Configuration

Configure retry behavior on the connection:

```powershell
# 5 retries with 10 second pause between each attempt
Connect-PSDataverse -ConnectionString $cs -MaxRetryCount 5 -RetryPauseSeconds 10
```

### Like Filter (Wildcard Search)

```powershell
# Find accounts whose name starts with "Contoso"
Find-PSDataverseRecord -LogicalName "account" -LikeFilter @{ name = "Contoso%" }

# Find accounts whose name contains "Ltd"
Find-PSDataverseRecord -LogicalName "account" -LikeFilter @{ name = "%Ltd%" }
```

### Sorting

```powershell
# Get newest 20 accounts
Find-PSDataverseRecord -LogicalName "account" -Top 20 -OrderBy "createdon" -Descending

# Get accounts sorted by name
Find-PSDataverseRecord -LogicalName "account" -Top 100 -OrderBy "name"
```

### Selecting Specific Columns

```powershell
# Retrieve only specific columns (improves performance)
Get-PSDataverseRecord -LogicalName "account" -Id $id -Columns @("name", "emailaddress1")

# Find with specific columns
Find-PSDataverseRecord -LogicalName "account" -Filter @{ statecode = 0 } -Columns @("name", "telephone1")
```

---

## Common Dataverse Table Names

| Display Name | Logical Name | Primary ID Column |
|---|---|---|
| Account | `account` | `accountid` |
| Contact | `contact` | `contactid` |
| Lead | `lead` | `leadid` |
| Opportunity | `opportunity` | `opportunityid` |
| Case | `incident` | `incidentid` |
| Task | `task` | `activityid` |
| Email | `email` | `activityid` |
| Note | `annotation` | `annotationid` |
| User | `systemuser` | `systemuserid` |

For custom tables, the logical name typically follows the pattern `prefix_tablename` (where `prefix` is the publisher prefix, e.g. `cr_xxx`).

---

## Development

Source, build instructions and contributions live in the Azure DevOps repository (`i-system/PSModules/Isystem.PowerShell.PowerPlatform`, see its `CONTRIBUTING.md`). This README is published alongside the compiled module, so build steps are documented where the source they refer to actually is.

---

## License

[MIT](LICENSE)
