# Product Metadata

Every ODPS document carries a set of root-level fields that identify and describe the data product itself, plus an
optional `description` block for its purpose, limitations, and usage. This page covers both.

## Root-level fields

Straight from the upstream example, these fields land directly on the root `DataProduct` schema; no separate file
is needed, since they're plain scalars and a tag list:

| Field | Value | Notes |
|---|---|---|
| `id` | `fbe8d147-28db-4f1d-bedf-a3fe9f458427` | Required. A UUID reduces the risk of name collisions. |
| `name` | `Customer Data Product` | |
| `domain` | `seller` | Business domain. |
| `status` | `draft` | Required. Closed to the lifecycle union `proposed \| draft \| active \| deprecated \| retired`. |
| `tenant` | `RetailCorp` | Organization identifier. |
| `productCreatedTs` | `2023-01-15T10:30:00Z` | Checked against an ISO-8601 date-time pattern. |
| `tags` | `["customer"]` | |

`apiVersion` and `kind` are **not** listed here: as covered on the previous page, both are left to their schema
defaults (`"v1.0.0"` and `"DataProduct"` respectively).

## The `Description` block

The `description` block uses `common.Description` (see [`common/description.k`](https://github.com/enkinex/enkinex-odps/blob/main/common/description.k) and
[`docs/schemas/common.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/common.md)), which (unlike most schemas in this library) is `Extensible`
but not `Taggable`: it carries `customProperties`/`authoritativeDefinitions` but no `tags` of its own, matching
upstream exactly.

Write `metadata/description.k`:

```bash
cat > metadata/description.k <<'EOF'
import enkinex_odps.common as common

ProductDescription = common.Description {
    purpose = "Enterprise view of a customer."
    limitations = "No known limitations."
    usage = "Check the various artefacts for their own description."
}
EOF
```

## Composing the root `odps.k`

The root file imports the `metadata` package and wires the description in alongside the scalar fields. Write it
now — this is also the file the next four pages will keep growing:

```bash
cat > odps.k <<'EOF'
import enkinex_odps.odps
import metadata

product = odps.DataProduct {
    name = "Customer Data Product"
    id = "fbe8d147-28db-4f1d-bedf-a3fe9f458427"
    domain = "seller"
    status = "draft"
    tenant = "RetailCorp"
    productCreatedTs = "2023-01-15T10:30:00Z"
    tags = ["customer"]
    description = metadata.ProductDescription
}
EOF
```

## Checkpoint

You don't have to wait until every field is populated to start type-checking. Run the project now:

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
description:
  purpose: Enterprise view of a customer.
  limitations: No known limitations.
  usage: Check the various artefacts for their own description.
productCreatedTs: '2023-01-15T10:30:00Z'
```

That's already a valid, if partial, ODPS document. The next pages fill in `team`, `inputPorts`, `outputPorts`,
`managementPorts`, and `support`, each time rewriting `odps.k` with one more section added.