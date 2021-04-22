# --------------------DATA SCRIPTS-------------------- #
# Various personal notes:
#    generic_lib_data - What it says on the tin. Help for each individual lib entry, as well as an alphabet set and number set, used for some tags.
#    lib_setup_task - free floating task, used to generate a unique fallback (this is because we never know what value is going to be passed, so if we were to check for false or nil or
#        something like that, it could fail when it doesn't need to), get the lib_data script and get config, and assign them to defintions. This is the closest to globals in denizen.
#        We just call this at the beginning of each script so that we always have access to these defs.
#    assert - For error checking. I had some crazy if trees and I figured keeping it all top level would be easier than what I was doing before.
#    co_lib_* - All the other custom object that have this naming scheme are used to emulate how some tags work in denizen. So for example, you have co_lib_random, and when using it,
#        you can call <[util].random.pitch>, where random returns another custom object, and pitch only exists in there. That way, we don't need to keep doing random_thing1, random_thing2,
#        we can just have them all under the "random" custom object. As well, since it is a CO, we can define it so we are just using the randoms. So we could do - define r <[util].random>
#        and then just call <[r].pitch>, which you actually couldn't do with an actual tag.
#   co_lib_._ - Various interal helper functions. Things we want to use, but don't need to make a task for. setup_task needs a task because you can't inject a tag, which is what a CO
#        basically is, but getting values we can do in a tag. As well, it takes a value to actually do anything so even if someone called it, it won't do anything unless they know how the
#        internals work. Uses a naming scheme from other programming languages.
#   epsilon - not a true epsilon! I'm not entirely sure the best way to get that value, but that is up to 64
#       decimal places so :shrug: maybe it's enough.I found an equation where you keep multiplying a value by
#       epsilon until 1 == 1 + epsilon but it didn't work xD I think monkey is using a big num library because
#       I've seen some insane precision that blows longs out of the water.
generic_lib_data:
    type: data
    alphabet_set: abcdefghijklmnopqrstuvwxyz
    number_set: 0123456789
    phi: 1.618033988749895
    epsilon: 0.0000000000000000000000000000000000000000000000000000000000000001
    help:
        default: Jumpsplat120's library!
        random: The Random object. You can return just this if you need to access random values a lot, and don't want to type out <&lt>[lib].random<&gt> every time.
        random.pitch: Returns a random, gaussian distributed value, useful for a random pitch value for a sound. Most values will be between .8 .. 1.2, but will occasionally go down to .5 and up to .1.5. Due to how a gaussian value is created, there's no guarentee you won't get values that create weird sounds. Consider clamping the range if that will be an issue.
        random.color: Returns a random color, which can be used directly in text. Unlike a color tag, this can not be manipulated. The random.color will return a color tag with default saturation and brightness values (100, 100).
        random.color_tag: Returns a random color tag color, clamped to certain values. Default saturation and brightness have a minimum value of 100, to lower the amount of white/grey/black colors.
        random.by_weight: Return a value min a map, where each key in the map has a weight value, and it returns a random value, weighted towards items with higher weights. A weight of 0 or less will never return. If no value can be returned, because there is no value to return or because all values are weights of zero, then returns false.
        has: The Has object. You can return this if you need to check if elements contain certain patterns a lot, and don't want to type out <&lt>[lib].has<&gt> every time.
        has.alpha: Returns true if passed string has any alphabetical letters in it. NON-case sensitive
        has.numeric: Returns true if passed string has any numeric characters in it.
        has.alphanumeric: Returns true if passed string has any alphanumeric characters in it. NON-case sensitive
        is: The Is object. You can return just this if you need to verify elements lot, and don't want to type out <&lt>[lib].is<&gt> every time.
        is.alpha: Returns true if passed string is only composed of alphabetical characters. NON-case sensitive
        is.numeric: Checks if a value is numeric. This is simply here for completeness; is.numeric is simply a wrapper for the standard tag .is_decimal, and using this tag will throw a warning in the console about it.
        is.alphanumeric: Returns true if passed string is only composed of alphanumeric characters. NON-case sensitive
        as: The As object. You can return just this if you need to modify elements lot, and don't want to type out <&lt>[lib].as<&gt> every time.
        as.alpha: Returns the string as the passed value trimmed down only to alphabetical characters.
        as.numeric: Returns the string as the passed value trimmed down only to numeric characters.
        as.alphanumeric: Returns the string as the passed value trimmed down only to alphanumeric characters.
        as.nonalpha: Returns the string as the passed value trimmed down only to non-alphabetic characters.
        as.nonnumeric: Returns the string as the passed value trimmed down only to non-numeric characters.
        as.nonalphanumeric: Returns the string as the passed value trimmed down only to non-alphanumeric characters.
        first_character_uppercase: Returns string with the first letter uppercased.
        epsilon: Epsilon returns an incredibly small increment. In a traditional programming language, epsilon is the largest value that could be added to a float, and not affect that value of that float. Or in otherwords, 1 + epsilon == 1. This is useful for some rounding's, or other cases where you just need to tip the value of a number slightly one way or the other, without majorly affecting the value.
        phi: Returns the golden ratio, to 15 digits of precision.
        alphabet_set: Returns the latin alphabet (a, b, c...) in a character set. The characters are all lowercased; use to_uppercase if you need the set in uppercase format.
        alphabet_list: Returns the latin alphabet (a, b, c...) in a list. Similar to the alphabet set, but these come preseparated. If you need an uppercase list, simply filter[to_uppercase].
        map_range: Maps one range to another range, then returns a value based on the input provided. For example, if the starting range is 0 - 4, and the ending range is 0 - 100, and the input value was 2, the output value would return 50, as 2 is equidistant min it's starting and ending value as 50 is min it's starting and end value.
        cycle_value: Using a range, determines where the input should be, numerically cycles the value. For example, if you had a range of 0 - 360, and the input was 450, you'd recieve 90 back. as 450 is 360 + 90. Cycle value works no matter how many "cycles" have been made.
        rainbow_text: Returns the passed text with rainbow coloring. The first letter starts with 'start_color', or red if none specified, and increments by a hue of 'increment', or 15 if none specified. start_color MUST be a colortag.
        animated_rainbow_text: Returns a list containing the passed text with rainbow coloring, where each entry in the list has the colors offset by "increment". When the list is iterated through quickly, it appears as though the text's colors are animating.
        numeric_list:  Returns a numeric list with a starting value of size 'size', counting up by 1 each time. For example, a list of 'start == 4' and 'size == 9' would be the list [4|5|6|7|8|9|10|11|12].
        farthest_from_zero: Returns a list containing the index and value of the value in the list that is farthest min zero. If there is both a highest and lowest value that are equidistant (abs(x) == abs(y)), then both values will be passed in the list, along with their respective indexes.
        normalize: Returns the list normalized. (ie, takes the farthest min zero in the list, makes that 1, then squishes everything towards zero.)
        clamp: Clamps a value between a minimum and maximum value.
        fill_list: Fills a list with a the results of a procedure script, with length 'length'.
        sine_wave: Outputs a sine wave. Offset will offset the starting point of the wave, amplitude is the height of the wave, and frequency how often the wave oscilates. Input technically takes radians, meaning that inputting integer values will most likely move the sine wave too fast to be useful.
        sine_wave_increment: Outputs a sine wave in increments. Returns the amount the value will need to be increased by for the sine wave, compared to the previous amount. Useful for the rotate command. Input technically takes radians, meaning that inputting integer values will most likely move the sine wave too fast to be useful.
        ease: Ease script takes an ease type, direction, input, as well as an optional speed, range_min, and range_max. Input goes min 0 to 1, as well as speed, and range_min and range_max is a range in which you want the result to be mapped to. Both values must be passed for range to work. If no range is passed, output value goes min 0 to 1. When the ease has reached it's maximum value, returns false.
        find_nearest_npc_by_name: Find the nearest spawned npc to a passed location that matches the name passed. Returns false if no npc with that name is found.
        player_by_name: Returns the dPlayer of a player, parsed from the passed name. Unlike <&lt>server.match_offline_player<&gt>, this will only return the player object if the name is matched exactly, excluding case sensitivity. This is useful for commands that take player names where it's important to verify who a command is being cast on. For example, if you had a command that wiped a player's inventory, or granted the player special permissions. Returns false if the player name does not match a player who has joined your server.
        instances_of_character: Returns the amount of times the search appears in a body of text.
        has_permission: Returns whether passed player has a j_utilities.permission permission. This is a small permission system created entirely within denizen, and used locally within utilities for various utility commands.
        lowest_index: Return the index of the lowest value in a list. If multiple values are the lowest, returns the first one.
        highest_index: Return the index of the highest value in a list. If multiple values are the highest, returns the first one.
        outline_cuboid: Returns a list of locations that outline the physical cuboid, based in the density parmeter. The higher the density, the more locations returned. If density is not passed, uses a default of 1, which is one location per block. Unlike the outline tag, this CANNOT be used for actual locations, and is used internally for the particles in the notable tool. If you want a visual representation of a cuboid for whatever reason, use this. If not, consider using the actual outline tag.
        outline_location: Returns a list of locations that outline the block of a location. If the passed location isn't an actual block, it will highlight an area that is the size of one block, but will be offset from the rest of the Minecraft grid.
        flipped_case: Returns the opposite case of whatever each character's case is. Uppercase becomes lowercase, and lowercase becomes uppercase.
        shell_ellipsoid: Returns a list of locations that create a shell of the physical ellipsoid, based on the denisity parmeter. The higher the denisity, the more locations returned. If denisity is not passed, uses a default of 1. Unlike the shell tag, this CANNOT be used for actual locations, and is used internally for the particles in the notable tool. If you want a visual representation of an ellipsoid for whatever reason, use this. If not, consider using the actual shell tag.
    ease:
        dir:
            - in
            - out
            - inout
            - in_out
            - in-out
        type:
            - sine
            - quad
            - cubic
            - quart
            - quint
            - exp
            - circ
            - back
            - elastic
            - bounce
        C1: 1.70158
        C2: 2.5949095
        C2A: 3.5949095
        C3: 2.70158
        C4: 2.0943951
        C5: 1.3962634
    command:
        usage:
            simple_permissions: <[fs]><white>perm <[lb]><white>action:view<[fs]><white>clear<[fs]><[lc]><white>set<[rc]><[rb]> <[lb]><white>node:<[lt]><gray>permission_name<[gt]><[rb]> <[lp]><white>player:<[lt]><gray>player_name<[gt]><[rp]>
        error:
            permission: I<&sq>m sorry, but you do not have permission to perform this command. Please contact the server administrators if you believe that this is in error.
            wrong_args: Command was run with the incorrect amount of arguments! Expected<&co> <[arg_amount]>; Recieved<&co> <[size]><&nl>Usage<&co><&nl><[usage]>
            min_args: Too few arguments were passed! Expected at least<&co> <[min_args]>; Recieved<&co> <[size]><&nl>Usage<&co><&nl><[usage]>
            max_args: Too many arguments were passed! Expected at most<&co> <[max_args]>; Recieved<&co> <[size]><&nl>Usage<&co><&nl><[usage]>
            missing_req: <&sq><[required]>' is a required parameter, but '<[value]>' is not a valid entry!<&nl>Usage<&co><&nl><[usage]>
    error_messages:
        wrong_type: Passed value's type is incorrect for <&sq><[title]><&sq>. Expected<&co> <[type]>; Recieved<&co> <[bad_type]>
        wrong_args: Passed list has incorrect amount of elements for <&sq><[title]><&sq>. Expected<&co> <[arg_amount]>; Recieved<&co> <[size]>
        min_args: Passed list has less than the minimum amount of elements for <&sq><[title]><&sq>. Expected<&co> <[min_args]>; Recieved<&co> <[size]>
        max_args: Passed list has more than the maximum amount of elements for <&sq><[title]><&sq>. Expected<&co> <[max_args]>; Recieved<&co> <[size]>
        empty: Internal use of a library function returned an empty value! Something went wrong; currently on <&sq><[title]><&sq>.
        invalid_range: Invalid range; The first value <&sq><[min]><&sq> must be less than or equal to the second value <&sq><[max]><&sq>.
        not_number: <&sq><[number]><&sq> is not a valid number.

