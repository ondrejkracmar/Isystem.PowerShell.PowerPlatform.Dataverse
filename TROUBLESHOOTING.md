# Troubleshooting

Error ids are the first segment of `$_.FullyQualifiedErrorId` (for example
`DataverseNotConnected,Isystem.PowerShell.PowerPlatform.Dataverse.Commands.GetPSDataverseRecordCmdlet`).

| Error id / symptom | Cause | What to do |
|---|---|---|
| `DataverseNotConnected` | No session in this runspace. | Run `Connect-PSDataverse` first. Sessions are per runspace: a `ForEach-Object -Parallel` block or a background job needs its own connection. |
| `DataverseConnectionFailed` | The SDK could not connect (bad URL, wrong secret, app user missing, network). | `Connect-PSDataverse -Verbose`; check the URL is the environment URL from the Power Platform admin center; for app-only auth confirm the application user exists in the environment and has a security role. |
| `DataverseInvalidConnectionParameter` | A parameter needed by the chosen mode is missing (e.g. `-AuthMode ClientSecret` without `-TenantId`), or a value contains `;` / `=`. | Follow the parameter set in `Get-Help Connect-PSDataverse -Full`. |
| `Connect-PSDataverse -Delegated -LoginMode Silent` fails with "no account" / `MsalUiRequiredException` | The token cache is empty, expired, or the refresh token was revoked (Conditional Access, password change). | Re-run the one-time bootstrap: `Connect-PSDataverse -Delegated -LoginMode Interactive` (or `DeviceCode` on a headless host), then persist `Get-PSDataverseTokenCache` again. |
| `DataverseTokenCacheNotAvailable` | `Get-PSDataverseTokenCache` called without a delegated session (ever) in this runspace. | Only `-Delegated` sessions have an exportable cache. |
| "The token cache value is not one produced by Get-PSDataverseTokenCache" | `-TokenCache` was given something else (raw bytes, a truncated secret). | Pass the string exactly as exported; check the secret store did not wrap or trim it. |
| `DataverseInvalidAttributeValue` | A lookup hashtable is malformed (`LogicalName` missing, `Id` not a GUID, `Key` empty) or an alternate key value is `$null`. | Lookups are `@{ LogicalName = ...; Id = <guid> }` or `@{ LogicalName = ...; Key = @{ attr = value } }`. |
| `DataverseRetrieveFailed` / `DataverseUpdateFailed` / `DataverseDeleteFailed` with fault `0x80040217` | The record does not exist. | These are non-terminating: the pipeline continues. Use `-ErrorAction Stop` to abort, or `Test-PSDataverseRecord` first. |
| Upsert by `-Key` fails with "alternate key ... not found" | The key is not defined on the table, or its attribute names are wrong. | Define the alternate key on the table (Maker portal → Keys) and use the attribute logical names, not display names. |
| `DataverseBatchFailed` / `DataverseTransactionFailed` | The whole request was rejected (too many operations, request too large, throttling) - not a per-operation fault. | Keep batches ≤ 1 000 operations (the SDK limit); per-operation faults are in `.Items` of the result, not here. |
| `DataverseFetchXmlNotPageable` | `-All` with an aggregate FetchXML. | Aggregates return one result set; drop `-All`. |
| "The 'top' attribute was removed" warning | `-All` and `top` are mutually exclusive in Dataverse. | Expected; use `-All` for everything or `top` without `-All`. |
| `Get-PSDataverseRecordCount` fails with "attribute ... not found" | The table's primary key is not `{logicalname}id`. | Pass `-PrimaryIdAttribute` (e.g. `activityid`). |
| Import fails: "build output for runtime 'netX' not found" | The installed module lacks the `bin/<tfm>/` folder for your PowerShell (7.5 → net9.0, 7.6+ → net10.0). | Reinstall from the gallery; a hand-copied module must include both `bin/net9.0` and `bin/net10.0`. |
| `FileLoadException` for `Microsoft.Extensions.*` / `Azure.Identity` after importing several modules | Another module loaded an **older** major of a shared assembly into the default load context first. | On PowerShell 7.5, import this module **before** PSSqlRepository / PSDataRepository (its 9.x assemblies satisfy their 8.x references, not the other way round). On 7.6+ all three ship 10.x and the order does not matter. |
| Dataverse for Teams: batch or transaction "not supported" | Teams environments do not support every message (`SetState`, some `ExecuteTransaction` shapes). | Use plain field updates (a custom two-option "active" column instead of state changes) and `Invoke-PSDataverseBatch`; or upgrade the environment. |
| Device-code prompt never appears | `-AuthMode DeviceCode` / `-LoginMode DeviceCode` needs a host that can write to the console. | Run in an interactive `pwsh`, not under a scheduler; for unattended runs use a persisted cache instead. |

## Diagnostics

- `-Verbose` on every cmdlet logs what was sent (table, target, page numbers) without secrets.
- `-Debug` on the query cmdlets prints the generated FetchXML / page cookies.
- `Get-PSDataverseConnection` shows organisation, environment id, identity and authentication type of the current session.
