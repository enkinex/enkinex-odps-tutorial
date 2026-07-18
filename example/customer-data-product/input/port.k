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
