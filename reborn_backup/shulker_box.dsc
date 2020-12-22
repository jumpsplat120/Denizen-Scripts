prevent_shulker_box_recursion:
    type: world
    debug: false
    events:
        on player number_key clicks in inventory:
            - define item <player.inventory.slot[<context.hotbar_button>]>
            - if <[item].material.name.ends_with[shulker_box]> && <[item].inventory_contents.is_empty.not>:
                - determine passively cancelled
                - narrate <script[master_config].data_key[shulker_box.hotbar].parsed>
        on player clicks *shulker_box in inventory:
            - if <context.is_shift_click> && <context.item.inventory_contents.is_empty.not>:
                - narrate <script[master_config].data_key[shulker_box.shift_click].parsed>
                - determine cancelled
        on player clicks in inventory with *shulker_box:
            - inject shulker_recursion_task
        on player drags *shulker_box in inventory:
            - inject shulker_recursion_task

shulker_recursion_task:
    type: task
    debug: false
    script:
        - define type <context.clicked_inventory.inventory_type||false>
        - if <[type].to_lowercase> != player && <[type]> != false && <element[<context.cursor_item||<context.item>>].as_item.inventory_contents.is_empty.not>:
                - narrate "<script[master_config].data_key[shulker_box.<[type]>].parsed||<element[Missing shulker message for <[type]>]>>"
                - determine cancelled
