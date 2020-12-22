# | must escape player list
wait_and_narrate:
    type: task
    definitions: name_fmt|text|players
    debug: false
    script:
        - define len <[text].length.mul[<element[1].div[<script[master_config].data_key[general.npc.talking_speed]>]>]>
        - wait <util.random.decimal[<[len].sub[.1]>].to[<[len].add[.1]>]>
        - narrate "<[name_fmt]> <[text]>" targets:<[players].unescaped||<player>>

# | must escape list
flag_list:
    type: task
    definitions: flag_name|value|list
    debug: false
    script:
        - foreach <[list].unescaped> as:player:
            - flag <[player]> <[flag_name]>:<[value]>