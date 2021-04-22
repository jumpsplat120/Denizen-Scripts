jumps_pad:
    type: world
    debug: true
    events:
        on player clicks crimson_trapdoor:
            - define door <list[<location[trapdoor1_jumps_pad]>|<location[trapdoor2_jumps_pad]>]>
            - if <[door].contains[<context.location>]>:
                - determine passively cancelled
                - define north <location[-1,0,0,world]>
                - define west <location[0,0,-1,world]>
                - adjust <[door]> block_facing:<tern[<context.location.block_facing.is[==].to[<[north]>]>].pass[<[west]>].fail[<[north]>]>