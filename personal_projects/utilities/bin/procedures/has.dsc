#alpha: Returns true if passed string has any alphabetical letters in it. NON-case sensitive
#numeric: Returns true if passed string has any numeric characters in it.
#alphanumeric: Returns true if passed string has any alphanumeric characters in it. NON-case sensitive
#permission: Returns wether a user has a permission based on an internal flag system. Used internally for commands.

lib_has_alpha:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].to_lowercase.contains_any_text[<script[lib_generic_data].data_key[alphabet_set].to_list>]>

lib_has_numeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].contains_any_text[<script[lib_generic_data].data_key[number_set].to_list>]>

lib_has_alphanumeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <proc[lib_has_alpha].context[<[element]>].or[<proc[lib_has_numeric].context[<[element]>]>]>

lib_has_permission:
    type: procedure
    debug: false
    definitions: permission|player
    script:
        - define player <[player].if_null[<player.if_null[null]>]>
        - if <[player].object_type> == Player:
            - define permission_map <player.flag[jlib.permissions].if_null[null]>
            - define has_permission <[permission_map].deep_get[<[permission]>].if_null[false]>
            - if !<[has_permission]>:
                - while <[permission].contains[.]> && !<[has_permission]>:
                    - define permission <[permission].before_last[.]>
                    - define has_permission <[permission_map].deep_get[<[permission]>.*].if_null[false]>
            - determine <[has_permission]>
        - determine false