# --------------------TASK SCRIPTS-------------------- #

lib_tasks:
    type: task
    debug: false
    script:
        - determine true
    setup:
        - define lib_data <script[__generic_lib_data]>
        - define config   <script[__lib_config]>
        - define assert   false
        - define debug    <player.has_flag[j_utilities.debug]||nil>
        - define error    <custom_object[co_error]>
        - define size     <queue.definitions.size.sub[6]>
        - define list     <custom_object[_co_lib_core].parse_list[<context.value||<context.args||<empty>>>]>
        - define nil      <custom_object[co_nil]>
        - define lib      <custom_object[co_lib]>
        - define map      <[list].to_map[:]||<map>>
        - if <[debug]> == nil:
            - announce to_console "<yellow>Tried to access j_utilities flag but found nothing! Running flag setup..."
            - inject locally flags
            - define debug true
    flags:
        - flag <player> j_utilities.permissions:<map>
        - flag <player> j_utilities.debug:true
    spawn_falling_block:
        - inject locally setup
        # ~~ definitions ~~ #
        - define material <[1]||false>
        - define location <[2]||false>
        # ~~ asserts ~~ #
        - if <[debug]>:
            - define error  <[error].set[<map.with[title].as[spawn_falling_block].with[arg_amount].as[2].with[explicit_size].as[<[size]>]>]>
            - define assert <[error].wrong_args>
            - if <[material].type> != Material:
                - define material <material[<[material]>]||false>
            - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[material]>|Material]>]>
            - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[location]>|Location]>]>
        # ~~ logic ~~ #
        - if !<[assert]>:
            - spawn armor_stand[visible=false;invulnerable=true;gravity=false]|shulker[has_ai=false;invulnerable=true;potion_effects=INVISIBILITY,0,<util.int_max>,false,false,false]|falling_block[fallingblock_type=<[1]>;time_lived=-<util.int_max>s] <[2]> save:entities
            - adjust <entry[entities].spawned_entities.get[1]> passengers:<entry[entities].spawned_entities.get[2]>|<entry[entities].spawned_entities.get[3]>
            - determine passively <entry[entities].spawned_entities>
        - else:
            - determine <[nil]>
    clear_bad_mobs:
        - define diff <player.world.difficulty>
        - adjust <player.world> difficulty:peaceful
        - wait 5t
        - adjust <player.world> difficulty:<[diff]>

