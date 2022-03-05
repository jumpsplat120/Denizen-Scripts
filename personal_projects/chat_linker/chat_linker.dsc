chat_linker:
    type: world
    debug: false
    events:
        on player chats priority:1000:
            - determine passively cancelled
            - define message <context.message>
            - definemap items:
                main_hand: <player.item_in_offhand>
                off_hand: <player.item_in_hand>
                boots: <player.equipment.get[1]>
                leggings: <player.equipment.get[2]>
                chestplate: <player.equipment.get[3]>
                helmet: <player.equipment.get[4]>
            - foreach <[items]> as:item:
                - define display <[item].display.if_null[<[item].material.translated_name>].on_hover[<[item]>].type[SHOW_ITEM]>
                - define message <[message].replace_text[{<[key]>}].with[<[display].underline>]>
            - announce <[message]>