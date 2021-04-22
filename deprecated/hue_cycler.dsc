# | Kept for historical purposes, as there is now a tag that will do all of this; <ColorTag.with_hue[]>

cycle_hue:
    type: procedure
    debug: false
    definitions: color|time
    script:
        - define r <[color].red>
        - define g <[color].green>
        - define b <[color].blue>

        - if <[r]> == 255 && <[b]> == 0 && <[g]> != 255:
            - define g <[g].add[<[time]>].min[255]>
        - else if <[g]> == 255 && <[b]> == 0 && <[r]> != 0:
            - define r <[r].sub[<[time]>].max[0]>
        - else if <[r]> == 0 && <[g]> == 255 && <[b]> != 255:
            - define b <[b].add[<[time]>].min[255]>
        - else if <[r]> == 0 && <[b]> == 255 && <[g]> != 0:
            - define g <[g].sub[<[time]>].max[0]>
        - else if <[b]> == 255 && <[g]> == 0 && <[r]> != 255:
            - define r <[r].add[<[time]>].min[255]>
        - else if <[r]> == 255 && <[g]> == 0 && <[b]> != 0:
            - define b <[b].sub[<[time]>].max[0]>
        
        - determine <color[<[r]>,<[g]>,<[b]>]>