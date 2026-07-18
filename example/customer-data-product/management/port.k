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
