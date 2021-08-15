# --------------------DATA SCRIPTS-------------------- #

lib_generic_data:
    type: data
    alphabet_set: abcdefghijklmnopqrstuvwxyz
    number_set: 0123456789
    phi: 1.618033988749895
    epsilon: 0.0000000000000000000000000000000000000000000000000000000000000001
    ease:
        dir:
            - in
            - out
            - inout
            - in_out
            - in-out
        type:
            - sine
            - quad
            - cubic
            - quart
            - quint
            - exp
            - circ
            - back
            - elastic
            - bounce
        C1: 1.70158
        C2: 2.5949095
        C2A: 3.5949095
        C3: 2.70158
        C4: 2.0943951
        C5: 1.3962634
    #The map was always in the wrong order for some reason? So we store it like this
    roman:
        - M/1000
        - CM/900
        - D/500
        - CD/400
        - C/100
        - XC/90
        - L/50
        - XL/40
        - X/10
        - IX/9
        - V/5
        - IV/4
        - I/1
    face_to_vec:
        up: 0,1,0
        down: 0,-1,0
        north: 0,0,-1
        south: 0,0,1
        east: 1,0,0
        west: -1,0,0
    command:
        usage:
            panic: /panic
            end_queues: /end_queues
            puppet: /puppet (<&lt>name<&gt>)
            simple_permissions: /perm [action:{set}/clear/view] [node:<&lt>permission_name<&gt>] (player:<&lt>player_name<&gt>)
            remove_flags: /remove_flags [action:{player}/server/all] (name:<&lt>player_name<&gt>)
            remove_notables: /remove_notables [type:{all}/location/cuboid/ellipsoid/inventory]
            random_placement: /random_placer (action:{set}/clear) (block:<&lt>name<&gt>) (weight:<&lt>amount<&gt>)
            notable_tool: /notable_tool (action:{save}/clear) (save:<&lt>name<&gt>)
            denchant: /denchant [<&lt>name<&gt>] ({1}/<&lt>amount<&gt>)
        error:
            permission: I<&sq>m sorry, but you do not have permission to perform this command. Please contact the server administrators if you believe that this is in error.
            wrong_args: Command was run with the incorrect amount of arguments! Expected<&co> <[color].get[soft_server_notice]><[3]><[color].get[error]>; Recieved<&co> <[color].get[soft_server_notice]><[4]>
            min_args: Too few arguments were passed! Expected at least<&co> <[color].get[soft_server_notice]><[3]><[color].get[error]>; Recieved<&co> <[color].get[soft_server_notice]><[4]>
            max_args: Too many arguments were passed! Expected at most<&co> <[color].get[soft_server_notice]><[3]><[color].get[error]>; Recieved<&co> <[color].get[soft_server_notice]><[4]>
            extra_keys: Found unrecogonized keys; <[3]>
            missing_keys: Found values with no keys; <[3]>
            implicit: Unable to use implicit player context. Are you running this through the server console or a command block?
            invalid_player: Unable to find player <[color].get[hard_server_notice]>'<[color].get[soft_server_notice]><[3]><[color].get[hard_server_notice]>'<[color].get[error]>.
            invalid_value: <[color].get[soft_server_notice]><[4]><[color].get[error]> is not a valid <[color].get[soft_server_notice]><[3]><[color].get[error]>!
    block_placing:
        - ancient_debris
        - anvil
        - bamboo
        - bamboo_sapling
        - basalt
        - bone_block
        - chain
        - coral_block
        - fungus
        - gilded_blackstone
        - glass
        - grass
        - gravel
        - honey_block
        - ladder
        - lantern
        - lily_pad
        - lodestone
        - metal
        - nether_bricks
        - gold_ore
        - nether_ore
        - netherite_block
        - netherrack
        - nylium
        - roots
        - sand
        - scaffolding
        - shroomlight
        - slime_block
        - snow
        - soul_sand
        - soul_soil
        - stem
        - stone
        - sweet_berry_bush
        - wart_block
        - wet_grass
        - wood
        - wool
    dye_hex_colors:
        black: 000000
        red: B02E26
        green: 5E7C16
        brown: 835432
        blue: 3C44AA
        purple: 8932B8
        cyan: 169C9C
        light_gray: 9D9D97
        gray: 474F52
        pink: F38BAA
        lime: 80C71F
        yellow: FED83D
        light_blue: 3AB3DA
        magenta: C74EBD
        orange: F9801D
        white: FFFFFF
    vanilla_enchantment_map:
        aqua_affinity: 1
        bane_of_arthropods: 5
        binding_curse: 1
        blast_protection: 4
        channeling: 1
        depth_strider: 3
        efficiency: 5
        feather_falling: 4
        fire_aspect: 2
        fire_protection: 4
        flame: 1
        fortune: 3
        frost_walker: 2
        impaling: 5
        infinity: 1
        knockback: 2
        looting: 3
        loyalty: 3
        luck_of_the_sea: 3
        lure: 3
        mending: 1
        multishot: 1
        piercing: 4
        power: 5
        projectile_protection: 4
        protection: 4
        punch: 2
        quick_charge: 3
        respiration: 3
        riptide: 3
        sharpness: 5
        silk_touch: 1
        smite: 5
        soul_speed: 3
        sweeping: 3
        thorns: 3
        unbreaking: 3
        vanishing_curse: 1
    duration:
        t: tick
        s: second
        m: minute
        h: hour
        d: day
        w: week
        y: year