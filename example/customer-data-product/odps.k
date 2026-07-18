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
