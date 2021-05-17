# | Items must be escaped before passed
has_raw_nbt:
    type: procedure
    debug: false
    definitions: item|nbt_tags
    script:
        - define has_nbt false
        - define item <[item].unescaped>
        - foreach <[nbt_tags]>:
            - if <[item].raw_nbt.get[<[value].to_lowercase>]||null> != null:
                - define has_nbt <[value]>
                - foreach stop
        - determine <[has_nbt]>

map_range:
    type: procedure
    definitions: from_min|from_max|to_min|to_max|input
    debug: false
    script:
        - determine <[input].sub[<[from_min]>].mul[<[to_max].sub[<[to_min]>]>].div[<[from_max].sub[<[from_min]>]>].add[<[to_min]>]>

clamp:
    type: procedure
    definitions: min|max|input
    debug: false
    script:
        - determine <tern[<[input].is[MORE].than[<[max]>]>].pass[<[max]>].fail[<tern[<[input].is[LESS].than[<[min]>]>].pass[<[min]>].fail[<[input]>]>]>