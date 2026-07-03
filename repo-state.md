# Repo State

## Current Status

- Purpose: Xamarin.Essentials cross-platform API library.
- Primary validation: `./scripts/validate.sh`.
- Full build path: legacy Visual Studio/Xamarin environment or `azure-pipelines.yml`.
- Local platform limitation: generic Linux machines are not expected to build or run
  the full mobile/UWP/device-test matrix.

## Stewardship Checks

The local validator verifies required files, important project layout, XML metadata,
Azure/GitHub CI definitions, and a best-effort restore for `Tests/Tests.csproj`.
