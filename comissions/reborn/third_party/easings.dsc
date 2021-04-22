ease:
    type: procedure
    definitions: type|dir|input|range_min|range_max
    debug: false
    script:
        - if <[input]> < 1:
            - define res <proc[<[type].to_lowercase>].context[<[dir].to_lowercase>|<proc[n].context[<[input]>]>]>
            - if <[range_min].is_decimal||false.and[<[range_max].is_decimal||false>]>:
                - define res <proc[map_range].context[0|1|<[range_min]>|<[range_max]>|<[res]>]>
        - else:
            - define res false
        - determine <[res]>

# ~ ~ ~ Eases; based on work from https://easings.net/ ~ ~ ~ #

n:
    type: procedure
    definitions: val
    debug: false
    script:
        - determine <proc[clamp].context[0|1|<[val]>]>

bo:
    type: procedure
    definitions: dt
    debug: false
    script:
        - determine <tern[<[dt].is[LESS].than[.363636363]>].pass[<element[7.5625].mul[<[dt]>].mul[<[dt]>]>].fail[<tern[<[dt].is[LESS].than[.727272727]>].pass[<element[7.5625].mul[<[dt].sub[.5454545]>].mul[<[dt].sub[.5454545]>].add[.75]>].fail[<tern[<[dt].is[LESS].than[.909090909]>].pass[<element[7.5625].mul[<[dt].sub[.81818181]>].mul[<[dt].sub[.81818181]>].add[0.9375]>].fail[<element[7.5625].mul[<[dt].sub[.95454545]>].mul[<[dt].sub[.95454545]>].add[0.984375]>]>]>]>

sine:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - choose <[dir]>:
            - case in:
                - determine <element[1].sub[<[dt].mul[<util.pi>].div[2].cos>]>
            - case out:
                - determine <[dt].mul[<util.pi>].div[2].sin>
            - case inout in-out in_out:
                - determine <[dt].mul[<util.pi>].cos.sub[1].div[2].mul[-1]>
quad:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - choose <[dir]>:
            - case in:
                - determine <[dt].power[2]>
            - case out:
                - determine <element[1].sub[<element[1].sub[<[dt]>].power[2]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[2].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[2].div[2]>]>]>

cubic:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - choose <[dir]>:
            - case in:
                - determine <[dt].power[3]>
            - case out:
                - determine <element[1].sub[<element[1].sub[<[dt]>].power[3]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[4].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[3].div[2]>]>]>

quart:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - choose <[dir]>:
            - case in:
                - determine <[dt].power[4]>
            - case out:
                - determine <element[1].sub[<element[1].sub[<[dt]>].power[4]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[8].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[4].div[2]>]>]>

quint:
    type: procedure
    definitions: dir|dt
    debug: false
    script:

        - choose <[dir]>:
            - case in:
                - determine <[dt].power[5]>
            - case out:
                - determine <element[1].sub[<element[1].sub[<[dt]>].power[5]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[16].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[5].div[2]>]>]>

exp:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - choose <[dir]>:
            - case in:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<element[2].power[<[dt].mul[10].sub[10]>]>]>
            - case out:
                - determine <tern[<[dt].is[==].to[1]>].pass[1].fail[<element[1].sub[<element[2].power[<[dt].mul[-10]>]>]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<tern[<[dt].is[LESS].than[.5]>].pass[<element[2].power[<[dt].mul[20].sub[10]>].div[2]>].fail[<element[2].sub[<element[2].power[<[dt].mul[-20].add[10]>]>].div[2]>]>]>]>

circ:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - choose <[dir]>:
            - case in:
                - determine <element[1].sub[<element[1].sub[<[dt].power[2]>].sqrt>]>
            - case out:
                - determine <element[1].sub[<[dt].sub[1].power[2]>].sqrt>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[1].sub[<element[1].sub[<[dt].mul[2].power[2]>].sqrt>].div[2]>].fail[<element[1].sub[<[dt].mul[-2].add[2].power[2]>].sqrt.add[1].div[2]>]>

back:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - define C1 1.70158
        - define C2 2.5949095
        - define C2A 3.5949095
        - define C3 2.70158
        - choose <[dir]>:
            - case in:
                - determine <[C3].mul[<[dt]>].mul[<[dt]>].mul[<[dt]>].sub[<[C1].mul[<[dt]>].mul[<[dt]>]>]>
            - case out:
                - determine <[dt].sub[1].power[3].mul[<[C3]>].add[1].add[<[dt].sub[1].power[2].mul[<[C1]>]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<[dt].mul[2].power[2].mul[<[C2A].mul[2].mul[<[dt]>].sub[<[C2]>]>].div[2]>].fail[<[dt].mul[2].sub[2].power[2].mul[<[C2A].mul[<[dt].mul[2].sub[2]>].add[<[C2]>]>].add[2].div[2]>]>

elastic:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - define C4 2.0943951
        - define C5 1.3962634
        - choose <[dir]>:
            - case in:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<element[2].power[<[dt].mul[10].sub[10]>].mul[-1].mul[<[dt].mul[10].sub[10.75].mul[<[C4]>].sin>]>]>]>
            - case out:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<element[2].power[<[dt].mul[-10]>].mul[<[dt].mul[10].sub[.75].mul[<[C4]>].sin>].add[1]>]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[==].to[0]>].pass[0].fail[<tern[<[dt].is[==].to[1]>].pass[1].fail[<tern[<[dt].is[LESS].than[.5]>].pass[<element[2].power[<[dt].mul[20].sub[10]>].mul[<[dt].mul[20].sub[11.125].mul[<[C5]>].sin>].mul[-1].div[2]>].fail[<element[2].power[<[dt].mul[-20].add[10]>].mul[<[dt].mul[20].sub[-11.125].mul[<[C5]>].sin>].div[2].add[1]>]>]>]>

bounce:
    type: procedure
    definitions: dir|dt
    debug: false
    script:
        - choose <[dir]>:
            - case in:
                - determine <element[1].sub[<proc[bo].context[<element[1].sub[<[dt]>]>]>]>
            - case out:
                - determine <proc[bo].context[<[dt]>]>
            - case inout in-out in_out:
                - determine <tern[<[dt].is[LESS].than[.5]>].pass[<element[1].sub[<proc[bo].context[<element[1].sub[<[dt].mul[2]>]>]>].div[2]>].fail[<proc[bo].context[<[dt].mul[2].sub[1]>].add[1].div[2]>]>
