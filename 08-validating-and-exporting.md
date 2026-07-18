# Validating & Exporting

KCL is both a validator and a renderer, so the same source drives type-checking and serialization. This page
renders the project built over the previous pages to YAML, then validates that YAML back against the schema.

## Parse and render

To render `odps.k` as a YAML file, run the following command:

```bash
kcl run odps.k --format yaml -S product
```

```yaml
tags:
- customer
apiVersion: v1.0.0
kind: DataProduct
id: fbe8d147-28db-4f1d-bedf-a3fe9f458427
name: Customer Data Product
status: draft
domain: seller
tenant: RetailCorp
# ...
```

## Export to a file

Add `-o`/`--output` to write straight to disk instead of standard output:

```bash
kcl run odps.k --format yaml -S product -o product.yaml
```

(`--format json` produces JSON the same way.) The generated file in this repo's copy of the project is
[`example/customer-data-product/product.yaml`](example/customer-data-product/product.yaml).


## Wrapping up

Over the course of this tutorial you built a typed, modular KCL project: one small file per concern, composed
into a single root document, type-checked at every step, and both renderable to and validatable against the ODPS
standard. Reusable pieces (a `TeamMember`, a `Support` channel, an `InputPort`) are now named values a second data
product could import and reuse, instead of copy-pasted YAML blocks.

From here:

- The full schema reference is generated straight from the schema docstrings: [`docs/library/odps.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/library/odps.md).
- The reasoning behind each schema's shape (what was kept 1:1 with upstream, what was synthesized, and why) is
  documented per module under [`docs/schemas/`](https://github.com/enkinex/enkinex-odps/tree/main/docs/schemas).
- The complete project is checked into this repo under [`example/customer-data-product`](example/customer-data-product).