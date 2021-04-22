# alpha: Returns the string as the passed value trimmed down only to alphabetical characters.
# numeric: Returns the string as the passed value trimmed down only to numeric characters.
# alphanumeric: Returns the string as the passed value trimmed down only to alphanumeric characters.
# nonalpha: Returns the string as the passed value trimmed down only to non-alphabetic characters.
# nonnumeric: Returns the string as the passed value trimmed down only to non-numeric characters.
# nonalphanumeric: Returns the string as the passed value trimmed down only to non-alphanumeric characters.

lib_as_alpha:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].trim_to_character_set[<script[lib_generic_data].data_key[alphabet_set].to_uppercase><script[lib_generic_data].data_key[alphabet_set]>]>

lib_as_numeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].trim_to_character_set[<script[lib_generic_data].data_key[number_set]>]>

lib_as_alphanumeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].trim_to_character_set[<script[lib_generic_data].data_key[alphabet_set].to_uppercase><script[lib_generic_data].data_key[alphabet_set]><script[lib_generic_data].data_key[number_set]>]>

lib_as_nonalpha:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].to_list.exclude[<script[lib_generic_data].data_key[alphabet_set].to_uppercase.to_list.include[<script[lib_generic_data].data_key[alphabet_set].to_list>]>].unseparated>

lib_as_nonnumeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].to_list.exclude[<script[lib_generic_data].data_key[number_set].to_list>].unseparated>

lib_as_nonalphanumeric:
    type: procedure
    debug: false
    definitions: element
    script:
        - determine <[element].to_list.exclude[<script[lib_generic_data].data_key[alphabet_set].to_uppercase.to_list.include[<script[lib_generic_data].data_key[alphabet_set].to_list>].include[<script[lib_generic_data].data_key[number_set].to_list>]>].unseparated>
