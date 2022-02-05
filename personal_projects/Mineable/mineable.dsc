# +----------------------
# |
# |      MINEABLE
# |
# | Changes drops of ore blocks to decrease progression
# | rate of vanilla game.
# |
# +----------------------
#
# @author jumpsplat120
# @date 12/02/21
# @denizen-build 1.2.3-b5951-DEV
# @script-version 1.1.1
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * mineable.dsc
#     * /utilities
#
# Don't forget the textures!
#
# Usage:
# Simply mine any vanilla ore, and the drops will instead be ore
# pieces (or in the case of some ores, the drops will be the same
# [nether gold ore, redstone ore, lapis ore, nether quartz ore]).
# Fragments can be combined in a crafting table to get one whole
# material, and in the case of gold and iron, will need to be smelted
# into nuggets first.
#
# The block has a 10% chance of breaking on each mine, meaning that
# there is technically a higher return on ores with this plugin, but
# time spent and randomness means it won't be any noticeable amount.
#
# Drops are affected by fortune. The equation for resource drops is
# rand(1, rand(1, 3) * fortune_level). What this means is each fortune
# level, the theoretical maximum upper limit increases by three. On average,
# the upper limit is fortune_level * 1.5.
#
# XP for diamond or emerald ore is rand(1, 3), while XP for everything else
# is rand(0, 1).
#
# --------------------END HEADER / START CONFIG--------------------

mineable_config:
    type: data
    break_percentage: 10
    fortune_multiplier: 3
    xp:
        coal:
            - 0
            - 1
        nether_gold:
            - 0
            - 1
        diamond:
            - 2
            - 4
        emerald:
            - 2
            - 4
        lapis:
            - 1
            - 3
        nether_quartz:
            - 1
            - 3
        redstone:
            - 0
            - 2
    cmd_offset: 0

# --------------------END CONFIG / START CODE--------------------

mineable:
    type: world
    events:
        on player breaks *_ore:
            - define held <player.item_in_hand>
            - define loc  <context.location>
            - define enchants <[held].enchantment_map>
            - if <[loc].drops[<[held]>].size> > 0 && <[enchants].get[silk_touch].if_null[0]> == 0:
                - determine passively cancelled
                - define config <script[mineable_config]>
                - define ploc   <player.location>
                - define dloc   <[loc].add[<proc[lib_block_facing]>]>
                - define mat    <context.material.name>
                - define xp     <[config].data_key[xp.<[mat]>].if_null[<list[1|2]>]>
                - inventory adjust durability:<[held].durability.add[<util.random.int[1].to[100].is_less_than[<element[100].div[<[enchants].get[unbreaking].if_null[0].add[1]>]>].if_true[1].if_false[0]>]> slot:<player.held_item_slot>
                - modifyblock <[loc]> air <[config].data_key[break_percentage]>
                - drop mineable_<[mat]>_drop quantity:<util.random.int[1].to[<util.random.int[1].to[<[config].data_key[fortune_multiplier]>].mul[<[enchants].get[fortune].if_null[0]>].add[1]>]> <[dloc]>
                - drop xp quantity:<util.random.int[<[xp].first>].to[<[xp].last>]> <[dloc]>
        on furnace burns mineable_coal_ore_drop:
            - determine 20s

mineable_raw_gold:
    type: item
    material: raw_gold
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - mineable_gold_ore_drop|mineable_gold_ore_drop|mineable_gold_ore_drop
                - mineable_gold_ore_drop|mineable_gold_ore_drop|mineable_gold_ore_drop
                - mineable_gold_ore_drop|mineable_gold_ore_drop|mineable_gold_ore_drop

mineable_raw_iron:
    type: item
    material: raw_iron
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - mineable_iron_ore_drop|mineable_iron_ore_drop|mineable_iron_ore_drop
                - mineable_iron_ore_drop|mineable_iron_ore_drop|mineable_iron_ore_drop
                - mineable_iron_ore_drop|mineable_iron_ore_drop|mineable_iron_ore_drop

mineable_raw_copper:
    type: item
    material: raw_copper
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - mineable_copper_ore_drop|mineable_copper_ore_drop|mineable_copper_ore_drop
                - mineable_copper_ore_drop|mineable_copper_ore_drop|mineable_copper_ore_drop
                - mineable_copper_ore_drop|mineable_copper_ore_drop|mineable_copper_ore_drop

mineable_coal:
    type: item
    material: coal
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - mineable_coal_ore_drop|mineable_coal_ore_drop
                - mineable_coal_ore_drop|mineable_coal_ore_drop

mineable_diamond:
    type: item
    material: diamond
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - air|mineable_diamond_ore_drop|air
                - mineable_diamond_ore_drop|mineable_diamond_ore_drop|mineable_diamond_ore_drop
                - air|mineable_diamond_ore_drop|air

mineable_emerald:
    type: item
    material: emerald
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - air|mineable_emerald_ore_drop|air
                - mineable_emerald_ore_drop|mineable_emerald_ore_drop|mineable_emerald_ore_drop
                - air|mineable_emerald_ore_drop|air

mineable_netherite:
    type: item
    material: netherite_scrap
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - mineable_ancient_debris_drop|mineable_ancient_debris_drop

mineable_gold_ore_drop:
    type: item
    material: stick
    display name: <&r>Gold Ore Fragment
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[cmd_offset].add[0]>

mineable_iron_ore_drop:
    type: item
    material: stick
    display name: <&r>Iron Ore Fragment
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[cmd_offset].add[1]>

mineable_coal_ore_drop:
    type: item
    material: stick
    display name: <&r>Coal Fragment
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[cmd_offset].add[2]>
    recipes:
        1:
            type: shapeless
            output_quantity: 4
            input: coal

mineable_diamond_ore_drop:
    type: item
    material: stick
    display name: <&r>Diamond Shard
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[cmd_offset].add[3]>

mineable_emerald_ore_drop:
    type: item
    material: stick
    display name: <&r>Emerald Shard
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[cmd_offset].add[4]>

mineable_copper_ore_drop:
    type: item
    material: stick
    display name: <&r>Copper Ore Fragment
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[cmd_offset].add[5]>

mineable_ancient_debris_drop:
    type: item
    material: stick
    display name: <&r>Netherite Swarf
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[cmd_offset].add[6]>

mineable_nether_gold_ore_drop:
    type: item
    material: gold_nugget
    no_id: true

mineable_lapis_ore_drop:
    type: item
    material: lapis_lazuli
    no_id: true

mineable_redstone_ore_drop:
    type: item
    material: redstone
    no_id: true

mineable_nether_quartz_ore_drop:
    type: item
    material: quartz
    no_id: true
