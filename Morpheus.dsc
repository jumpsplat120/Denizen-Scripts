# | ===== START OF EDITABLE CONFIG ===== | #

morpheus_config:
    type: data
    percent: .50
    wake_message: "Wakey, wakey, rise and shine... good morning everyone!"

# | ===== END OF EDITABLE CONFIG ===== | #

morpheus:
    type: world
    events:
        on player enters bed:
            - flag server sleeping_players:|:<player.uuid>
            - define curr_percent <server.flag[sleeping_players].size.div[<server.online_players.size>]>
            - define req_amt <server.online_players.size.mul[<script[morpheus_config].yaml_key[percent]>].round_down.max[1]>
            - announce "<player.name> <&e>is now sleeping. <&6><server.flag[sleeping_players].size>/<[req_amt]> (<server.flag[sleeping_players].size.div[<[req_amt]>].mul[100].round><&pc>)"
            - if <[curr_percent]> >= <script[morpheus_config].yaml_key[percent]>:
                - time 0
                - announce "<&e><script[morpheus_config].yaml_key[wake_message]>"
        on player leaves bed:
            - flag server sleeping_players:<-:<player.uuid>
            - define period <world[world].time.period>
            - define req_amt <server.online_players.size.mul[<script[morpheus_config].yaml_key[percent]>].round_down.max[1]>
            - if <[period]> == dusk || <[period]> == night:
                - announce "<player.name> <&e>left their bed. <&6><server.flag[sleeping_players].size>/<[req_amt]> (<server.flag[sleeping_players].size.div[<[req_amt]>].mul[100].round><&pc>)"