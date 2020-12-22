custom_cartography:
    type: world
    debug: false
    events:
        on player clicks in inventory:
            - inject locally global_constants
            - if <[is_cartography_table]>:
                - define is_hotkey <context.hotbar_button.is[!=].to[0]>
                - define item <tern[<[is_hotkey]>].pass[<player.inventory.slot[<context.hotbar_button>]>].fail[<tern[<context.cursor_item.material.name.is[!=].to[air]>].pass[<context.cursor_item>].fail[<context.item>]>]>
                - if <proc[has_raw_nbt].context[<[item].escaped>|<list[<[config].get[uncraftable_tags]>]>]> != false:
                    - if <[is_hotkey]> || <context.is_shift_click> || <[is_clicked_cartography]>:
                        - narrate <[cancel_msg]>
                        - determine cancelled
        on player drags in inventory:
            - inject locally global_constants
            - if <[is_cartography_table]> && <proc[has_raw_nbt].context[<context.item.escaped>|<list[<[config].get[uncraftable_tags]>]>]> != false && <[is_clicked_cartography]>:
                - narrate <[cancel_msg]>
                - determine cancelled
    global_constants:
        - define is_cartography_table <context.inventory.inventory_type.is[==].to[CARTOGRAPHY]>
        - define config <script[master_config].data_key[cartography]>
        - define cancel_msg <[config].get[cancel_message].parsed>
        - define is_clicked_cartography <context.clicked_inventory.inventory_type.is[==].to[CARTOGRAPHY]>