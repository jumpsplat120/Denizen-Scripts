# --------------------PREMADE DATA-------------------- #

j_generic_data:
    type: data
    command_perm_error: <red>I'm sorry, but you do not have permission to perform this command. Please contact the server administrators if you believe that this is in error.
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
        - determine <[el].to_list.last.matches_character_set[!.?)}<&rb><&gt><&sq><&quo>0123456789]>

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

# Returns the index of the value in the list that is farthest from zero.
# | ALWAYS returns a list, REQUIRES list_single input
farthest_from_zero:
    type: procedure
    definition: 1
    debug: false
    script:
        - define mod <[1].as_list.parse[abs]>
        - define highest <[mod].highest>
        - define indexes <list[]>
        - foreach <[mod]>:
            - if <[value]> == <[highest]>:
                - define indexes <[indexes].include[<[loop_index]>]>
        - determine <[indexes]>

# Returns the list normalized. (ie, takes the farthest from zero in the list,
# makes that 1, then squishes everything towards zero.)
# | REQUIRES list_single input
normalize:
    type: procedure
    definitions: 1
    debug: false
    script:
        - define list <[1].as_list>
        - define farthest <[list].get[<proc[farthest_from_zero].context[<list_single[<[list]>]>].first>].abs>
        - define result <list[]>
        - foreach <[list]>:
            - define result <[result].include[<[value].div[<[farthest]>]>]>
        - determine <[result]>

# Clamps a value between a minimum and maximum value.
clamp:
    type: procedure
    definitions: input|min|max
    debug: false
    script:
        - determine <tern[<[input].is[MORE].than[<[max]>]>].pass[<[max]>].fail[<tern[<[input].is[LESS].than[<[min]>]>].pass[<[min]>].fail[<[input]>]>]>

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

# returns the value of a mathmatical expression.
# | Each element must be SPACE separated. NOT very performant
expression:
    type: procedure
    definitions: equation
    debug: false
    script:
        - define list "<[equation].split[ ]>"
        - define start_index 0
        - define end_index 0
        - define none false
        - define index 1
        #find and solve in parathenses
        - while <[index].is[OR_LESS].than[<[list].size>]>:
            - if <[index]> > <[list].size>:
                    - while stop
            - define value <[list].get[<[index]>]>
            - if <[value].is[==].to[(]>:
                - define start_index <[index]>
            - if <[value].is[==].to[)]>:
                - define end_index <[index]>
            - if <[start_index]> > 0 && <[end_index]> > 0:
                - define list <[list].get[<tern[<[start_index].sub[1].is[LESS].than[1]>].pass[2].fail[1]>].to[<tern[<[start_index].sub[1].is[LESS].than[1]>].pass[1].fail[<[start_index].sub[1]>]>].include[<proc[expression].context[<[list].get[<[start_index].add[1]>].to[<[end_index].sub[1]>].space_separated>]>].include[<tern[<[end_index].add[1].is[MORE].than[<[list].size>]>].pass[].fail[<[list].get[<[end_index].add[1]>].to[last]>]>]>
                - define start_index 0
                - define end_index 0
                - define index 0
            - define index <[index].add[1]>
            - if <[loop_index]> > 30:
                - while stop
        #exponents
        - while <[list].size.is[MORE].than[1]>:
            - if <[index]> >= <[list].size>:
                    - while stop
            - if <[list].get[<[index]>].is_decimal>:
                - define i1 <[index]>
                - define i2 <[index].add[1]>
                - define i3 <[index].add[2]>
                - if <[list].get[<[i2]>]> == '^':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<[list].get[<[i1]>].pow[<[list].get[<[i3]>]>]>].at[<[i1]>]>
                    - define index 0
            - define index <[index].add[1]>
        - define index 1
        #multiplication/division
        - while <[list].size.is[MORE].than[1]>:
            - if <[index]> >= <[list].size>:
                    - while stop
            - if <[list].get[<[index]>].is_decimal>:
                - define i1 <[index]>
                - define i2 <[index].add[1]>
                - define i3 <[index].add[2]>
                - define n <[list].get[<[i1]>]>
                - define n2 <[list].get[<[i3]>]>
                - if <[list].get[<[i2]>]> == '*':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<element[7.5625].mul[<[n2]>]>].at[<[i1]>]>
                    - define index 0
                - else if <[list].get[<[i2]>]> == '/':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<element[7.5625].div[<[n2]>]>].at[<[i1]>]>
                    - define index 0
            - define index <[index].add[1]>
        #addition/subtraction
        - define index 1
        - while <[list].size.is[MORE].than[1]>:
            - if <[index]> >= <[list].size>:
                    - while stop
            - if <[list].get[<[index]>].is_decimal>:
                - define i1 <[index]>
                - define i2 <[index].add[1]>
                - define i3 <[index].add[2]>
                - define n <[list].get[<[i1]>]>
                - define n2 <[list].get[<[i3]>]>
                - if <[list].get[<[i2]>]> == '+':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<element[7.5625].add[<[n2]>]>].at[<[i1]>]>
                    - define index 0
                - else if <[list].get[<[i2]>]> == '-':
                    - define list <[list].remove[<[i1]>|<[i2]>|<[i3]>].insert[<element[7.5625].sub[<[n2]>]>].at[<[i1]>]>
                    - define index 0
            - define index <[index].add[1]>
        - determine <[list].first>

