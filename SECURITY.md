# Security

This document describes what the module protects, by which mechanism, and what each mechanism
does **not** protect against. Report vulnerabilities privately to the maintainer (see the
`Author` field of the module manifest) rather than in a public issue.

## Supported versions

Only the latest published version receives fixes. Pre-release versions (`-alpha`, `-preview`)
are for validation and are not supported.

## Credentials

| Surface | Handling |
|---|---|
| `-ConnectionString`, `-ClientSecret`, `-ExternalToken` | `SecureString` parameters; the plaintext exists only for the SDK call that needs it (a known .NET limitation - the decrypted value lives in managed memory until collected). |
| Connection strings built from parameters | Every value goes through `ConnectionStringGuard`, which rejects `;`, `=` and control characters, so a parameter cannot inject additional keys. |
| Delegated token cache (`-Delegated`, `Get-PSDataverseTokenCache`) | The MSAL cache - which contains the refresh token - is held **in memory, unprotected**, and exported as one opaque string. The module deliberately does not persist or protect it: DPAPI/keychain would bind it to one user on one machine, which defeats the purpose (unattended runs on a different host). **The caller owns its protection.** Store it in a secret store (Azure Key Vault, SecretManagement), never in a script, a config file or a log. Treat it exactly like a password: anyone holding it can act as that user against Dataverse until the refresh token expires or is revoked (Conditional Access, sign-out everywhere, password change). |
| AzAuth named caches (`-AuthMode Interactive/DeviceCode/Cache -TokenCacheName`) | Written by MSAL's `MsalCacheHelper`: DPAPI on Windows, keychain on macOS, libsecret/keyring on Linux. Bound to the current user and machine. |
| Verbose / debug output | Never contains secrets: connect messages name the URL, the client id and the login mode only. Error records carry the target record or table name, not credentials. |

## Assembly identity

All assemblies are strong-named with the key in `src/Isystem.PowerShell.PowerPlatform.Dataverse/Isystem.PowerShell.PowerPlatform.snk`
(public key token `9dfdba2f30eafd53`). The **private** key is checked in so any developer can build
locally and the friend-assembly (`InternalsVisibleTo`) relationship with the test project holds.

Consequences, stated plainly:

- Strong-naming gives a stable identity and tamper evidence at load time (a modified signed
  assembly fails validation).
- It is **not** a secret boundary. Anyone with read access to this repository can sign an
  assembly with the same identity.
- For distribution trust the release pipeline supports **Authenticode signing** of every shipped
  file (`.psd1`, `.psm1`, `.ps1xml`, `.dll`) from a certificate held in the `CodeSigning`
  variable group; the code-signing private key never lives in the repository. A production
  strong-name key can likewise be injected at build time with
  `/p:AssemblyOriginatorKeyFile=<secure file>` (see `Directory.Build.props`).

## Dependencies

- The build fails on any NuGet package with a known vulnerability (`NuGetAudit` +
  `dotnet list package --vulnerable --include-transitive` in the pipeline).
- A CycloneDX SBOM is produced for every build and published as a pipeline artifact.
- Third-party code executed by the module: the Microsoft Dataverse SDK
  (`Microsoft.PowerPlatform.Dataverse.Client`), MSAL (`Microsoft.Identity.Client`),
  Azure.Identity through `Isystem.AzAuth.Core`, and the shared `Isystem.Shared.Infrastructure.*`
  libraries. The module runs no extensions or plug-ins.

## Test seam

`DataverseCmdletBase` honours a private runspace variable that lets the test project inject an
`IOrganizationService`. The variable is private to the runspace and its name is only known to the
test project (`InternalsVisibleTo`). It is not a privilege boundary: whoever can run code in your
runspace can already do anything the connected user can. It is documented here so nobody mistakes
it for one.

## What the module does not do

- It does not enforce least privilege in Dataverse - grant the application user or the delegated
  user the narrowest security role that covers the tables the automation touches.
- It does not throttle: Dataverse service-protection limits are honoured by the SDK's retry
  policy (`-MaxRetryCount`, `-RetryPauseSeconds`), not by the module.
- It does not log. Wrap calls in your own logging if an audit trail is required.
