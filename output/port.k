import enkinex_odps.product.output

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
        {property = "transactionsVersion", value = "2.0.0"}
    ]
    authoritativeDefinitions = [
        {$type = "data_dictionary", url = "https://mydata/dictionary"}
    ]
    sbom = [
        {$type = "external", url = "https://mysbomserver/mysbom"}
    ]
    inputContracts = [
        {id = "dbb7b1eb-7628-436e-8914-2a00638ba6db", version = "2.0.0"}
        {id = "ec2a112d-5cfe-49f3-8760-f9cfb4597544", version = "1.0.0"}
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