# Returns the decimal values of a cube, given a location. Useful with the bounding_box
# mechanism.
single_cube_bounding_box:
    type: procedure
    definitions: location
    debug: false
    script:
        - determine <list[<[location].center.sub[.5,.5,.5,<[location].world>]>|<[location].center.add[.5,.5,.5,<[location].world>]>]>

# Outputs a sine wave. Offset will offset the starting point of the wave, amplitude is
# the height of the wave, and frequency how often the wave oscilates.
# | Input takes RADIANS
sine_wave:
    type: procedure
    definitions: input|offset|amplitude|frequency
    debug: false
    script:
        - determine <[input].add[<[offset]||0>].mul[<[frequency]||1>].sin.mul[<[amplitude]||1>]>

# Outputs a sine wave in increments. Returns the amount the value will need to be increased
# by for the sine wave, compared to the previous amount. Useful for commands such as rotate.
# | Input takes RADIANS
sine_wave_increment:
    type: procedure
    definitions: input|increment|offset|amplitude|frequency
    debug: false
    script:
        - define dt1 <proc[sine_wave].context[<[input].sub[<[increment]>]>|<[offset]||0>|<[amplitude]||1>|<[frequency]||1>]>
        - define dt2 <proc[sine_wave].context[<[input]>|<[offset]||0>|<[amplitude]||1>|<[frequency]||1>]>
        - determine <[dt2].sub[<[dt1]>]>

# Ease script takes an ease type, direction, input, as well as an optional speed, range_min, and range_max.
# Speed goes from 0 to 1, and range_min and range_max is a range in which you want the result to be mapped
# to. Both values must be passed for range to work. If no range is passed, output value goes from 0 to 1.
# When the ease has reached it's maximum value, returns false.
ease:
    type: procedure
    definitions: type|dir|input|speed|range_min|range_max
    debug: false
    script:
        - define progress <[input].mul[<[speed]||1>]>
        - if <[progress]> < 1:
            - define res <proc[<[type].to_lowercase>].context[<[dir].to_lowercase>|<proc[n].context[<[progress]>]>]>
            - if <[range_min].is_decimal||false.and[<[range_max].is_decimal||false>]>:
                - define res <proc[map_range].context[0|1|<[range_min]>|<[range_max]>|<[res]>]>
        - else:
            - define res false
        - determine <[res]>