# --------------------CUSTOM CORE OBJ-------------------- #

_co_lib_core:
    type: custom
    debug: true
    inherit: co_base
    tags:
        type:
            - determine Library.Core
        ease:
            # ~ ~ ~ Eases; based on work from https://easings.net/ ~ ~ ~ #
            - define type <context.value.get[1]>
            - define dir  <context.value.get[2]>
            - define dt   <context.value.get[3]>
            - define ease_conf <script[__generic_lib_data].data_key[ease]>
            - if <[ease_conf].get[type].contains[<[type]>]> && <[ease_conf].get[dir].contains[<[dir]>]>:
                - define concat <[type]>_<[dir]>
            - choose <[type]>:
                - case sine_in:
                    - determine <element[1].sub[<[dt].mul[<util.pi>].div[2].cos>]>
                - case sine_out:
                    - determine <[dt].mul[<util.pi>].div[2].sin>
                - case sine_inout sine_in-out sine_in_out:
                    - determine <[dt].mul[<util.pi>].cos.sub[1].div[2].mul[-1]>
                - case quad_in:
                    - determine <[dt].power[2]>
                - case quad_out:
                    - determine <element[1].sub[<element[1].sub[<[dt]>].power[2]>]>
                - case quad_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[2].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[2].div[2]>]>]>
                - case cubic_in:
                    - determine <[dt].power[3]>
                - case cubic_out:
                    - determine <element[1].sub[<element[1].sub[<[dt]>].power[3]>]>
                - case cubic_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[4].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[3].div[2]>]>]>
                - case quart_in:
                    - determine <[dt].power[4]>
                - case quart_out:
                    - determine <element[1].sub[<element[1].sub[<[dt]>].power[4]>]>
                - case quart_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[8].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[4].div[2]>]>]>
                - case quint_in:
                    - determine <[dt].power[5]>
                - case quint_out:
                    - determine <element[1].sub[<element[1].sub[<[dt]>].power[5]>]>
                - case quint_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[16].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[5].div[2]>]>]>
                - case exp_in:
                    - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<element[2].power[<[dt].mul[10].sub[10]>]>]>
                - case exp_out:
                    - determine <tern[<[dt].is[==].to[1]>].pass[1].fail[<element[1].sub[<element[2].power[<[dt].mul[-10]>]>]>]>
                - case exp_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<tern[<[dt].is[LESS].than[.5]>].pass[<element[2].power[<[dt].mul[20].sub[10]>].div[2]>].fail[<element[2].sub[<element[2].power[<[dt].mul[-20].add[10]>]>].div[2]>]>]>]>
                - case circ_in:
                    - determine <element[1].sub[<element[1].sub[<[dt].power[2]>].sqrt>]>
                - case circ_out:
                    - determine <element[1].sub[<[dt].sub[1].power[2]>].sqrt>
                - case circ_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[1].sub[<element[1].sub[<[dt].mul[2].power[2]>].sqrt>].div[2]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[2]>].sqrt.add[1].div[2]>]>
                - case back_in:
                    - determine <[ease_conf].get[C3].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].sub[<[ease_conf].get[C1].mul[<[dt]>].mul[<[dt]>]>]>
                - case back_out:
                    - determine <[dt].sub[1].power[3].mul[<[ease_conf].get[C3]>].add[1].add[<[dt].sub[1].power[2].mul[<[ease_conf].get[C1]>]>]>
                - case back_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[LESS].than[.5]>].pass[<[dt].mul[2].power[2].mul[<[ease_conf].get[C2A].mul[2].mul[<[dt]>].sub[<[ease_conf].get[C2]>]>].div[2]>].fail[<[dt].mul[2].sub[2].power[2].mul[<[ease_conf].get[C2A].mul[<[dt].mul[2].sub[2]>].add[<[ease_conf].get[C2]>]>].add[2].div[2]>]>
                - case elastic_in:
                    - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<element[2].power[<[dt].mul[10].sub[10]>].mul[-1].mul[<[dt].mul[10].sub[10.75].mul[<[ease_conf].get[C4]>].sin>]>]>]>
                - case elastic_out:
                    - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<element[2].power[<[dt].mul[-10]>].mul[<[dt].mul[10].sub[.75].mul[<[ease_conf].get[C4]>].sin>].add[1]>]>]>
                - case elastic_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<tern[<[dt].is[LESS].than[.5]>].pass[<element[2].power[<[dt].mul[20].sub[10]>].mul[<[dt].mul[20].sub[11.125].mul[<[ease_conf].get[C5]>].sin>].mul[-1].div[2]>].fail[<element[2].power[<[dt].mul[-20].add[10]>].mul[<[dt].mul[20].sub[-11.125].mul[<[ease_conf].get[C5]>].sin>].div[2].add[1]>]>]>]>
                - case bounce_in:
                    - determine <element[1].sub[<context.this.bo[<element[1].sub[<[dt]>]>]>]>
                - case bounce_out:
                    - determine <context.this.bo[<[dt]>]>
                - case bounce_inout sine_in-out sine_in_out:
                    - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[1].sub[<context.this.bo[<element[1].sub[<[dt].mul[2]>]>]>].div[2]>].fail[<context.this.bo[<[dt].mul[2].sub[1]>].add[1].div[2]>]>
                - case default:
                    - debug error "An error occurred!"
                    - determine false
        bo:
            - determine bo <tern[<context.value.is[LESS].than[.363636363]>].pass[<element[7.5625].mul[<context.value>].mul[<context.value>]>].fail[<tern[<context.value.is[LESS].than[.727272727]>].pass[<element[7.5625].mul[<context.value.sub[.5454545]>].mul[<context.value.sub[.5454545]>].add[.75]>].fail[<tern[<context.value.is[LESS].than[.909090909]>].pass[<element[7.5625].mul[<context.value.sub[.81818181]>].mul[<context.value.sub[.81818181]>].add[0.9375]>].fail[<element[7.5625].mul[<context.value.sub[.95454545]>].mul[<context.value.sub[.95454545]>].add[0.984375]>]>]>]>
        parse_list:
            - determine <tern[<context.value.type.is[==].to[List]>].pass[<context.value>].fail[<context.value.as_list>]>
        command_usage:
            - announce to_console <server.scripts>
            - define c <script[__lib_config].data_key[color.command]>
            - define fs <[c].get[fs]>
            - define lb <[c].get[lb]>
            - define rb <[c].get[rb]>
            - define lt <[c].get[lt]>
            - define gt <[c].get[gt]>
            - define lp <[c].get[lp]>
            - define rp <[c].get[rp]>
            - define rc <[c].get[rc]>
            - define lc <[c].get[lc]>
            - determine <script[__generic_lib_data].data_key[command.usage.<context.value>].parsed.parsed>

