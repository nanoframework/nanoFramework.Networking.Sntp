# Copilot Instructions for nanoFramework.Networking.Sntp

## Repository Overview

This repository contains the **nanoFramework.Networking.Sntp** class library — a thin managed (C#) wrapper around the native SNTP client built into .NET nanoFramework firmware. It targets embedded microcontrollers running nanoFramework, not desktop/server .NET.

The library exposes `nanoFramework.Networking.Sntp` (namespace `nanoFramework.Networking`, class `Sntp`) which provides `Start()`, `Stop()`, `UpdateNow()`, `IsStarted`, `Server1`, and `Server2`. All members use `[MethodImpl(MethodImplOptions.InternalCall)]` — the actual logic lives in the C++ firmware (not in this repo). Changes here only affect the managed API surface and XML documentation.

## Key Concepts for nanoFramework Libraries

- **Project file extension is `.nfproj`**, not `.csproj`. The nanoFramework MSBuild system drives compilation.
- **`[MethodImpl(MethodImplOptions.InternalCall)]`** marks methods and property accessors that are implemented natively in the firmware. Do not add managed implementations to them.
- **`AssemblyNativeVersion`** in `Properties/AssemblyInfo.cs` (currently `"100.0.4.4"`) must be updated whenever the native assembly signature changes. This is a checksum used to verify firmware/library version compatibility.
- **PE files** (`.pe`) are the nanoFramework equivalent of .NET DLLs and are included in the NuGet package alongside `.dll`, `.pdb`, and `.pdbx` files.
- The target framework version in the project is `v1.0` (nanoFramework-specific, not .NET Standard).
- There are **no unit test projects** in this repository. The library is verified by firmware integration tests.

## Repository Structure

```
/
├── nanoFramework.Networking.Sntp/        # Main (and only) project
│   ├── Sntp.cs                           # Only source file — the public API
│   ├── Properties/AssemblyInfo.cs        # Assembly metadata + AssemblyNativeVersion
│   ├── packages.config                   # NuGet packages (CoreLibrary, GitVersioning)
│   ├── packages.lock.json                # Lock file — must be kept in sync
│   ├── nanoFramework.Networking.Sntp.nfproj
│   └── key.snk                          # Assembly signing key (do not modify)
├── nanoFramework.Networking.Sntp.sln
├── nanoFramework.Networking.Sntp.nuspec  # NuGet package definition
├── version.json                          # Nerdbank.GitVersioning config (current: 1.6.x)
├── NuGet.Config                          # Points to nuget.org only
├── azure-pipelines.yml                   # Main CI (Azure DevOps, windows-latest)
├── .github/workflows/
│   ├── pr-checks.yml                     # PR checks: package-lock + NuGet version freshness
│   ├── update-dependencies.yml           # Auto-updates NuGet deps (Mon/Thu)
│   ├── update-dependencies-develop.yml
│   ├── generate-changelog.yml
│   ├── dependency-submission.yml
│   └── keep-repo-active.yml
├── .editorconfig                         # Code style rules (see below)
├── CHANGELOG.md
└── spelling_exclusion.dic
```

## Coding Conventions

All conventions come from `.editorconfig`:

- **Line endings**: CRLF for all files except `.sh` (LF).
- **Encoding**: UTF-8 with BOM (`charset = utf-8-bom`).
- **Indentation**: 4 spaces for C#; 2 spaces for XML, YAML, `.nuspec`, `.props`, `.targets`, `.config`.
- **C# file header** (every `.cs` file must start with):
  ```csharp
  //
  // Copyright (c) .NET Foundation and Contributors
  // See LICENSE file in the project root for full license information.
  //
  ```
- **Naming**:
  - `public`/`protected` types and members: PascalCase.
  - Private/internal fields: `_camelCase`.
  - Static private/internal fields: `s_camelCase`.
  - Constants: PascalCase.
- **Braces**: Always on a new line (`csharp_new_line_before_open_brace = all`).
- **`this.` qualifier**: Avoid unless necessary.
- **`var`**: Avoid for built-in types; use explicit types.
- **`using` directives**: Outside namespace declaration.
- **XML documentation** is required on all public members (the project produces `nanoFramework.Networking.Sntp.xml`).

## Build and CI

- **Build system**: Azure Pipelines (`azure-pipelines.yml`), using shared templates from [`nanoframework/nf-tools`](https://github.com/nanoframework/nf-tools). The template `class-lib-build.yml` handles compile, NuGet pack, signing, and publish.
- **Build agent**: `windows-latest` (required by the nanoFramework MSBuild toolchain).
- **Triggers**: `main`, `develop`, `release-*` branches; PRs always trigger.
- **GitHub Actions PR checks** (`pr-checks.yml`): verify `packages.lock.json` is up to date and that NuGet packages are at their latest versions.
- **Dependency auto-updates**: Scheduled Monday and Thursday via `update-dependencies.yml` (repository dispatch: `update-dependencies`).
- **Versioning**: [Nerdbank.GitVersioning](https://github.com/dotnet/Nerdbank.GitVersioning) driven by `version.json`. Version is `1.6.x`. Release branches are named `release-v{version}`.

## NuGet Package

- Package ID: `nanoFramework.Networking.Sntp`
- Defined in `nanoFramework.Networking.Sntp.nuspec`.
- Depends on `nanoFramework.CoreLibrary` (currently `1.17.11`).
- Includes `.dll`, `.pdb`, `.pdbx`, `.pe`, `.xml` artifacts from `bin/Release/`.
- Version is injected automatically by Nerdbank.GitVersioning (`$version$` placeholder).

## Making Changes

### Adding or modifying public API
1. Edit `nanoFramework.Networking.Sntp/Sntp.cs`.
2. All method/property bodies must use `[MethodImpl(MethodImplOptions.InternalCall)]` with `extern` — no managed logic.
3. Add or update XML `<summary>` and `<remarks>` documentation on every member.
4. If the native firmware signature changes, increment `AssemblyNativeVersion` in `Properties/AssemblyInfo.cs`.

### Updating NuGet dependencies
- Update `packages.config` and regenerate `packages.lock.json`.
- The lock file is checked in CI; an out-of-date lock file causes a PR check failure.

### Changelog
- `CHANGELOG.md` is auto-generated by the `generate-changelog.yml` workflow; do not edit manually.

## Common Errors and Workarounds

- **Build fails locally**: The nanoFramework MSBuild toolchain (NFProjectSystem) is only reliably available on Windows with the nanoFramework VS extension installed. Use the Azure Pipelines CI for authoritative builds.
- **`packages.lock.json` out of date**: Run `nuget restore` (or let the auto-update workflow handle it) and commit the updated lock file.
- **NuGet restore fails**: Ensure `NuGet.Config` points to `https://api.nuget.org/v3/index.json`. The nanoFramework packages are published to nuget.org.
- **AssemblyNativeVersion mismatch at runtime**: The managed library version must match the native firmware. If deploying to a device fails with a version mismatch error, update `AssemblyNativeVersion` in `Properties/AssemblyInfo.cs` to match the firmware's native version.
