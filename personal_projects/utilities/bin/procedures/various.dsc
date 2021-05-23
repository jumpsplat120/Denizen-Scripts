# fill_list: Fills a list with a the results of a procedure script, with length 'length'.
# find_nearest_npc_by_name: Find the nearest spawned npc to a passed location that matches the name passed.Returns false if no npc with that name is found.
# player_by_name: Returns the dPlayer of a player, parsed from the passed name. Unlike <&lt>servermatch_offline_player<&gt>, this will only return the player object if the name is matched exactly, excludingcase sensitivity. This is useful for commands that take player names where it's important to verify who acommand is being cast on. For example, if you had a command that wiped a player's inventory, or granted theplayer special permissions. Returns false if the player name does not match a player who has joined yourserver.
# outline_cuboid: Returns a list of locations that outline the physical cuboid, based in the density parmeter.The higher the density, the more locations returned. If density is not passed, uses a default of 1, which isone location per block. Unlike the outline tag, this CANNOT be used for actual locations, and is usedinternally for the particles in the notable tool. If you want a visual representation of a cuboid forwhatever reason, use this. If not, consider using the actual outline tag.
# outline_location: Returns a list of locations that outline the block of a location. If the passed locationisn't an actual block, it will highlight an area that is the size of one block, but will be offset from therest of the Minecraft grid.
# shell_ellipsoid: Returns a list of locations that create a shell of the physical ellipsoid, based on thedenisity parmeter. The higher the denisity, the more locations returned. If denisity is not passed, uses adefault of 1. Unlike the shell tag, this CANNOT be used for actual locations, and is used internally for theparticles in the notable tool. If you want a visual representation of an ellipsoid for whatever reason, usethis. If not, consider using the actual shell tag.
# center_armor_stand_on_head: Does what it says on the tin; returns a location where the armor stand is centered on the head. This returns the center of a block, so you will most likely need to adjust seperately after using this procedure.
# block_face: Get's the face of a block that the passed entity is looking up, up to the range passed. If there is no passed entity, attempts to fallback to a linked player, and if there is no range, uses the default of 200.
# block_facing: Get's the facing vector of the block at location.
# rainbow_list: Returns a list of just colors. Similar to rainbow text, but doesn't need text, so you can use the colors however and have them be to your spec.
# unstackable: Takes a passed item name, and returns an item with random nbt on it, so it doesn't stack with other items of the same type. Useful for creating non stacking items out of a material that normally stacks, when you don't want to adjust the material in it's entirety.

