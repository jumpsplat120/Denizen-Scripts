lib_core_ease:
    type: procedure
    debug: false
    definitions: type|dir|dt
    script:
        # ~ ~ ~ Eases; based on work from https://easings.net/ ~ ~ ~ #
        - define ease_conf <script[lib_generic_data].data_key[ease]>
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
                - determine <element[1].sub[<proc[bo].context[<element[1].sub[<[dt]>]>]>]>
            - case bounce_out:
                - determine <proc[bo].context[<[dt]>]>
            - case bounce_inout bounce_in-out bounce_in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[1].sub[<proc[bo].context[<element[1].sub[<[dt].mul[2]>]>]>].div[2]>].fail[<proc[bo].context[<[dt].mul[2].sub[1]>].add[1].div[2]>]>
            - case default:
                - debug error "An error occurred!"
                - determine false

lib_core_bo:
    type: procedure
    debug: false
    definitions: value
    script:
        - determine bo <tern[<[value].is[LESS].than[.363636363]>].pass[<element[7.5625].mul[<[value]>].mul[<[value]>]>].fail[<tern[<[value].is[LESS].than[.727272727]>].pass[<element[7.5625].mul[<[value].sub[.5454545]>].mul[<[value].sub[.5454545]>].add[.75]>].fail[<tern[<[value].is[LESS].than[.909090909]>].pass[<element[7.5625].mul[<[value].sub[.81818181]>].mul[<[value].sub[.81818181]>].add[0.9375]>].fail[<element[7.5625].mul[<[value].sub[.95454545]>].mul[<[value].sub[.95454545]>].add[0.984375]>]>]>]>

lib_core_command_usage:
    type: procedure
    debug: false
    definitions: name
    script:
        - define c <script[lib_config].parsed_key[color.command]>
        - define l <[c].get[literal]>
        - define fs <[c].get[forward_slash]><[l]>
        - define lb <[c].get[left_bracket]><[l]>
        - define rb <[c].get[right_bracket]><[l]>
        - define lt <[c].get[less_than]><[l]>
        - define gt <[c].get[greater_than]><[l]>
        - define lp <[c].get[left_parenthesis]><[l]>
        - define rp <[c].get[right_parenthesis]><[l]>
        - define rc <[c].get[right_curly_bracket]><[l]>
        - define lc <[c].get[left_curly_bracket]><[l]>
        - define nl <[c].get[non_literal]>
        - determine <script[lib_generic_data].parsed_key[command.usage.<[name]>]>

lib_core_command_error:
    type: procedure
    debug: false
    definitions: err_type|usage_name
    script:
        - define color <script[lib_config].parsed_key[color]>
        - define usage_loc <script[lib_generic_data].data_key[command.usage.<[usage_name]>].if_null[true].if_true[<proc[<[usage_name]>]>].if_false[<proc[lib_core_command_usage].context[<[usage_name]>]>]>
        - determine <[color].get[error]><script[lib_generic_data].parsed_key[command.error.<[err_type]>]><list[permission|implicit|invalid_player].contains[<[err_type]>].not.if_true[<[color].get[error]><&nl>Usage<&co><&nl><[usage_loc]>].if_false[]>

lib_core_command_extra_keys:
    type: procedure
    debug: true
    definitions: list
    script:
        - define last <[list].size>
        - define s_last <[list].size.sub[1]>
        - foreach <[list]>:
            - define result "<[result].if_null[]><gray><[value]><[loop_index].equals[<[s_last]>].if_true[ and ].if_false[<[loop_index].equals[<[last]>].if_true[<dark_gray>.].if_false[<dark_gray>, ]>]>"
        - determine <[result]>