# Team

The `team/` package holds the data product's ownership record: individual `TeamMember` values, composed into a
single `Team`.

## Members

`team.TeamMember` (see [`team/member.k`](https://github.com/enkinex/enkinex-odps/blob/main/team/member.k) and [`docs/schemas/team.md`](https://github.com/enkinex/enkinex-odps/blob/main/docs/schemas/team.md))
validates `dateIn`/`dateOut` against an ISO-8601 date pattern (`YYYY-MM-DD`) via its own `check` block, so a
malformed date is rejected at compile time rather than silently accepted as an arbitrary string.

Write `team/member.k`:

```bash
cat > team/member.k <<'EOF'
import enkinex_odps.team as team

JohnDoe = team.TeamMember {
    username = "john.doe@retailcorp.com"
    name = "John Doe"
    description = "Data Product Owner"
    role = "owner"
    dateIn = "2023-01-15"
}

JaneSmith = team.TeamMember {
    username = "jane.smith@retailcorp.com"
    name = "Jane Smith"
    description = "Data Steward"
    role = "data steward"
    dateIn = "2023-02-01"
}
EOF
```

Both members only set `dateIn`: `dateOut` and `replacedByUsername` stay unset, since neither has left the team in
the source document.

## Composing the team

`team/team.k` assembles the two members into a `team.Team`. Because `member.k` and `team.k` live in the same local
package (`team/`), the top-level values `JohnDoe` and `JaneSmith` are already in scope — no import needed to reach
across files in the same directory:

```bash
cat > team/team.k <<'EOF'
import enkinex_odps.team as team

DataTeam = team.Team {
    name = "Data Team"
    description = "The Data Team is responsible for the data product."
    members = [JohnDoe, JaneSmith]
}
EOF
```

## Composing the root `odps.k`

Rewrite `odps.k`, adding the `team` import and field to what page 4 wrote:

```bash
cat > odps.k <<'EOF'
import enkinex_odps.odps
import metadata
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
    team = team.DataTeam
}
EOF
```

## Checkpoint

```bash
kcl run odps.k --format yaml -S product
```

The output should now include a `team:` block with both members. If KCL instead reports an unresolved
`JohnDoe`/`JaneSmith`, double check `team/member.k` and `team/team.k` are both saved — values are only in scope
across files that live in the same directory.