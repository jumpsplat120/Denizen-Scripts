#all the eases used for the front facing easing proc. Math is kept here for simplicity
lib_core_ease:
    type: procedure
    debug: false
    definitions: type|dir|dt
    script:
        # ~ ~ ~ Eases; based on work from https://easings.net/ ~ ~ ~ #
        - define ease_conf <script[lib_core].data_key[ease]>
        - if <[ease_conf].get[type].contains[<[type]>]> && <[ease_conf].get[dir].contains[<[dir]>]>:
            - define concat <[type]>_<[dir]>
        - choose <[concat]>:
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
            - case quad_inout quad_in-out quad_in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[2].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[2].div[2]>]>]>
            - case cubic_in:
                - determine <[dt].power[3]>
            - case cubic_out:
                - determine <element[1].sub[<element[1].sub[<[dt]>].power[3]>]>
            - case cubic_inout cubic_in-out cubic_in_out:
                - determine <[dt].is_less_than[0.5].if_true[<element[4].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].if_false[<element[1].sub[<[dt].mul[-2].add[2].power[3].div[2]>]>]>
            - case quart_in:
                - determine <[dt].power[4]>
            - case quart_out:
                - determine <element[1].sub[<element[1].sub[<[dt]>].power[4]>]>
            - case quart_inout quart_in-out quart_in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[8].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[4].div[2]>]>]>
            - case quint_in:
                - determine <[dt].power[5]>
            - case quint_out:
                - determine <element[1].sub[<element[1].sub[<[dt]>].power[5]>]>
            - case quint_inout quint_in-out quint_in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[16].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[5].div[2]>]>]>
            - case exp_in:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<element[2].power[<[dt].mul[10].sub[10]>]>]>
            - case exp_out:
                - determine <tern[<[dt].is[==].to[1]>].pass[1].fail[<element[1].sub[<element[2].power[<[dt].mul[-10]>]>]>]>
            - case exp_inout exp_in-out exp_in_out:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<tern[<[dt].is[LESS].than[.5]>].pass[<element[2].power[<[dt].mul[20].sub[10]>].div[2]>].fail[<element[2].sub[<element[2].power[<[dt].mul[-20].add[10]>]>].div[2]>]>]>]>
            - case circ_in:
                - determine <element[1].sub[<element[1].sub[<[dt].power[2]>].sqrt>]>
            - case circ_out:
                - determine <element[1].sub[<[dt].sub[1].power[2]>].sqrt>
            - case circ_inout circ_in-out circ_in_out:
                - determine <[dt].is_less_than[0.5].if_true[<element[1].sub[<element[1].sub[<[dt].mul[2].power[2]>].sqrt>].div[2]>].if_false[<element[1].sub[<[dt].mul[-2].add[2].power[2]>].sqrt.add[1].div[2]>]>
            - case back_in:
                - determine <[ease_conf].get[C3].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].sub[<[ease_conf].get[C1].mul[<[dt]>].mul[<[dt]>]>]>
            - case back_out:
                - determine <[dt].sub[1].power[3].mul[<[ease_conf].get[C3]>].add[1].add[<[dt].sub[1].power[2].mul[<[ease_conf].get[C1]>]>]>
            - case back_inout back_in-out back_in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<[dt].mul[2].power[2].mul[<[ease_conf].get[C2A].mul[2].mul[<[dt]>].sub[<[ease_conf].get[C2]>]>].div[2]>].fail[<[dt].mul[2].sub[2].power[2].mul[<[ease_conf].get[C2A].mul[<[dt].mul[2].sub[2]>].add[<[ease_conf].get[C2]>]>].add[2].div[2]>]>
            - case elastic_in:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<element[2].power[<[dt].mul[10].sub[10]>].mul[-1].mul[<[dt].mul[10].sub[10.75].mul[<[ease_conf].get[C4]>].sin>]>]>]>
            - case elastic_out:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<element[2].power[<[dt].mul[-10]>].mul[<[dt].mul[10].sub[.75].mul[<[ease_conf].get[C4]>].sin>].add[1]>]>]>
            - case elastic_inout elastic_in-out elastic_in_out:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<tern[<[dt].is[LESS].than[.5]>].pass[<element[2].power[<[dt].mul[20].sub[10]>].mul[<[dt].mul[20].sub[11.125].mul[<[ease_conf].get[C5]>].sin>].mul[-1].div[2]>].fail[<element[2].power[<[dt].mul[-20].add[10]>].mul[<[dt].mul[20].sub[-11.125].mul[<[ease_conf].get[C5]>].sin>].div[2].add[1]>]>]>]>
            - case bounce_in:
                - determine <element[1].sub[<proc[lib_core_bo].context[<element[1].sub[<[dt]>]>]>]>
            - case bounce_out:
                - determine <proc[lib_core_bo].context[<[dt]>]>
            - case bounce_inout bounce_in-out bounce_in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[1].sub[<proc[lib_core_bo].context[<element[1].sub[<[dt].mul[2]>]>]>].div[2]>].fail[<proc[lib_core_bo].context[<[dt].mul[2].sub[1]>].add[1].div[2]>]>
            - case default:
                - debug error "An error occurred!"
                - determine false