# --------------------WORLD SCRIPTS-------------------- #

lib_events:
    type: world
    debug: false
    events:
        on player places bedrock priority:1051:
            - define lib <custom_object[co_lib]>
            - if <[lib].has.permission[<player>|utilities.random_placement]>:
                - if <context.item_in_hand.custom_model_data||-1> == <script[U_generic_data].data_key[custom_model_data_offset].add[1]>:
                    - define block <material[<proc[random_by_weight].context[<player.flag[U_rand_placer].as_map||<map>>]||false>]||false>
                    - if <[block]> == false:
                        - narrate "<red>List is empty."
                    - else if <[block].is_directional||false> != false:
                        - adjust def:block direction:<list[north|south|east|west].closest_to[<player.location.direction>]>
                    - modifyblock <context.location> <tern[<[block].is[==].to[false]>].pass[air].fail[<[block]>]>
            - else:
                - narrate "<red>You do not have permission to use the Random Placer Tool."
        on player drops bedrock priority:1051:
            - if <context.item.custom_model_data||-1> == <script[U_generic_data].data_key[custom_model_data_offset].add[1]>:
                - remove <context.entity>
        on player clicks bedrock in inventory priority:1051:
            - if <context.item.custom_model_data||-1> == <script[U_generic_data].data_key[custom_model_data_offset].add[1]>:
                - take slot:<context.slot>
        on player drops stick priority:1051:
            - if <context.item.nbt[notable_tool]||false>:
                - flag player U_notable_tool:<map.with[type].as[1].with[data].as[<list>].with[valid].as[false]>
                - remove <context.entity>
        on player clicks stick in inventory priority:1051:
            - if <context.item.nbt[notable_tool]||false>:
                - determine passively cancelled
                - flag player U_notable_tool:<map.with[type].as[1].with[data].as[<list>].with[valid].as[false]>
                - take slot:<context.slot>
        on player right clicks block with:stick priority:1051:
            - if <context.item.nbt[notable_tool]||false>:
                    - define flag_map <player.flag[U_notable_tool].as_map>
                    - if <player.is_sneaking>:
                        - define new_index <proc[cycle_value].context[1|3|<[flag_map].get[type].add[1]>]>
                        - flag player U_notable_tool:<[flag_map].with[type].as[<[new_index]>].with[data].as[<list>].with[valid].as[false]>
                        - flag player U_actionbar:!
                        - wait 1t
                        - flag player U_actionbar:true
                        - foreach <proc[cycle_rainbow_text].context[<list[LOCATION|CUBOID|ELLIPSOID].get[<[new_index]>]>|100|5|<proc[random_color].with_saturation[255].with_brightness[255]>]>:
                            - if <player.has_flag[U_actionbar].not>:
                                - foreach stop
                            - wait 1t
                            - actionbar "Current selection type: <[value]>"
                        - flag player U_actionbar:!
                    - else:
                        - define location <context.location||<player.eye_location.forward[5].round_down>>
                        - define loc_data <[flag_map].get[data].as_list>
                        - choose <[flag_map].get[type]>:
                            - case 1:
                                - define flag_map <[flag_map].with[data].as[<[location]>].with[valid].as[<[location]>]>
                                - define msg "<gray>Location<green> ( <gray>x: <white><[location].x> <gray>y: <white><[location].y> <gray>z: <white><[location].z><green> )"
                            - case 2:
                                - define flag_map <[flag_map].with[data].as[<tern[<list[0|1].contains[<[loc_data].size>]>].pass[<[loc_data].include[<[location]>]>].fail[<[loc_data].set[<[location]>].at[2]>]>].with[valid].as[<tern[<[loc_data].size.is[OR_MORE].to[1]>].pass[<[flag_map].get[data].first.to_cuboid[<[location]>]>].fail[false]>]>
                                - define loc_data <[flag_map].get[data].as_list>
                                - define msg "<gray>Cuboid<green> ( <white><[loc_data].first.x><gray>; <white><[loc_data].first.y><gray>; <white><[loc_data].first.z> <gray>↔ <white><tern[<[loc_data].size.is[MORE].than[1]>].pass[<[loc_data].last.x><gray>; <white><[loc_data].last.y><gray>; <white><[loc_data].last.z>].fail[?]><green> )"
                            - case 3:
                                - define loc <[loc_data].get[2].sub[<[location]>]||<location[0,0,0,world]>>
                                - define index <[loc_data].get[1]||1>
                                - define radius <list[<[loc].x>|<[loc].y>|<[loc].z>].get[<proc[cycle_value].context[1|3|<[index]>]>].abs>
                                - define flag_map <[flag_map].with[data].as[<tern[<[loc_data].size.is[==].to[0]>].pass[<list[1|<[location]>]>].fail[<tern[<list[2|3|4].contains[<[loc_data].size>]>].pass[<[loc_data].include[<[radius]>].set[<[index].add[1]>].at[1]>].fail[<[loc_data].set[<[radius]>].at[<proc[cycle_value].context[3|5|<[index].sub[1]>]>].set[<[index].add[1]>].at[1]>]>]>]>
                                - define loc_data <[flag_map].get[data].as_list>
                                - define flag_map <[flag_map].with[valid].as[<tern[<[loc_data].size.is[==].to[5]>].pass[<ellipsoid[<[loc_data].get[2].x>,<[loc_data].get[2].y>,<[loc_data].get[2].z>,<[loc_data].get[2].world>,<[loc_data].get[3]>,<[loc_data].get[4]>,<[loc_data].get[5]>]>].fail[false]>]>
                                - define msg "<gray>Ellipsoid<green> ( <gray>center: <white><[loc_data].get[2].x><gray>; <white><[loc_data].get[2].y><gray>; <white><[loc_data].get[2].z> <gray>radii: <yellow><&lb> <gray>x: <white><tern[<[loc_data].size.is[MORE].than[2]>].pass[<white><[loc_data].get[3]>].fail[?]> <gray>y: <white><tern[<[loc_data].size.is[MORE].than[3]>].pass[<white><[loc_data].get[4]>].fail[?]> <gray>z: <white><tern[<[loc_data].size.is[MORE].than[4]>].pass[<white><[loc_data].get[5]>].fail[?]> <yellow><&rb> <green>)"
                        - flag player U_notable_tool:<[flag_map]>
                        - narrate <[msg]>
                        - inject locally display_particle_effect
        after player scrolls their hotbar priority:1051:
            - if <player.item_in_hand.nbt[notable_tool]||false>:
                - inject locally display_particle_effect
    display_particle_effect:
        - define flag_map <player.flag[U_notable_tool].as_map||false>
        - define data <[flag_map].get[valid]||false>
        - if <[flag_map]> != false && <[data]> != false:
            - define outline <proc[<tern[<[flag_map].get[type].is[==].to[3]>].pass[shell].fail[outline]>_<tern[<[flag_map].get[type].is[==].to[1]>].pass[location].fail[<tern[<[flag_map].get[type].is[==].to[2]>].pass[cuboid].fail[ellipsoid]>]>].context[<[data]>]>
            - define i 0
            - flag player U_notable_particles:true
            - while <player.item_in_hand.nbt[notable_tool]||false> && <player.flag[U_notable_particles]||false> != false:
                - flag player U_notable_particles:false
                - define i:++
                - if <[i]> == 5:
                    - playeffect effect:flame at:<[outline]> offset:0 targets:<player>
                    - define i 0
                - define flag_map <player.flag[U_notable_tool].as_map||false>
                - define new_data <[flag_map].get[valid]||false>
                - if <[new_data]> != <[data]>:
                    - if <[new_data]> == false:
                        - while stop
                    - define outline <proc[<tern[<[flag_map].get[type].is[==].to[3]>].pass[shell].fail[outline]>_<tern[<[flag_map].get[type].is[==].to[1]>].pass[location].fail[<tern[<[flag_map].get[type].is[==].to[2]>].pass[cuboid].fail[ellipsoid]>]>].context[<[new_data]>]>
                    - define data <[new_data]>
                - wait 1t
                - flag player U_notable_particles:true

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
    debug: true
    description: Gives a player a permission, using Denizen's flag system.<&nl><&nl>Not a true permission system. If the player argument is not filled, then command defaults to player running the command. By default, command will only run if you have OP level permissions or higher.<&nl>If the first argument is marked as "view", the command will instead display all of the player's current permissions. If the first is marked as "clear", the command will instead remove all of the specified player's permissions after the specified node.<&nl>Uses a node system. A * node counts as a wildcard for everything below that node. In otherwords, if you have perm1.*, you have permissions for everything underneath perm1. Giving a permission of a higher level, which is to say, perm1 over perm1.subperm1, will overwrite all lower level permissions. In other words, if a perm1 was given, then removed, the player would no longer have any perm1 permissions, including perm1.subperm1.
    usage: <custom_object[_co_lib_core].command_usage[simple_permissions]>
    allowed help:
        - determine <player.is_op||true>
    script:
        - inject lib_tasks.setup
        # ~~ definitions ~~ #
        - define a <[map].get[action].to_lowercase||set>
        - define b <[map].get[player]||<player||<[nil]>>>
        - define action <tern[<list[set|view|clear].contains[<[a]>]>].pass[<[a]>].fail[<[nil]>]>
        - define player <[lib].player_obj_by_name[<[b]>]>
        - define node   <[map].get[node]||<[nil]>>
        # ~~ asserts ~~ #
        - define error  <[error].command.set[<map.with[usage].as[simple_permissions].with[min_args].as[1].with[max_args].as[3].with[explicit_size].as[<[list].size>]>]>
        - if !<player.is_op||true>:
            - define assert <script[lib_config].data_key[command.error.permission].parsed>
        - define assert <tern[<[assert]>].pass[<[error].command.min_args>].fail[<[assert]>]>
        - define assert <tern[<[assert]>].pass[<[error].command.max_args>].fail[<[assert]>]>
        - define assert <tern[<[assert]>].pass[<[error].command.missing_req[<[player].type.is[!=].to[Player]>|node|<tern[<[b].is_nil||false>].pass[nil].fail[<[b]>]>]>].fail[<[assert]>]>
        - define assert <tern[<[assert]>].pass[<[error].command.missing_req[<[lib].is.nil[<[node]>]>]>].fail[<[assert]>]>
        - define assert <tern[<[assert]>].pass[<[error].command.missing_req[<[lib].is.nil[<[action]>]>].fail[<[assert]>]>]>
        # ~~ logic ~~ #
        - if <[assert]>:
            #<[a]> == "view"
            #- if !<[player_name].is_nil>:
            #    - define player <[lib].player_obj_by_name[<[player_name]>]>
            #    - if <[player].type> == Player:
            #        - if !<[player].has_flag[j_utilities.permissions]>:
            #            - run lib_tasks.flags
            #        - define perm_map <[player].flag[j_utilities.permissions]>
