# Project & Module

This page scaffolds the KCL module that will hold the ported `customer-data-product` example.

## The source being ported

We're adapting [`customer-data-product.odps.yaml`](https://github.com/bitol-io/open-data-product-standard/blob/main/docs/examples/customer-data-product.odps.yaml)
from the upstream ODPS repository. Two deliberate differences from that source, kept consistent with how this
library itself is documented (see [`docs/schemas/odps.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/odps.md)):

1. **`apiVersion` is left to its schema default.** The upstream document pins `apiVersion: v0.9.0`. This port's
   `DataProduct` schema (see [`odps.k`](https://github.com/enkinex/enkinex-odps/blob/main/odps.k)) defaults `apiVersion` to `"v1.0.0"`, which is the shape this
   library actually models (see the [version disclaimer in the README](https://github.com/enkinex/enkinex-odps#project-summary)). We let
   the default apply instead of writing `apiVersion` explicitly, the same way `kind` is never written explicitly
   since it's pinned to `"DataProduct"`.
2. **Custom property names are normalized to camelCase.** The upstream example writes `transactions_version`;
   `CustomProperty.property`'s docstring calls for camelCase ("the same as if they were permanent properties in the
   contract"), so this port writes `transactionsVersion` instead.

Everything else (every ID, URL, port, and team member) is ported as-is.

## Initializing the module

Two commands scaffold a new KCL module and pull in the Enkinex ODPS library as a dependency:

```bash
kcl mod init customer-data-product --version 1.0.0-draft
cd customer-data-product
kcl mod add --git https://github.com/enkinex/enkinex-odps --branch main
```

`kcl mod init` creates `kcl.mod`, `kcl.mod.lock`, and a placeholder `main.k`. This tutorial uses `odps.k` as the
root file instead, so delete the placeholder:

```bash
rm main.k
```

`kcl mod add --git` clones the library and records it as a dependency:

```toml
[package]
name = "customer-data-product"
edition = "v0.12.3"
version = "1.0.0-draft"

[dependencies]
enkinex-odps = { git = "https://github.com/enkinex/enkinex-odps", branch = "main", version = "1.0.0-draft" }
```


Every schema you'll use is reachable through the `enkinex_odps` package (note the underscore: KCL module names
replace hyphens with underscores on import):

```kcl
import enkinex_odps.odps
import enkinex_odps.common
import enkinex_odps.management
import enkinex_odps.support
import enkinex_odps.team
import enkinex_odps.product.input
import enkinex_odps.product.output
```

## Project structure

The recommended layout organizes local files by which part of the standard they populate, mirroring the library's
own module grouping (`common`, `management`, `support`, `team`, `product.input`, `product.output`; see the
[module table in the README](https://github.com/enkinex/enkinex-odps#how-the-odps-standard-was-mapped-to-kcl-schemas)):

```
customer-data-product/
├── kcl.mod / kcl.mod.lock
├── odps.k              # root composition file
├── product.yaml         # generated output (built in the last page)
├── metadata/
│   └── description.k    # the Description block
├── input/
│   └── port.k            # InputPort values
├── output/
│   └── port.k             # OutputPort values (Sbom, InputContract)
├── management/
│   └── port.k              # ManagementPort values
├── support/
│   └── channels.k            # Support values
└── team/
    ├── member.k                # TeamMember values
    └── team.k                   # the Team composition
```

Files are composed bottom-up: leaf modules (`input/`, `output/`, `management/`, `support/`, `team/`, `metadata/`)
declare named, typed values; the root `odps.k` file imports each of those packages and assembles them into a single
`DataProduct`. The next five pages build one leaf package at a time, then the final page composes and exports the
whole thing.

Create the leaf directories now, from inside `customer-data-product/`, so each following page only has to add
files to an already-scaffolded tree:

```bash
mkdir -p metadata input output management support team
```