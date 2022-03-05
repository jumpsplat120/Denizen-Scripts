color_chat:
    type: world
    debug: false
    events:
        on player chats:
            - define message <context.message>
            - while true:
                - define open <[message].index_of[<&lt>]>
                - define close <[message].index_of[<&gt>]>
                - while stop if:<[open].is_more_than[0].and[<[open].add[8].equals[<[close]>]>].not>
                - define message <[message].substring[1,<[open].sub[1]>]><&color[<[message].substring[<[open].add[1]>,<[close].sub[1]>]>]><[message].substring[<[close].add[1]>,<[message].length>]>
            - determine <[message]>
