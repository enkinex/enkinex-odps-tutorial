import enkinex_odps.team

import .member as team_member

DataTeam = team.Team {
    name = "Data Team"
    description = "The Data Team is responsible for the data product."
    tags = ["data", "team"]
    customProperties = [
        {property = "dataTeam", value = "true"}
    ]
    members = [
        team_member.JohnDoe
        team_member.JaneSmith
    ]
}
