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
