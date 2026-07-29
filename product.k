import enkinex_odps.odps

import .metadata.description as product_description
import .input.port as input_port
import .output.port as output_port
import .management.port as management_port
import .support.channels as support_channels
import .team.team as product_team

odps.DataProduct {
    name = "Customer Data Product"
    id = "fbe8d147-28db-4f1d-bedf-a3fe9f458427"
    domain = "seller"
    status = "draft"
    tenant = "RetailCorp"
    tags = ["customer"]
    description = product_description.ProductDescription
    inputPorts = [
        input_port.Payments1_0
        input_port.Payments2_0
        input_port.OnlineTransactions1_0
        input_port.OnlineTransactions1_1
    ]
    outputPorts = [
        output_port.RawTransactions1_0
        output_port.RawTransactions2_0
        output_port.ConsolidatedTransactions1_0
        output_port.FullTransactionsWithReturns0_3
    ]
    managementPorts = [
        management_port.DictionaryUpdatesPort
    ]
    support = [
        support_channels.DataTeamSlack
        support_channels.EmailSupport
    ]
    team = product_team.DataTeam
    productCreatedTs = "2023-01-15T10:30:00Z"
}
