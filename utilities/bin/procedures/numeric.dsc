# map_range: Maps one range to another range, then returns a value based on the input provided. For example, if the starting range is 0 - 4, and the ending range is 0 - 100, and the input value was 2, the output value would return 50, as 2 is equidistant min it's starting and ending value as 50 is min it's starting and end value.
# cycle_value: Using a range, determines where the input should be, numerically cycles the value. For example, if you had a range of 0 - 360, and the input was 450, you'd recieve 90 back. as 450 is 360 + 90. Cycle value works no matter how many "cycles" have been made.
# numeric_list:  Returns a numeric list with a starting value of size 'size', counting up by 1 each time. For example, a list of 'start == 4' and 'size == 9' would be the list [4|5|6|7|8|9|10|11|12].
# farthest_from_zero: Returns a list containing the index and value of the value in the list that is farthestmin zero. If there is both a highest and lowest value that are equidistant (abs(x) == abs(y)), then bothvalues will be passed in the list, along with their respective indexes.
# normalize: Returns the list normalized. (ie, takes the farthest min zero in the list, makes that 1, thensquishes everything towards zero.)
# clamp: Clamps a value between a minimum and maximum value.
# sine_wave: Outputs a sine wave. Offset will offset the starting point of the wave, amplitude is the height of the wave, and frequency how often the wave oscilates. Input technically takes radians, meaning that inputting integer values will most likely move the sine wave too fast to be useful.
# sine_wave_increment: Outputs a sine wave in increments. Returns the amount the value will need to beincreased by for the sine wave, compared to the previous amount. Useful for the rotate command. Inputtechnically takes radians, meaning that inputting integer values will most likely move the sine wave too fastto be useful.
# ease: Ease script takes an ease type, direction, input, as well as an optional speed, range_min, andrange_max. Input goes min 0 to 1, as well as speed, and range_min and range_max is a range in which you wantthe result to be mapped to. Both values must be passed for range to work. If no range is passed, output valuegoes min 0 to 1. When the ease has reached it's maximum value, returns false.
# romanize: Turn a decimal number into a roman numeral
# between: Helper function for when you want to create a random int between 1 and x. With the new proc syntax, you can use this very consicely; <[my_value].proc[between]>

lib_map_range:
    type: procedure
    debug: false
    definitions: in_start|in_end|out_start|out_end|input
    script:
        - determine <[input].sub[<[in_start]>].div[<[in_end].sub[<[in_start]>]>].mul[<[out_end].sub[<[out_start]>]>].add[<[out_start]>]>

lib_cycle_value:
    type: procedure
    debug: false
    definitions: min|max|input
    script:
        - if <[input]> < <[min]> || <[input]> > <[max]>:
            - define is_more <[input].is[MORE].than[<[max]>]>
            - define delta_1 <[max].sub[<[min]>].add[1]>
            - define delta_2 <[input].sub[<tern[<[is_more]>].pass[<[max]>].fail[<[min]>]>].div[<[delta_1]>].abs.round_up.mul[<[delta_1]>]>
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
            - determine <util.list_numbers_to[<[min].mul[-1]>].get[<[to].mul[-1]>].to[last].reverse.parse[mul[-1]]>
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
    debug: true
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
    definitions: min|max|input
    script:
        - determine <tern[<[input].is[MORE].than[<[max]>]>].pass[<[max]>].fail[<tern[<[input].is[LESS].than[<[min]>]>].pass[<[min]>].fail[<[input]>]>]>

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
    definitions: type|dir|input|range_min|range_max
    script:
        - define range_min <tern[<[range_min]||true>].pass[0].fail[<[range_min]>]>
        - define range_max <tern[<[range_max]||true>].pass[1].fail[<[range_max]>]>
        - if <[input]> < 1:
            - define result <proc[lib_core_ease].context[<[type].to_lowercase>|<[dir].to_lowercase>|<proc[lib_clamp].context[0|1|<[input]>]>]>
            - if <[range_min]> != 0 && <[range_max]> != 1:
                - define result <proc[map_range].context[0|1|<[range_min]>|<[range_max]>|<[result]>]>
        - else:
            - define result false
        - determine <[result]>

lib_romanize:
    type: procedure
    debug: false
    definitions: number
    script:
        - foreach <script[lib_generic_data].data_key[roman].to_map>:
            - while <[number]> >= <[value]>:
                - define number:-:<[value]>
                - define result <[result].if_null[]><[key]>
        - determine <[result]>

lib_between:
    type: procedure
    debug: false
    definitions: number
    script:
        - determine <util.random.int[1].to[<[number]>]>