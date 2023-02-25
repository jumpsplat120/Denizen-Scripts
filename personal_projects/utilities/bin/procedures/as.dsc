as_alpha:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].if_null[].to_lowercase.trim_to_character_set[abcdefghijklmnopqrstuvwxyz]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to modify.
                required: true
        description: Returns the element as the passed value trimmed down only to alphabetical characters.
        determines: elementTag
        usage:
            - narrate "The following sentence of 13 words, being trimmed to only the alphabetical characters."
            - narrate "<element[The following sentence of 13 words, being trimmed to only the alphabetical characters.].proc[as_alpha]>"

as_numeric:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].trim_to_character_set[0123456789]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to modify.
                required: true
        description: Returns the element as the passed value trimmed down only to numeric characters.
        determines: elementTag
        usage:
            - narrate "The following sentence of 13 words, being trimmed to only the numeric characters."
            - narrate "<element[The following sentence of 13 words, being trimmed to only the numeric characters.].proc[as_numeric]>"

as_alphanumeric:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].to_lowercase.trim_to_character_set[abcdefghijklmnopqrstuvwxyz0123456789]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to modify.
                required: true
        description: Returns the element as the passed value trimmed down only to alphanumeric characters.
        determines: elementTag
        usage:
            - narrate "The following sentence of 13 words, being trimmed to only the alphanumeric characters."
            - narrate "<element[The following sentence of 13 words, being trimmed to only the alphanumeric characters.].proc[as_alphanumeric]>"

as_nonalpha:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].to_list.exclude[a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z].unseparated>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to modify.
                required: true
        description: Returns the element as the passed value trimmed down only to non-alphabetic characters.
        determines: elementTag
        usage:
            - narrate "The following sentence of 13 words, being trimmed to only the non-alphabetic characters."
            - narrate "<element[The following sentence of 13 words, being trimmed to only the non-alphabetic characters.].proc[as_nonalpha]>"

as_nonnumeric:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].to_list.exclude[0|1|2|3|4|5|6|7|8|9].unseparated>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to modify.
                required: true
        description: Returns the element as the passed value trimmed down only to non-numeric characters.
        determines: elementTag
        usage:
            - narrate "The following sentence of 13 words, being trimmed to only the non-numeric characters."
            - narrate "<element[The following sentence of 13 words, being trimmed to only the non-numeric characters.].proc[as_nonnumeric]>"

as_nonalphanumeric:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[args.element].to_list.exclude[a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z|0|1|2|3|4|5|6|7|8|9].unseparated>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to modify.
                required: true
        description: Returns the element as the passed value trimmed down only to non-alphanumeric characters.
        determines: elementTag
        usage:
            - narrate "The following sentence of 13 words, being trimmed to only the non-alphanumeric characters."
            - narrate "<element[The following sentence of 13 words, being trimmed to only the non-alphanumeric characters.].proc[as_nonalphanumeric]>"