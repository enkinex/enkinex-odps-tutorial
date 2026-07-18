# Introduction

Data products traditionally start life as a single YAML file. That works fine for one product, owned by one team.
It stops working once an organization has dozens of data products, each with its own input ports, output ports,
management endpoints, and ownership records: the same support-channel block or custom property gets copied, with
minor changes, into many files. Nothing catches a typo in a port's `contractId` or a malformed URL until a consumer
trips over it at runtime, because plain YAML has no modularity, no type system, and no build-time validation.

**Enkinex ODPS** is a modular [KCL](https://www.kcl-lang.io/) implementation of the
[Open Data Product Standard (ODPS) v1.0.0](https://github.com/bitol-io/open-data-product-standard). It treats a
data product the way software treats a project: schemas and imports instead of copy-paste YAML blocks, a static
type system that rejects an invalid document at compile time instead of in production, and one library that both
validates existing ODPS YAML and lets you author new data products directly in typed KCL.

This tutorial is a hands-on port of the canonical ODPS full example,
[`customer-data-product.odps.yaml`](https://github.com/bitol-io/open-data-product-standard/blob/main/docs/examples/customer-data-product.odps.yaml),
into an equivalent, modular KCL project. The source document describes a `Customer Data Product` owned by a
`Data Team` at `RetailCorp`: it has input ports for payments and online transactions, output ports for raw and
consolidated transactions, a management port for dictionary updates, two support channels, and a two-person team.
That's a small enough document to read in one sitting, but it already exercises every top-level section of the
standard — which makes it a good teaching example.

By the end of this tutorial you will have built the project checked into this repo at
[`example/customer-data-product/`](example/customer-data-product), broken into one small KCL file per
concern, composed into a single root `odps.k`, and validated with `kcl vet` against the same schemas.