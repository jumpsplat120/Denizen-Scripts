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
# @script-version 1.1.0
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
# are all configurable in watering_can_config.
#
# --------------------END HEADER / START CONFIG--------------------

watering_can_config:
    type: data
    cmd_offset: 5
    refills: 0
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
        - beetroots
        - carrots
        - potatoes
        - cocoa
        - nether_wart
        - sweet_berry_bush
        - vine
        - bamboo_sapling
        - bamboo
        - grass_block
        #- grass
        - sunflower
        - azalea
        - peony
        - lilac
        - rose_bush
        - glow_lichen
        - cave_vines
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
        #pumpkin/melon stems don't use apply_bonemeal as it only grows the stems, but instead
        #uses vanilla_tick to grow the pumpkin/melons faster. If this behaviour is unwanted,
        #go into the code, and comment out the pumkpin/melon stem cases in the choose.
        - pumpkin_stem
        - melon_stem

# --------------------END CONFIG / START CODE--------------------

watering_can_events:
    type: world
    debug: false
    events:
        on player breaks block with:watering_can_*:
            # don't decrease durability
            - define d <player.item_in_hand.durability>
            - define s <player.held_item_slot>
            - wait 1t
            - inventory adjust durability:<[d]> slot:<[s]>
        on player right clicks block with:watering_can_*:
            - define config <script[watering_can_config]>
            - define can    <context.item>
            - define slot   <player.held_item_slot>
            - define material       <player.cursor_on[4.5].material.name.if_null[air]>
            - define max_durability <[can].max_durability>
            - define water_level    <[can].flag[water_level]>
            - define total_water    <[can].flag[total_water]>
            - define is_water       <[material].advanced_matches_text[*water]>
            - define is_creative    <player.gamemode.equals[creative]>
            - define grow_plants    <[water_level].equals[0].not.and[<[is_water].not>].and[<[material].equals[air].not>].or[<[is_creative]>]>
            - if <[is_water]>:
                - define water_level:+:2
                - define total_water:+:0
            - else if <[grow_plants]>:
                - define water_level:-:1
                - define total_water:+:1
                - define precise_loc <player.eye_location.precise_cursor_on.up[0.25]>
                - define data   <[config].data_key[<[can].flag[can_type]>]>
                - define range  <[data].get[range]>
                - define chance <[data].get[chance]>
                - define cuboid <[precise_loc].add[<[range]>,1,<[range]>].to_cuboid[<[precise_loc].add[-<[range]>,-1,-<[range]>]>]>
                - define growables <[config].data_key[growables]>
                #playing them consecutively looks smoother since it happens in between each "right click"
                - repeat 5:
                    - playeffect effect:FALLING_WATER at:<[precise_loc]> quantity:<[range].mul[<[config].data_key[particles]>]> offset:<[range].mul[0.5]>,0,<[range].mul[0.5]>
                    - wait 1t
                - if !<player.has_flag[watering_can.sound]>:
                    - playsound <[precise_loc]> sound:watering_can.water sound_category:players volume:0.25 custom
                    - flag player watering_can.sound expire:10t
                - foreach <[cuboid].blocks.filter_tag[<[growables].contains[<[filter_value].material.name>]>]>:
                    - if <[chance].proc[lib_between]> == 1:
                        - define material <[value].material.name>
                        - define effect true
                        - choose <[material]>:
                            - case pumkpin_stem melon_stem:
                                - adjust <[value]> vanilla_tick
                            - case chorus_flower chorus_plant:
                                - define flowers <[value].flood_fill[22].types[chorus_*].filter[material.name.equals[chorus_flower]]>
                                # only play effect if you actually are apply the effect
                                - define effect <[flowers].size.is_more_than[0]>
                                - foreach <[flowers]>:
                                    - adjust <[value]> vanilla_tick
                            - case cactus:
                                - repeat 10 as:_:
                                    - adjust <[value].highest> vanilla_tick
                            - case sugar_cane:
                                - define highest <[value]>
                                - while true:
                                    - define block <[highest].add[0,1,0]>
                                    - while stop if:<[block].material.name.equals[sugar_cane].not>
                                    - define highest <[block]>
                                - repeat 10 as:_:
                                    - adjust <[highest]> vanilla_tick
                            - default:
                                - adjust <[value]> apply_bonemeal:up
                                - define effect false
                        - playeffect effect:happy_villager at:<[value].center> quantity:6 offset:0.3,0.3,0.3 if:<[effect]>
                    - if <[can].flag[total_water]> >= <[config].data_key[refills].add[1].mul[99]>:
                        - run lib_simulate_item_breaking def:<[can]>
                        - take iteminhand
            - if !<[is_creative]>:
                - inventory flag water_level:<[water_level]> slot:<[slot]>
                - inventory flag total_water:<[total_water]> slot:<[slot]>
                - inventory adjust durability:<[max_durability].sub[<[water_level].mul[.01].mul[<[max_durability]>]>].round_down> slot:<[slot]>

watering_can_wooden:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Wooden Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[watering_can_config].data_key[cmd_offset].add[0]>
    flags:
        water_level: 0
        total_water: 0
        can_type: wooden
    recipes:
        1:
            type: shaped
            input:
                - *_planks|bone_meal|air
                - *_planks|bowl|*_planks
                - air|*_planks|air

watering_can_stone:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Stone Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[watering_can_config].data_key[cmd_offset].add[1]>
    flags:
        water_level: 0
        total_water: 0
        can_type: stone
    recipes:
        1:
            type: shaped
            input:
                - <server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>|bone_meal|air
                - <server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>|bowl|<server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>
                - air|<server.vanilla_tagged_materials[base_stone_overworld].parse[name].separated_by[/]>|air

watering_can_iron:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Iron Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[watering_can_config].data_key[cmd_offset].add[2]>
    flags:
        water_level: 0
        total_water: 0
        can_type: iron
    recipes:
        1:
            type: shaped
            input:
                - iron_ingot|bone_meal|air
                - iron_ingot|bowl|iron_ingot
                - air|iron_ingot|air

watering_can_golden:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Golden Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[watering_can_config].data_key[cmd_offset].add[3]>
    flags:
        water_level: 0
        total_water: 0
        can_type: golden
    recipes:
        1:
            type: shaped
            input:
                - gold_ingot|bone_meal|air
                - gold_ingot|bowl|gold_ingot
                - air|gold_ingot|air

watering_can_diamond:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Diamond Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[watering_can_config].data_key[cmd_offset].add[4]>
    flags:
        water_level: 0
        total_water: 0
        can_type: diamond
    recipes:
        1:
            type: shaped
            input:
                - diamond|bone_meal|air
                - diamond|bowl|diamond
                - air|diamond|air

watering_can_netherite:
    type: item
    debug: false
    material: wooden_sword
    display name: <reset>Netherite Watering Can
    mechanisms:
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
        durability: <item[wooden_sword].max_durability>
        custom_model_data: <script[watering_can_config].data_key[cmd_offset].add[5]>
    flags:
        water_level: 0
        total_water: 0
        can_type: netherite
    recipes:
        1:
            type: shaped
            input:
                - netherite_ingot|bone_meal|air
                - netherite_ingot|bowl|netherite_ingot
                - air|netherite_ingot|air