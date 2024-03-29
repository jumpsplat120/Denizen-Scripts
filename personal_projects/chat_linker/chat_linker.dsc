chat_linker:
    type: world
    debug: true
    events:
        on player chats priority:1000:
            - determine passively cancelled
            - define message <context.full_text>
            - definemap items:
                main_hand: <player.item_in_hand>
                off_hand: <player.item_in_offhand>
                boots: <player.equipment.get[1]>
                leggings: <player.equipment.get[2]>
                chestplate: <player.equipment.get[3]>
                helmet: <player.equipment.get[4]>
            - foreach <[items]> as:item:
                - define display <[item].display.if_null[<[item].material.translated_name>].on_hover[<[item]>].type[SHOW_ITEM]>
                - define message <[message].replace_text[{<[key]>}].with[<[display].underline>]>
            - announce <[message]>