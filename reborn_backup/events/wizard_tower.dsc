# - set_to_clear - #
#experience add @s -4 levels
#tellraw @a {"text":"A powerful magic has brought peace to the skies.","italic":true,"color":"gray"}
#particle minecraft:dragon_breath 451.5 126.2 -27.5 0 0 0 .1 20 normal
#weather clear

# - set_to_day - #
#experience add @s -4 levels
#tellraw @a {"text":"Day has broken the darkness of night.","italic":true,"color":"gray"}
#particle minecraft:dragon_breath 451.5 126 -37.5 0 0 0 .1 20 normal
#time set day

# - set_to_night - #
#experience add @s -4 levels
#tellraw @a {"text":"A powerful magic has painted the sky black....","italic":true,"color":"gray"}
#particle minecraft:dragon_breath 441.5 126.20 -27.5 0 0 0 .1 20 normal
#time set 14000

# - set_to_rain - #
#experience add @s -4 levels
#tellraw @a {"text":"A powerful magic has summoned the healing rains.","italic":true,"color":"gray"}
#particle minecraft:dragon_breath 441.5 126.20 -37.5 0 0 0 .1 20 normal
#weather thunder

# - command block triggers - #
#execute as @p if entity @s[level=4..] run function custom_gameplay:wizard_tower_weather/set_to_rain
#execute as @p if entity @s[level=4..] run function custom_gameplay:wizard_tower_weather/set_to_day
#execute as @p if entity @s[level=4..] run function custom_gameplay:wizard_tower_weather/set_to_night
#execute as @p if entity @s[level=4..] run function custom_gameplay:wizard_tower_weather/set_to_clear


# | TO DO
# Add a bit of flair to each of the events
wizard_tower_events:
    type: world
    debug: false
    events:
        on player enters wizard_tower_top:
            - if <cuboid[wizard_tower_top].players.is_empty>:
                - flag server wizard_tower_particles
                - repeat 4:
                    - run particle_pressure_plate def:wizard_tower_particles|<location[wizard_tower_particle<[value]>].round_down.add[<location[.5,.5,.5,world]>]>
        after player exits wizard_tower_top:
            - if <cuboid[wizard_tower_top].players.is_empty>:
                - flag server wizard_tower_particles:!
        on player enters wizard_tower_*_trigger:
            - define config <script[master_config].data_key[wizard_tower]>
            - ratelimit <player> <[config].get[ratelimit]>s
            - flag player <context.area>:true
            - inject locally validate_and_run
        on player exits wizard_tower_*_trigger:
            - flag player <context.area>:!
    validate_and_run:
        - if <player.xp_level> >= <[config].get[xp_requirement]>:
            - define buffer <[config].get[buffer_time]>
            - define type <context.area.note_name.replace_text[wizard_tower_].replace_text[_trigger]>
            - narrate "<[config].get[start_effect].parsed> <[config].get[<[type]>].get[attempt].parsed> <[config].get[stand_still].parsed>"
            - cast confusion duration:<[buffer].add[100]>t amplifier:0 <player> hide_particles no_icon
            - wait <[buffer]>t
            - if <player.has_flag[<context.area>]>:
                - define time_period <world[world].time.period>
                - if <[type].is[==].to[day].and[<list[day|dawn].contains[<[time_period]>]>]> || <[type].is[==].to[night].and[<list[night|dusk].contains[<[time_period]>]>]> || <[type].is[==].to[clear].and[<world[world].thundering.or[<world[world].has_storm>].not>]> || <[type].is[==].to[rain].and[<world[world].thundering.or[<world[world].has_storm>]>]>:
                    - narrate <[config].get[<[type]>].get[fail].parsed>
                - else:
                    - inject locally <[type]>
                    - narrate <[config].get[<[type]>].get[success].parsed>
                    - experience take level <[config].get[xp_requirement]>
        - else:
            - narrate <[config].get[missing_xp].parsed>
    time:
        - define prev 0
        - define delta 0
        - define time <[config].get[time_speed].mul[20]>
        - while <[delta].is[!=].to[false]>:
            - time <world[world].time.add[<[delta]>]>t
            - define new <proc[ease].context[quad|inout|<[loop_index].div[<[time]>]>|0|<[difference]>]>
            - define delta <[new].sub[<[prev]>]||false>
            - define prev <[new]>
            - wait 1t
        - playsound <player> sound:BLOCK_CONDUIT_DEACTIVATE pitch:0.5
    day:
        - define difference <element[24000].sub[<world[world].time>]>
        - inject locally time
    night:
        - define difference <tern[<world[world].time.is[OR_MORE].than[13000]>].pass[<element[24000].sub[<world[world].time>].add[<element[13000].sub[<world[world].time>]>]>].fail[<element[13000].sub[<world[world].time>]>]>
        - inject locally time
    clear:
        - flag server fire_burst_temp:true
        - repeat 4:
            - define pos <player.location.forward_flat[<util.random.int[3].to[8]>].down[2].left[<util.random.gauss.mul[4]>]>
            - run particle_pressure_plate def:fire_burst_temp|<[pos]>|0.2|1|1|20|1|lava
            - run particle_pressure_plate def:fire_burst_temp|<[pos]>|0.2|1|1|20|1|flame
            - playsound <player> sound:item_firecharge_use pitch:<util.random.decimal[0.75].to[1.15]>
            - wait <util.random.int[2].to[5]>t
        - flag server fire_burst_temp:!
        - weather sunny
    rain:
        - repeat 4:
            - strike no_damage <player.location.forward_flat[<util.random.int[3].to[8]>].down[6].left[<util.random.gauss.mul[4]>]>
            - wait <util.random.int[8].to[16]>t
        - weather thunder