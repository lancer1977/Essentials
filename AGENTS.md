# Agent Notes

## Purpose

This repository is the Xamarin.Essentials source tree. It provides cross-platform C#
APIs for mobile and desktop application features such as sensors, storage, app
metadata, connectivity, geolocation, sharing, and launchers.

## Local Validation

Run the stewardship smoke checks before handing off changes:

```bash
./scripts/validate.sh
```

The validator performs deterministic repository checks and restores the unit-test
project. Full solution builds require the legacy Xamarin, UWP, Android, iOS, macOS,
and Tizen toolchains documented in `README.md` and the Azure Pipelines definition.

## Change Boundaries

- Prefer targeted fixes in `Xamarin.Essentials/` and matching coverage in `Tests/`.
- Avoid broad retargeting or SDK upgrades unless the task is explicitly migration
  work.
- Treat device test projects as platform-specific validation assets. They are not
  expected to run on a generic Linux workstation.
