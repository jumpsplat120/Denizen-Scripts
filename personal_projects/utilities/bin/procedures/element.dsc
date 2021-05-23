# flipped_case: Returns the opposite case of whatever each character's case is. Uppercase becomes lowercase, and lowercase becomes uppercase.
# rainbow_text: Returns the passed text with rainbow coloring. The first letter starts with 'start_color', or red if none specified, and increments by a hue of 'increment', or 15 if none specified. start_color MUST be a colortag.
# animated_rainbow_text: Returns a list containing the passed text with rainbow coloring, where each entry in the list has the colors offset by "increment". When the list is iterated through quickly, it appears as though the text's colors are animating.
# instances_of_character: Returns the amount of times the search appears in a body of text.

lib_rainbow_text:
    type: procedure
    debug: false
    definitions: text|color|increment
    script:
        - define increment <tern[<[increment].if_null[true]>].pass[15].fail[<[increment]>]>
        - define color <tern[<[color]||true>].pass[<proc[lib_random_color_tag]>].fail[<[color]>]>
        - foreach <[text].to_list> as:chr:
            - define result:->:<&color[<[color]>]><[chr]>
            - define color <[color].with_hue[<[color].hue.add[<[increment]>]>]>
        - determine <[result].unseparated>

lib_animated_rainbow_text:
    type: procedure
    debug: false
    definitions: text|color|text_increment|delta_increment|length
    script:
        - define delta_increment <[delta_increment].if_null[true].if_true[15].if_false[<[delta_increment]>]>
        - define text_increment <[text_increment].if_null[true].if_true[15].if_false[<[text_increment]>]>
        - define length <tern[<[length]||true>].pass[20].fail[<[length]>]>
        - define color <tern[<[color]||true>].pass[<proc[lib_random_color_tag]>].fail[<[color]>]>
        - define increment_counter 0
        - repeat <[length]>:
            - define result:->:<proc[lib_rainbow_text].context[<[text]>|<[color].with_hue[<[color].hue.add[<[increment_counter]>]>]>|<[text_increment]>]>
            - define increment_counter:+:<[delta_increment]>
        - determine <[result]>

lib_instances_of_character:
    type: procedure
    debug: false
    definitions: text|search
    script:
        - determine <[text].trim_to_character_set[<[search]>].length>

lib_flipped_case:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].to_list.parse_tag[<tern[<[parse_value].is_uppercase>].pass[<[parse_value].to_lowercase>].fail[<[parse_value]>]>].unseparated>