# --------------------PREMADE DATA-------------------- #

j_generic_data:
    type: data
    long_number_array:
        - -100
        - -99
        - -98
        - -97
        - -96
        - -95
        - -94
        - -93
        - -92
        - -91
        - -90
        - -89
        - -88
        - -87
        - -86
        - -85
        - -84
        - -83
        - -82
        - -81
        - -80
        - -79
        - -78
        - -77
        - -76
        - -75
        - -74
        - -73
        - -72
        - -71
        - -70
        - -69
        - -68
        - -67
        - -66
        - -65
        - -64
        - -63
        - -62
        - -61
        - -60
        - -59
        - -58
        - -57
        - -56
        - -55
        - -54
        - -53
        - -52
        - -51
        - -50
        - -49
        - -48
        - -47
        - -46
        - -45
        - -44
        - -43
        - -42
        - -41
        - -40
        - -39
        - -38
        - -37
        - -36
        - -35
        - -34
        - -33
        - -32
        - -31
        - -30
        - -29
        - -28
        - -27
        - -26
        - -25
        - -24
        - -23
        - -22
        - -21
        - -20
        - -19
        - -18
        - -17
        - -16
        - -15
        - -14
        - -13
        - -12
        - -11
        - -10
        - -9
        - -8
        - -7
        - -6
        - -5
        - -4
        - -3
        - -2
        - -1
        - 0
        - 1
        - 2
        - 3
        - 4
        - 5
        - 6
        - 7
        - 8
        - 9
        - 10
        - 11
        - 12
        - 13
        - 14
        - 15
        - 16
        - 17
        - 18
        - 19
        - 20
        - 21
        - 22
        - 23
        - 24
        - 25
        - 26
        - 27
        - 28
        - 29
        - 30
        - 31
        - 32
        - 33
        - 34
        - 35
        - 36
        - 37
        - 38
        - 39
        - 40
        - 41
        - 42
        - 43
        - 44
        - 45
        - 46
        - 47
        - 48
        - 49
        - 50
        - 51
        - 52
        - 53
        - 54
        - 55
        - 56
        - 57
        - 58
        - 59
        - 60
        - 61
        - 62
        - 63
        - 64
        - 65
        - 66
        - 67
        - 68
        - 69
        - 70
        - 71
        - 72
        - 73
        - 74
        - 75
        - 76
        - 77
        - 78
        - 79
        - 80
        - 81
        - 82
        - 83
        - 84
        - 85
        - 86
        - 87
        - 88
        - 89
        - 90
        - 91
        - 92
        - 93
        - 94
        - 95
        - 96
        - 97
        - 98
        - 99
        - 100

# --------------------PROCEDURE SCRIPTS-------------------- #

# Returns true if passed string has any alphabetical letters in it. non-case sensitive.
# | NON-case sensitive
has_alpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.contains_any_text[a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z]>

# Returns true if passed string has any numeric characters in it.
has_numeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.contains_any_text[1|2|3|4|5|6|7|8|9|0]>

# Returns true if passed string has any alphanumeric characters in it.
# | NON-case sensitive
has_alphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <proc[has_alpha].context[el].and[<proc[has_numeric].context[el]>]>

# Returns true if passed string is only composed of alphabetical characters.
# | NON-case sensitive
is_alpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.matches_character_set[abcdefghijklmnopqrstuvwxyz]>

 # Returns true if passed string is only composed of numerals characters.
is_numeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.matches_character_set[1234567890]>

# Returns true if passed string is only composed of alphanumeric characters.
# | NON-case sensitive
is_alphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_lowercase.matches_character_set[abcdefghijklmnopqrstuvwxyz1234567890]>

# Returns the string as the passed value trimmed down only to alphabetical characters.
# | case sensitive
as_alpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].trim_to_character_set[ABDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]>

# Returns the string as the passed value trimmed down only to numeric characters.
as_numeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].trim_to_character_set[0123456789]>

# Returns the string as the passed value trimmed down only to alphanumeric characters.
# | case sensitive
as_alphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].trim_to_character_set[ABDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789]>

# Returns the string as the passed value trimmed down only to non-alphabetic characters.
as_nonalpha:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_list.exclude[<proc[as_alpha].context[<[el]>].to_list.deduplicate>].unseparated>

# Returns the string as the passed value trimmed down only to non-numeric characters.
as_nonnumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_list.exclude[<proc[as_numeric].context[<[el]>].to_list.deduplicate>].unseparated>

# Returns the string as the passed value trimmed down only to non-alphanumeric characters.
as_nonalphanumeric:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_list.exclude[<proc[as_alphanumeric].context[<[el]>].to_list.deduplicate>].unseparated>

# Returns true if the string ends in valid ending punctuation, as determined by the english language.
# | Valid characters: ! . ? ) ] } > ' " 0 1 2 3 4 5 6 7 8 9
has_valid_ending_puncuation:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].to_list.last.matches_character_set[!.?)}&rb&gt&sq&quo0123456789]>

# Returns string with the first letter uppercased.
first_letter_uppercase:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <tern[<[el].length.is[OR_MORE].than[2]>].pass[<[el].char_at[1].to_uppercase><[el].substring[2]>].fail[<[el]>]>