#
            #    - else:
            #        - narrate "<red>Unable to find specified player <gray><[player_name]><red>."
            #- else:
            #    - narrate "<red>Player name is a required argument if the source of the command is a #<dark_gray><context.source_type><red>."
#
            #- define perm_name <context.args.first>
            #- if <[perm_name]> == view:
            #    - define clean_yaml <[perm_map].to_yaml.replace_text[:].replace_text['true'].split[<&nl>]>
            #    - define list <list[<aqua>|<green>|<yellow>|<red>|<light_purple>|<dark_purple>|<light_purple>|<red>|#<yellow>|<green>]>
            #    - foreach <[clean_yaml]>:
            #        - define level "<[value].trim_to_character_set[ ].length.div[2].round_down.add[1]>"
            #        - define clean_yaml "<[clean_yaml].set[<tern[<[loop_index].is[==].to[1]>].pass[].fail[<element[<&#nl>].pad_right[<[level]>]>]><[list].get[<proc[cycle_value].context[1|<[list].size>|<[level]>]>]#><tern[<[level].is[==].to[1]>].pass[╶].fail[╰]><white> <[value].replace_text[<&nl>].replace_text[ #]>].at[<[loop_index]>]>"
            #    - narrate "<gold>----- <white><[player].name><yellow>'s Permissions <gold>-----"
            #    - narrate <[clean_yaml].unseparated>
            #- else if <[perm_name]> == clear:
            #    - flag <[player]> U_simple_permissions:!
            #    - narrate "<yellow>Player <white><[player].name><yellow> has had all of their permissions cleared."
            #- else:
            #    - flag <[player]> U_simple_permissions:<proc[deep_set].context[<[perm_map]>|<[perm_name]>|true]>
            #    - narrate "<yellow>Player <white><[player].name><yellow> has gained the permission <gray><[perm_name]>."
            - define a b
        - else:
            - narrate <[assert]>

