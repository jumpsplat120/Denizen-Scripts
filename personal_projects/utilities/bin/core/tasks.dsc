#.center.down[0.25] to center a location with other blocks
lib_spawn_falling_block:
    type: task
    debug: false
    definitions: mat_name|location
    script:
        - define material <[mat_name].if_null[sand]>
        - define location <[location].if_null[<player.location.if_null[null]>]>
        - if <[location]> != null:
            - spawn lib_entity_stand|lib_entity_shulker<[material].equals[air].if_true[].if_false[|falling_block[fallingblock_type=<[material]>;time_lived=<util.int_min>s]]> <[location]> save:entities
            - adjust <entry[entities].spawned_entities.get[1]> passengers:<entry[entities].spawned_entities.get[2]><[material].equals[air].if_true[].if_false[|<entry[entities].spawned_entities.get[3]>]>
            - determine <entry[entities].spawned_entities>

# - One of these days I gotta fix up a LUT for sounds because neither find_partial or closest_to will match block name to block sound accurately
lib_simulate_block_placing:
    type: task
    debug: false
    definitions: location|material|offhand
    script:
        - animate <player> animation:arm_swing<[offhand].exists.if_true[_offhand].if_false[]>
        - define list <script[lib_core].data_key[block_placing]>
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
        - define unique <util.random_uuid>
        - define wait 1t if:<[wait].exists.not>
        - flag player actionbar:<[unique]>
        - foreach <[list]>:
            - if <player.flag[actionbar].if_null[null]> != <[unique]>:
                - foreach stop
            - actionbar <[value]>
            - wait <[wait]>

#lib_help:
#    type: task
#    definitions: script_name|running_command|is_alias
#    debug: true
#    script:
#        - define width 275
#        - define is_alias <[is_alias].if_null[false]>
#        - define script <script[<[script_name]>]>
#        - define cmd_name <[script].data_key[name]>
#        - define help_text "<element[<gold>Description: <reset><[script].parsed_key[description]>].split_lines_by_width[<[width]>].split[<n>]>"
#        - define alias_for "<[is_alias].if_true[<yellow>Alias for <reset>/<[cmd_name]>].if_false[<empty>]>"
#        - define usage "<element[<gold>Usage: <[script].parsed_key[usage]>].split_lines_by_width[<[width]>].split[<n>]>"
#        - define aliases "<gold>Aliases: <reset>"
#        - foreach <[script].data_key[aliases]>:
#            - define aliases <[aliases]><[value]>,<&sp>
#        - define aliases <[aliases].substring[1,<[aliases].length.sub[2]>].split_lines_by_width[<[width]>].split[<n>]>
#        - define pagination <[help_text].size.add[<[usage].size>].add[<[aliases].size>].div[9].round_up>
#        - define page_counter <[pagination].equals[1].if_true[].if_false[(1/<[pagination]>)]>
#        - define bar "<yellow>--------- <reset>Help: /<[running_command]> <[page_counter]> <yellow>"
#        #bar doesn't split between hyphens, and zwsps don't render correctly in minecraft
#        #we just add one bar at a time until we go over the width, then get rid of the last
#        #bar and go from there
#        - repeat 30:
#            - define bar <[bar]>-
#            - if <[bar].strip_color.text_width> > <[width]>:
#                - define bar <[bar].substring[1,<[bar].length.sub[1]>]>
#                - repeat stop
#        - define lines 9
#        - define result:->:<[bar]>
#        #If command is alias, add "alias for" line
#        - if <[is_alias]>:
#            - define lines:--
#            - define result:->:<[alias_for]>
#        #description lines
#        - define amt <[help_text].size.min[<[lines]>]>
#        - define lines:-:<[amt]>
#        - define result:->:<[help_text].get[1].to[<[amt]>].separated_by[<n>]>
#        #if room, usage
#        - if <[lines]> > 0:
#            - define amt <[usage].size.min[<[lines]>]>
#            - define lines:-:<[amt]>
#            - define result:->:<[usage].get[1].to[<[amt]>].separated_by[<n>]>
#        #if room, aliases
#        - if <[lines]> > 0:
#            - define amt <[aliases].size.min[<[lines]>]>
#            - define lines:-:<[amt]>
#            - define result:->:<[aliases].get[1].to[<[amt]>].separated_by[<n>]>
#        - narrate <[result].separated_by[<n>]>

#under construction
#lib_copyable:
#    type: task
#    debug: true
#    script:
#        - define result b
#        - announce <[result]>