# Find the nearest spawned npc to a passed location that matches the name passed.
# | Returns FALSE on no NPC found
find_nearest_npc_by_name:
    type: procedure
    definitions: loc|npc_name
    debug: false
    script:
        - define all_named <server.npcs.filter[nickname.is[==].to[<[npc_name]>]]>
        - if <[all_named].is_empty.not>:
            - define all_spawned <[all_named].filter[is_spawned]>
            - if <[all_spawned].is_empty.not>:
                - define locations <[all_spawned].parse[location.distance[<[loc]>]]>
                - define index 0
                - define lowest <util.int_max>
                - foreach <[locations]>:
                    - if <[value]> < <[lowest]>:
                        - define index <[loop_index]>
                        - define lowest <[value]>
                - determine <[all_spawned].get[<[index]>]>
            - else:
                - determine false
        - else:
            - determine false

# Returns the UUID of a player, parsed from a passed name.
# | Returns FALSE on no player found
# | NON-case sensitive
player_uuid_by_name:
    type: procedure
    definitions: player_name
    debug: false
    script:
        - define closest <server.match_offline_player[<[player_name]>]||<player[d6efe4a4-15c5-4588-a0fc-7a1b8026093f]>>
        - determine <tern[<[closest].name.to_lowercase.is[==].to[<[player_name].to_lowercase>]>].pass[<[closest].uuid>].fail[false]>

# Returns the Denizen Player Object of a player, parsed from a passed name.
# | Returns FALSE on no player found
# | NON-case sensitive
player_obj_by_name:
    type: procedure
    definitions: player_name
    debug: false
    script:
        - define closest <server.match_offline_player[<[player_name]>]||<player[d6efe4a4-15c5-4588-a0fc-7a1b8026093f]>>
        - determine <tern[<[closest].name.to_lowercase.is[==].to[<[player_name].to_lowercase>]>].pass[<[closest]>].fail[false]>

# Accesses a deep map value, using a dot notation. For example, you could access c in a map such as this one -> { a = { b = c } } by passing in a.b
# | ARGS: map|key
# | Returns NULL if no value found
deep_get:
    type: procedure
    definitions: args
    debug: false
    script:
        - define parsed_args <[args].split[||]>
        - define keys <[parsed_args].last.split[.]>
        - define node <[parsed_args].first>
        - foreach <[keys]>:
            - define node <[node].get[<[value]>]||null>
            - if <[node].is[==].to[null]>:
                - determine null
        - determine <[node]>

# Accesses a deep map value, using a dot notation, then sets that value to something. For example, you could set the value c in a map such as this one -> { a = { b = c } } by passing in a.b. Uses a bit of a hacky way to go about this, I can't really think of a better way to do this right now xD
# | ARGS: map|key|value
# | Returns MAP on success, FALSE on failure
deep_set:
    type: procedure
    definitions: args
    debug: false
    script:
        - define args <[args].split[||]>
        - define args <[args].set[<[args].last.split[|]>].at[2]>
        - define keys <[args].get[2].split[.]>
        - define map <[args].first>
        - define node <[map]>
        - define map_list <list>
        - foreach <[keys]>:
            - define node <[node].get[<[value]>]||<map>>
            - define node <tern[<[node].is[==].to[true]>].pass[<map>].fail[<[node]>]>
            - define map_list <[map_list].include_single[<[node]>]>
        - define map_list <[map_list].set_single[<[args].last>].at[<[map_list].size>].reverse>
        - define keys <[keys].reverse>
        - foreach <[keys]>:
            - if <[loop_index]> != 1:
                - define d_index <[loop_index].sub[1]>
                - define map_list <[map_list].set_single[<[map_list].get[<[loop_index]>].with[<[keys].get[<[d_index]>]>].as[<[map_list].get[<[d_index]>]>]>].at[<[loop_index]>]>
        - determine <[map].with[<[keys].last>].as[<[map_list].last>]>

