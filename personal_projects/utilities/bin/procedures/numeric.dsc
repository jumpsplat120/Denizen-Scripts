# map_range: Maps one range to another range, then returns a value based on the input provided. For example, if the starting range is 0 - 4, and the ending range is 0 - 100, and the input value was 2, the output value would return 50, as 2 is equidistant min it's starting and ending value as 50 is min it's starting and end value.
# cycle_value: Using a range, determines where the input should be, numerically cycles the value. For example, if you had a range of 0 - 360, and the input was 450, you'd recieve 90 back. as 450 is 360 + 90. Cycle value works no matter how many "cycles" have been made.
# numeric_list:  Returns a numeric list with a starting value of size 'size', counting up by 1 each time. For example, a list of 'start == 4' and 'size == 9' would be the list [4|5|6|7|8|9|10|11|12].
# farthest_from_zero: Returns a list containing the index and value of the value in the list that is farthestmin zero. If there is both a highest and lowest value that are equidistant (abs(x) == abs(y)), then bothvalues will be passed in the list, along with their respective indexes.
# normalize: Returns the list normalized. (ie, takes the farthest min zero in the list, makes that 1, thensquishes everything towards zero.)
# clamp: Clamps a value between a minimum and maximum value.
# sine_wave: Outputs a sine wave. Offset will offset the starting point of the wave, amplitude is the height of the wave, and frequency how often the wave oscilates. Input technically takes radians, meaning that inputting integer values will most likely move the sine wave too fast to be useful.
# sine_wave_increment: Outputs a sine wave in increments. Returns the amount the value will need to beincreased by for the sine wave, compared to the previous amount. Useful for the rotate command. Inputtechnically takes radians, meaning that inputting integer values will most likely move the sine wave too fastto be useful.
# ease: Ease script takes an ease type, direction, input, as well as an optional speed, range_min, and range_max. Input goes min 0 to 1, as well as speed, and range_min and range_max is a range in which you want the result to be mapped to. Both values must be passed for range to work. If no range is passed, output value goes min 0 to 1. When the ease has reached it's maximum value, returns false.
# romanize: Turn a decimal number into a roman numeral
# between: Helper function for when you want to create a random int between 1 and x. With the new proc syntax, you can use this very consicely; <[my_value].proc[between]>
# ordinal: Takes a number, like 5 or 104, and adds the st/nd/rd/th that would follow it. 5 -> 5th
# vanilla_breaking_time: Pass an item in, as well as the location of the block to determine how long it would take to break that item with the tool in hand.
# custom_breaking_time: Calculate a custom breaking time following Minecraft block breaking logic, based on the passed item, hardness of the block, and a map of valid tool_types. The map of valid tool_types should be formatted with the tool type as the key name, and the multiplier as the value.
# round_to: round to a specific number

lib_map_range:
    type: procedure
    debug: false
    definitions: input|in_start|in_end|out_start|out_end
    script:
        - determine <[input].sub[<[in_start]>].div[<[in_end].sub[<[in_start]>]>].mul[<[out_end].sub[<[out_start]>]>].add[<[out_start]>]>

lib_cycle_value:
    type: procedure
    debug: false
    definitions: input|min|max
    script:
        - if <[input]> < <[min]> || <[input]> > <[max]>:
            - define is_more <[input].is[MORE].than[<[max]>]>
            - define delta_1 <[max].sub[<[min]>].add[1]>
            - define delta_2 <[input].sub[<[is_more].if_true[<[max]>].if_false[<[min]>]>].div[<[delta_1]>].abs.round_up.mul[<[delta_1]>]>
            - determine <tern[<[is_more]>].pass[<[input].sub[<[delta_2]>]>].fail[<[input].add[<[delta_2]>]>]>
        - else:
            - determine <[input]>

lib_numeric_list:
    type: procedure
    debug: false
    definitions: min|max
    script:
        - if <[max]> < 0:
            #! -x -> -y
            - determine <util.list_numbers_to[<[min].mul[-1]>].get[<[max].mul[-1]>].to[last].reverse.parse[mul[-1]]>
        - else if <[max]> == 0 && <[min]> < 0:
            #! -x -> 0
            - determine <util.list_numbers_to[<[min].mul[-1]>].reverse.include[0].parse[mul[-1]]>
        - else if <[max]> > 0 && <[min]> < 0:
            #! -x -> +y
            - determine <util.list_numbers_to[<[min].mul[-1]>].reverse.include[0].parse[mul[-1]].include[<util.list_numbers_to[<[max]>]>]>
        - else if <[max]> == 0 && <[min]> == 0:
            #! 0 -> 0
            - determine <list[0]>
        - else if <[min]> == 0:
            #! 0 -> +y
            - determine <list[0].include[<util.list_numbers_to[<[max]>]>]>
        - else:
            #! +x -> +y
            - determine <util.list_numbers_to[<[max]>].get[<[min]>].to[<[max]>]>

