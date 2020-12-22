d1_portal_trigger:
    type: world
    debug: false
    events:
        on player enters d1_dominus_warp_zone:
            - if <player.flag[d1_portal_explanation]||false> == false:
                - narrate <script[master_config].data_key[d1.portal_explanation].parsed>
                - flag player d1_portal_explanation:true
        on player chats in d1_dominus_warp_zone:
            - define config <script[master_config].data_key[d1]>
            - if <context.message.to_lowercase> == <[config].get[trigger_word].parsed.to_lowercase>:
                - define players <cuboid[<[config].get[cuboid].get[dominus_warp_zone]>].players>
                - determine passively cancelled
                - narrate <context.full_text> targets:<[players]>
                - narrate <[config].get[teleport_message].parsed> targets:<[players]>
                - cast confusion duration:9t <[players]> hide_particles
                - wait 1
                - cast blindness duration:2s <[players]> hide_particles
                - teleport <[players]> <location[<[config].get[location].get[teleport_to_boss]>]>