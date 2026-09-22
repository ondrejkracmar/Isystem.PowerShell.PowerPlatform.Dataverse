# Changelog

All notable changes to **Isystem.PowerShell.PowerPlatform.Dataverse** are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). The newest section is
copied into the module manifest's `ReleaseNotes` by the build.

## [Unreleased]

_Nothing yet._

## [1.0.1] - 2026-09-21

### Fixed
- README shipped with 1.0.0 still described a source build and `bin/` import - meaningless on
  the GitHub mirror, which carries no source. It now opens with the mirror notice, installs from
  the PowerShell Gallery, and documents the Isystem.AzAuth and delegated (portable token cache)
  authentication modes and the upsert section that 1.0.0 introduced. No code changes.

## [1.0.0] - 2026-09-21

First public release (PowerShell Gallery). Breaking changes against the internal 0.1.0 are listed under **Changed**.

### Added
- **Upsert and alternate keys.** `Set-PSDataverseRecord -Key @{ ... } -Upsert` creates or updates
  a record addressed by an alternate key and returns a `DataverseUpsertResult` (`Id`,
  `RecordCreated`). `Get-`, `Set-`, `Remove-` and `Test-PSDataverseRecord` all accept `-Key`
  instead of `-Id`. Batch and transaction operations gained `Action = 'Upsert'` and a `Key`
  entry for Update/Upsert/Delete. This is the primitive an idempotent sync is built on.
- **Lookups without SDK types.** Any attribute value written as
  `@{ LogicalName = 'account'; Id = $guid }` or
  `@{ LogicalName = 'it3c_company'; Key = @{ it3c_name = 'Acme' } }` becomes an
  `EntityReference` - the SDK equivalent of an OData `@odata.bind`. `PSObject`-wrapped values
  are unwrapped before they reach the SDK serializer.
- **Delegated sign-in with a portable token cache.** `Connect-PSDataverse -Delegated` signs a
  user in through MSAL with an *in-memory* cache; `Get-PSDataverseTokenCache` exports it as
  one opaque string and `-TokenCache` seeds the next session with it. The refresh token thus
  lives wherever the caller keeps secrets (Azure Key Vault via PSDataRepository, for
  instance), which is what Dataverse for Teams - no application users, no premium licence -
  requires. `-LoginMode Silent` makes unattended runs fail fast instead of prompting;
  `Interactive` / `DeviceCode` cover the one-time bootstrap. The cache survives
  `Disconnect-PSDataverse` so it can be persisted after the work is done.
- **Isystem.AzAuth authentication.** `Connect-PSDataverse -AuthMode` acquires tokens through
  `Isystem.AzAuth.Core` with the same mode names PSDataRepository uses: `ClientSecret`,
  `ClientCertificate` (thumbprint, file or `X509Certificate2`), `ManagedIdentity`,
  `WorkloadIdentity`, `NonInteractive` (Azure.Identity default chain), `Interactive`,
  `DeviceCode` and `Cache` (named on-disk MSAL cache). Device-code prompts are relayed to the
  host from the pipeline thread.
- **Structured batch results.** `DataverseBatchResult.Items` carries one
  `DataverseBatchItemResult` per operation - `Index`, `Action`, `LogicalName`, the record
  `Id` (created, upserted or targeted), `Succeeded`, `RecordCreated`, `ErrorCode` and
  `Message`. Operations that never ran because an earlier one faulted (without
  `-ContinueOnError`) are reported as such instead of vanishing.
- `Get-PSDataverseConnection` reports `OrganizationFriendlyName`, `OrganizationId`,
  `EnvironmentId`, `Identity`, `AuthenticationType` and `HasTokenCache`.
- `Get-PSDataverseRecordCount -PrimaryIdAttribute` for tables whose primary key does not
  follow the `{logicalname}id` convention.
- `net10.0` build next to `net9.0`; the new `.psm1` loader picks `bin/<tfm>/` for the running
  PowerShell (7.5 → net9.0, 7.6+ → net10.0), the same way PSSqlRepository and
  PSDataRepository do, so side-by-side modules share one `Microsoft.Extensions.*` major.
- Assemblies are strong-named (public key token `9dfdba2f30eafd53`); see SECURITY.md for what
  that does and does not protect.
- `build/Update-MamlSyntax.ps1` regenerates the MAML syntax blocks from cmdlet metadata so a
  parameter change cannot drift from the shipped help.
- Release pipeline: GitVersion 6.7, Conventional Commits check on pull requests, NuGet
  vulnerability gate, CycloneDX SBOM artifact, strong-name validation of the staged module,
  optional Authenticode signing, publish to Azure Artifacts, the GitHub mirror and the
  PowerShell Gallery from `v*` tags.

### Changed
- **BREAKING - per-record cmdlets raise non-terminating errors.** `Get-`, `New-`, `Set-`,
  `Remove-` and `Test-PSDataverseRecord` now `WriteError` instead of terminating the pipeline,
  so `$ids | Get-PSDataverseRecord` reports one missing record and continues; use
  `-ErrorAction Stop` for the old behaviour. Connection, query, batch and transaction failures
  stay terminating.
- **BREAKING - `Invoke-PSDataverseTransaction` returns a `DataverseBatchResult`** (was the
  operation count) so callers get the ids of created records.
- `Invoke-PSDataverseFetchXml -All` strips a `top` attribute with a warning and refuses
  aggregate queries with a clear error instead of letting Dataverse fail the request.
- `Connect-PSDataverse` reports invalid parameter combinations as `InvalidArgument`
  (`DataverseInvalidConnectionParameter`) rather than as a connection failure.
- The module package no longer carries PowerShell host runtime bits and MSAL satellite
  resources (32 MB → 13 MB per target).

### Fixed
- `tests/general/strings.Tests.ps1` had executed zero tests since February 2026: the assembly
  path was wrong for a `bin/`-based root module and the `::ResourceManager` access on an
  internal type yielded `$null`. `tests/pester.ps1` now counts container-level discovery
  failures, so a broken test file can no longer pass CI silently.
- `tests/general/FileIntegrity.Tests.ps1` had a syntax error and never ran.
- `global.json` pinned `10.0.100` with `latestPatch`, which refused every other 10.0.x SDK.
- The committed `TestResults/` folder is gone and ignored.

## [0.1.0] - 2026-03-05

### Added
- Initial internal release: session-based connection (connection string, client secret,
  certificate, managed identity), CRUD cmdlets, `Find-PSDataverseRecord` with paging,
  `Invoke-PSDataverseBatch`, `Invoke-PSDataverseTransaction`, `Invoke-PSDataverseFetchXml`,
  `Get-PSDataverseRecordCount`, MAML help, xUnit and Pester suites.
