co_lib_random:
    type: custom
    debug: true
    inherit: co_base
    tags:
        type:
            - determine Library.Random
        pitch:
            - determine <util.random.gauss.div[6].add[1]>
        color:
            - determine <&color[<context.this.random_color_tag>]>
        color_tag:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define min_sat <tern[<[list].get[1]||true>].pass[100].fail[<[list].get[1]>]>
            - define min_val <tern[<[list].get[2]||true>].pass[100].fail[<[list].get[2]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[random.color_tag].with[max_args].as[2].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[min_sat]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[min_val]>]>]>
             # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<color[255,0,0].with_hue[<util.random.int[0].to[255]>].with_saturation[<util.random.int[<[config].data_key[random_color.min_sat]>].to[255]>].with_brightness[<util.random.int[<[config].data_key[random_color.min_val]>].to[255]>]>]>
        text:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define length <tern[<[list].get[1]||true>].pass[10].fail[<[list].get[1]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[random.text].with[max_args].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[length]>]>]>
             # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<[lib_data].data_key[alphabet_set].to_list.random[<[length]>].unseparated>]>
        uppercase:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define element <[list].get[1]||<[nil]>>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[random.uppercase].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[element]>|Element]>]>
             # ~~ logic ~~ #
            - if !<[assert]>:
                - define counter 1
                - define type true
                - foreach <[element].to_list>:
                    - if <[value]> == <&sp>:
                        - define result:->:<&sp>
                    - else:
                        - define flip <util.random.boolean>
                        - define counter <tern[<[flip].is[==].to[<[type]>]>].pass[<[counter].add[1]>].fail[1]>
                        - define type <[flip]>
                        - if <[counter]> > 2:
                            - define flip <[flip].not>
                            - define counter 1
                        - define result:->:<tern[<[flip]>].pass[<[value].to_uppercase>].fail[<[value].to_lowercase>]>
                - determine <[result].unseparated>
            - else:
                - determine <[nil]>
        by_weight:
            #definitions: map
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define map <[list].get[1]||false>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[random_by_weight].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define passed:->:<[map]>
                - define passed:->:Map
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[passed]>]>]>
                - define non_nums <[map].values.filter[is_decimal.not]||<list>>
                - if <[non_nums].size> > 0:
                    - define assert true
                    - define number <[non_nums].comma_separated>
                    - debug error <script[lib_config].data_key[error_messages].get[not_number].parsed>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define rand <util.random.decimal.mul[<[map].values.sum>]>
                - if <[rand]> == 1:
                    - define rand:-:<context.this.epsilon>
                - foreach <[map]> key:weight:
                    - if <[rand]> <= <[weight]>:
                        - determine <[value]>
                    - define rand:-:<[weight]>
            - else:
                - determine <[nil]>

# ~ ~ ~ ~ #

co_lib_has:
    type: custom
    debug: true
    inherit: co_base
    tags:
        type:
            - determine Library.Has
        alpha:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[has.alpha].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<context.value.to_lowercase.contains_any_text[<[lib_data].data_key[alphabet_set].to_list>]>]>
        numeric:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[has.numeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
             # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<context.value.contains_any_text[<[lib_data].data_key[number_set].to_list>]>]>
        alphanumeric:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define title  has.alphanumeric
            - define alpha  <context.this.alpha[<context.value>]>
            - define number <context.this.numeric[<context.value>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[has.alphanumeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].empty[<[alpha]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].empty[<[number]>]>]>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<[alpha].or[<[number]>]>]>
        has_permission:
            #definitions: permission|player
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define permission <[list].get[1]||<[nil]>>
            - define player     <tern[<[list].get[2]||true>].pass[<player||false>].fail[<[list].get[2]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[has_permission].with[max_args].as[2].with[min_args].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].min_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[permission]>|Element]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[player]>|Player]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define permission_map <player.flag[j_utilities.permissions]||nil>
                - if <[permission_map]> == nil:
                    - announce to_console "<yellow>Tried to access j_utilities flag but found nothing! Running flag setup..."
                    - inject lib_tasks.flags
                - define has_permission <[permission_map].deep_get[<[permission]>]||false>
                - if !<[has_permission]>:
                    - while <[permission].contains[.]> && !<[has_permission]>:
                        - define permission     <[permission].before_last[.]>
                        - define has_permission <[permission_map].deep_get[<[permission]>.*]||false>
                - determine <[has_permission]>
            - else:
                - determine <[nil]>

