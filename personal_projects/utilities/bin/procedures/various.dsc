# fill_list: Fills a list with a the results of a procedure script and it's contexts, with length 'length'.
# find_nearest_npc_by_name: Find the nearest spawned npc to a passed location that matches the name passed.Returns false if no npc with that name is found.
# player_by_name: Returns the dPlayer of a player, parsed from the passed name. Unlike <&lt>server match_offline_player<&gt>, this will only return the player object if the name is matched exactly, excludingcase sensitivity. This is useful for commands that take player names where it's important to verify who acommand is being cast on. For example, if you had a command that wiped a player's inventory, or granted theplayer special permissions. Returns false if the player name does not match a player who has joined yourserver.
# outline_cuboid: Returns a list of locations that outline the physical cuboid, based in the density parmeter.The higher the density, the more locations returned. If density is not passed, uses a default of 1, which isone location per block. Unlike the outline tag, this CANNOT be used for actual locations, and is usedinternally for the particles in the notable tool. If you want a visual representation of a cuboid forwhatever reason, use this. If not, consider using the actual outline tag.
# outline_location: Returns a list of locations that outline the block of a location. If the passed location isn't an actual block, it will highlight an area that is the size of one block, but will be offset from therest of the Minecraft grid.
# shell_ellipsoid: Returns a list of locations that create a shell of the physical ellipsoid, based on the denisity parmeter. The higher the denisity, the more locations returned. If denisity is not passed, uses adefault of 1. Unlike the shell tag, this CANNOT be used for actual locations, and is used internally for the particles in the notable tool. If you want a visual representation of an ellipsoid for whatever reason, use this. If not, consider using the actual shell tag.
# center_on_head: Does what it says on the tin; returns a location where the armor stand is centered on the head. This returns the center of a block, so you will most likely need to adjust seperately after using this procedure.
# block_face: Get's the face of a block that the passed entity is looking at, up to the range passed. If there is no passed entity, attempts to fallback to a linked player, and if there is no range, uses the default of 200.
# block_facing: Get's the facing vector of the block at location.
# sort_by_distance_to: Sorts a list of location by their distance to another location.
# full_volume: returns the true full volume of a cuboid, including sub cuboids.
# formatted_date: returns the current timestamp, formatted in a nice way, or a passed timestamp.
# rainbow_list: Returns a list of just colors. Similar to rainbow text, but doesn't need text, so you can use the colors however and have them be to your spec.
# unstackable: Takes a passed item name, and returns an item with random nbt on it, so it doesn't stack with other items of the same type. Useful for creating non stacking items out of a material that normally stacks, when you don't want to adjust the material in it's entirety.
# face_to_vector: Takes a face (up/down/north/south/east/west) and turns it into a vector (0,1,0/0,-1,0...)
# mix_dyes: Pass in a list of Minecraft Item dyes of any size and get back a ColorTag representing the colors mixed together.
# command_usage: Takes a command's usage (ex. /tp <player_name>) and automatically formats it with colors to make it easier to read/parse.
# tokenize: Breaks words into "syllables". Not super accurate, but it's good enough for most purposes.

lib_tokenize:
    type: procedure
    debug: false
    definitions: element
    script:
        - define vowels <list[a|e|i|o|u|y]>
        - define word <[element].to_list>
        - foreach <[word]> as:letter:
            - if <[letter]> == " ":
                - define result[<[result].size>]:<[result].last><[token].unseparated>
                - define token:!
                - foreach next
            - define token:->:<[letter]>
            - if <[letter]> in <[vowels]> and <[word].get[<[loop_index].sub[1]>]> not in <[vowels]>:
                - define result:->:<[token].unseparated>
                - define token:!
        - define result[<[result].size>]:<[result].last><[token].unseparated> if:<[token].exists>
        - determine <[result]>

lib_fill_list:
    type: procedure
    debug: false
    definitions: proc_name|number
    script:
        - if <[proc_name].exists>:
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

lib_center_on_head:
    type: procedure
    debug: false
    definitions: loc
    script:
        - determine <[loc].add[-0.01,0.25,0.01]>

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
        - define increment <[increment].if_true[15].if_false[<[increment]>].if_null[15]>
        - define color <[color].if_true[<proc[lib_random_color_tag]>].if_false[<[color]>].if_null[<proc[lib_random_color_tag]>]>
        - repeat <[amount]>:
            - define color_list:->:<[color]>
            - define color <[color].with_hue[<[color].hue.add[<[increment]>]>]>
        - determine <[color_list]>

lib_sort_by_distance_to:
    type: procedure
    debug: false
    definitions: list|location
    script:
        - define result <list>
        - foreach <[list]> as:loc:
            - define distance <[loc].distance[<[location]>]>
            - define index 1
            - foreach <[result]> as:compare_loc:
                - if <[distance]> <= <[compare_loc].distance[<[location]>]>:
                    - foreach stop
                - define index:++
            - define result <[result].insert[<[loc]>].at[<[index]>]>
        - determine <[result]>

lib_full_volume:
    type: procedure
    debug: false
    definitions: cuboid
    script:
        - determine <[cuboid].list_members.parse[volume].sum>

