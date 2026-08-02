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

## Global DevOps GitHub–Kanban Contract

For DevOps, infrastructure, deployment, security, GitOps, and service work:

1. GitHub is authoritative for Issues, PRs, CI, reviews, merges, releases, and delivery state, and is the execution queue.
2. One GitHub Issue should normally produce one PR directly to `main`.
3. Before branch work or a PR, fetch `origin/main` and reconcile against the current remote default branch. Do not build branch-on-branch PR stacks unless an explicit integration owner and final target are stated.
4. Do not merge, deploy, close issues, rotate secrets, or claim production success unless the task explicitly authorizes it and verification evidence exists.
5. If branches diverge, stop merging the stack. Create one integration branch from current `origin/main`, resolve semantic conflicts deliberately, run tests, and open one replacement PR to `main`.
6. For security or infrastructure work, provide exact build, test, and diff evidence and require fresh independent review before merge. Never put secrets in code, logs, PRs, or comments.
7. A task is not complete because a local test passes or a Kanban card says done. Completion requires the requested GitHub state and, when applicable, verified live behavior.
8. When creating a PR, state its target branch, linked issue, validation output, and whether it supersedes prior PRs. Do not leave divergent worker PRs ambiguous.

<!-- dev-forge:low-interruption:start version=1 -->
## Low-Interruption Execution

- Treat explicit outcome requests such as "fix," "build," "complete," and
  "finish" as continuing authorization for bounded work toward that outcome.
- Continue through diagnosis, implementation, tests, commits, pushes, review
  feedback, and CI repair without renewed confirmation.
- New defects discovered within the same task or pull request remain in scope
  when the repair is reversible, clearly supported, and consistent with the
  existing architecture.
- Progress updates are informational and do not pause execution.
- Do not request confirmation when the only realistic alternatives are the
  clearly supported action and inaction.
- Use a blocking checkpoint only at a genuine impasse. Present two or three
  materially different choices as **A**, **B**, and optionally **C**; recommend
  one and ask for a one-letter reply.
- Do not use "Done — continue" as a generic permission gate.
- Preserve explicit approval boundaries for merge, deploy, destructive work,
  secret or access changes, material cost, external communication, and credible
  downtime or data-loss risk.
<!-- dev-forge:low-interruption:end -->