# ~ ~ ~ ~ #

co_lib_is:
    type: custom
    debug: false
    inherit: co_base
    tags:
        type:
            - determine Library.Is
        alpha:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[is.alpha].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<context.value.to_lowercase.matches_character_set[<[lib_data].data_key[alphabet_set]>]>]>
        numeric:
            - announce to_console "<yellow>NOTE: is.numeric is ONLY a wrapper for '<&lt>elementTag.is_integer<&gt>'!"
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[is.numeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<context.value.is_integer>]>
        alphanumeric:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[is.alphanumeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<[lib_data].data_key[alphabet_set]><[lib_data].data_key[number_set]>]>
        nil:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error <[error].set[<map.with[title].as[is.nil].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<context.value.is_nil||false>]>

# ~ ~ ~ ~ #

co_lib_as:
    type: custom
    debug: false
    inherit: co_base
    tags:
        type:
            - determine Library.As
        alpha:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[as.alpha].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<[lib_data].data_key[alphabet_set].to_uppercase><[lib_data].data_key[alphabet_set]>]>
        numeric:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[as.numeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<context.value.trim_to_character_set[<[lib_data].data_key[number_set]>]>]>
        alphanumeric:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[as.alphanumeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<context.value.trim_to_character_set[<[lib_data].data_key[alphabet_set].to_uppercase><[lib_data].data_key[alphabet_set]><[lib_data].data_key[number_set]>]>]>
        nonalpha:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[as.nonalpha].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<context.value.to_list.replace[<[lib_data].data_key[alphabet_set].to_uppercase.to_list.include[<[lib_data].data_key[alphabet_set].to_list>]>].unseparated>]>
        nonnumeric:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[as.nonnumeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<context.value.to_list.replace[<[lib_data].data_key[number_set].to_list>].unseparated>]>
        nonalphanumeric:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[as.nonalphanumeric].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
            # ~~ logic ~~ #
            - determine <tern[<[error]>].pass[<[nil]>].fail[<context.value.to_list.replace[<[lib_data].data_key[alphabet_set].to_uppercase.to_list.include[<[lib_data].data_key[alphabet_set].to_list>].include[<[lib_data].data_key[number_set].to_list>]>].unseparated>]>

# ~ ~ ~ ~ #