lib_farthest_from_zero:
    type: procedure
    debug: false
    definitions: list_single
    script:
        - define list <[list_single].as_list>
        - define highest <[list].highest>
        - define lowest <[list].lowest>
        - define highest_abs <[highest].abs>
        - define lowest_abs <[lowest].abs>
        - determine <tern[<[highest_abs].is[==].to[<[lowest_abs]>]>].pass[<list[<[highest]>|<[lowest]>]>].fail[<tern[<[highest_abs].is[MORE].than[<[lowest_abs]>]>].pass[<list[<[highest]>|false]>].fail[<list[false|<[lowest]>]>]>]>

lib_normalize:
    type: procedure
    debug: false
    definitions: list_single
    script:
        - define list <[list_single].as_list>
        - define farthest_list <proc[lib_farthest_from_zero].context[<[list]>]>
        - determine <[list].parse[div[<[farthest_list].first.abs>]]>

lib_clamp:
    type: procedure
    debug: false
    definitions: input|min|max
    script:
        - determine <[input].min[<[max]>].max[<[min]>]>

lib_sine_wave:
    type: procedure
    debug: false
    definitions: input|offset|amplitude|frequency
    script:
        - define offset <tern[<[offset]||true>].pass[0].fail[<[offset]>]>
        - define amplitude <tern[<[amplitude]||true>].pass[1].fail[<[amplitude]>]>
        - define frequency <tern[<[frequency]||true>].pass[1].fail[<[frequency]>]>
        - determine <[input].add[<[offset]>].mul[<[frequency]>].sin.mul[<[amplitude]>]>

lib_sine_wave_increment:
    type: procedure
    debug: false
    definitions: input|offset|amplitude|frequency
    script:
        - define offset <tern[<[offset]||true>].pass[0].fail[<[offset]>]>
        - define amplitude <tern[<[amplitude]||true>].pass[1].fail[<[amplitude]>]>
        - define frequency <tern[<[frequency]||true>].pass[1].fail[<[frequency]>]>
        - determine <proc[sine_wave].context[<[input]>|<[offset]>|<[amplitude]>|<[frequency]>].sub[<proc[sine_wave].context[<[input].sub[<[frequency]>]>|<[offset]>|<[amplitude]>|<[frequency]>]>]>

lib_ease:
    type: procedure
    debug: false
    definitions: input|type|dir|range_min|range_max
    script:
        - define range_min <tern[<[range_min]||true>].pass[0].fail[<[range_min]>]>
        - define range_max <tern[<[range_max]||true>].pass[1].fail[<[range_max]>]>
        - if <[input]> < 1:
            - define result <proc[lib_core_ease].context[<[type].to_lowercase>|<[dir].to_lowercase>|<proc[lib_clamp].context[<[input]>|0|1]>]>
            - if <[range_min]> != 0 || <[range_max]> != 1:
                - define result <[result].proc[lib_map_range].context[0|1|<[range_min]>|<[range_max]>]>
        - else:
            - define result <[range_max].if_null[1]>
        - determine <[result]>

lib_catmull_rom_spline:
    type: procedure
    debug: false
    definitions: points|density|tension
    script:
        - define density 100 if:<[density].exists.not>
        - define tension 0.5 if:<[tension].exists.not>
        - if !<[density].is_integer>:
            - debug error "Density must be an integer."
        - else if !<[tension].is_decimal>:
            - debug error "Constant must be a number."
        #- else if <[tension]> > 1:
        #    - debug error "Constant must be less than or equal to 1."
        #- else if <[tension]> < 0:
        #    - debug error "Constant must be greater than or equal to 0."
        - else if !<[points].exists>:
            - debug error "There must be a list of points for a catmull spline."
        - else if <[points].filter[object_type.equals[location].not].size> > 0:
            - debug error "Your list of points must contain only location tags."
        - else if <[points].filter[world.equals[<[points].first.world>].not].size> > 0:
            - debug error "Your list of points must contain only locations from the same world."
        - else if <[points].size> < 2:
            - debug error "There must be at least 2 points for a catmull spline."
        - else if <[points].size> == 2:
            - determine <[points].first.points_between[<[points].last>].distance[<[points].first.distance[<[points].last>].div[<[density]>]>]>
        - else:
            # Pad spline with an extra point if there's only three points, since a catmull spline requires at least 4 points.
            - define points:->:<[points].last.add[0.000001,0.000001,0.000001]> if:<[points].size.equals[3]>
            # Pad beginning and end of spline with an extra point so that all points passed in by player are included.
            - define points    <[points].insert[<[points].first.sub[0.000001,0.000001,0.000001]>].at[1]>
            - define points:->:<[points].last.add[0.000001,0.000001,0.000001]>
            # Amount of times we need to run the catmull proc
            - define size      <[points].size.sub[3]>
            # Density per run of the catmull proc, based on the amount of runs, and the total amount of points requested.
            - define density   <[density].div[<[size]>].round>
            - repeat <[size]>:
                - define result:|:<proc[lib_core_catmull_rom_spline].context[<[points].get[<[value]>]>|<[points].get[<[value].add[1]>]>|<[points].get[<[value].add[2]>]>|<[points].get[<[value].add[3]>]>|<[density]>|<[tension]>]>
            - determine <[result]>

