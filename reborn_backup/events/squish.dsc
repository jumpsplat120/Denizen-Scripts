squish:
    type: world
    debug: false
    events:
        on player statistic fall_one_cm increments:
            - if <player.fall_distance> >= <script[master_config].data_key[squish.terminal_velocity]>:
                - burn <player> duration:2t
        on player damaged by fall:
            - define config <script[master_config].data_key[squish]>
            - define super_fall <player.fall_distance.is[OR_MORE].than[<[config].get[terminal_velocity]>]>
            - define entities <player.location.find.entities.within[<tern[<[super_fall]>].pass[<[config].get[squish_range]>].fail[<[config].get[terminal_squish_range]>]>].exclude[<player>]>
            - flag <player> squishing duration:1s
            - hurt <player.fall_distance.mul[<[config].get[damage_multiplier]>]> <[entities]> source:<player>
            - if <[super_fall]>:
                - burn <[entities]> duration:250t
        on entity dies:
            - if <context.cause||null> == ENTITY_ATTACK && <context.damager.has_flag[squishing]||false> != false:
                - determine "<green>[<yellow>D<green>] <red><context.entity.name> was squished by <context.damager.name>"
    