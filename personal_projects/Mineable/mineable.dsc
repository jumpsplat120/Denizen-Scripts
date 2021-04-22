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
# @date 10/04/2020
# @denizen-build b5081-DEV
# @script-version 1.0
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
    custom_model_data_offset: 0

# --------------------END CONFIG / START CODE--------------------

mineable:
    type: world
    events:
        on player breaks *_ore:
            - define held <player.item_in_hand>
            - if <context.location.drops[<[held]>].size> > 0 && <[held].enchantments.level[silk_touch]> == 0:
                - determine passively cancelled
                - define config <script[mineable_config]>
                - define drop_location <context.location.center.points_between[<player.location>].get[2]||<player.location>>
                - inventory adjust durability:<[held].durability.add[<tern[<util.random.int[1].to[100].is[LESS].than[<element[100].div[<[held].enchantments.level[unbreaking].add[1]>]>]>].pass[1].fail[0]>]> slot:<player.held_item_slot>
                - modifyblock <context.location> air <[config].data_key[break_percentage]>
                - drop <context.material.name>_drop quantity:<util.random.int[1].to[<util.random.int[1].to[<[config].data_key[fortune_multiplier]>].mul[<[held].enchantments.level[fortune]>].add[1]>]> <[drop_location]>
                - drop xp quantity:<tern[<context.material.name.is[==].to[diamond_ore].or[<context.material.name.is[==].to[emerald_ore]>]>].pass[<util.random.int[1].to[3]>].fail[<util.random.int[0].to[1]>]> <[drop_location]>

cstm_gold_nugget:
    type: item
    material: gold_nugget
    no_id: true
    recipes:
        1:
            type: furnace
            cook_time: 1s
            input: gold_ore_drop
            experience: 2

cstm_iron_nugget:
    type: item
    material: iron_nugget
    no_id: true
    recipes:
        1:
            type: furnace
            cook_time: 1s
            input: iron_ore_drop
            experience: 1

cstm_coal:
    type: item
    material: coal
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - coal_ore_drop|coal_ore_drop
                - coal_ore_drop|coal_ore_drop

cstm_diamond:
    type: item
    material: diamond
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - diamond_ore_drop|diamond_ore_drop|diamond_ore_drop
                - diamond_ore_drop|diamond_ore_drop|diamond_ore_drop
                - diamond_ore_drop|diamond_ore_drop|diamond_ore_drop

cstm_emerald:
    type: item
    material: emerald
    no_id: true
    recipes:
        1:
            type: shaped
            input:
                - emerald_ore_drop|emerald_ore_drop|emerald_ore_drop
                - emerald_ore_drop|emerald_ore_drop|emerald_ore_drop
                - emerald_ore_drop|emerald_ore_drop|emerald_ore_drop

gold_ore_drop:
    type: item
    material: stick
    display name: <&r>Gold Ore Chunk
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[custom_model_data_offset].add[1]>

iron_ore_drop:
    type: item
    material: stick
    display name: <&r>Iron Ore Chunk
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[custom_model_data_offset].add[2]>

coal_ore_drop:
    type: item
    material: stick
    display name: <&r>Coal Fragment
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[custom_model_data_offset].add[3]>

nether_gold_ore_drop:
    type: item
    material: gold_nugget
    no_id: true

lapis_ore_drop:
    type: item
    material: lapis_lazuli
    no_id: true

diamond_ore_drop:
    type: item
    material: stick
    display name: <&r>Diamond Fragment
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[custom_model_data_offset].add[4]>

redstone_ore_drop:
    type: item
    material: redstone
    no_id: true

emerald_ore_drop:
    type: item
    material: stick
    display name: <&r>Emerald Fragment
    mechanisms:
        custom_model_data: <script[mineable_config].data_key[custom_model_data_offset].add[5]>

nether_quartz_ore_drop:
    type: item
    material: quartz
    no_id: true

