music_maker:
    type: world
    debug: false
    events:
        on player crafts mm_i_*:
            - determine <context.item.proc[lib_unstackable]>
        on mm_i_didgeridoo recipe formed:
            #workaround; check custom item for expl
            - determine <context.inventory.find_item[chisel].equals[-1].if_true[cancelled].if_false[true]>
        on player crafts mm_i_didgeridoo:
            - define inv <context.inventory>
            - define chisel_slot <[inv].find_item[chisel]>
            - define chisel      <[inv].slot[<[chisel_slot]>]>
            - define durability  <[chisel].durability.add[1]>
            - wait 1t
            - adjust <[inv]> matrix:<[inv].matrix.set[<[durability].equals[<[chisel].max_durability>].if_true[air].if_false[<[chisel].with[durability=<[durability]>]>]>].at[<[chisel_slot].sub[1]>]>
        on player left clicks block with:mm_i_*:
            - inject music_maker path:init
            - flag player music_maker.<[sneaking].if_true[scale_index].if_false[root_index]>:<proc[lib_cycle_value].context[1|<[sneaking].if_true[<[config].data_key[scale].keys.size>].if_false[12]>|<[sneaking].if_true[<[scale_index]>].if_false[<[root_index]>].add[1]>]>
            - inject music_maker path:new_scale
            - run lib_animated_actionbar "def:<list_single[<proc[lib_animated_rainbow_text].context[<[config].data_key[scale.<[scale_index]>.lang]> <[data].data_key[notes.<[root_index]>.lang]>|<color[red]>|15|5|60]>]>"
        on player right clicks block with:mm_i_*:
            - determine passively cancelled
            - inject music_maker path:init
            - define adv_mode <[flag].get[advanced]>
            - if <[sneaking]>:
                - flag player music_maker.advanced:<[adv_mode].if_true[false].if_false[true]>
                - run lib_animated_actionbar "def:<list_single[<proc[lib_animated_rainbow_text].context[Advanced Mode:|<color[red]>|15|5|60].parse_tag[<[parse_value]> <reset><player.has_flag[music_maker.advanced].if_true[ON].if_false[OFF]>]>]>"
            - else:
                - define percentage <player.location.pitch.add[-90].mul[-1].div[1.8].round>
                - define percentage <proc[lib_clamp].context[25|75|<[percentage]>]> if:<[adv_mode]>
                - define scale_size <[scale].size>
                - playsound <player.location> sound:<[data].data_key[instruments.<context.item.script.name.after[mm_i_]>]> volume:1.5 pitch:<[scale].get[<[adv_mode].if_true[<proc[lib_map_range].context[25|75|0|100|<[percentage]>]>].if_false[<[percentage]>].div[<element[100].div[<[scale_size]>]>].add[0.000001].round_up.min[<[scale_size]>]>]>
    init:
        - define config <script[mm_config]>
        - define data   <script[mm_data]>
        - inject music_maker path:update_flag_def
        - if !<player.has_flag[music_maker]>:
            - flag player music_maker:<map.with[scale_index].as[1].with[root_index].as[1].with[advanced].as[false]>
            - inject music_maker path:new_scale
        - define sneaking    <player.is_sneaking>
    new_scale:
        - inject music_maker path:update_flag_def
        - define notes_map <[data].data_key[notes]>
        - define octave <[notes_map].deep_get[<[root_index]>.values].keys.first>
        - define did_increase false
        - foreach <[config].data_key[scale.<[flag].get[scale_index]>.intervals]>:
            - define index <[root_index].add[<[value]>]>
            - if <[index].is_more_than[12].and[<[did_increase].not>]>:
                - define octave:++
                - define did_increase true
            - define result:->:<[notes_map].deep_get[<proc[lib_cycle_value].context[1|12|<[index]>]>.values.<[octave]>]>
        - flag player music_maker.scale:<[result]>
        - inject music_maker path:update_flag_def
    update_flag_def:
        - define flag        <player.flag[music_maker].if_null[]>
        - define scale       <[flag].get[scale].if_null[]>
        - define root_index  <[flag].get[root_index].if_null[]>
        - define scale_index <[flag].get[scale_index].if_null[]>
