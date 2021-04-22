dnd_stats_command:
    type: command
    name: stats
    debug: true
    description: Assign or view your stats.<&nl><&nl>Allows players to assign themselves stats, or, if you have the permissions, assign stats to others. For those without permissions, running the command with no extra arguments will allow you to view your currently assigned stats.<&nl>If you run the command as /<yellow>stat <gray><&lt>stat_name<&gt> <&lt>stat_value<&gt><white>, you will assign the said stat name with the corresponding value. Be aware that there is nothing preventing you from assigning stats with mispellings, so be sure to double check. Capitlization does not matter.<&nl>If you run the command /<yellow>stat <gray><&lt>stat_name<&gt> clear<white>, then that stat will be removed.<&nl><&nl>Users with permissions can assign stats to others, both players and NPCs. Running the command as listed previously will work as expected, however, if you pass a name in front of either of those commands, you will instead run the command on that player or NPC. If there is a player and NPC with the same name, the player will take priority.<&nl>For example, /<yellow>stat <gray><&lt>player_name<&gt> <&lt>stat_name<&gt> <&lt>stat_value<&gt><white> would assign the relevant stats to <gray>player_name<white>. If you were to run the command /<yellow>stat <gray><&lt>player_name<&gt><white>, then you would instead view the stat of <gray>player_name<white>.
    usage: /stats (<&lt>player_name/stat_name<&gt>) (<&lt>stat_value/stat_name<&gt>/clear) (<&lt>stat_value<&gt>/clear)
    script:
        - if <context.args.size> == 0:
            - define stats  <player.flag[dnd_stats].as_map||<map>>
            - if <[stats].size> == 0:
                - narrate "<aqua>You do not currently have any stats."
            - else:
                - narrate "Your stats:"
                - foreach <player.flag[dnd_stats].as_map||<map>>:
                    - narrate "<[key]> <aqua>| <white><[value]>"
        - else if <context.args.size> == 1:
            - if <proc[has_permission].context[<player>|dnd.stats]>:
                - define entity <server.match_offline_player[<context.args.first>]||<proc[find_nearest_npc_by_name].context[<player.location>|<context.args.first>]>>
                - if <[entity]> == false:
                    - narrate "<red>No player or NPC found by the name <gray><context.args.first><red>."
                - else:
                    - define stats <[entity].flag[dnd_stats].as_map||<map>>
                    - if <[stats].size> == 0:
                        - narrate "<aqua>Entity <gray><context.args.first> <aqua>does not currently have any stats."
                    - else:
                        - narrate "<aqua>Stats of <gray><context.args.first><aqua>:"
                        - foreach <[stats]>:
                            - narrate "<[key]> <aqua>| <white><[value]>"
            - else:
                - narrate "<red>Command is missing arguments!"
        - else if <context.args.size> == 2:
            - define stats <player.flag[dnd_stats].as_map||<map>>
            - if <context.args.last> == clear:
                - flag <player> dnd_stats:<[stats].exclude[<context.args.first>]>
                - narrate "<aqua>Removed <gray><player.name> <aqua>stat: <white><context.args.first>"
            - else:
                - flag <player> dnd_stats:<[stats].with[<context.args.first>].as[<context.args.last>]>
                - narrate "<aqua>Assigned <gray><player.name> <aqua>stat: <white><context.args.first> <aqua>| <white><context.args.last>"
        - else if <context.args.size> > 2:
            - if <proc[has_permission].context[<player>|dnd.stats]>:
                - if <context.args.size> == 3:
                    - define entity <server.match_offline_player[<context.args.first>]||<proc[find_nearest_npc_by_name].context[<player.location>|<context.args.first>]>>
                    - if <[entity]> == false:
                        - narrate "<red>No player or NPC found by the name <gray><context.args.first><red>."
                    - else:
                        - define stats <[entity].flag[dnd_stats].as_map||<map>>
                        - if <context.args.last> == clear:
                            - flag <player> dnd_stats:<[stats].exclude[<context.args.get[2]>]>
                            - narrate "<aqua>Removed <gray><[entity].name> <aqua>stat: <white><context.args.get[2]>"
                        - else:
                            - flag <[entity]> dnd_stats:<[stats].with[<context.args.get[2]>].as[<context.args.last>]>
                            - narrate "<aqua>You have set the stat for <gray><[entity].name><aqua>: <white><context.args.get[2]> <aqua>| <white><context.args.last>"
                - else:
                    - narrate "<red>Command has too many arguments!"
            - else:
                - narrate "<red>Command has too many arguments!"
