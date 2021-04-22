lib_spawn_falling_block:
    type: task
    debug: false
    definitions: mat_name|location
    script:
        - define material <[mat_name].if_null[sand]>
        - define location <[location].if_null[<player.location.if_null[null]>]>
        - if <[location]> != null:
            - spawn lib_entity_stand|lib_entity_shulker|falling_block[fallingblock_type=<[material]>;time_lived=-<util.int_max>s] <[location]> save:entities
            - adjust <entry[entities].spawned_entities.get[1]> passengers:<entry[entities].spawned_entities.get[2]>|<entry[entities].spawned_entities.get[3]>
            - determine passively <entry[entities].spawned_entities>

lib_simulate_block_placing:
    type: task
    debug: false
    definitions: location|material|offhand
    script:
        - animate <player> animation:arm_swing<[offhand].exists.if_true[_offhand].if_false[]>
        - define list <script[lib_generic_data].data_key[block_placing]>
        - playsound <[location]> block_<[list].get[<[list].find_partial[<[material]>]>].if_null[stone]>_place pitch:<proc[lib_random_pitch]>