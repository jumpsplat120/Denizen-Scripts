#-init-#
# say Loaded

#-restock chest-#

#-wizard tower item labels-#
#execute unless entity @e[tag=ItemNightLabel] run summon item 442.5 127 -28.5 {Tags:["ItemNightLabel"],CustomName:"{\"text\":\"Night\"}",CustomNameVisible:1b,Age:-32768,PickupDelay:32767,Item:{id:"minecraft:gray_glazed_terracotta",Count:1b},NoGravity:1b}
#execute unless entity @e[tag=ItemRainLabel] run summon item 442.5 127 -36.5 {Tags:["ItemRainLabel"],CustomName:"{\"text\":\"Rain\"}",CustomNameVisible:1b,Age:-32768,PickupDelay:32767,Item:{id:"minecraft:blue_glazed_terracotta",Count:1b},NoGravity:1b}
#execute unless entity @e[tag=ItemDayLabel] run summon item 450.5 127 -36.5 {Tags:["ItemDayLabel"],CustomName:"{\"text\":\"Day\"}",CustomNameVisible:1b,Age:-32768,PickupDelay:32767,Item:{id:"minecraft:white_glazed_terracotta",Count:1b},NoGravity:1b}
#execute unless entity @e[tag=ItemClearSkyLabel] run summon item 450.5 127 -28.5 {Tags:["ItemClearSkyLabel"],CustomName:"{\"text\":\"Clear Sky\"}",CustomNameVisible:1b,Age:-32768,PickupDelay:32767,Item:{id:"minecraft:yellow_glazed_terracotta",Count:1b},NoGravity:1b}

# Instead of creating floating terrecotta the eventually despawns, we can create invisible armour stands. Same resource cost, but this only needs to be run on creation. Rerunning the task will remove existing armour stands at the top of the wizard tower first, before creating new ones.
wizard_tower_labels:
    type: task
    debug: false
    script:
        - define forward <location[7,0,0]>
        - define labels "<list[Rain|Night|Clear Sky|Day]>"
        - remove <location[wizard_tower_top].find.entities[armor_stand].within[8]>
        - repeat 4:
            - spawn armor_stand <location[wizard_tower_top].round_down.add[<location[.5,.5,.5,world]>].add[<[forward].rotate_around_y[<element[45].add[<[value].mul[90]>].to_radians>]>]> persistent save:stand
            - define stand <entry[stand].spawned_entity>
            - adjust <[stand]> <map.with[gravity].as[false].with[invulnerable].as[true].with[custom_name].as[<[labels].get[<[value]>]>].with[custom_name_visible].as[true].with[visible].as[false]>