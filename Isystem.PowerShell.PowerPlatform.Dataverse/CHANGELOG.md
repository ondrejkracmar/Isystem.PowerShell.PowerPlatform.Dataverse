# Changelog

All notable changes to **Isystem.PowerShell.PowerPlatform.Dataverse** are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). The newest section is
copied into the module manifest's `ReleaseNotes` by the build.

## [Unreleased]

## [1.4.1] - 2026-10-01

### Fixed

- A `$batch` that succeeded was reported as failing for every operation. Response parts were
  matched back to requests by `Content-ID`, which is only meaningful inside a changeset: requests
  sent independently - what `-ContinueOnError` asks for - come back without one, so no part matched
  any request and a wholly successful batch of 900 upserts was reported as 900 failures. Parts are
  now matched by position, which is the order the protocol guarantees, with `Content-ID` used to
  correct the mapping only where the service sends one. Found on the first live run; the unit tests
  had only ever exercised the changeset shape.

## [1.4.0] - 2026-10-01

### Added

- `Invoke-PSDataverseBatch -UseWebApi` sends the batch through the OData `$batch` endpoint instead
  of `ExecuteMultipleRequest`. Dataverse for Teams does not support the ExecuteMultiple message at
  all - it answers that the message is not supported for that offering - so until now a batch was
  simply impossible there and callers had to fall back to one request per row. Service protection
  allows roughly 6000 requests per five minutes, which makes a 330,000 row load four to five hours
  one row at a time and minutes at 1000 rows per call.
- Without the switch the cmdlet tries ExecuteMultiple first and moves to the Web API by itself when
  the environment refuses the message, remembering it for the session. An environment does not grow
  an ExecuteMultiple halfway through, so re-learning it on every batch would cost one wasted round
  trip per batch.
- `ContinueOnError` maps onto the protocol rather than being emulated: a changeset is atomic, so the
  requests go inside one changeset when the caller wants all-or-nothing, and straight into the batch
  when the caller wants the rest to proceed after a failure.
- The Web API path returns the same `DataverseBatchResult` as ExecuteMultiple, down to the fault code
  and the created/updated distinction on an upsert, so a caller cannot tell which transport ran. A
  request whose part is missing from the response - a rolled-back changeset, a batch refused as a
  whole - is reported as failed rather than counted as a success.

## [1.3.0] - 2026-09-30

### Added

- **`New-PSDataverseTable`, `New-PSDataverseColumn`, `New-PSDataverseKey` and
  `New-PSDataverseLookup`.** The module could read metadata and not write it, so every table a
  script wanted to fill had to be built by hand in the maker portal first - for a mirrored model
  that is a table, an alternate key, a soft-delete flag and a column per property, times eight
  entities, with every typo surfacing later as a rejected row.
- **`-Wait` on `New-PSDataverseKey`.** An alternate key's unique index is built asynchronously, so
  the request returning does not mean the key works; until the index reports Active an upsert
  through it fails with a message that never mentions the index. `-Wait` polls until it is Active,
  backing off as it goes, and says so plainly when the index fails - a duplicate in the existing
  rows being the usual reason.
- **`-SolutionUniqueName` on all four.** Without it Dataverse puts the new component in the
  Default solution, where it works but cannot be exported cleanly - discovered much later, when
  someone tries to move the tables to another environment and finds there is nothing to move.
- `New-PSDataverseLookup` names the relationship explicitly. A lookup is a one-to-many
  relationship and the column appears as a side effect; the relationship's schema name is what the
  Web API navigation property and `@odata.bind` are built from, which is the detail that trips
  people up when they hand-write OData.

### Fixed

- **The help for `Get-PSDataverseTable -IncludeSystem` said something untrue.** It claimed that
  without the switch "only custom tables are listed", but the filter is `IsCustomEntity`, which
  means "did not come with the base platform" rather than "you made it". Every table installed by
  any solution passes - Microsoft's first-party ones included (`msdyn_`, `mspp_`, `adx_`) - so on
  a tenant with apps installed hundreds of unrelated tables come back. The help now says so and
  points at filtering by publisher prefix.
- `New-PSDataverseColumn` takes `-MaxLength` and `-Precision` as plain integers rather than
  nullables, which surfaced in help as `Nullable\`1`. Whether one was supplied is read from
  `BoundParameters`, so a legitimate `-Precision 0` stays distinguishable from not passing it.

## [1.2.1] - 2026-09-29

Documentation only - the module binaries are byte-for-byte those of 1.2.0. The release
exists because SECURITY.md ships to the GitHub mirror, so leaving it untagged would have
left the mirror describing a signing arrangement the repository had already corrected.

### Fixed

- `GitVersion.yml` covers `release/*`. The comment above the branch regexes says they must
  between them match every branch name that can open a pull request, because an unmatched
  branch makes GitVersion emit `Infinity` and the pipeline's `ConvertFrom-Json` rejects it.
  The obvious name for a release branch was the one they missed; earlier releases used
  `chore/release-x.y.z`, which matches the hotfix regex, so the gap stayed hidden.

