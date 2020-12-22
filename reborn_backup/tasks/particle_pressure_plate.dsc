particle_pressure_plate:
    type: task
    debug: false
    definitions: flag_name|position|size_radius|swirl_amount|layer_spacing|layer_amount|delay|effect
    script:
        - define config <script[master_config].data_key[particle_pressure_plate]>
        - define amount <[swirl_amount]||<[config].get[swirl_amount]>>
        - define height <[layer_amount]||<[config].get[layer_amount]>>
        - define delay <[delay]||<[config].get[delay]>>
        - define size_radius <[size_radius]||<[config].get[size_radius]>>
        - define position <[position]||<player.location.relative[0,0.5,2]>>
        - define layer_spacing <[layer_spacing]||<[config].get[layer_spacing]>>
        - define effect <[effect]||<[config].get[effect]>>
        - define swirl_inc <element[360].div[<[height]>]>
        - define space_inc <element[360].div[<[amount]>]>
        - define locations <list>
        - define size <location[<[size_radius].mul[2]>,0,0,world]>
        - repeat <[height]> as:y:
            - define group <list>
            - repeat <[amount]> as:xz:
                - define group <[group].include[<[position].add[<[size].rotate_around_y[<[y].mul[<[swirl_inc]>].add[<[xz].mul[<[space_inc]>]>].to_radians>]>].up[<[y].mul[<[layer_spacing]>]>]>]>
            - define locations <[locations].include_single[<[group]>]>
        - while <server.has_flag[<[flag_name]>]>:
            - foreach <[locations]> as:group:
                - playeffect effect:<[effect]> at:<[group]> offset:0,0,0
                - wait <[delay]>t