lib_core_catmull_rom_spline:
    type: procedure
    debug: false
    definitions: p1|p2|p3|p4|density|constant
    script:
        - define constant <[constant].mul[0.5]>
        - define t1 <[p2].x.sub[<[p1].x>].power[2].add[<[p2].y.sub[<[p1].y>].power[2]>].add[<[p2].z.sub[<[p1].z>].power[2]>].sqrt.power[<[constant]>]>
        - define t2 <[p3].x.sub[<[p2].x>].power[2].add[<[p3].y.sub[<[p2].y>].power[2]>].add[<[p3].z.sub[<[p2].z>].power[2]>].sqrt.power[<[constant]>].add[<[t1]>]>
        - define t3 <[p4].x.sub[<[p3].x>].power[2].add[<[p4].y.sub[<[p3].y>].power[2]>].add[<[p4].z.sub[<[p3].z>].power[2]>].sqrt.power[<[constant]>].add[<[t2]>]>
        - define c <[t2].sub[<[t1]>].div[<[density]>]>
        - repeat <[density]>:
            - define t:->:<[t1].add[<[c].mul[<[value]>]>]>
        - define c <[t1]>
        - foreach <[t]>:
            - define A1:->:<[p1].mul[<[t1].sub[<[value]>].div[<[c]>]>].add[<[p2].mul[<[value].div[<[c]>]>]>]>
        - define c <[t2].sub[<[t1]>]>
        - foreach <[t]>:
            - define A2:->:<[p2].mul[<[t2].sub[<[value]>].div[<[c]>]>].add[<[p3].mul[<[value].sub[<[t1]>].div[<[c]>]>]>]>
        - define c <[t3].sub[<[t2]>]>
        - foreach <[t]>:
            - define A3:->:<[p3].mul[<[t3].sub[<[value]>].div[<[c]>]>].add[<[p4].mul[<[value].sub[<[t2]>].div[<[c]>]>]>]>
        - define c <[t2]>
        - foreach <[t]>:
            - define B1:->:<[A1].get[<[loop_index]>].mul[<[t2].sub[<[value]>].div[<[c]>]>].add[<[A2].get[<[loop_index]>].mul[<[value].div[<[c]>]>]>]>
        - define c <[t3].sub[<[t1]>]>
        - foreach <[t]>:
            - define B2:->:<[A2].get[<[loop_index]>].mul[<[t3].sub[<[value]>].div[<[c]>]>].add[<[A3].get[<[loop_index]>].mul[<[value].sub[<[t1]>].div[<[c]>]>]>]>
        - define c <[t2].sub[<[t1]>]>
        - foreach <[t]>:
            - define C1:->:<[B1].get[<[loop_index]>].mul[<[t2].sub[<[value]>].div[<[c]>]>].add[<[B2].get[<[loop_index]>].mul[<[value].sub[<[t1]>].div[<[c]>]>]>]>
        - determine <[C1]>

#Used in the bounce in, out and inout of the easing script
lib_core_bo:
    type: procedure
    debug: false
    definitions: value
    script:
        - determine <tern[<[value].is[LESS].than[.363636363]>].pass[<element[7.5625].mul[<[value]>].mul[<[value]>]>].fail[<tern[<[value].is[LESS].than[.727272727]>].pass[<element[7.5625].mul[<[value].sub[.5454545]>].mul[<[value].sub[.5454545]>].add[.75]>].fail[<tern[<[value].is[LESS].than[.909090909]>].pass[<element[7.5625].mul[<[value].sub[.81818181]>].mul[<[value].sub[.81818181]>].add[0.9375]>].fail[<element[7.5625].mul[<[value].sub[.95454545]>].mul[<[value].sub[.95454545]>].add[0.984375]>]>]>]>

#Gets an error type from core/data, and the name of the script calling the proc
#so it can print out errors. Also takes unlisted arguments that are change depending
#on the error.
lib_core_command_error:
    type: procedure
    debug: false
    definitions: err_type|usage_name
    script:
        - define color <script[lib_config].parsed_key[color]>
        - define usage_loc <script[lib_core].data_key[command.usage.<[usage_name]>].if_null[true].if_true[<proc[<[usage_name]>]>].if_false[<proc[lib_command_usage].context[lib_core|command.usage.<[usage_name]>]>]>
        - determine <[color].get[error]><script[lib_core].parsed_key[command.error.<[err_type]>]><list[permission|implicit|invalid_player].contains[<[err_type]>].not.if_true[<[color].get[error]><&nl>Usage<&co><&nl><[usage_loc]>].if_false[]>

#Like <ListTag.formatted> but it colors the text and commas.
lib_core_command_extra_keys:
    type: procedure
    debug: false
    definitions: list
    script:
        - define clr    <script[lib_config].parsed_key[color]>
        - define soft   <[clr].get[soft_server_notice]>
        - define hard   <[clr].get[hard_server_notice]>
        - define last   <[list].size>
        - define s_last <[list].size.sub[1]>
        - foreach <[list]>:
            - define result "<[result].if_null[]><[soft]><[value]><[loop_index].equals[<[s_last]>].if_true[ and ].if_false[<[loop_index].equals[<[last]>].if_true[<[hard]>.].if_false[<[hard]>, ]>]>"
        - determine <[result]>
