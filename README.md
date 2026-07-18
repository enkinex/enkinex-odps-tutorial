# Enkinex ODPS Tutorial

A hands-on port of the canonical [Open Data Product Standard](https://github.com/bitol-io/open-data-product-standard)
[`customer-data-product.odps.yaml`](https://github.com/bitol-io/open-data-product-standard/blob/main/docs/examples/customer-data-product.odps.yaml)
example into an equivalent, modular [KCL](https://www.kcl-lang.io/) project, using the Enkinex ODPS library.

Each page adds one more piece of the data product, building toward the finished project checked into this repo at
[`example/customer-data-product/`](example/customer-data-product). By the end you'll have a typed, modular
KCL project that renders to (and validates) the same ODPS document the upstream YAML describes.

## Pages

1. [Introduction](01-introduction.md)
2. [Installing KCL](02-installing-kcl.md)
3. [Project & Module](03-project-module.md)
4. [Product Metadata](04-product-metadata.md)
5. [Team](05-team.md)
6. [Input & Output Ports](06-ports.md)
7. [Management Ports & Support](07-management-and-support.md)
8. [Validating & Exporting](08-validating-and-exporting.md)

## Prerequisites

- The [KCL CLI](https://www.kcl-lang.io/) installed (`kcl --version` should print `0.12.4` or newer — see
  [Installing KCL](02-installing-kcl.md)).
- No prior KCL experience is assumed, but basic familiarity with YAML and the shape of an ODPS document helps.

For the finished, single-page reference document this tutorial builds toward, see the upstream
[`customer-data-product.odps.yaml`](https://github.com/bitol-io/open-data-product-standard/blob/main/docs/examples/customer-data-product.odps.yaml).
For the library's full schema reference, see [`docs/library/odps.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/library/odps.md) and the per-module design
notes under [`docs/schemas/`](https://github.com/enkinex/enkinex-odps/tree/main/docs/schemas).
