# alpha: Returns true if passed string is only composed of alphabetical characters. NON-case sensitive
# numeric: Checks if a value is numeric. This is simply here for completeness; is_numeric is simply a wrapper for the standard tag .is_decimal, and using this tag will throw a warning in the console about it.
# alphanumeric: Returns true if passed string is only composed of alphanumeric characters. NON-case sensitive
# player: Checks that the passed element is a player object. Returns false on any other object type.

lib_is_alpha:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].to_lowercase.matches_character_set[<script[lib_generic_data].data_key[alphabet_set]>]>

lib_is_numeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - announce to_console "<yellow>NOTE: is.numeric is ONLY a wrapper for '<&lt>elementTag.is_integer<&gt>'!"
        - determine <[element].is_integer>

lib_is_alphanumeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].to_lowercase.matches_character_set[<[lib_data].data_key[alphabet_set]><[lib_data].data_key[number_set]>]>

lib_is_player:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].object_type.equals[Player]>