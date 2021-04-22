# | ===== START OF EDITABLE CONFIG ===== | #

morpheus_config:
    type: data
    percent: 0.5
    wake_message: "Wakey, wakey, rise and shine... good morning everyone!"

# | ===== END OF EDITABLE CONFIG ===== | #

morpheus_events:
    type: world
    events:
        on player enters bed:
            - ratelimit player 10t
            - wait 10t
            - flag server morpheus:->:<player>
            - inject init path:morpheus
            - announce "<player.name> <&e>is now sleeping. <[msg_addon]>"
            - if <[amt_of_players_sleeping].div[<[amt_of_players]>]> >= <[percentage]>:
                - time 0
                - announce <&e><[config].parsed_key[wake_message]>"
        on player leaves bed:
            - inject init path:morpheus
            - flag server morpheus:<-:<player>
            - define period <player.world.time.period>
            - if <[period]> == dusk || <[period]> == night:
                - announce "<player.name> <&e>left their bed. <[msg_addon]>"
    init:
        - define config <script[morpheus_config]>
        - define percentage <[config].data_key[percent]>
        - define amt_of_players <server.online_players.size>
        - define amt_of_players_sleeping <server.flag[sleeping_players].size>
        - define required <[amt_of_players].mul[<[percentage]>].round_down.max[1]>
        - define msg_addon "<&6><[amt_of_players_sleeping]>/<[required]> (<[amt_of_players_sleeping].div[<[required]>].mul[100].round><&pc>)"