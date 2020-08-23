has_alpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.contains_any_text[a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z]>

has_numeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.contains_any_text[1|2|3|4|5|6|7|8|9|0]>

has_alphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <proc[has_alpha].context[el].and[<proc[has_numeric].context[el]>]>

is_alpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.matches_character_set[abcdefghijklmnopqrstuvwxyz]>
    
is_numeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.matches_character_set[1234567890]>

is_alphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.matches_character_set[abcdefghijklmnopqrstuvwxyz1234567890]>

as_alpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].trim_to_character_set[ABDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]>

as_numeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].trim_to_character_set[0123456789]>

as_alphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].trim_to_character_set[ABDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789]>

as_nonalpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_list.exclude[<proc[as_alpha].context[<[el]>].to_list.deduplicate>].unseparated>

as_nonnumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_list.exclude[<proc[as_numeric].context[<[el]>].to_list.deduplicate>].unseparated>

as_nonalphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_list.exclude[<proc[as_alphanumeric].context[<[el]>].to_list.deduplicate>].unseparated>

is_valid_ending_puncuation:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].matches_character_set[!.?)]>

first_letter_uppercase:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <tern[<[el].length.is[OR_MORE].than[2]>].pass[<[el].char_at[1].to_uppercase><[el].substring[2]>].fail[<[el]>]>

map_range:
    type: procedure
    definitions: from_min|from_max|to_min|to_max|input
    debug: false
    script:
        - determine <[input].sub[<[from_min]>].mul[<[to_max].sub[<[to_min]>]>].div[<[from_max].sub[<[from_min]>]>].add[<[to_min]>]>

cycle_value:
    type: procedure
    definitions: start|end|input
    debug: false
    script:
        - define delta <[end].sub[<[start]>]>
        - while <[input]> < <[start]> || <[input]> > <[end]>:
            - if <[input]> < <[start]>:
                - define input <[input].add[<[delta]>]>
            - else if <[input]> > <[end]>:
                - define input <[input].sub[<[delta]>]>
        - determine <[input]>

random_color:
    type: procedure
    debug: false
    script:
        - determine <color[255,0,0].with_hue[<util.random.int[0].to[255]>].with_saturation[<util.random.int[100].to[255]>].with_brightness[<util.random.int[100].to[255]>]>

random_pitch:
    type: procedure
    debug: false
    script:
        - determine <util.random.gauss.div[6].add[1]>

make_numeric_list:
    type: procedure
    definitions: size
    debug: false
    script:
        - define num_list <list[]>
        - repeat <[size]>:
            - define num_list <[num_list].include[<[value]>]>
        - determine <[num_list]>