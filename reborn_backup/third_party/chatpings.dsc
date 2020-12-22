chat_pings:
    type: world
    debug: false
    events:
        on player chats:
        - define master_list <server.flag[all_chat_nicknames]||<list>>
        - if <context.message.contains_any[<[master_list]>]>:
            - foreach <[master_list]>:
                #an update borked denizen so doing a custom border check; consider swapping back to regex when that's available
                - if <context.message.contains[<[value]>]>:
                    - define matched <[value]>
                    - foreach stop
            - if <[matched]> != false:
                - define matched <[matched].trim_to_character_set[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789]>
                - define space_sep_message <context.message.split>
                - foreach <[space_sep_message]>:
                    - if <[value].trim_to_character_set[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789]> == <[matched]>:
                        - define full_match true
                        - foreach stop
                - if <[full_match]>:
                    - define players <list>
                    - foreach <server.list_online_players>:
                        - if <player> != <[value]>:
                            - define player_nicks <[value].flag[chat_nicknames]||<list>>
                            - if <[player_nicks].contains[<[matched]>]>:
                                - define players <[players].include[<[value]>]>
                    - if <[players].size> > 0:
                        - determine passively cancelled
                        - narrate <context.full_text> targets:<server.list_online_players.exclude[<[players]>]>
                        - narrate targets:<[players]> "<player.name><aqua><italic> mentioned you!"
                        - narrate targets:<[players]> <context.full_text.replace_text[<[matched]>].with[<gray><[matched]><white>]>
                        - playsound <[players]> sound:block_note_block_bell
                        - toast targets:<[players]> "<player.name><aqua><italic> mentioned you!" frame:goal icon:paper