#Returns true if the alphabetic characters in the string are all lowercase.
# | TRUE if there are no alphabetic characters
is_lowercase:
    type: procedure
    definitions: el
    debug: false
    script:
        - define alpha <proc[as_alpha].context[<[el]>]>
        - determine <[alpha].to_lowercase.contains_all_case_sensitive_text[<[alpha]>]>

#Returns true if the alphabetic characters in the string are all uppercase.
# | TRUE if there are no alphabetic characters
is_uppercase:
    type: procedure
    definitions: el
    debug: false
    script:
        - define alpha <proc[as_alpha].context[<[el]>]>
        - determine <[alpha].to_uppercase.contains_all_case_sensitive_text[<[alpha]>]>

# Maps one range to another range, then returns a value based on the input provided. For example, if the
# starting range is 0 - 4, and the ending range is 0 - 100, and the input value was 2, the output value would
# return 50, as 2 is equidistant from it's starting and ending value as 50 is from it's starting and end value.
map_range:
    type: procedure
    definitions: from_min|from_max|to_min|to_max|input
    debug: false
    script:
        - determine <[input].sub[<[from_min]>].mul[<[to_max].sub[<[to_min]>]>].div[<[from_max].sub[<[from_min]>]>].add[<[to_min]>]>

# Using a range, determines where the input should be, numerically cycles the value. For example, if you had
# a range of 0 - 360, and the input was 450, you'd recieve 90 back. as 450 is 360 + 90. Cycle value works no
# matter how many "cycles" have been made.
cycle_value:
    type: procedure
    definitions: start|end|input
    debug: false
    script:
        - if <[input]> < <[start]> || <[input]> > <[end]>:
            - define is_more <[input].is[MORE].than[<[end]>]>
            - define delta_1 <[end].sub[<[start]>].add[1]>
            - define delta_2 <[input].sub[<tern[<[is_more]>].pass[<[end]>].fail[<[start]>]>].div[<[delta_1]>].abs.round_up.mul[<[delta_1]>]>
            - define result <tern[<[is_more]>].pass[<[input].sub[<[delta_2]>]>].fail[<[input].add[<[delta_2]>]>]>
        - else:
            - define result <[input]>
        - determine <[result]>

# Returns a random color tag color, clamped to certain values.
# | Saturation and brightness have a minimum value of 100, to lower the amount of white/grey/black colors.
random_color:
    type: procedure
    debug: false
    script:
        - determine <color[255,0,0].with_hue[<util.random.int[0].to[255]>].with_saturation[<util.random.int[100].to[255]>].with_brightness[<util.random.int[100].to[255]>]>

# Returns a random, gaussian distributed value, useful for a random pitch value for a sound.
# | Most values will be between .8 .. 1.2, but will occasionally go down to .5 and up to .1.5. Due to how a gaussian
# | value is created, there's no guarentee you won't get values that create weird sounds. Consider clamping the range
# | if that will be an issue.
random_pitch:
    type: procedure
    debug: false
    script:
        - determine <util.random.gauss.div[6].add[1]>

# Returns a numeric list from from a starting value of size 'size', counting up by 1 each time. For example, a list of 'start == 4' and 'size == 9' would be the list [4|5|6|7|8|9|10|11|12].
# | Lists outside -100 .. 100 dynamically generate needed values through a REAL lazy loop. If you consistantly need to
# | generate values outside that range, consider adding them to the long_number_array, found in the data value at the
# | top of the utilities file.
make_numeric_list:
    type: procedure
    definitions: start|size
    debug: false
    script:
        - define lna <script[j_generic_data].data_key[long_number_array]>
        - define low_bound <[lna].first>
        - define high_bound <[lna].last>
        - define index <[high_bound].add[1].add[<[start]>]>
        - define end <[size].add[<[start]>]>
        - if <[start]> > <[low_bound]> && <[end]> < <[high_bound]>:
            - define result <[lna].get[<[index]>].to[<[index].add[<[size]>]>]>
        - else:
            - define lna_size <[lna].size>
            - define result <list[]>
            - if <[start]> < <[low_bound]>:
                - define loops <[start].sub[<[low_bound]>].abs>
                - repeat <[loops]>:
                    - define result <[result].include[<[loops].sub[<[value].sub[1]>].mul[-1].add[<[low_bound]>]>]>
            - define result <[result].include[<[lna].get[<tern[<[start].is[LESS].than[<[low_bound]>]>].pass[1].fail[<[index]>]>].to[<tern[<[end].is[MORE].than[<[high_bound]>]>].pass[<[lna_size]>].fail[<[size].sub[<[result].size>]>]>]>]>
            - if <[end]> > <[high_bound]>:
                - define loops <[size].sub[<[result].size>]>
                - repeat <[loops]>:
                    - define result <[result].include[<[high_bound].add[<[value]>]>]>
        - determine <[result]>

# Returns true if the provided element is a list
is_list:
    type: procedure
    definitions: el
    debug: false
    script:
        - determine <[el].type.is[==].to[list]>

# Fills a list with a the results of a procedure script, with length 'length'.
# | Can NOT take a procedure script that requires extra values
fill_list:
    type: procedure
    definitions: proc_name|length
    debug: false
    script:
        - define result <list[]>
        - repeat <[length]>:
            - define result <[result].include[<proc[<[proc_name]>]>]>
        - determine <[result]>