lib_unstackable:
    type: procedure
    debug: false
    definitions: item
    script:
        - define item <[item].object_type.equals[Item].if_true[<[item]>].if_false[<item[<[item]>]>]>
        - determine <[item].with[raw_nbt=<map.with[antistack].as[float:<util.random_decimal>]>]>

face_to_vector:
    type: procedure
    debug: false
    definitions: face
    script:
        - definemap map:
            up: 0,1,0
            down: 0,-1,0
            north: 0,0,-1
            south: 0,0,1
            east: 1,0,0
            west: -1,0,0
            southeast: 1,0,1
            southwest: -1,0,1
            northeast: 1,0,-1
            northwest: -1,0,-1
        - determine <[map].get[<[face].to_lowercase>]>

lib_mix_dyes:
    type: procedure
    debug: false
    script:
        - define colors <queue.definition_map.exclude[raw_context].values.first.parse[material.name.before[_dye]]>
        - define hex <script[lib_core].data_key[dye_hex_colors]>
        - define result <color[<&ns><[hex].get[<[colors].get[1].if_null[white]>]>]>
        - foreach <[colors]>:
            - define result <[result].mix[<color[<&ns><[hex].get[<[value]>]>]>]>
        - determine <[result]>

lib_formatted_date:
    type: procedure
    debug: false
    definitions: time
    script:
        - determine "<[time].if_null[<util.time_now>].format[h':'mm a',' MMMM '<&lt>element['d'].proc[lib_ordinal]<&gt>' uuuu].parsed>"

lib_command_usage:
    type: procedure
    debug: false
    definitions: script_name|key_name
    script:
        - define c <script[lib_config].parsed_key[color.command]>
        - define l <[c].get[literal]>
        #Replace characters with appropriate coloring (minus < and >)
        - define format <script[<[script_name]>].parsed_key[<[key_name]>].replace_text[/].with[<[c].get[forward_slash]>/<[l]>].replace_text[<&lb>].with[<[c].get[bracket]><&lb><[l]>].replace_text[<&rb>].with[<[c].get[bracket]><&rb><[l]>].replace_text[(].with[<[c].get[parenthesis]>(<[l]>].replace_text[)].with[<[c].get[parenthesis]>)<[l]>].replace_text[{].with[<[c].get[curly_bracket]>{<[l]>].replace_text[}].with[<[c].get[curly_bracket]>}<[l]>]>
        #Split lines what's in between <here> and what between >here<
        - define lines:->:<[format].before[<&lt>]>
        - define text <&lt><[format].after[<&lt>]>
        - while <[text].length.is_more_than[1]>:
            - define lines:->:<[text].after[<&lt>].before[<&gt>]>
            - define text <&gt><[text].after[<&gt>]>
            - define lines:->:<[text].after[<&gt>].before[<&lt>]>
            - define text <&lt><[text].after[<&lt>]>
        #Even lines replace < and > with color variants, and add non literal coloring over everything in between. Non literal coloring overrides all other coloring because it is non literal stuff, which means any usage of / should not be interpreted as a split, but as it's own raw character.
        - foreach <[lines]>:
            - define lines[<[loop_index]>]:<[c].get[less_or_greater_than]><&lt><[c].get[non_literal]><[value].strip_color><[c].get[less_or_greater_than]><&gt><[l]> if:<[loop_index].mod[2].equals[0]>
        - determine <[lines].unseparated>

lib_calculate_xp_drop_from_mobs:
    type: procedure
    debug: false
    definitions: entity
    script:
        - define name <[entity].entity_type.to_lowercase>
        - if <[name]> == player:
            - define xp <player.xp_level.mul[7].min[100]>
        - else:
            - if <[entity].has_passenger> or <[entity].is_inside_vehicle>:
                - define name ridden_<[name]>
            - else if <[entity].is_baby.if_null[false]>:
                - define name baby_<[name]>
            - else if <[name]> == ender_dragon:
                - define name summoned_<[name]> if:<server.has_flag[ender_dragon_killed]>
            - define min_max <script[lib_core].data_key[mob_xp_rates.<[name]>].if_null[null]>
            - define name <[entity].entity_type.to_lowercase>
            - define min_max <script[lib_core].data_key[mob_xp_rates.<[name]>]> if:<[min_max].equals[null]>
            - if <[entity].proc[lib_is_chicken_jockey]> or <[entity].proc[lib_is_spider_jockey]> or <[entity].proc[lib_is_skeleton_horseman]>:
                - repeat <[entity].passenger.equipment_map.size.if_null[0]>:
                    - define xp:+:<util.random.int[1].to[3]>
                - repeat <[entity].vehicle.equipment_map.size.if_null[0]>:
                    - define xp:+:<util.random.int[1].to[3]>
            - repeat <[entity].equipment_map.size.if_null[0]>:
                - define xp:+:<util.random.int[1].to[3]>
            - define xp:+:<util.random.int[<[min_max].get[min]>].to[<[min_max].get[max]>]>
        - determine <[xp]>

lib_get_script_recipes:
    type: procedure
    debug: false
    script:
        - define result  <map>
        - define recipes <server.recipe_ids.filter[starts_with[denizen]]>
        - foreach <[recipes]> as:recipe:
            - define result.<[recipe].after[recipe_].before_last[_]>:->:<[recipe]>
        - determine <[result]>