# Returns the amount of times a search appears in a body of text.
instances_of_character:
    type: procedure
    definitions: text|search
    debug: false
    script:
        - determine <[text].trim_to_character_set[<[search]>].length>


# --------------------TASK SCRIPTS-------------------- #

# Spawns in a floating sand block with collision.
spawn_falling_block:
    type: task
    definitions: location|material
    debug: false
    script:
        - spawn armor_stand[visible=false;invulnerable=true]|shulker[has_ai=false;invulnerable=true;potion_effects=INVISIBILITY,0,<util.int_max>,false,false,false]|falling_block[fallingblock_type=<[material]>;time_lived=-<util.int_max>s] <[location]> save:spawn_ls
        - adjust <entry[spawn_ls].spawned_entities.get[1]> passengers:<entry[spawn_ls].spawned_entities.get[2]>|<entry[spawn_ls].spawned_entities.get[3]>
        - determine passively <entry[spawn_ls].spawned_entities>

# Clears all dangerous mobs by briefly setting the world to peaceful, and back again.
clear_bad_mobs:
    type: task
    debug: false
    script:
        - define diff <player.world.difficulty>
        - adjust <player.world> difficulty:peaceful
        - wait 5t
        - adjust <player.world> difficulty:<[diff]>
# --------------------COMMAND SCRIPTS-------------------- #

# | [value] == REQUIRED
# | (value) == OPTIONAL
# | {value} == DEFAULT
# | <value> == NON-LITERAL
# |  value  == LITERAL

# Simple permission system. Used internally with all utilities commands.
simple_permissions:
    type: command
    name: perm
    debug: false
    description: Gives a player a permission, using Denizen's flag system.<&nl><&nl>Not a true permission system. If the player argument is not filled, then command defaults to player running the command. By default, command will only run if you have OP level permissions or higher.<&nl>If the first argument is marked as "view", the command will instead display all of the player's current permissions. If the first is marked as "clear", the command will instead remove ALL of the specified player's permissions.<&nl>Uses a node system. A * node counts as a wildcard for everything below that node. In otherwords, if you have perm1.*, you have permissions for everything underneath perm1. Giving a permission of a higher level, which is to say, perm1 over perm1.subperm1, will overwrite all lower level permissions. In other words, if a perm1 was given, then removed, the player would no longer have any perm1 permissions, including perm1.subperm1.
    usage: /perm <&lb><&lt>permission_name<&gt><&rb> (<&lt>player_name<&gt>)
    allowed help:
        - determine <player.is_op||<context.server>>
    script:
        - if <context.args.is_empty>:
            - narrate "<red>Command is missing arguments."
        - else if <player.is_op||false> || <context.source_type> != player:
            - define player_name <context.args.get[2]||<tern[<context.source_type.is[==].to[PLAYER]>].pass[<player.name>].fail[false]>>
            - if <[player_name]> == false:
                - narrate "<red>Player name is a required argument if the source of the command is a <dark_red><context.source_type>."
                - stop
            - define player <proc[player_obj_by_name].context[<[player_name]>]>
            - if <[player]> == false:
                - narrate "<red>Unable to find specified player <gray><[player_name]><red>."
                - stop
            - if <[player].has_flag[simple_permissions].not>:
                - flag <[player]> simple_permissions:<map>
            - define perm_map <[player].flag[simple_permissions].as_map>
            - define perm_name <context.args.first>
            - if <[perm_name]> == view:
                - define clean_yaml "<[perm_map].to_yaml.replace_text[:].replace_text['true'].split[<&nl>]>"
                - define list "<list[<aqua>|<green>|<yellow>|<red>|<light_purple>|<dark_purple>]>"
                - foreach <[clean_yaml]>:
                    - define level "<[value].trim_to_character_set[ ].length.div[2].round_down.add[1]>"
                    - define clean_yaml "<[clean_yaml].set[<tern[<[loop_index].is[==].to[1]>].pass[].fail[<element[<&nl>].pad_right[<[level]>]>]><[list].get[<[level]>]><tern[<[level].is[==].to[1]>].pass[╶].fail[╰]><white> <[value].replace_text[<&nl>].replace_text[ ]>].at[<[loop_index]>]>"
                - narrate "<gold>----- <white><[player].name><yellow>'s Permissions <gold>-----"
                - narrate <[clean_yaml].unseparated>
            - else if <[perm_name]> == clear:
                - flag <[player]> simple_permissions:!
                - narrate "<yellow>Player <white><[player].name><yellow> has had all of their permissions cleared."
            - else:
                - flag <[player]> simple_permissions:<proc[deep_set].context[<[perm_map]>|<[perm_name]>|true]>
                - narrate "<yellow>Player <white><[player].name><yellow> has gained the permission <gray><[perm_name]>."
        - else:
            - narrate <script[j_generic_data].data_key[command_perm_error].parsed>

