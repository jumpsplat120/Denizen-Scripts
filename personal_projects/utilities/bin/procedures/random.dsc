# pitch: Returns a random, gaussian distributed value, useful for a random pitch value for a sound. Most values will be between .8 .. 1.2, but will occasionally go down to .5 and up to .1.5. Due to how a gaussian value is created, there's no guarentee you won't get values that create weird sounds. Consider clamping the range if that will be an issue.
# color: Returns a random color, which can be used directly in text. Unlike a color tag, this can not be manipulated. The random.color will return a color tag with default saturation and brightness values (100, 100).
# color_tag: Returns a random color tag color, clamped to certain values. Default saturation and brightness have a minimum value of 100, to lower the amount of white/grey/black colors.
# by_weight: Return a value min a map, where each key in the map has a weight value, and it returns a random value, weighted towards items with higher weights. A weight of 0 or less will never return. If no value can be returned, because there is no value to return or because all values are weights of zero, then returns false.
# uppercase: Returns an element with random upper and lowercased letters. Not truely random, since it prevents more than 2 letters being in a row being the same case.

random_pitch:
    type: procedure
    debug: false
    script:
        - determine <util.random_gauss.div[6].add[1]>

random_color:
    type: procedure
    debug: false
    definitions: map
    script:
        - define map <[map].as_map.if_null[<map>]>
        - define map <[map].default[min_hue].as[0]>
        - define map <[map].default[max_hue].as[255]>
        - define map <[map].default[min_saturation].as[100]>
        - define map <[map].default[min_value].as[100]>
        - define map <[map].default[max_saturation].as[255]>
        - define map <[map].default[max_value].as[255]>
        - determine <&color[<[map].proc[random_color_tag]>]>
    data:
        description: Returns a random &color tag, which can be used directly in text. Unlike a color tag, this can not be manipulated with standard colortag tags. By default, the minimum saturation/value are 100, and the maximum saturation/value are 255, while the min hue is 0, and max is 255, allowing the full spectrum.
        usage:
            - narrate "<proc[random_color]>This text is randomly colored using the default values."
            - narrate "<proc[random_color].context[min_hue=50;max_hue=100;min_saturation=200;max_saturation=225;min_value=50;max_value=75]>This text is randomly colored with manually set min/max saturations and values."

random_color_tag:
    type: procedure
    debug: false
    definitions: min_sat|min_val
    script:
        - define min_sat <[min_sat].if_null[true].if_true[100].if_false[<[min_sat]>]>
        - define min_val <[min_val].if_null[true].if_true[100].if_false[<[min_val]>]>
        - determine <color[255,0,0].with_hue[<util.random.int[0].to[255]>].with_saturation[<util.random.int[<[min_sat]>].to[255]>].with_brightness[<util.random.int[<[min_val]>].to[255]>]>

random_text:
    type: procedure
    debug: false
    definitions: length
    script:
        - define length <[length].if_null[true].if_true[10].if_false[<[length]>]>
        - determine <script[lib_core].data_key[alphabet_set].to_list.random[<[length]>].unseparated>

random_uppercase:
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
                - define flip <util.random_boolean>
                - define counter <[flip].equals[<[type]>].if_true[<[counter].add[1]>].if_false[1]>
                - define type <[flip]>
                - if <[counter]> > 2:
                    - define flip <[flip].not>
                    - define counter 1
                - define result:->:<[flip].if_true[<[value].to_uppercase>].if_false[<[value].to_lowercase>]>
        - determine <[result].unseparated>

random_by_weight:
    type: procedure
    debug: false
    definitions: map
    script:
        - define map <[map].if_null[<map>]>
        - if <[map].size> > 0:
            - define rand <util.random_decimal.mul[<[map].values.sum>]>
            - if <[rand]> == 1:
                - define rand:-:<script[lib_core].data_key[epsilon]>
            - foreach <[map]> as:weight:
                - if <[rand]> <= <[weight]>:
                    - determine <[key]>
                - define rand:-:<[weight]>
            - determine <[map].keys.first>

one_in_x:
    type: procedure
    debug: false
    definitions: number
    script:
        - determine <util.random.int[1].to[<[number]>].equals[1]>