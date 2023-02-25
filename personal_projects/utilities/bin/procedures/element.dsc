rainbow_text:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define text   <[args.text].if_null[]>
        - define color  <[args.color].if_null[]>
        - define offset <[args.offset].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define text   <[args].if_null[<[null]>]> if:<[text].equals[]>
        - define color  <proc[random_color_tag]>   if:<[color].equals[]>
        - define offset 15                         if:<[offset].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[text|<[null]>|<[text]>|<queue>]>
        - define error <proc[error_type_check].context[text|element|<[text]>|<queue>]>     if:<[error].not>
        - define error <proc[error_type_check].context[color|color|<[color]>|<queue>]>     if:<[error].not>
        - define error <proc[error_type_check].context[offset|element|<[offset]>|<queue>]> if:<[error].not>
        - define error <proc[error_number_check].context[offset|<[offset]>|<queue>]>       if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define hue <[color].hue>
        - foreach <[text].to_list> as:chr:
            - define result:->:<&color[<[color].with_hue[<[hue]>]>]><[chr]>
            - define hue:+:<[offset]>
        - determine <[result].unseparated>
    data:
        args:
            text:
                type: elementTag
                description: The text you want to make rainbow.
                required: true
            color:
                type: colorTag
                description: The starting color of the rainbow text. If no starting color is defined, then it will instead use a random color.
                required: false
            offset:
                type: elementTag
                description: A number that is used to cycle through the hues. So the first character will have the same color as 'color', while the second character would have 'color.hue = color.hue + offset'. If no offset is specified, defaults to 15.
                required: false
        description: Returns the passed text with rainbow coloring.
        determines: elementTag
        usage:
            - narrate "<element[Here is some rainbow text, using the default values.].proc[rainbow_text]>"
            - narrate "<proc[rainbow_text].context[text=Here is some rainbow text, adjusting the available parameters.;color=green;increment=5]>"

animated_rainbow_text:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define text   <[args.text].if_null[]>
        - define color  <[args.color].if_null[]>
        - define offset <[args.offset].if_null[]>
        - define speed  <[args.speed].if_null[]>
        - define length <[args.length].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define text  <[args].if_null[<[null]>]> if:<[text].equals[]>
        - define color <proc[random_color_tag]>   if:<[color].equals[]>
        - define offset 15                        if:<[offset].equals[]>
        - define speed  5                         if:<[speed].equals[]>
        - define length 60                        if:<[length].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[text|<[null]>|<[text]>|<queue>]>
        - define error <proc[error_type_check].context[text|element|<[text]>|<queue>]>     if:<[error].not>
        - define error <proc[error_type_check].context[color|color|<[color]>|<queue>]>     if:<[error].not>
        - define error <proc[error_type_check].context[offset|element|<[offset]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[speed|element|<[speed]>|<queue>]>   if:<[error].not>
        - define error <proc[error_type_check].context[length|element|<[length]>|<queue>]> if:<[error].not>
        - define error <proc[error_number_check].context[offset|<[offset]>|<queue>]>       if:<[error].not>
        - define error <proc[error_number_check].context[speed|<[speed]>|<queue>]>         if:<[error].not>
        - define error <proc[error_number_check].context[length|<[length]>|<queue>]>       if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define hue <[color].hue>
        - repeat <[length]>:
            - define result:->:<proc[rainbow_text].context[text=<[text]>;color=<[color].with_hue[<[hue]>]>;increment=<[offset]>]>
            - define hue:+:<[speed]>
        - determine <[result]>
    data:
        args:
            text:
                type: elementTag
                description: The text you want to animate.
                required: true
            color:
                type: colorTag
                description: The starting color of the rainbow text. If no starting color is defined, then it will instead use a random color.
                required: false
            offset:
                type: elementTag
                description: A number that is used to cycle through the hues. So the first character will have the same color as 'color', while the second character would have 'color.hue = color.hue + offset'. If no offset is specified, defaults to 15.
                required: false
            speed:
                type: elementTag
                description: A number that is used to animate the rate of change for the animation. The larger this number, the faster the color will animate. If no number is provided, defaults to 5.
                required: false
            length:
                type: elementTag
                description: The length of the resulting listTag. The larger this number is, the more "frames" your animation has. If no number is provided, defaults to 60.
                required: false
        description: Returns a list of entries, where each entry in the list is the text with rainbow coloring, using the passed values. Each entry's hue is slightly offset by 'speed'. When the list is iterated through quickly, it appears as though the text's colors are animating.
        determines: listTag<&gt>elementTag<&lt>
        usage:
            - foreach "<element[This text will be animated, using the default values.].proc[animated_rainbow_text]>":
                - actionbar <[value]>
                - wait 1t

instances_of_element:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define text   <[args.text].if_null[]>
        - define search <[args.search].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define text <[null]>   if:<[text].equals[]>
        - define search <[null]> if:<[search].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[text|<[null]>|<[text]>|<queue>]>
        - define error <proc[error_missing_check].context[search|<[null]>|<[search]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[text|element|<[text]>|<queue>]>         if:<[error].not>
        - define error <proc[error_type_check].context[search|element|<[search]>|<queue>]>     if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine 0 if:<[text].equals[]>
        - determine 0 if:<[search].equals[]>
        - determine <[text].split[<[search]>].size.sub[1]>
    data:
        args:
            text:
                type: elementTag
                description: The text you want to search through.
                required: true
            search:
                type: elementTag
                description: The text you're looking to count.
                required: true
        description: Returns the amount of times the search appears in a body of text.
        determines: elementTag
        usage:
            - narrate "<element[The text 'hello' has <gray><proc[instances_of_element].context[text=hello;search=l]><reset> instances of the letter 'l'.]>"
            - narrate "<element[The text 'the green the alien the has the habit the of saying the word the quite often.' has <gray><proc[instances_of_element].context[text=the green the alien the has the habit the of saying the word the quite often.;search=the]><reset> instances of the word 'the'.]>"

flipped_case:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define text <[args.text].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define text <[args].if_null[<[null]>]> if:<[text].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[text|<[null]>|<[text]>|<queue>]>
        - define error <proc[error_type_check].context[text|element|<[text]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[text].to_list.parse_tag[<[parse_value].is_uppercase.if_true[<[parse_value].to_lowercase>].if_false[<[parse_value].to_uppercase>]>].unseparated>
    data:
        args:
            text:
                type: elementTag
                description: The text you want to search through.
                required: true
        description: Returns the opposite case of whatever each character's case is. Uppercase becomes lowercase, and lowercase becomes uppercase.
        determines: elementTag
        usage:
            - narrate "This is a sentence with regular casing, followed by the FLIPPED CASE version."
            - narrate "<element[This is a sentence with regular casing, followed by the FLIPPED CASE version.].proc[flipped_case]>"