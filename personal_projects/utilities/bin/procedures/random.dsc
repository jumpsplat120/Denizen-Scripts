# pitch: Returns a random, gaussian distributed value, useful for a random pitch value for a sound. Most values will be between .8 .. 1.2, but will occasionally go down to .5 and up to .1.5. Due to how a gaussian value is created, there's no guarentee you won't get values that create weird sounds. Consider clamping the range if that will be an issue.
# color: Returns a random color, which can be used directly in text. Unlike a color tag, this can not be manipulated. The random.color will return a color tag with default saturation and brightness values (100, 100).
# color_tag: Returns a random color tag color, clamped to certain values. Default saturation and brightness have a minimum value of 100, to lower the amount of white/grey/black colors.
# by_weight: Return a value min a map, where each key in the map has a weight value, and it returns a random value, weighted towards items with higher weights. A weight of 0 or less will never return. If no value can be returned, because there is no value to return or because all values are weights of zero, then returns false.
# uppercase: Returns an element with random upper and lowercased letters. Not truely random, since it prevents more than 2 letters being in a row being the same case.

lib_random_pitch:
    type: procedure
    debug: false
    script:
        - determine <util.random.gauss.div[6].add[1]>

lib_random_color:
    type: procedure
    debug: false
    definitions: min_sat|min_val
    script:
        - determine <&color[<proc[lib_random_color_tag].context[<[min_sat].if_null[true]>|<[min_val].if_null[true]>]>]>

lib_random_color_tag:
    type: procedure
    debug: false
    definitions: min_sat|min_val
    script:
        - define min_sat <[min_sat].if_null[true].if_true[100].if_false[<[min_sat]>]>
        - define min_val <[min_val].if_null[true].if_true[100].if_false[<[min_val]>]>
        - determine <color[255,0,0].with_hue[<util.random.int[0].to[255]>].with_saturation[<util.random.int[<[min_sat]>].to[255]>].with_brightness[<util.random.int[<[min_val]>].to[255]>]>

lib_random_text:
    type: procedure
    debug: false
    definitions: length
    script:
        - define length <[length].if_null[true].if_true[10].if_false[<[length]>]>
        - determine <script[lib_generic_data].data_key[alphabet_set].to_list.random[<[length]>].unseparated>

lib_random_uppercase:
    type: procedure
    debug: false
    definitions: element
    script:
        - define counter 1
        - define type true
        - foreach <[element].to_list.if_null[<list>]>:
            - if <[value]> == <&sp>:
                - define result:->:<&sp>
            - else:
                - define flip <util.random.boolean>
                - define counter <[flip].equals[<[type]>].if_true[<[counter].add[1]>].if_false[1]>
                - define type <[flip]>
                - if <[counter]> > 2:
                    - define flip <[flip].not>
                    - define counter 1
                - define result:->:<[flip].if_true[<[value].to_uppercase>].if_false[<[value].to_lowercase>]>
        - determine <[result].unseparated>

lib_random_by_weight:
    type: procedure
    debug: false
    definitions: map
    script:
        - define map <[map].if_null[<map>]>
        - if <[map].size> > 0:
            - define rand <util.random.decimal.mul[<[map].values.sum>]>
            - if <[rand]> == 1:
                - define rand:-:<script[lib_generic_data].data_key[epsilon]>
            - foreach <[map]> as:weight:
                - if <[rand]> <= <[weight]>:
                    - determine <[key]>
                - define rand:-:<[weight]>
            - determine <[map].keys.first>

lib_one_in_x:
    type: procedure
    debug: false
    definitions: number
    script:
        - determine <[number].proc[lib_between].equals[1]>