lib_fill_list:
    type: procedure
    debug: false
    definitions: proc_name|number
    script:
        - define proc_name <[proc_name].if_null[#]>
        - repeat <[number]>:
            - define result:->:<proc[<[proc_name]>]>
        - determine <[result]>

lib_find_nearest_npc_by_name:
    type: procedure
    debug: false
    definitions: npc_name|loc
    script:
        - determine <server.npcs_named[<[npc_name]>].filter[is_spawned].sort_by_number[location.distance[<[loc].if_null[true].if_true[<player.location.if_null[false]>].if_false[<[loc]>]>]].first>

lib_exact_match_offline_player:
    type: procedure
    debug: false
    definitions: player_name
    script:
        - define player <server.match_offline_player[<[player_name]>].if_null[null]>
        - determine <[player].name.to_lowercase.equals[<[player_name].to_lowercase>].if_true[<[player]>].if_false[false].if_null[false]>

lib_outline_cuboid:
    type: procedure
    debug: false
    definitions: cuboid|density
    script:
        - define density <tern[<[density].if_null[true]>].pass[1].fail[<[density]>]>
        - if <[cuboid].list_members.size> == 1:
            - define density <element[1].div[<[density]>]>
            - define world   <[cuboid].center.world>
            - define max     <[cuboid].max.center.add[.51,.51,.51,<[world]>]>
            - define min     <[cuboid].min.center.sub[.51,.51,.51,<[world]>]>
            - define a       <[max].with_z[<[min].z>]>
            - define b       <[max].with_x[<[min].x>]>
            - define c       <[b].with_z[<[min].z>]>
            - define d       <[min].with_x[<[max].x>]>
            - define e       <[min].with_z[<[max].z>]>
            - define f       <[e].with_x[<[max].x>]>
            - define res     <[max].points_between[<[a]>].distance[<[density]>].include[<[max].points_between[<[b]>].distance[<[density]>]>].include[<[b].points_between[<[c]>].distance[<[density]>]>].include[<[a].points_between[<[c]>].distance[<[density]>]>].include[<[min].points_between[<[e]>].distance[<[density]>]>].include[<[min].points_between[<[d]>].distance[<[density]>]>].include[<[e].points_between[<[f]>].distance[<[density]>]>].include[<[d].points_between[<[f]>].distance[<[density]>]>].include[<[max].points_between[<[f]>].distance[<[density]>]>].include[<[a].points_between[<[d]>].distance[<[density]>]>].include[<[b].points_between[<[e]>].distance[<[density]>]>].include[<[c].points_between[<[min]>].distance[<[density]>]>]>
        - else:
            - foreach <[cuboid].list_members>:
                - define extra:->:<proc[lib_outline_cuboid].context[<[value]>|<[density]>]>
        - determine <[res].include[<[extra].if_null[<empty>]>]>

lib_outline_location:
    type: procedure
    debug: false
    definitions: location
    script:
        - define c <[location].center>
        - define w <[location].world>
        - define f <[c].x.add[.5]>
        - define k <[c].x.sub[.5]>
        - define t <[c].y.add[.5]>
        - define b <[c].y.sub[.5]>
        - define l <[c].z.add[.5]>
        - define r <[c].z.sub[.5]>
        - determine <list[<location[<[f]>,<[b]>,<[r]>,<[w]>]>|<location[<[f]>,<[b]>,<[l]>,<[w]>]>|<location[<[f]>,<[t]>,<[r]>,<[w]>]>|<location[<[f]>,<[t]>,<[l]>,<[w]>]>|<location[<[k]>,<[t]>,<[r]>,<[w]>]>|<location[<[k]>,<[t]>,<[l]>,<[w]>]>|<location[<[k]>,<[b]>,<[r]>,<[w]>]>|<location[<[k]>,<[b]>,<[l]>,<[w]>]>]>

lib_shell_ellipsoid:
    type: procedure
    debug: false
    definitions: ellipsoid|density
    script:
        - define density <[density].if_null[true].if_true[1].if_false[<[density]>]>
        - define center <[ellipsoid].location>
        - define amount <[density].mul[100]>
        - repeat <[amount]>:
            - define dist <proc[lib_map_range].context[1|<[amount]>|-0.5|0.5|<[value]>].abs.cos>
            - define theta <proc[lib_map_range].context[1|<[amount]>|-<util.pi.div[2]>|<util.pi.div[2]>|<[value]>].mul[<[dist]>]>
            - define lambda <proc[lib_map_range].context[1|<[amount]>|0|<util.tau>|<[value].mul[30]>]>
            - define theta_cos <[theta].cos>
            - define result:->:<[center].with_x[<[center].x.add[<[theta_cos].mul[<[lambda].cos>].mul[<[ellipsoid].size.x>]>]>].with_y[<[center].y.add[<[theta_cos].mul[<[lambda].sin>].mul[<[ellipsoid].size.y>]>]>].with_z[<[center].z.add[<[theta].sin.mul[<[ellipsoid].size.z>]>]>]>
        - determine <[result]>

lib_center_armor_stand_on_head:
    type: procedure
    debug: false
    definitions: loc
    script:
        - determine <[loc].center.relative[0,-1.45,0.265]>

lib_block_face:
    type: procedure
    debug: false
    definitions: entity|distance
    script:
        - define entity <[entity].if_null[<player>]>
        - determine <[entity].eye_location.precise_impact_normal[<[distance].if_null[200]>].vector_to_face.to_lowercase>

lib_block_facing:
    type: procedure
    debug: false
    definitions: entity|distance
    script:
        - define entity <[entity].if_null[<player>]>
        - determine <[entity].eye_location.precise_impact_normal[<[distance].if_null[200]>]>

lib_rainbow_list:
    type: procedure
    debug: false
    definitions: amount|color|increment
    script:
        - define increment <[increment].if_false[<[increment]>].if_true[15].if_null[15]>
        - define color <[color].if_false[<[color]>].if_true[<proc[lib_random_color_tag]>].if_null[<proc[lib_random_color_tag]>]>
        - repeat <[amount]>:
            - define color_list:->:<&color[<[color]>]>
            - define color <[color].with_hue[<[color].hue.add[15]>]>
        - determine <[color_list]>

lib_unstackable:
    type: procedure
    debug: false
    definitions: item
    script:
        - determine <[item].with[raw_nbt=<map.with[antistack].as[float:<util.random.decimal>]>]>