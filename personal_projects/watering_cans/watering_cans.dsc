# +----------------------
# |
# |      WATERING CANS
# |
# |   Grow plants faster.
# |
# +----------------------
#
# @author jumpsplat120
# @date 05/23/21
# @denizen-build 1.2.0-b1739-REL
# @script-version 1.0.0
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * watering_can.dsc
#
# Feel free to use the provided textures, or to make your own.
#
# Usage:
# To craft a watering can, do the following pattern:
#    R = Resource / B = Bonemeal / O = Bowl / A = Air
#
#              [R][B][A]
#              [R][O][R]
#              [A][R][A]
#
# Right click your watering can in water to fill it up. All watering cans
# hold the same amount of water, but higher level cans affect wider ranges
# of crop, and will grow plants faster. The range and growthTick increase
# are all configurable in wc_config.
#
# --------------------END HEADER / START CONFIG--------------------

wc_config:
    type: data
    cmd_offset: 0
    refill: 0
    particles: 10
    wooden:
        range: 1
        chance: 12
    stone:
        range: 3
        chance: 8
    iron:
        range: 5
        chance: 6
    golden:
        range: 7
        chance: 4
    diamond:
        range: 9
        chance: 2
    netherite:
        range: 11
        chance: 1
    growables:
        - oak_sapling
        - spruce_sapling
        - birch_sapling
        - jungle_sapling
        - acacia_sapling
        - dark_oak_sapling
        - brown_mushroom
        - red_mushroom
        - warped_fungus
        - crimson_fungus
        - wheat
        - pumpkin_stem
        - melon_stem
        - beetroots
        - carrots
        - potatoes
        - cocoa
        - nether_wart
        - sweet_berry_bush
        ##special cases! Unlike the above, specifying these contains extra growing mechanics
        ##to simplify the usage of a watering can.
        #Sugarcane can be grown just by watering the lowest block of sugarcane, and the
        #sugarcane will only grow up to three tall.
        - sugar_cane
        #Cactus is similar to sugarcane that watering the lowest block will have the cactus
        #continue to grow. Watered cacti grow to three blocks tall.
        - cactus
        #Chorus tree's can be watered at the base of the chorus tree. This means that watering
        #the block called "chorus_plant" will still provide growth ticks to the chorus flowers
        #on the top of the structure.
        - chorus_flower
        - chorus_plant
        #Bamboo starts out as a seperate block called bamboo sapling. Both need to be present
        #for bamboo growth to work correctly. Watering the bottom block of a bamboo tree will
        #cause the whole tree to grow. Bamboo has a height max of 16 blocks.
        - bamboo_sapling
        - bamboo
        #Vines use a flood fill algorithm to try to find vines that are attached to the inital
        #vine. Vines that go around corners will not count as attached. All attached vines will
        #tick when a single vine is watered. There is a limit of 50 blocks for performance
        #reasons.
        - vine

# --------------------END CONFIG / START CODE--------------------

