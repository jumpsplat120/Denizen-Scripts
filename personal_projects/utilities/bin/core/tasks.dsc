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

# - One of these days I gotta fix up a LUT for sounds because neither find_partial or closest_to will match block name to block sound accurately
lib_simulate_block_placing:
    type: task
    debug: true
    definitions: location|material|offhand
    script:
        - animate <player> animation:arm_swing<[offhand].exists.if_true[_offhand].if_false[]>
        - define list <script[lib_generic_data].data_key[block_placing]>
        - define match <[list].find_partial[<[material].name>]>
        - playsound <[location]> block_<[list].get[<[match].equals[-1].if_true[stone].if_false[<[match]>]>].if_null[stone]>_place pitch:<proc[lib_random_pitch]>

lib_simulate_item_breaking:
    type: task
    debug: false
    definitions: item
    script:
        - playsound <player.location> sound:entity_item_break pitch:<proc[lib_random_pitch]>
        - repeat 4:
            - playeffect effect:ITEM_CRACK at:<player.eye_location.forward[.75].right[.75].down[.25]> special_data:<[item]> offset:0.1,0.1,0.1

lib_animated_actionbar:
    type: task
    definitions: list|wait
    debug: false
    script:
        - define unique <util.random.uuid>
        - define wait 1t if:<[wait].exists.not>
        - flag player actionbar:<[unique]>
        - foreach <[list]>:
            - if <player.flag[actionbar].if_null[null]> != <[unique]>:
                - foreach stop
            - actionbar <[value]>
            - wait <[wait]>

lib_grow_mushroom:
    type: task
    definitions: loc
    debug: false
    script:
        - define mushroom <[loc].material.name>
        - define up <[loc].up[3]>
        - define cuboid <[loc].up[1].to_cuboid[<[up]>].add_member[<[up].relative[3,2,3].to_cuboid[<[up].relative[-3,0,-3]>]>]>
        - if <[cuboid].blocks.filter_tag[<[filter_value].material.advanced_matches[*_leaves].or[<[filter_value].material.is_solid.not>]>].size.equals[<[cuboid].proc[lib_full_volume]>]>:
            - modifyblock <[loc]> no_physics air
            - adjust <[loc]> generate_tree:<[mushroom]>

lib_grow_fungus:
    type: task
    definitions: loc
    debug: false
    script:
        - define sapling <[loc].material.name>
        - if <[loc].down.material.name.before[_]> == <[sapling].before[_]>:
            - modifyblock <[loc]> no_physics air
            - adjust <[loc]> generate_tree:<[sapling]>

#under constructions
lib_copyable:
    type: task
    debug: true
    script:
        - define result b
        - announce <[result]>