# Panic command for users.
#panic_button:
#    type: command
#    name: panic
#    debug: false
#    description: Panic button for the player.<&nl><&nl>Kills all loaded agressive mobs except for players or npcs, sets the time to day, heals the player, clears the weather, and feeds the player, and gives the player resistance.
#    usage: /panic
#    allowed help:
#        - determine <proc[has_permission].context[<player>|utilities.panic]>
#    aliases:
#        - a
#        - aa
#        - aaa
#    script:
#        #- if <proc[has_permission].context[<player>|utilities.panic]>:
#            - run clear_bad_mobs
#            - time 0t
#            - heal 20
#            - weather sunny
#            - feed amount:20
#        #- else:
#        #    - narrate <script[U_generic_data].data_key[command_perm_error].parsed>
#
## Removes all flags dependent on passed argument. If no value is passed, defaults to player who ran the command.
## | Will NOT remove permission flag
#remove_all_flags:
#    type: command
#    name: remove_flags
#    debug: false
#    description: Removes all flags min the specified object, or the player running the command if none specified.
#    usage: /remove_flags <&rb><&gt>player_name/server/all<&lt><&lb>
#    aliases:
#        - removeflags
#        - killflags
#        - kill_flags
#    allowed help:
#        - determine <proc[has_permission].context[<player>|utilities.flags]>
#    script:
#        #- if <proc[has_permission].context[<player>|utilities.flags]>:
#            - define arg <context.args.first||false>
#            - define flag_burned false
#            - if <list[server|all].contains[<[arg]>]>:
#                - foreach <server.list_flags>:
#                    - narrate "<yellow>Removed <gray>server<yellow> flag: <white><[value]>"
#                    - flag server <[value]>:!
#                    - define flag_burned true
#            - define player <proc[player_obj_by_name].context[<[arg]>]>
#            - define player <tern[<[player].is[==].to[false]>].pass[<tern[<[arg].is[==].to[all]>].pass[<player>].fail[<tern[<context.args.is_empty>].pass[<player>].fail[false]>]>].fail[<[player]>]>
#            - if <[player]> != false:
#                - foreach <[player].list_flags>:
#                    - if <[value]> != U_simple_permissions:
#                        - narrate "<yellow>Removed <gray><[player].name><yellow> flag: <white><[value]>"
#                        - flag player <[value]>:!
#                        - define flag_burned true
#            - if <[flag_burned].not>:
#                - narrate "<yellow>No flags to remove min <gray><tern[<[arg].is[==].to[false]>].pass[<[player].name>].fail[<[arg]>]>."
#        #- else:
#        #    - narrate <script[U_generic_data].data_key[command_perm_error].parsed>
#
## Removes all notables dependent on passed argument. If no value is passed, defaults to all notables.
## | Will NOT remove permission flag
#remove_all_notables:
#    type: command
#    name: remove_notables
#    debug: false
#    description: Removes all notables of whatever type was passed, or all notables if no argument passed.
#    usage: /remove_flags <&rb><&gt>location/cuboid/ellipsoid/inventory/all<&lt><&lb>
#    aliases:
#        - removenotables
#        - killnotables
#        - kill_notables
#    allowed help:
#        - determine <proc[has_permission].context[<player>|utilities.notables]>
#    script:
#        #- if <proc[has_permission].context[<player>|utilities.notables]>:
#            - define arg <context.args.first||all>
#            - define arg <[arg].to_lowercase>
#            - define note_burned false
#            - if <list[location|locations|all].contains[<[arg]>]>:
#                - foreach <server.notables[locations]>:
#                    - narrate "<yellow>Removed noted <gray>location<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <list[cuboid|cuboids|all].contains[<[arg]>]>:
#                - foreach <server.notables[cuboids]>:
#                    - narrate "<yellow>Removed noted <gray>cuboid<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <list[ellipsoid|ellipsoids|all].contains[<[arg]>]>:
#                - foreach <server.notables[ellipsoids]>:
#                    - narrate "<yellow>Removed noted <gray>ellipsoid<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <list[inventory|inventorys|all].contains[<[arg]>]>:
#                - foreach <server.notables[inventorys]>:
#                    - narrate "<yellow>Removed noted <gray>inventory<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <[note_burned].not>:
#                - narrate "<yellow>No notables to remove<tern[<[arg].is[==].to[all]>].pass[].fail[ min <gray><[arg]>]><yellow>."
#        #- else:
#        #    - narrate <script[U_generic_data].data_key[command_perm_error].parsed>
#
## Tool for randomly placing blocks
#random_placement:
#    type: command
#    name: rand_placer
#    debug: false
#    description: Gives tool for placing blocks randomly, based on a predefined list, or defines list.<&nl>If running the command with no arguments, recieve the random placement tool. It should look like a bedrock block by default, or if you have the utilities texture pack installed, will be an animated block. When the block is placed, it will choose one of the blocks previously defined with the rand_placer command, based on weight. The higher the weight, the more chance the block will be placed. If no blocks have been defined, will recieve an error message.<&nl>If you'd like to add a block to the list, simply type the command, along with the name of the block that you would use if you were using the give command (i.e., redstone_ore instead of Redstone Ore), as well as the weight you'd like for that block. Weights can be any reasonable number above 1. 10,000 is okay, 10 billion is not. If you don't provide a weight, block will be added with a weight of 1. If you'd like to create a new list, you can clear your previous list by simply passing "clear" as the first argument.
#    usage: /rand_placer <&rb><&gt>block_name<&lt>/clear<&lb> <&rb><&gt>weight<&lt><&lb>
#    aliases:
#        - rplace
#    allowed help:
#        - determine <proc[has_permission].context[<player>|utilities.random_placement]>
#    script:
#        #- if <proc[has_permission].context[<player>|utilities.random_placement]>:
#            - define err_msg false
#            - if <context.args.size> > 2:
#                - define err_msg "Too many arguments! Did you add a space for the item name instead of an underscore?"
#            - else if <context.args.size> > 0 && <element[<material[<context.args.first>]||<material[stick]>>].as_material.is_block.not> && <context.args.first> != clear:
#                - define err_msg "Not able to find a block called <gray><context.args.first><red>. Double check that you spelled it correctly."
#            - else if <context.args.size> == 2 && <context.args.last.is_decimal.not>:
#                - define err_msg "<gray><context.args.last><red> is not a numeric value."
#            - if <[err_msg]> != false:
#                - narrate <red><[err_msg]>
#                - stop
#            - if <player.has_flag[U_rand_placer].not>:
#                - flag player U_rand_placer:<map>
#            - define curr_flag <player.flag[U_rand_placer].as_map>
#            - if <context.args.size> == 0:
#                - if <player.item_in_hand.material.name> != air:
#                    - take iteminhand
#                - give "bedrock[enchantments=vanishing_curse,1;hides=all;display_name=<&r>Random Placer Tool;custom_model_data=<script[U_generic_data].data_key[custom_model_data_offset].add[1]>]" slot:<player.held_item_slot>
#            - else:
#                - if <context.args.first> == clear:
#                    - flag player U_rand_placer:<map>
#                    - narrate "<yellow>List cleared."
#                - else:
#                    - define weight <tern[<context.args.size.is[==].to[1]>].pass[1].fail[<context.args.last>]>
#                    - flag player U_rand_placer:<[curr_flag].with[<context.args.first>].as[<[weight]>]>
#                    - narrate "<yellow>Added <gray><context.args.first><yellow> with a weight of <gray><[weight]><yellow>."
#        #- else:
#        #    - narrate <script[U_generic_data].data_key[command_perm_error].parsed>
#
## Removes all notables dependent on passed argument. If no value is passed, defaults to all notables.
## | Will NOT remove permission flag
#remove_all_notables:
#    type: command
#    name: remove_notables
#    debug: false
#    description: Removes all notables of whatever type was passed, or all notables if no argument passed.
#    usage: /remove_notables <&rb><&gt>location/cuboid/ellipsoid/inventory/all<&lt><&lb>
#    aliases:
#        - removenotables
#        - killnotables
#        - kill_notables
#    allowed help:
#        - determine <proc[has_permission].context[<player>|utilities.notables]>
#    script:
#        #- if <proc[has_permission].context[<player>|utilities.notables]>:
#            - define arg <context.args.first||all>
#            - define arg <[arg].to_lowercase>
#            - define note_burned false
#            - if <list[location|locations|all].contains[<[arg]>]>:
#                - foreach <server.notables[locations]>:
#                    - narrate "<yellow>Removed noted <gray>location<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <list[cuboid|cuboids|all].contains[<[arg]>]>:
#                - foreach <server.notables[cuboids]>:
#                    - narrate "<yellow>Removed noted <gray>cuboid<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <list[ellipsoid|ellipsoids|all].contains[<[arg]>]>:
#                - foreach <server.notables[ellipsoids]>:
#                    - narrate "<yellow>Removed noted <gray>ellipsoid<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <list[inventory|inventorys|all].contains[<[arg]>]>:
#                - foreach <server.notables[inventorys]>:
#                    - narrate "<yellow>Removed noted <gray>inventory<yellow>: <white><[value].note_name>"
#                    - note remove as:<[value].note_name>
#                    - define note_burned true
#            - if <[note_burned].not>:
#                - narrate "<yellow>No notables to remove<tern[<[arg].is[==].to[all]>].pass[].fail[ min <gray><[arg]>]><yellow>."
#        #- else:
#        #    - narrate <script[U_generic_data].data_key[command_perm_error].parsed>
#
## Gives you a tool that allows you to note locations, cuboids, and ellipsoids with a visual effect for extra clarity.
#notable_tool:
#    type: command
#    name: notable_tool
#    debug: false
#    description: Gives a tool that allows you to specify locations, cuboids and ellipsoids, and save (note) them.<&nl>To recieve the tool, simply pass the command with no arguments. To change between selection type, shift right click. NOTE! If you change selection type, you will LOSE the previous selection.<&nl>For locations, you only need to right click on the single block to set the location. For cuboids, the first right click will set one corner, and every click after will set the other corner. If you need to change the location of the first corner, pass the "clear" argument to the command.<&nl>Ellipsoids are a little more complicated. The first right click will set the center of the ellipsoid. The second, third and fourth clicks will set the X, Y, and Z radii. If you click for a fifth time, you will set the X radius again, the sixth click will set the Y a radius, and so on. If you need to recenter the ellipsoid, pass the "clear" argument.<&nl>Once you've decided you have the right selection, pass the save argument, along with the name of the notable. Make sure there are no spaces in the notable's name or the command will fail.
#    usage: /notable_tool <&rb>save/clear<&lb> (<&lt>save_name<&gt>)
#    aliases:
#        - ntool
#    allowed help:
#        - determine <proc[has_permission].context[<player>|utilities.notable_tool]>
#    script:
#        #- if <proc[has_permission].context[<player>|utilities.notable_tool]>:
#            - define err_msg false
#            - if <context.args.size> > 2:
#                - define err_msg "Too many arguments! Did you place a space in the notable's name?"
#            - else if <list[clear|save].contains[<element[<context.args.first||save>].to_lowercase>].not>:
#                - define err_msg "<gray><context.args.first><red> is not a valid argument."
#            - if <[err_msg]> != false:
#                - narrate <red><[err_msg]>
#            - else if <context.args.size> == 0:
#                - if <player.item_in_hand.material.name> != air:
#                    - take iteminhand
#                - give "stick[display_name=<&r><aqua>Notable Tool;nbt=notable_tool/true]" slot:<player.held_item_slot>
#                - flag player U_notable_tool:<map.with[type].as[1].with[data].as[<list>].with[valid].as[false]>
#                - flag player U_actionbar:!
#                - wait 1t
#                - flag player U_actionbar:true
#                - foreach <proc[cycle_rainbow_text].context[LOCATION|100|5|<proc[random_color].with_saturation[255].with_brightness[255]>]>:
#                    - if <player.has_flag[U_actionbar].not>:
#                        - foreach stop
#                    - wait 1t
#                    - actionbar "Current selection type: <[value]>"
#                - flag player U_actionbar:!
#            - else:
#                - define flag_map <player.flag[U_notable_tool].as_map>
#                - define sel_type <list[Location|Cuboid|Ellipsoid].get[<[flag_map].get[type]>]>
#                - if <context.args.first> == save:
#                    - if <context.args.size> != 2:
#                        - narrate "<red>Missing <gray>save_name <red>argument!"
#                    - else:
#                        - define success_msg "<gray><[sel_type]><white> <context.args.last> <yellow>was saved."
#                        - define size <[flag_map].get[data].size||0>
#                        - define data_list <[flag_map].get[data]>
#                        - define construct <[flag_map].get[valid]>
#                        - define msg "<tern[<[sel_type].is[==].to[Location]>].pass[<tern[<[construct].is[!=].to[false]>].pass[<[success_msg]>].fail[<red>No <gray>location <red>has been set!]>].fail[<tern[<[sel_type].is[==].to[Cuboid]>].pass[<tern[<list[0|1].contains[<[size]>].not>].pass[<tern[<[data_list].first.world.is[==].to[<[data_list].last.world>]>].pass[<[success_msg]>].fail[<red>Unable to form <gray>cuboid <red>with locations in different dimensions!]>].fail[<gray>Cuboid <red>is missing <white><list[2|1].get[<[size].add[1]>]><red> location<tern[<[size].is[==].to[1]>].pass[].fail[s]>!]>].fail[<tern[<[size].is[==].to[5]>].pass[<[success_msg]>].fail[<red>Missing <white><tern[<list[4|3|2].contains[<[size]>]>].pass[<tern[<[size].is[==].to[4]>].pass[z].fail[<tern[<[size].is[==].to[3]>].pass[y].fail[x]>]>-radius].fail[center]><red> for <gray>ellipsoid<red>.]>]>]>"
#                        - if <[construct]> != false:
#                            - note <[construct]> as:<context.args.last>
#                        - narrate <[msg]>
#                - else:
#                    - narrate "<gray><[sel_type]><yellow> selection cleared."
#                    - flag player U_notable_tool:<map.with[type].as[<[flag_map].get[type]>].with[data].as[<list>].with[valid].as[false]>
#        #- else:
#        #    - narrate <script[U_generic_data].data_key[command_perm_error].parsed>
#
##Allows you to simulate taking control of an NPC
#puppet_npc:
#    type: command
#    name: puppet
#    debug: false
#    description: Allows you to "puppet" an NPC.<&nl>Run the command with an NPC's name to puppet that NPC on the map specifically, or run it with no name to puppet the closest NPC within 5 blocks. If there are multiple NPC's with the same name, it will puppet the one with the name that is closest to you.<&nl>Run the command a second time to stop puppeting the NPC. Players will be set to survival when beginning the puppet, then set to spectator when cancelling the puppet.
#    usage: /puppet (<&lt>npc_name<&gt>)
#    script:
#        - define no_arg <element[false].is[==].to[<context.args.first||false>]>
#        - if <player.flag[U_puppet]||true>:
#            - define npc <tern[<[no_arg]>].pass[<player.location.find.npcs.within[5].first||false>].fail[<proc[find_nearest_npc_by_name].context[<player.location>|<context.args.first>]>]>
#            - if <[npc]> != false:
#                - flag player U_puppet:<map.with[name].as[<player.name>].with[skin].as[<player.skin_blob>].with[npc].as[<[npc]>]>
#                - teleport <player> <[npc].location>
#                - adjust <player> display_name:<[npc].nickname>
#                - adjust <player> health:<[npc].health>
#                - adjust <player> skin_blob:<[npc].skin_blob>
#                - adjust <player> gamemode:survival
#                - despawn <[npc]>
#            - else:
#                - narrate "<red><tern[<[no_arg]>].pass[No <gray>NPC<red> found within <gray>5<red> blocks.].fail[Unable to find an <gray>NPC<red> by the name <white><context.args.first><red>.]>"
#        - else:
#            - define data <player.flag[U_puppet].as_map>
#            - flag player U_puppet:false
#            - spawn <[data].get[npc]> <player.location>
#            - adjust <player> gamemode:spectator
#            - adjust <player> display_name:<[data].get[name]>
#            - adjust <player> skin_blob:<[data].get[skin]>
#
##Ends all currently running queues
#end_queues:
#    type: command
#    name: end_queues
#    debug: false
#    description: Allows you to end all currently running queues on the server.<&nl>WARNING<&co> This is a nuclear option! This is only meant to be used in cases where you have infintely looping queues that you want to end without wanting to restart the whole server. Do not use this command within a script!
#    usage: /end_queues
#    aliases:
#        - killqueues
#        - kill_queues
#        - killqs
#    allowed help:
#        - determine <proc[has_permission].context[<player>|utilities.end_queues]>
#    script:
#        #- if <proc[has_permission].context[<player>|utilities.end_queues]>:
#            - if <queue.list.size> == 1:
#                - narrate "<red>No currently running queues!"
#            - else:
#                - foreach <queue.list.exclude[<queue>]> as:queue:
#                    - narrate "<yellow>Ending queue <white><[queue].id>..."
#                    - queue stop <[queue]>
#        #- else:
#        #    - narrate <script[U_generic_data].data_key[command_perm_error].parsed>
#