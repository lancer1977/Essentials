# Essentials Maintenance Index

This repository contains the Xamarin.Essentials library, samples, unit tests, and
device test projects.

## Main Areas

- `Xamarin.Essentials/` contains the multi-targeted library source.
- `Tests/` contains xUnit coverage for the shared and netstandard API surface.
- `DeviceTests/` contains platform device test projects for Android, iOS, and UWP.
- `Samples/` contains sample applications and the WebAuthenticator sample server.
- `docs/en/` contains API documentation metadata used by the historical docs build.

## Validation

Use `./scripts/validate.sh` for portable repository validation. Use the documented
Visual Studio/Xamarin environment or Azure pipeline for full platform builds.
