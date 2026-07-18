# Management Ports & Support

The last two sections of the standard are about operating and reaching the data product, rather than its data:
`managementPorts` are access points for managing the product itself (a REST admin endpoint, a Kafka control topic);
`support` lists the channels consumers use to get help.

## Management ports

`management.ManagementPort` (see [`management/port.k`](https://github.com/enkinex/enkinex-odps/blob/main/management/port.k) and
[`docs/schemas/management.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/management.md)) requires `name` and `content`; `$type` defaults to
`"rest"` but the upstream example's single management port is a Kafka topic, so it's set explicitly to `"topic"`.
Note the KCL boolean literal is capitalized (`True`, not `true`). That applies only in `.k` source, not in the
rendered YAML/JSON output:

Write `management/port.k`:

```bash
cat > management/port.k <<'EOF'
import enkinex_odps.management as management

DictionaryUpdatesPort = management.ManagementPort {
    content = "dictionary"
    $type = "topic"
    name = "tpc-dict-update"
    description = "Kafka topic for dictionary updates"
    tags = ["kafka"]
    customProperties = [
        { property = "kafkaTopic", value = True }
    ]
    authoritativeDefinitions = [
        { $type = "kafka_topic", url = "https://mykafka.retailcorp.example/topic" }
    ]
}
EOF
```

## Support channels

`support.Support` (see [`support/support.k`](https://github.com/enkinex/enkinex-odps/blob/main/support/support.k) and
[`docs/schemas/support.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/support.md)) requires `channel` and `url`; unlike `ManagementPort.url`,
which is optional, `Support.url` is always validated against the library's URL pattern, which explicitly accepts
`mailto:` links alongside `https:`:

Write `support/channels.k`:

```bash
cat > support/channels.k <<'EOF'
import enkinex_odps.support as support

DataTeamSlack = support.Support {
    channel = "Data Team Slack"
    url = "https://retailcorp.slack.com/archives/C1234567890"
    description = "Primary support channel for data product questions"
    tool = "slack"
    scope = "interactive"
}

EmailSupport = support.Support {
    channel = "Email Support"
    url = "mailto:data-support@retailcorp.com"
    description = "Email support for urgent issues"
    tool = "email"
    scope = "issues"
}
EOF
```

## Composing the root `odps.k`

This completes every section of the document. Rewrite `odps.k` one last time:

```bash
cat > odps.k <<'EOF'
import enkinex_odps.odps
import metadata
import input
import output
import management
import support
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
    managementPorts = [management.DictionaryUpdatesPort]
    support = [support.DataTeamSlack, support.EmailSupport]
    team = team.DataTeam
}
EOF
```

This is the same file as [`example/customer-data-product/odps.k`](example/customer-data-product/odps.k) in
this repo — `diff` your file against it if you want to double check. The next page renders it and validates the
result.
