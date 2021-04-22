soi_sand_config:
    type: data
    percent:
        dead_bush: 0.025
        dead_tree: 0.005
        fire_tree: 0.0025
        fire: 0.2
    fire_tree_height:
        min: 4
        max: 6

soi_sand_event:
    type: world
    debug: false
    events:
        on player right clicks block with:soi_sand_stick:
            - ratelimit <player> 5t
            - define percent <script[soi_sand_config].data_key[percent]>
            - narrate "<italic><yellow>Removing plants..."
            - define point <player.cursor_on[16]>
            - adjust <[point].find.blocks.within[32].filter[material.is_solid.not]> block_type:air
            - wait 1t
            - narrate <yellow><italic>Sandifying...
            - adjust <[point].find.surface_blocks.within[32].parse[up]> block_type:sand
            - wait 1t
            - narrate "<yellow><italic>Adding dead bushes..."
            - define surface <[point].find.surface_blocks.within[32].parse[up]>
            - define bush_locs <[surface].random[<[surface].size.mul[<[percent].get[dead_bush]>].round_up>]>
            - define surface <[surface].exclude[<[bush_locs]>]>
            - adjust <[bush_locs]> block_type:dead_bush
            - wait 1t
            - narrate "<yellow><italic>Adding dead trees..."
            - define dead_tree_locs <[surface].random[<[surface].size.mul[<[percent].get[dead_tree]>].round_up>]>
            - define surface <[surface].exclude[<[dead_tree_locs]>]>
            - foreach <[dead_tree_locs]> as:loc:
                - foreach <proc[soi_sand_tree].context[<[loc]>]> as:map:
                    - define loc <[map].get[loc]>
                    #Up to get to surface block
                    - while <[loc].material.name> != air:
                        - define loc <[loc].up>
                    #Down until ontop of solid block
                    - while !<[loc].down.material.is_solid>:
                        - define loc <[loc].down>
                    - adjust <[loc]> block_type:<[map].get[material]>
                    - adjustblock <[loc]> direction:<[map].get[dir]>
            - wait 1t
            - narrate "<yellow><italic>Adding fire trees..."
            - foreach <[surface].random[<[surface].size.mul[<[percent].get[fire_tree]>].round_up>]> as:loc:
                - foreach <proc[soi_sand_fire_tree].context[<[loc]>]> as:map:
                    - adjust <[map].get[loc]> block_type:<[map].get[material]>
                    - if <[map].get[dir]||false>:
                        - adjustblock <[map].get[loc]> direction:<[map].get[dir]>
                    - if !<[map].get[face]||true>:
                        - adjustblock <[map].get[loc]> faces:<[map].get[face]>
            - narrate <yellow><italic>Done!
        on player right clicks block with:soi_anti_sand_stick:
            - ratelimit <player> 5t
            - define point <player.cursor_on[16]>
            - adjust <[point].find.blocks[sand|fire|dead_bush|stripped_oak_log|stripped_dark_oak_log|stripped_spruce_log|stripped_birch_log|stripped_jungle_log].within[32]> block_type:air
            - narrate "<yellow><italic>Sand be gone!"

soi_anti_sand_stick:
    type: item
    material: stick
    display name: <reset>The Anti-Sand Stick
    lore:
        - <reset><aqua>Right click near the surface
        - <reset><aqua>to remove a whole bunch of
        - <reset><aqua>sand, and sand adjacent stuff.

soi_sand_stick:
    type: item
    material: stick
    display name: <reset>The Sand Stick
    lore:
        - <reset><aqua>Right click near the surface
        - <reset><aqua>to place a whole bunch of
        - <reset><aqua>sand!

soi_sand_tree:
    type: procedure
    debug: false
    definitions: loc
    script:
        - define map <map.with[material].as[stripped_<list[oak|spruce|jungle|birch].random>_log]>
        - choose <util.random.int[1].to[4]>:
            - case 1:
                - define map <[map].with[dir].as[x]>
                - define result:->:<[map].with[loc].as[<[loc]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[1,0,0]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[2,0,0]>]>
                - determine <[result]>
            - case 2:
                - define map <[map].with[dir].as[z]>
                - define result:->:<[map].with[loc].as[<[loc]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[0,0,1]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[0,0,2]>]>
                - determine <[result]>
            - case 3:
                - define map <[map].with[dir].as[x]>
                - define result:->:<[map].with[loc].as[<[loc]>].with[dir].as[y]>
                - define result:->:<[map].with[loc].as[<[loc].relative[2,0,0]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[3,0,0]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[4,0,0]>]>
                - determine <[result]>
            - case 4:
                - define map <[map].with[dir].as[z]>
                - define result:->:<[map].with[loc].as[<[loc]>].with[dir].as[y]>
                - define result:->:<[map].with[loc].as[<[loc].relative[0,0,2]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[0,0,3]>]>
                - define result:->:<[map].with[loc].as[<[loc].relative[0,0,4]>]>
                - determine <[result]>

soi_sand_fire_tree:
    type: procedure
    debug: false
    definitions: loc
    script:
        - define map <map.with[material].as[stripped_dark_oak_log].with[dir].as[y]>
        - define fire_chance <script[soi_sand_config].data_key[percent.fire]>
        - define height <script[soi_sand_config].data_key[fire_tree_height]>
        - repeat <util.random.int[<[height].get[min]>].to[<[height].get[max]>]>:
            - define new_loc <[loc].relative[0,<[value].sub[1]>,0]>
            - define result:->:<[map].with[loc].as[<[new_loc]>]>
            - if <[value]> != 1:
                - foreach <list.include[<[new_loc].forward>|<[new_loc].backward>|<[new_loc].left>|<[new_loc].right>]> as:fire_val:
                    - if <util.random.decimal> < <[fire_chance]>:
                        - define result:->:<[map].with[material].as[fire].with[loc].as[<[fire_val]>].with[face].as[<[fire_val].direction[<[new_loc]>]>].exclude[dir]>
        - determine <[result].sort_by_value[get[material]].reverse>
