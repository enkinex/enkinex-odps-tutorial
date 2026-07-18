# Input & Output Ports

Ports are the heart of an ODPS document: `inputPorts` describe what a data product consumes, `outputPorts` describe
what it produces. Both are `Taggable`, so each entry can also carry `tags`, `customProperties`, and
`authoritativeDefinitions` (see [`docs/schemas/product-input.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/product-input.md) and
[`docs/schemas/product-output.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/product-output.md)).

## Input ports

`product.input.InputPort` requires `name`, `version`, and `contractId`. The upstream example lists two ports —
`payments` and `onlinetransactions` — each with two versions, so each `name`+`version` pair becomes its own named
value:

Write `input/port.k`:

```bash
cat > input/port.k <<'EOF'
import enkinex_odps.product.input as input

Payments1_0 = input.InputPort {
    name = "payments"
    version = "1.0.0"
    contractId = "dbb7b1eb-7628-436e-8914-2a00638ba6db"
}

Payments2_0 = input.InputPort {
    name = "payments"
    version = "2.0.0"
    contractId = "dbb7b1eb-7628-436e-8914-2a00638ba6da"
}

OnlineTransactions1_0 = input.InputPort {
    name = "onlinetransactions"
    version = "1.0.0"
    contractId = "ec2a112d-5cfe-49f3-8760-f9cfb4597544"
}

OnlineTransactions1_1 = input.InputPort {
    name = "onlinetransactions"
    version = "1.1.0"
    contractId = "ec2a112d-5cfe-49f3-8760-f9cfb4597547"
    tags = ["transactions"]
    customProperties = [
        { property = "transactionsVersion", value = "1.1.0" }
    ]
    authoritativeDefinitions = [
        { $type = "data_dictionary", url = "https://mydata.retailcorp.example/dictionary" }
    ]
}
EOF
```

`AuthoritativeDefinition`'s type field is named `$type` in KCL (see [`common/authoritative.k`](https://github.com/enkinex/enkinex-odps/blob/main/common/authoritative.k)):
the `$`-prefix lets the schema use `type` as a field name without colliding with the KCL keyword. It maps back to
the plain `type:` key when rendered to YAML/JSON — you'll see this in the exported output on the last page.

## Output ports

`product.output.OutputPort` is the most composite entity in the library: alongside `name`/`version`/`contractId`,
it can carry a list of `product.Sbom` entries and a list of `product.input.InputContract` dependencies (see
[`docs/schemas/product.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/product.md)). The upstream example's second `rawtransactions` version uses
both:

Write `output/port.k`:

```bash
cat > output/port.k <<'EOF'
import enkinex_odps.product.output as output

RawTransactions1_0 = output.OutputPort {
    name = "rawtransactions"
    description = "Raw Transactions"
    $type = "tables"
    version = "1.0.0"
    contractId = "c2798941-1b7e-4b03-9e0d-955b1a872b32"
}

RawTransactions2_0 = output.OutputPort {
    name = "rawtransactions"
    description = "Raw Transactions"
    $type = "tables"
    version = "2.0.0"
    contractId = "c2798941-1b7e-4b03-9e0d-955b1a872b33"
    tags = ["transactions"]
    customProperties = [
        { property = "transactionsVersion", value = "2.0.0" }
    ]
    authoritativeDefinitions = [
        { $type = "data_dictionary", url = "https://mydata.retailcorp.example/dictionary" }
    ]
    sbom = [
        { $type = "external", url = "https://mysbomserver.retailcorp.example/mysbom" }
    ]
    inputContracts = [
        { id = "dbb7b1eb-7628-436e-8914-2a00638ba6db", version = "2.0.0" }
        { id = "ec2a112d-5cfe-49f3-8760-f9cfb4597544", version = "1.0.0" }
    ]
}

ConsolidatedTransactions1_0 = output.OutputPort {
    name = "consolidatedtransactions"
    description = "Consolidated transactions"
    $type = "tables"
    version = "1.0.0"
    contractId = "a44978be-1fe0-4226-b840-1b715bc25c63"
}

FullTransactionsWithReturns0_3 = output.OutputPort {
    name = "fulltransactionswithreturns"
    description = "Full transactions with returns"
    $type = "tables"
    version = "0.3.0"
    contractId = "ef769969-0cbe-4188-876f-bb00abadaee4"
}
EOF
```

The `sbom` and `inputContracts` entries are written as bare `{ ... }` dict literals inside a typed list: KCL infers
the element schema (`product.Sbom`, `product.input.InputContract`) from `OutputPort`'s own attribute types, so no
explicit import or schema name is needed at each call site.

## Composing the root `odps.k`

Rewrite `odps.k`, adding the `input`/`output` imports and fields to what page 5 wrote:

```bash
cat > odps.k <<'EOF'
import enkinex_odps.odps
import metadata
import input
import output
import team

product = odps.DataProduct {
    name = "Customer Data Product"
    id = "fbe8d147-28db-4f1d-bedf-a3fe9f458427"
    domain = "seller"
    status = "draft"
    tenant = "RetailCorp"
    productCreatedTs = "2023-01-15T10:30:00Z"
    tags = ["customer"]
    description = metadata.ProductDescription
    inputPorts = [
        input.Payments1_0
        input.Payments2_0
        input.OnlineTransactions1_0
        input.OnlineTransactions1_1
    ]
    outputPorts = [
        output.RawTransactions1_0
        output.RawTransactions2_0
        output.ConsolidatedTransactions1_0
        output.FullTransactionsWithReturns0_3
    ]
    team = team.DataTeam
}
EOF
```

## Checkpoint

```bash
kcl run odps.k --format yaml -S product
```

The output should now include `inputPorts:` (4 entries) and `outputPorts:` (4 entries) alongside the metadata and
team from the previous pages.