# Contributing to the Enkinex ODPS Tutorial

Thank you for your interest in contributing to the **Enkinex ODPS Tutorial**, the companion sample project for the
[Enkinex ODPS Library](https://github.com/enkinex/enkinex-odps) — a [KCL](https://www.kcl-lang.io/) implementation of
the [Open Data Product Standard (ODPS)](https://github.com/bitol-io/open-data-product-standard). This guide covers
everything you need to build, validate, and submit changes.

## Prerequisites

- [KCL Language CLI](https://www.kcl-lang.io/docs/user_docs/getting-started/install) `>= 0.12.8`
- [`just` Command Runner](https://github.com/casey/just).

Check both are on your `PATH`:

```bash
kcl --version
just --version
```

## Getting Started

```bash
git clone git@github.com:enkinex/enkinex-odps-tutorial.git
cd enkinex-odps-tutorial
just init      # kcl mod update
just export    # compiles product.k and writes product.yaml
```

Run `just` with no arguments at any point to list every available task.

## Development Workflow

All day-to-day tasks are `just` recipes defined in the [`Justfile`](Justfile):

| Command       | What it does                                                                 |
|---------------|-------------------------------------------------------------------------------|
| `just init`   | Syncs module dependencies (`kcl mod update`).                                 |
| `just fmt`    | Formats every `.k` file in the project (`kcl fmt ./...`).                     |
| `just lint`   | Runs `kcl lint` against the root data product and every project directory.   |
| `just export` | Compiles `product.k` and exports the data product to `product.yaml`.         |

Before pushing, always run:

```bash
just fmt
just lint
just export
```

`just export` must succeed with no errors, and the regenerated `product.yaml` should be committed together with any
`.k` change that affects it.

## Project layout

The tutorial implements the official ODPS **customer data product example** as a modular KCL project on top of the
`enkinex-odps` schema library:

| Path          | Contains                                                                     |
|---------------|-------------------------------------------------------------------------------|
| `product.k`   | The root `DataProduct` instance that assembles every part below.             |
| `metadata/`   | The product description block.                                               |
| `input/`      | The input ports the product consumes.                                        |
| `output/`     | The output ports the product produces, with their SBOM and input contracts.  |
| `management/` | Management ports — access points for operating the product itself.           |
| `support/`    | Support and communication channels.                                          |
| `team/`       | Ownership: the team and its members.                                         |

The data product content deliberately mirrors the upstream
[ODPS customer data product example](https://github.com/bitol-io/open-data-product-standard/blob/main/docs/examples/customer-data-product.odps.yaml),
so changes should track either that example or a new `enkinex-odps` library release — not diverge from both.

## Branch and commit conventions

Commit messages in this repo follow a **Conventional Commits** subset. Use one of these prefixes based on what the
commit actually changes:

- `feat:` — new tutorial content or data product sections
- `fix:` — a correctness fix (typing, constraints, export behavior)
- `docs:` — documentation-only changes
- `refactor:` — restructuring without behavior change
- `chore:` — tooling, dependency, or repo-scaffolding changes

Keep the subject line short and imperative, matching the existing `git log`. Branch names follow `<type>/<short-slug>`,
e.g. `docs/ports-section` or `chore/bump-library`.

## Pull request process

1. Fork the repo (or branch directly if you're a collaborator) and open your PR against `main`.
2. Describe what changed and paste the output of `just export` (or note that `product.yaml` is unchanged).
3. A maintainer will review; address feedback with follow-up commits rather than force-pushes once a review is in
   progress, unless asked otherwise.
4. PRs are squash-merged, so the PR title should itself read as a good commit message.

## Code of conduct and security

- This project follows the
  [Enkinex Code of Conduct](https://github.com/enkinex/enkinex-odps/blob/main/CODE_OF_CONDUCT.md).
- To report a security vulnerability, see the
  [Enkinex security policy](https://github.com/enkinex/enkinex-odps/blob/main/SECURITY.md) — please do not open a
  public issue for security reports.

## Other references

- [`AUTHORS.md`](AUTHORS.md) — contributor list.
- [`CHANGELOG.md`](CHANGELOG.md) — notable changes per release.
- [`history.md`](history.md) — which Enkinex ODPS library version this tutorial tracks.