co_lib:
    type: custom
    debug: false
    inherit: co_base
    tags:
        type:
            - determine Library
        has:
            - determine <custom_object[co_lib_has]>
        random:
            - determine <custom_object[co_lib_random]>
        is:
            - determine <custom_object[co_lib_is]>
        as:
            - determine <custom_object[co_lib_as]>
        epsilon:
            - determine <script[generic_lib_data].data_key[epsilon]>
        phi:
            - determine <script[generic_lib_data].data_key[phi]>
        alphabet_set:
            - determine <script[generic_lib_data].data_key[alphabet_set]>
        alphabet_list:
            - determine <script[generic_lib_data].data_key[alphabet_set].to_list>
        map_range:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define in_start  <[list].get[1]||false>
            - define in_end    <[list].get[2]||false>
            - define out_start <[list].get[3]||false>
            - define out_end   <[list].get[4]||false>
            - define input     <[list].get[5]||false>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[map_range].with[arg_amount].as[5].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[in_start]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[in_end]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[out_start]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[out_end]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[input]>]>]>
                # - Standard invalid range is less than OR equal, this can NOT be equal.
                - if !<[assert]> && ( <[in_start]> >= <[in_end]> ):
                    - define assert true
                    - debug error "Invalid range; The first value <&sq><[in_start]><&sq> must be less than the second value <&sq><[in_end]><&sq>."
                - if !<[assert]> && ( <[out_start]> >= <[out_end]> ):
                    - define assert true
                    - debug error "Invalid range; The third value <&sq><[out_start]><&sq> must be less than the second value <&sq><[out_end]><&sq>."
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<[input].sub[<[in_start]>].div[<[in_end].sub[<[in_start]>]>].mul[<[out_end].sub[<[out_start]>]>].add[<[out_start]>]>]>
        cycle_value:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define min   <[list].get[1]||false>
            - define max   <[list].get[2]||false>
            - define input <[list].get[3]||false>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[cycle_value].with[arg_amount].as[3].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[min]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[max]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[input]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].invalid_range[<[min]>|<[max]>]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - if <[input]> < <[min]> || <[input]> > <[max]>:
                    - define is_more <[input].is[MORE].than[<[max]>]>
                    - define delta_1 <[max].sub[<[min]>].add[1]>
                    - define delta_2 <[input].sub[<tern[<[is_more]>].pass[<[max]>].fail[<[min]>]>].div[<[delta_1]>].abs.round_up.mul[<[delta_1]>]>
                    - determine <tern[<[is_more]>].pass[<[input].sub[<[delta_2]>]>].fail[<[input].add[<[delta_2]>]>]>
                - else:
                    - determine <[input]>
            - else:
                - determine <[nil]>
        rainbow_text:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define text      <[list].get[1]||<[nil]>>
            - define color     <tern[<[list].get[2]||true>].pass[<context.this.random.color_tag>].fail[<[list].get[2]>]>
            - define increment <tern[<[list].get[3]||true>].pass[15].fail[<[list].get[3]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[rainbow_text].with[max_args].as[3].with[min_args].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].min_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[text]>|Element]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[color]>|Color]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[increment]>]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define result <list>
                - foreach <[text].to_list> as:chr:
                    - define result <[result].include[<&color[<[color]>]><[chr]>]>
                    - define color  <[color].with_hue[<[color].hue.add[<[increment]>]>]>
                - determine <[result].unseparated>
            - else:
                - determine <[nil]>
        animated_rainbow_text:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define text      <[list].get[1]||<[nil]>>
            - define color     <tern[<[list].get[2]||true>].pass[<context.this.random.color_tag>].fail[<[list].get[2]>]>
            - define text_inc  <tern[<[list].get[3]||true>].pass[15].fail[<[list].get[3]>]>
            - define delta_inc <tern[<[list].get[4]||true>].pass[15].fail[<[list].get[4]>]>
            - define length    <tern[<[list].get[5]||true>].pass[20].fail[<[list].get[5]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[animated_rainbow_text].with[max_args].as[5].with[min_args].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].min_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[text]>|Element]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[color]>|Color]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[text_inc]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[delta_inc]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[length]>]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define result <list>
                - repeat <[length]>:
                    - define result <[result].include[<context.this.rainbow_text[<[text]>|<[color]>|<[text_inc]>]>]>
                    - define text_inc:+:<[delta_inc]>
                - determine <[result].unseparated>
            - else:
                - determine <[nil]>
        numeric_list:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define min <[list].get[1]||false>
            - define max <[list].get[2]||false>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[numeric_list].with[arg_amount].as[2].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[min]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[max]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].invalid_range[<[min]>|<[max]>]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - if <[max]> < 0:
                    # -x -> -y
                    - determine <util.list_numbers_to[<[min].mul[-1]>].get[<[to].mul[-1]>].to[last].reverse.parse[mul[-1]]>
                - else if <[max]> == 0 && <[min]> < 0:
                    # -x -> 0
                    - determine <util.list_numbers_to[<[min].mul[-1]>].reverse.include[0].parse[mul[-1]]>
                - else if <[max]> > 0 && <[min]> < 0:
                    # -x -> +y
                    - determine <util.list_numbers_to[<[min].mul[-1]>].reverse.include[0].parse[mul[-1]].include[<util.list_numbers_to[<[max]>]>]>
                - else if <[max]> == 0 && <[min]> == 0:
                    # 0 -> 0
                    - determine <list[0]>
                - else if <[min]> == 0:
                    # 0 -> +y
                    - determine <list[0].include[<util.list_numbers_to[<[max]>]>]>
                - else:
                    # +x -> +y
                    - determine <util.list_numbers_to[<[max]>].get[<[min]>].to[<[max]>]>
            - else:
                - determine <[nil]>
        farthest_from_zero:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[farthest_from_zero].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define non_nums <[list].filter[is_decimal.not]||<list>>
                - if <[non_nums].size> > 0:
                    - define assert true
                    - define number <[non_nums].comma_separated>
                    - debug error <script[lib_config].data_key[error_messages].get[not_number].parsed>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define highest <[list].highest>
                - define lowest  <[list].lowest>
                - define highest_abs <[highest].abs>
                - define lowest_abs  <[lowest].abs>
                - determine <tern[<[highest_abs].is[==].to[<[lowest_abs]>]>].pass[<list[<[highest]>|<[list].find[<[highest]>]>|<[lowest]>|<[list].find[<[lowest]>]>]>].fail[<tern[<[highest_abs].is[MORE].than[<[lowest_abs]>]>].pass[<list[<[highest]>|<[list].find[<[highest]>]>]>].fail[<list[<[lowest]>|<[list].find[<[lowest]>]>]>]>]>
            - else:
                - determine <[nil]>
        normalize:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define farthest_list <context.this.farthest_from_zero[<[list]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[normalize].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].empty[<[farthest_list]>]>]>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<[list].parse[div[<[farthest_list].first.abs>]]>]>
        clamp:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define min   <[list].get[1]||false>
            - define max   <[list].get[2]||false>
            - define input <[list].get[3]||false>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[clamp].with[arg_amount].as[3].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[min]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[max]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[input]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].invalid_range[<[min]>|<[max]>]>]>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<tern[<[input].is[MORE].than[<[max]>]>].pass[<[max]>].fail[<tern[<[input].is[LESS].than[<[min]>]>].pass[<[min]>].fail[<[input]>]>]>]>
        fill_list:
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # - While unlikely, a procedure called "false" is a valid procedure name. You however, can not have a
            # - # as a procedure name, since it then becomes a comment
            - define proc_name <[list].get[1]||#>
            - define number    <[list].get[2]||false>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[fill_list].with[arg_amount].as[2].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[number]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<script[<[proc_name]>]>|Container]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define result <list>
                - repeat <[number]>:
                    - define result:->:<proc[<[proc_name]>]>
                - determine <[result]>
            - else:
                - determine <[nil]>
        sine_wave:
            #definitions: input|offset|amplitude|frequency
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define input     <[list].get[1]||false>
            - define offset    <tern[<[list].get[2]||true>].pass[0].fail[<[list].get[2]>]>
            - define amplitude <tern[<[list].get[3]||true>].pass[1].fail[<[list].get[3]>]>
            - define frequency <tern[<[list].get[4]||true>].pass[1].fail[<[list].get[4]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[sine_wave].with[min_args].as[1].with[max_args].as[4].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].min_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[input]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[offset]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[amplitude]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[frequency]>]>]>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<[input].add[<[offset]>].mul[<[frequency]>].sin.mul[<[amplitude]>]>]>
        sine_wave_increment:
            #definitions: input|offset|amplitude|frequency
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define input     <[list].get[1]||false>
            - define offset    <tern[<[list].get[2]||true>].pass[0].fail[<[list].get[2]>]>
            - define amplitude <tern[<[list].get[3]||true>].pass[1].fail[<[list].get[3]>]>
            - define frequency <tern[<[list].get[4]||true>].pass[1].fail[<[list].get[4]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[sine_wave_increment].with[min_args].as[1].with[max_args].as[4].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].min_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[input]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[offset]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[amplitude]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[frequency]>]>]>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<context.this.sine_wave[<[input]>|<[offset]>|<[amplitude]>|<[frequency]>].sub[<context.this.sine_wave[<[input].sub[<[frequency]>]>|<[offset]>|<[amplitude]>|<[frequency]>]>]>]>
        ease:
            #definitions: type|dir|input|range_min|range_max
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define title ease
            - define max_args 6
            - define min_args 3
            - define type      <[list].get[1]||<[nil]>>
            - define dir       <[list].get[2]||<[nil]>>
            - define input     <[list].get[3]||false>
            - define range_min <tern[<[list].get[4]||true>].pass[0].fail[<[list].get[5]>]>
            - define range_max <tern[<[list].get[5]||true>].pass[1].fail[<[list].get[6]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[ease].with[min_args].as[3].with[max_args].as[5].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].min_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[type]>|Element]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[dir]>|Element]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[input]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[range_min]>]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[range_max]>]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - if <[input]> < 1:
                    - define result <custom_object[_co_lib_core].eases[<[type].to_lowercase>|<[dir].to_lowercase>|<context.this.clamp[0|1|<[input]>]>]>
                    - if <[range_min]> != 0 && <[range_max]> != 1:
                        - define result <context.this.map_range[0|1|<[range_min]>|<[range_max]>|<[result]>]>
                - else:
                    - define result false
                - determine <[result]>
            - else:
                - determine <[nil]>
        find_nearest_npc_by_name:
            #definitions: npc_name|loc
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define npc_name <[list].get[1]||<[nil]>>
            - define loc      <tern[<[list].get[2]||true>].pass[<player.location||false>].fail[<[list].get[2]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[find_nearest_npc_by_name].with[min_args].as[1].with[max_args].as[2].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].max_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].min_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[npc_name]>|Element]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[loc]>|Location]>]>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<server.npcs_named[<[npc_name]>].filter[is_spawned].sort_by_number[location.distance[<player.location>]].first||false>]>
        player_by_name:
            #definitions: player_name
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define player_name <[list].get[1]||<[nil]>>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[player_by_name].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[player_name]>|Element]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define player <server.match_offline_player[<[player_name]>]||false>
                - determine <tern[<[player].name.to_lowercase.is[==].to[<[player_name].to_lowercase>]||false>].pass[<[player]>].fail[false]>
            - else:
                - determine <[nil]>
        instances_of_character:
            #definitions: text|search
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define text   <[list].get[1]||<[nil]>>
            - define search <[list].get[2]||<[nil]>>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[instances_of_character].with[arg_amount].as[2].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[type]>|Element]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[search]>|Element]>]>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<[text].trim_to_character_set[<[search]>].length>]>
        lowest_index:
            #definitions: list
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error    <[error].set[<map.with[title].as[lowest_index].with[min_args].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert   <[error].min_args>
                - define non_nums <[list].filter[is_decimal.not]||<list>>
                - if <[non_nums].size> > 0:
                    - define assert true
                    - define number <[non_nums].comma_separated>
                    - debug error <script[lib_config].data_key[error_messages].get[not_number].parsed>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<tern[<[list].size.is[==].to[1]>].pass[<list[1|<list.first>]>].fail[<list[<[list].find[<[list].lowest>]>|<[list].lowest>]>]>]>
        highest_index:
            #definitions: list
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error    <[error].set[<map.with[title].as[highest_index].with[min_args].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert   <[error].min_args>
                - define non_nums <[list].filter[is_decimal.not]||<list>>
                - if <[non_nums].size> > 0:
                    - define assert true
                    - define number <[non_nums].comma_separated>
                    - debug error <script[lib_config].data_key[error_messages].get[not_number].parsed>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<tern[<[list].size.is[==].to[1]>].pass[<list[1|<list.first>]>].fail[<list[<[list].find[<[list].highest>]>|<[list].highest>]>]>]>
        outline_cuboid:
            #definitions: cuboid|density
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define cuboid  <[list].get[1]||false>
            - define density <tern[<[list].get[2]||true>].pass[1].fail[<[list].get[2]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[outline_cuboid].with[min_args].as[1].with[max_args].as[2].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].min_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].max_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[cuboid]>|Cuboid]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[density]>]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - if <[cuboid].list_members.size> == 1:
                    - define density <element[1].div[<[density]>]>
                    - define world   <[cuboid].center.world>
                    - define max     <[cuboid].max.center.add[.51,.51,.51,<[world]>]>
                    - define min     <[cuboid].min.center.sub[.51,.51,.51,<[world]>]>
                    - define a       <[max].with_z[<[min].z>]>
                    - define b       <[max].with_x[<[min].x>]>
                    - define c       <[b].with_z[<[min].z>]>
                    - define d       <[min].with_x[<[max].x>]>
                    - define e       <[min].with_z[<[max].z>]>
                    - define f       <[e].with_x[<[max].x>]>
                    - define res     <[max].points_between[<[a]>].distance[<[density]>].include[<[max].points_between[<[b]>].distance[<[density]>]>].include[<[b].points_between[<[c]>].distance[<[density]>]>].include[<[a].points_between[<[c]>].distance[<[density]>]>].include[<[min].points_between[<[e]>].distance[<[density]>]>].include[<[min].points_between[<[d]>].distance[<[density]>]>].include[<[e].points_between[<[f]>].distance[<[density]>]>].include[<[d].points_between[<[f]>].distance[<[density]>]>].include[<[max].points_between[<[f]>].distance[<[density]>]>].include[<[a].points_between[<[d]>].distance[<[density]>]>].include[<[b].points_between[<[e]>].distance[<[density]>]>].include[<[c].points_between[<[min]>].distance[<[density]>]>]>
                - else:
                    - foreach <[cuboid].list_members>:
                        - define extra:->:<context.this.outline_cuboid[<[value]>|<[density]>]>
                - determine <[res].include[<[extra]||<empty>>]>
            - else:
                - determine <[nil]>
        outline_location:
            #definitions: loc
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define loc <[list].get[1]||false>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[outline_location].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[loc]>|Location]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define c <[loc].center>
                - define w <[loc].world>
                - define f <[c].x.add[.5]>
                - define k <[c].x.sub[.5]>
                - define t <[c].y.add[.5]>
                - define b <[c].y.sub[.5]>
                - define l <[c].z.add[.5]>
                - define r <[c].z.sub[.5]>
                - determine <list[<location[<[f]>,<[b]>,<[r]>,<[w]>]>|<location[<[f]>,<[b]>,<[l]>,<[w]>]>|<location[<[f]>,<[t]>,<[r]>,<[w]>]>|<location[<[f]>,<[t]>,<[l]>,<[w]>]>|<location[<[k]>,<[t]>,<[r]>,<[w]>]>|<location[<[k]>,<[t]>,<[l]>,<[w]>]>|<location[<[k]>,<[b]>,<[r]>,<[w]>]>|<location[<[k]>,<[b]>,<[l]>,<[w]>]>]>
            - else:
                - determine <[nil]>
        flipped_case:
            #definitions: el
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define element <[list].get[1]||<[nil]>>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[flipped_case].with[arg_amount].as[1].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].wrong_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[element]>|Element]>]>
            # ~~ logic ~~ #
            - determine <tern[<[assert]>].pass[<[nil]>].fail[<[element].to_list.parse_tag[<tern[<[parse_value].is_uppercase>].pass[<[parse_value].to_lowercase>].fail[<[parse_value]>]>].unseparated>]>
        shell_ellipsoid:
            #definitions: ellipsoid|density
            - inject lib_tasks.setup
            # ~~ definitions ~~ #
            - define ellipsoid <[list].get[1]||false>
            - define density   <tern[<[list].get[2]||true>].pass[1].fail[<[list].get[2]>]>
            # ~~ asserts ~~ #
            - if <[debug]>:
                - define error  <[error].set[<map.with[title].as[random_by_weight].with[min_args].as[1].with[max_args].as[2].with[explicit_size].as[<[list].size>]>]>
                - define assert <[error].min_args>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].max_args>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].wrong_type[<[ellipsoid]>|Ellipsoid]>]>
                - define assert <tern[<[assert]>].pass[true].fail[<[error].not_number[<[density]>]>]>
            # ~~ logic ~~ #
            - if !<[assert]>:
                - define center <[ellipsoid].location>
                - define amount <[density].mul[100]>
                - repeat <[amount]>:
                    - define dist <context.this.map_range[1|<[amount]>|-0.5|0.5|<[value]>].abs.cos>
                    - define theta <context.this.map_range[1|<[amount]>|-<util.pi.div[2]>|<util.pi.div[2]>|<[value]>].mul[<[dist]>]>
                    - define lambda <context.this.map_range[1|<[amount]>|0|<util.tau>|<[value].mul[30]>]>
                    - define theta_cos <[theta].cos>
                    - define result:->:<[center].with_x[<[center].x.add[<[theta_cos].mul[<[lambda].cos>].mul[<[ellipsoid].size.x>]>]>].with_y[<[center].y.add[<[theta_cos].mul[<[lambda].sin>].mul[<[ellipsoid].size.y>]>]>].with_z[<[center].z.add[<[theta].sin.mul[<[ellipsoid].size.z>]>]>]>
                - determine <[result]>
            - else:
                - determine <[nil]>