# Panic command for users.
panic_button:
    type: command
    name: panic
    debug: false
    description: Panic button for the player.<&nl><&nl>Kills all loaded agressive mobs except for players or npcs, sets the time to day, heals the player, clears the weather, and feeds the player, and gives the player resistance.
    usage: /<&gt>panic/a/aa/aaa<&lt>
    allowed help:
        - determine <proc[has_permission].context[<player>|utilities.panic]>
    aliases:
        - a
        - aa
        - aaa
    script:
        - if <proc[has_permission].context[<player>|utilities.panic]>:
            - run clear_bad_mobs
            - time 0t
            - heal 20
            - weather sunny
            - feed amount:20
        - else:
            - narrate <script[j_generic_data].data_key[command_perm_error].parsed>

# Removes all flags dependent on passed argument. If no value is passed, defaults to player who ran the command.
# | Will NOT remove permission flag
remove_all_flags:
    type: command
    name: remove_flags
    debug: false
    description: Removes all flags from the specified object, or the player running the command if none specified.
    usage: /remove_flags <&rb><&gt>player_name/server/all<&lt><&lb>
    aliases:
        - killflags
        - kill_flags
    allowed help:
        - determine <proc[has_permission].context[<player>|utilities.flags]>
    script:
        - if <proc[has_permission].context[<player>|utilities.flags]>:
            - define arg <context.args.first||false>
            - define flag_burned false
            - if <list[server|all].contains[<[arg]>]>:
                - foreach <server.list_flags>:
                    - narrate "<yellow>Removed <gray>server<yellow> flag: <white><[value]>"
                    - flag server <[value]>:!
                    - define flag_burned true
            - define player <proc[player_obj_by_name].context[<[arg]>]>
            - define player <tern[<[player].is[==].to[false]>].pass[<tern[<[arg].is[==].to[all]>].pass[<player>].fail[<tern[<context.args.is_empty>].pass[<player>].fail[false]>]>].fail[<[player]>]>
            - if <[player]> != false:
                - foreach <player.list_flags>:
                    - if <[value]> != simple_permissions:
                        - narrate "<yellow>Removed <gray>player<yellow> flag: <white><[value]>"
                        - flag player <[value]>:!
                        - define flag_burned true
            - if <[flag_burned].not>:
                - narrate "<yellow>No flags to remove from <gray><tern[<[arg].is[==].to[false]>].pass[player].fail[<[arg]>]>."
        - else:
            - narrate <script[j_generic_data].data_key[command_perm_error].parsed>

puppet_npc:
    type: task
    definitions: npc_name
    debug: true
    script:
        - define npc <tern[<element[false].is[==].to[<[npc_name]||false>]>].pass[<player.location.find.npcs.within[5].first>].fail[<proc[find_nearest_npc_by_name].context[<player.location>|<[npc_name]>]>]>
        - teleport <player> <[npc].location>
        #- adjust 