### Changed

- `SECURITY.md` says which key the published packages are actually signed with: the
  checked-in development key, as with every other Isystem module, until signing that
  carries trust moves to a central Azure service. The `-KeyFile` hook stays for that day.
  Nobody should read a strong name here as evidence of origin.

## [1.2.0] - 2026-09-29

### Fixed

- **A connection opened inside a function is no longer lost when that function returns.** The
  session was written to the CALLER's scope and marked `Private`, so `Connect-PSDataverse` wrapped
  in a function - the normal way automation is written - left its connection behind the moment the
  function returned, and every later cmdlet got a fresh, disconnected session. Anything built on
  the module this way silently wrote nothing. The session now lives in the runspace's global
  scope and is visible from every nested scope, and two regression tests call a cmdlet from
  inside a function so the suite would notice if it came back.

### Added

- **`ConvertTo-PSDataverseObject`** and **`-AsObject` / `-IncludeFormattedValues`** on
  `Get-PSDataverseRecord`, `Find-PSDataverseRecord` and `Invoke-PSDataverseFetchXml`. A Dataverse
  row is a sparse bag of typed SDK objects, which is faithful to the service and unusable with
  `Format-Table`, `Export-Csv` or `$row.column`; these flatten it - lookup to its id, choice to its
  number, money to its decimal, aliased value to the value inside it.
- **Write-side counterparts for the flattened types**, so a row can be read, edited and written
  back: `@{ OptionSet = 1 }`, `@{ OptionSet = @(1, 2) }` and `@{ Money = 12.50 }` alongside the
  existing lookup forms. Choice and currency columns previously could not be written at all - the
  reader unwrapped them and nothing wrapped them again.
- **Whole numbers are narrowed to what a Dataverse column takes.** `ConvertFrom-Json`, and a
  PowerShell integer literal, produce `Int64`; a whole-number column is `Int32`, and the SDK
  rejected the wider type on serialization. A value that genuinely does not fit now says so and
  names the column.
- **A nested object or a list is refused with the column named**, instead of failing later inside
  the SDK with a message that mentions neither.

### Changed

- **The three filters behave the same way.** `Find-PSDataverseRecord -Filter` converted its values
  one way, `-LikeFilter` another and `Get-PSDataverseRecordCount -Filter` a third; a condition now
  always compares against the stored scalar, which is the shape a flattened row hands back.
- The retained delegated token cache is zeroed on dispose. `Close` keeps it on purpose so a script
  can export it after `Disconnect-PSDataverse`; disposal is where that retention has to end,
  because the blob holds a refresh token in clear.
- Seven user-facing messages moved from string literals into `Strings.resx`, as `CONTRIBUTING.md`
  requires - including the two seen most often, "Not connected to Dataverse" and
  "Failed to connect to Dataverse".
- `DataverseLoginMode.Auto` documents itself as an alias for `Interactive` rather than repeating
  that mode's description word for word.
- Both token providers state that the session is bound to the URL given at connect time, instead
  of silently ignoring the `instanceUri` the callback passes.

### Removed

- `build/vsts-syncRepository.ps1`: nothing called it, and it could not have run on the Linux
  agent (`System.Web.HttpUtility` without `Add-Type`, PSFramework without an import).
- `Strings.TransactionResultVerbose`: unused, and a duplicate of `TransactionCommittedVerbose`.

## [1.1.0] - 2026-09-24

### Added

- **Metadata cmdlets**: `Get-PSDataverseTable`, `Get-PSDataverseColumn` and `Get-PSDataverseKey`.
  They answer the question behind the SDK's most common error - *the entity with a name = X was not
  found in the MetadataCache* - by showing the logical names that exist in the environment you are
  connected to, which columns are writable (calculated, rollup and system columns read fine and are
  rejected on write), and whether an alternate key's index is `Active`, without which an upsert by
  key fails with a message that never mentions the index. An exact table name costs one metadata
  request; a wildcard reads the catalogue, because the metadata service has no server-side name
  filter. System tables are excluded unless `-IncludeSystem` is given.
- `Get-PSDataverseTable` output pipes into the query cmdlets:
  `Get-PSDataverseTable it3c_* | Find-PSDataverseRecord -Top 5` and
  `... | Get-PSDataverseRecordCount` now work, the latter taking the real primary key column from
  the metadata rather than assuming the `{table}id` convention.

### Changed

- `Find-PSDataverseRecord -LogicalName` and `Get-PSDataverseRecordCount -LogicalName` /
  `-PrimaryIdAttribute` bind from the pipeline by property name, which is what makes the two
  pipelines above work.
- The pipeline no longer runs on pushes to `main`: the required build-validation policy already
  validates the same content on the pull-request merge ref, so a merge - and a release tag on the
  same commit - used to queue two or three identical runs. Triggers are now the pull request and the
  `v*` tag only.

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