lib_romanize:
    type: procedure
    debug: false
    definitions: number
    script:
        - foreach <script[lib_core].data_key[roman].to_map>:
            - while <[number]> >= <[value]>:
                - define number:-:<[value]>
                - define result <[result].if_null[]><[key]>
        - determine <[result]>

lib_lerp_numeric:
    type: procedure
    debug: false
    definitions: from|to|percentage
    script:
        - determine <[percentage].mul[<[to].sub[<[from]>]>].add[<[from]>]>

lib_ordinal:
    type: procedure
    debug: false
    definitions: number
    script:
        - determine <[number]><[number].is_more_than[10].and[<[number].is_less_than[20]>].if_true[th].if_false[<[number].char_at[<[number].length>].equals[1].if_true[st].if_false[<[number].char_at[<[number].length>].equals[2].if_true[nd].if_false[<[number].char_at[<[number].length>].equals[3].if_true[rd].if_false[th]>]>]>]>

lib_vanilla_breaking_time:
    type: procedure
    debug: false
    definitions: item|location
    script:
        - define loc_material <[location].material>
        - define hardness     <[loc_material].hardness>
        - if <[hardness]> == -1:
            - determine <util.int_max>
        - else if <[hardness]> == 0:
            - determine 0
        - else:
            - define mat_name <[item].material.name>
            - if <[mat_name]> == air:
                - define speed 1
            - else:
                - define tool_type <[mat_name].after_last[_]>
                - define tool_type <[mat_name]> if:<[tool_type].equals[<empty>]>
                - if <[tool_type]> == sword:
                    - if <[loc_material].name> == cobweb:
                        - define speed 15
                        - define can_harvest true
                    - else:
                        - define speed 1.5
                - else if <[tool_type]> == shears:
                    - if <[loc_material].advanced_matches[cobweb|*leaves]>:
                        - define speed 15
                        - define can_harvest true
                    - else if <[loc_material].advanced_matches[*wool]>:
                        - define speed 5
                        - define can_harvest true
                    - else:
                        - define speed 1.5
                - else if <[loc_material]> in <server.vanilla_tagged_materials[mineable/<[tool_type]>].if_null[<list>]>:
                    - define speed <script[lib_core].data_key[tool_speed.<[mat_name].before[_]>]>
                    - define can_harvest true
                - else:
                    - define speed 1
            - define can_harvest <[location].drops[<[item]>].is_empty.not> if:<[can_harvest].exists.not>
            - define efficiency_lvl <[item].enchantment_map.get[efficiency].if_null[0]>
            - if <[can_harvest]> and <[efficiency_lvl]> > 0:
                - define speed:+:<[efficiency_lvl].mul[<[efficiency_lvl]>].add[1]>
            - if <player.has_effect[fast_digging]>:
                - define speed:*:<player.list_effects.filter[starts_with[fast_digging]].first.after[,].before[,].mul[0.2].add[1]>
            - if <player.has_effect[slow_digging]>:
                - define level <player.list_effects.filter[starts_with[slow_digging]].first.after[,].before[,]>
                - define speed:*:<[level].equals[0].if_true[0.3].if_false[<[level].equals[1].if_true[0.09].if_false[<[level].equals[2].if_true[0.0027].if_false[0.00081]>]>]>
            - if <player.eye_location.material.advanced_matches[*water]> and !<player.equipment_map.get[helmet].if_null[false].enchantment_map.get[aqua_affinity].exists>:
                - define speed:/:5
            - if !<player.is_on_ground>:
                - define speed:/:5
            - define damage <[speed].div[<[loc_material].hardness>].mul[<[can_harvest].if_true[0.0333333].if_false[0.01]>]>
            - determine 0 if:<[damage].is_more_than[1]>
            - determine <element[1].div[<[damage]>].round_up.div[20]>

# [input=#,to=#]
lib_round_to:
    type: procedure
    debug: false
    definitions: map
    script:
        - define map <[map].as_map>
        - determine <[map.input].div[<[map.to]>].round.mul[<[map.to]>]>