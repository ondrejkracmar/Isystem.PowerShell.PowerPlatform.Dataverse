# Isystem.PowerShell.PowerPlatform.Dataverse module loader
# Selects the binary matching the running .NET runtime, the same way PSSqlRepository and
# PSDataRepository do, so that side-by-side modules share one Microsoft.Extensions.* major
# and do not collide in the default AssemblyLoadContext.
# PowerShell 7.5 runs on .NET 9, PowerShell 7.6+ runs on .NET 10.

$moduleName = 'Isystem.PowerShell.PowerPlatform.Dataverse'
$dotnetMajor = [System.Environment]::Version.Major
$framework = if ($dotnetMajor -ge 10) { 'net10.0' } else { 'net9.0' }

$binRoot = [System.IO.Path]::Combine($PSScriptRoot, 'bin', $framework)
if (-not (Test-Path -LiteralPath $binRoot)) {
    throw "${moduleName}: build output for runtime '$framework' not found at '$binRoot'. " +
          "Detected .NET $($dotnetMajor).x; supported targets are net9.0 (PowerShell 7.5) " +
          "and net10.0 (PowerShell 7.6+). The module installation may be corrupted."
}

$binaryPath = [System.IO.Path]::Combine($binRoot, "$moduleName.dll")
if (-not (Test-Path -LiteralPath $binaryPath)) {
    throw "${moduleName}: could not find $moduleName.dll at '$binaryPath'. " +
          "The module installation may be corrupted."
}

Import-Module -Name $binaryPath

# Preload the Dataverse SDK so [Microsoft.Xrm.Sdk.EntityReference] and friends resolve at
# the prompt before any cmdlet has touched them. Import-Module only forces the cmdlet
# assembly; transitive references stay lazy and are invisible to the type resolver.
foreach ($asm in @('Microsoft.Xrm.Sdk.dll', 'Microsoft.Crm.Sdk.Proxy.dll')) {
    $asmPath = [System.IO.Path]::Combine($binRoot, $asm)
    if (Test-Path -LiteralPath $asmPath) {
        try { [void][System.Reflection.Assembly]::LoadFrom($asmPath) }
        catch { Write-Warning "${moduleName}: failed to preload '$asm': $($_.Exception.Message). Reinstall the module to repair." }
    }
}

# NOTE: do NOT call Export-ModuleMember here - it would replace the default export set and
# hide the nested binary module's cmdlets. Exports are controlled by the manifest.