wc_events:
    type: world
    debug: false
    events:
        on player breaks block with:wc_*:
            - define dura <player.item_in_hand.durability>
            - define slot <player.held_item_slot>
            - wait 1t
            - inventory adjust durability:<[dura]> slot:<[slot]>
        on player right clicks block with:wc_*:
            - define config <script[wc_config]>
            - define item   <context.item>
            - define slot   <player.held_item_slot>
            - define mat    <player.cursor_on[4.5].if_null[<player.eye_location.forward[4.5]>].material.name>
            - define max_dura  <[item].max_durability>
            - define water_lvl <[item].flag[water_level]>
            - define is_water    <[mat].advanced_matches_text[*water]>
            - define is_growing  <[water_lvl].equals[0].not.and[<[is_water].not>].and[<[mat].equals[air].not>]>
            - define is_creative <player.gamemode.equals[creative]>
            - define water_lvl:+:<[is_creative].if_true[0].if_false[<[is_water].and[<[water_lvl].is_less_than[100]>].if_true[2].if_false[<[water_lvl].is_more_than[0].if_true[-1].if_false[0]>]>]>
            - inventory flag water_level:<[water_lvl]> slot:<[slot]>
            - inventory flag used_water:<[is_creative].if_true[0].if_false[<[is_water].if_true[0].if_false[<[water_lvl].is_more_than[0].if_true[1].if_false[0]>]>].add[<[item].flag[used_water]>]> slot:<[slot]>
            - inventory adjust durability:<[max_dura].sub[<[water_lvl].mul[.01].mul[<[max_dura]>]>].round_down> slot:<[slot]>
            - define item <context.item>
            - if <[is_growing]> || <player.gamemode> == creative:
                - define loc      <player.eye_location.precise_cursor_on.up[0.25]>
                - define data     <[config].data_key[<[item].script.name.after[wc_]>]>
                - define range    <[data].get[range]>
                #playing them consecutively looks smoother since it happens in between each "right click"
                - repeat 5:
                    - playeffect effect:FALLING_WATER at:<[loc]> quantity:<[range].mul[<[config].data_key[particles]>]> offset:<[range].mul[0.5]>,0,<[range].mul[0.5]>
                    - wait 1t
                - if !<player.has_flag[watering_can.sound]>:
                    - playsound <[loc]> sound:watering_can.water sound_category:players volume:0.25 custom
                    - flag player watering_can.sound expire:10t
                - foreach <[loc].relative[<[range]>,0.5,<[range]>].to_cuboid[<[loc].relative[-<[range]>,-0.5,-<[range]>]>].blocks.filter_tag[<[config].data_key[growables].contains[<[filter_value].material.name>]>]>:
                    - if <[config].data_key[<[item].script.name.after[wc_]>].get[chance].proc[lib_between]> == 1:
                        - define mat <[value].material.name>
                        - define grew true
                        - choose <[mat]>:
                            - case brown_mushroom red_mushroom:
                                - run lib_grow_mushroom def:<[value]>
                            - case crimson_fungus warped_fungus:
                                - run lib_grow_fungus def:<[value]>
                            - case chorus_flower chorus_plant:
                                - define flowers <[value].flood_fill[22].types[chorus_*].filter[material.name.equals[chorus_flower]]>
                                - define grew <[flowers].size.is_more_than[0]>
                                - foreach <[flowers]>:
                                    - adjust <[value]> vanilla_tick
                            - case bamboo_sapling bamboo:
                                - adjust <[mat].equals[bamboo_sapling].if_true[<[value]>].if_false[<[value].highest>]> vanilla_tick
                            - case cactus:
                                - repeat 10 as:_:
                                    - adjust <[value].highest> vanilla_tick
                            - case sugar_cane:
                                - define y <[value].y>
                                - define highest <[value]>
                                - repeat <element[256].sub[<[y]>]> as:i:
                                    - define block <[value].with_y[<[y].add[<[i]>]>]>
                                    - if <[block].material.name> != sugar_cane:
                                        - repeat stop
                                    - define highest <[block]>
                                - repeat 10 as:_:
                                    - adjust <[highest]> vanilla_tick
                            - case vine:
                                - define vines <[value].flood_fill[50].types[vine]>
                                - define grew <[vines].size.is_more_than[0]>
                                - foreach <[vines]>:
                                    - repeat 5 as:_:
                                        - adjust <[value]> vanilla_tick
                            - default:
                                - repeat 10 as:_:
                                    - adjust <[value]> vanilla_tick
                        - playeffect effect:happy_villager at:<[value].center> quantity:6 offset:0.3,0.3,0.3 if:<[grew]>
            - if <[item].flag[used_water]> >= <[config].data_key[refill].add[1].mul[99]>:
                - run lib_simulate_item_breaking def:<[item]>
                - take iteminhand

wc_wooden:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        flag_map: <map.with[water_level].as[0].with[used_water].as[0]>
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[wc_config].data_key[cmd_offset].add[1]>
    recipes:
        1:
            type: shaped
            input:
                - *_planks|bone_meal|air
                - *_planks|bowl|*_planks
                - air|*_planks|air

wc_stone:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        flag_map: <map.with[water_level].as[0].with[used_water].as[0]>
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[wc_config].data_key[cmd_offset].add[2]>
    recipes:
        1:
            type: shaped
            input:
                - <server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>/cobblestone|bone_meal|air
                - <server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>/cobblestone|bowl|<server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>/cobblestone
                - air|<server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>/cobblestone|air

wc_iron:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        flag_map: <map.with[water_level].as[0].with[used_water].as[0]>
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[wc_config].data_key[cmd_offset].add[3]>
    recipes:
        1:
            type: shaped
            input:
                - iron_ingot|bone_meal|air
                - iron_ingot|bowl|iron_ingot
                - air|iron_ingot|air

wc_golden:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        flag_map: <map.with[water_level].as[0].with[used_water].as[0]>
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[wc_config].data_key[cmd_offset].add[4]>
    recipes:
        1:
            type: shaped
            input:
                - gold_ingot|bone_meal|air
                - gold_ingot|bowl|gold_ingot
                - air|gold_ingot|air

wc_diamond:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        flag_map: <map.with[water_level].as[0].with[used_water].as[0]>
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[wc_config].data_key[cmd_offset].add[5]>
    recipes:
        1:
            type: shaped
            input:
                - diamond|bone_meal|air
                - diamond|bowl|diamond
                - air|diamond|air

wc_netherite:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        flag_map: <map.with[water_level].as[0].with[used_water].as[0]>
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[wc_config].data_key[cmd_offset].add[6]>
    recipes:
        1:
            type: shaped
            input:
                - netherite_ingot|bone_meal|air
                - netherite_ingot|bowl|netherite_ingot
                - air|netherite_ingot|air