# --------------------DATA SCRIPTS-------------------- #

lib_core:
    type: data
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
    tool_speed:
        wooden: 2
        stone: 4
        iron: 6
        diamond: 8
        netherite: 9
        golden: 12
    note_to_color:
        - 0
        - 0.042
        - 0.083
        - 0.125
        - 0.167
        - 0.208
        - 0.250
        - 0.292
        - 0.333
        - 0.375
        - 0.417
        - 0.458
        - 0.5
        - 0.542
        - 0.583
        - 0.625
        - 0.667
        - 0.708
        - 0.750
        - 0.792
        - 0.833
        - 0.875
        - 0.917
        - 0.958
        - 1
    note_to_pitch:
        - 0.5
        - 0.529732
        - 0.561231
        - 0.594604
        - 0.629961
        - 0.667420
        - 0.707107
        - 0.749154
        - 0.793701
        - 0.840896
        - 0.890899
        - 0.943874
        - 1
        - 1.059463
        - 1.122462
        - 1.189207
        - 1.259921
        - 1.334840
        - 1.414214
        - 1.498307
        - 1.587401
        - 1.681793
        - 1.781797
        - 1.887749
        - 2
    instruments:
        - banjo
        - basedrum
        - bass
        - bell
        - bit
        - chime
        - cow_bell
        - didgeridoo
        - flute
        - guitar
        - harp
        - hat
        - iron_xylophone
        - pling
        - snare
        - xylophone
    attributes:
        wooden_sword:
            slot: hand
            attack_speed: 1.6
            attack_damage: 4
        stone_sword:
            slot: hand
            attack_speed: 1.6
            attack_damage: 5
        iron_sword:
            slot: hand
            attack_speed: 1.6
            attack_damage: 6
        golden_sword:
            slot: hand
            attack_speed: 1.6
            attack_damage: 4
        diamond_sword:
            slot: hand
            attack_speed: 1.6
            attack_damage: 7
        netherite_sword:
            slot: hand
            attack_speed: 1.6
            attack_damage: 8
        wooden_pickaxe:
            slot: hand
            attack_speed: 1.2
            attack_damage: 2
        stone_pickaxe:
            slot: hand
            attack_speed: 1.2
            attack_damage: 3
        iron_pickaxe:
            slot: hand
            attack_speed: 1.2
            attack_damage: 4
        golden_pickaxe:
            slot: hand
            attack_speed: 1.2
            attack_damage: 2
        diamond_pickaxe:
            slot: hand
            attack_speed: 1.2
            attack_damage: 5
        netherite_pickaxe:
            slot: hand
            attack_speed: 1.2
            attack_damage: 6
        wooden_hoe:
            slot: hand
            attack_speed: 1
            attack_damage: 1
        stone_hoe:
            slot: hand
            attack_speed: 2
            attack_damage: 1
        iron_hoe:
            slot: hand
            attack_speed: 3
            attack_damage: 1
        golden_hoe:
            slot: hand
            attack_speed: 1
            attack_damage: 1
        diamond_hoe:
            slot: hand
            attack_speed: 4
            attack_damage: 1
        netherite_hoe:
            slot: hand
            attack_speed: 4
            attack_damage: 1
        wooden_shovel:
            slot: hand
            attack_speed: 1
            attack_damage: 2.5
        stone_shovel:
            slot: hand
            attack_speed: 1
            attack_damage: 3.5
        iron_shovel:
            slot: hand
            attack_speed: 1
            attack_damage: 4.5
        golden_shovel:
            slot: hand
            attack_speed: 1
            attack_damage: 2.5
        diamond_shovel:
            slot: hand
            attack_speed: 1
            attack_damage: 5.5
        netherite_shovel:
            slot: hand
            attack_speed: 1
            attack_damage: 6.5
        wooden_axe:
            slot: hand
            attack_speed: 0.8
            attack_damage: 7
        stone_axe:
            slot: hand
            attack_speed: 0.8
            attack_damage: 9
        iron_axe:
            slot: hand
            attack_speed: 0.9
            attack_damage: 9
        golden_axe:
            slot: hand
            attack_speed: 1
            attack_damage: 7
        diamond_axe:
            slot: hand
            attack_speed: 1
            attack_damage: 9
        netherite_axe:
            slot: hand
            attack_speed: 1
            attack_damage: 10
        leather_helmet:
            slot: head
            armor: 1
        leather_chestplate:
            slot: chest
            armor: 2
        leather_leggings:
            slot: legs
            armor: 3
        leather_boots:
            slot: feet
            armor: 1
        chainmail_helmet:
            slot: head
            armor: 2
        chainmail_chestplate:
            slot: chest
            armor: 5
        chainmail_leggings:
            slot: legs
            armor: 4
        chainmail_boots:
            slot: feet
            armor: 2
        iron_helmet:
            slot: head
            armor: 2
        iron_chestplate:
            slot: chest
            armor: 6
        iron_leggings:
            slot: legs
            armor: 5
        iron_boots:
            slot: feet
            armor: 2
        golden_helmet:
            slot: head
            armor: 2
        golden_chestplate:
            slot: chest
            armor: 5
        golden_leggings:
            slot: legs
            armor: 3
        golden_boots:
            slot: feet
            armor: 1
        diamond_helmet:
            slot: head
            armor: 3
            armor_toughness: 2
        diamond_chestplate:
            slot: chest
            armor: 8
            armor_toughness: 2
        diamond_leggings:
            slot: legs
            armor: 6
            armor_toughness: 2
        diamond_boots:
            slot: feet
            armor: 3
            armor_toughness: 2
        netherite_helmet:
            slot: head
            armor: 3
            armor_toughness: 2
            knockback_resistance: 1
        netherite_chestplate:
            slot: chest
            armor: 8
            armor_toughness: 2
            knockback_resistance: 1
        netherite_leggings:
            slot: legs
            armor: 6
            armor_toughness: 2
            knockback_resistance: 1
        netherite_boots:
            slot: feet
            armor: 3
            armor_toughness: 2
            knockback_resistance: 1
    mob_xp_rates:
        bat:
            min: 0
            max: 0
        snow_golem:
            min: 0
            max: 0
        villager:
            min: 0
            max: 0
        wandering_trader:
            min: 0
            max: 0
        axolotl:
            min: 1
            max: 3
        cat:
            min: 1
            max: 3
        chicken:
            min: 1
            max: 3
        cod:
            min: 1
            max: 3
        cow:
            min: 1
            max: 3
        donkey:
            min: 1
            max: 3
        fox:
            min: 1
            max: 3
        glow_squid:
            min: 1
            max: 3
        horse:
            min: 1
            max: 3
        mooshroom:
            min: 1
            max: 3
        ocelot:
            min: 1
            max: 3
        parrot:
            min: 1
            max: 3
        pig:
            min: 1
            max: 3
        pufferfish:
            min: 1
            max: 3
        rabbit:
            min: 1
            max: 3
        salmon:
            min: 1
            max: 3
        sheep:
            min: 1
            max: 3
        squid:
            min: 1
            max: 3
        tropical_fish:
            min: 1
            max: 3
        turtle:
            min: 1
            max: 3
        zombie_horse:
            min: 1
            max: 3
        strider:
            min: 1
            max: 2
        iron_golem:
            min: 0
            max: 0
        zombified_piglin:
            min: 5
            max: 5
        baby_zombified_piglin:
            min: 12
            max: 12
        bee:
            min: 1
            max: 3
        dolphin:
            min: 1
            max: 3
        goat:
            min: 1
            max: 3
        llama:
            min: 1
            max: 3
        panda:
            min: 1
            max: 3
        polar_bear:
            min: 1
            max: 3
        trader_llama:
            min: 1
            max: 3
        wolf:
            min: 1
            max: 3
        cave_spider:
            min: 5
            max: 5
        enderman:
            min: 5
            max: 5
        piglin:
            min: 5
            max: 5
        spider:
            min: 5
            max: 5
        baby_zombie:
            min: 12
            max: 12
        blaze:
            min: 10
            max: 10
        evoker:
            min: 10
            max: 10
        elder_guardian:
            min: 10
            max: 10
        guardian:
            min: 10
            max: 10
        ridden_chicken:
            min: 22
            max: 22
        creeper:
            min: 5
            max: 5
        drowned:
            min: 5
            max: 5
        baby_drowned:
            min: 12
            max: 12
        ghast:
            min: 5
            max: 5
        hoglin:
            min: 5
            max: 5
        husk:
            min: 5
            max: 5
        baby_husk:
            min: 12
            max: 12
        illusioner:
            min: 5
            max: 5
        phantom:
            min: 5
            max: 5
        pillager:
            min: 5
            max: 5
        shulker:
            min: 5
            max: 5
        silverfish:
            min: 5
            max: 5
        skeleton:
            min: 5
            max: 5
        stray:
            min: 5
            max: 5
        vex:
            min: 5
            max: 5
        vindicator:
            min: 5
            max: 5
        witch:
            min: 5
            max: 5
        wither_skeleton:
            min: 5
            max: 5
        zombie:
            min: 5
            max: 5
        zombie_villager:
            min: 5
            max: 5
        baby_zombie_villager:
            min: 12
            max: 12
        zoglin:
            min: 5
            max: 5
        ender_dragon:
            min: 12000
            max: 12000
        summoned_ender_dragon:
            min: 500
            max: 500
        endermite:
            min: 3
            max: 3
        skeleton_horse:
            min: 1
            max: 3
        ridden_skeleton_horse:
            min: 11
            max: 13
        large_slime:
            min: 4
            max: 4
        large_magma_cube:
            min: 4
            max: 4
        medium_slime:
            min: 2
            max: 2
        medium_magma_cube:
            min: 2
            max: 2
        small_slime:
            min: 1
            max: 1
        small_magma_cube:
            min: 1
            max: 1
        ridden_spider:
            min: 10
            max: 10
        ridden_cave_spider:
            min: 10
            max: 10
        ravager:
            min: 20
            max: 20
        piglin_brute:
            min: 20
            max: 20
        wither:
            min: 50
            max: 50
    command:
        usage:
            panic: /panic
            end_queues: /end_queues
            puppet: /puppet (<&lt>name<&gt>)
            simple_permissions: /perm [action:{set}/clear/view] [node:<&lt>permission_name<&gt>] (name:<&lt>player_name<&gt>)
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