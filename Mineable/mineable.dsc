mineable:
    type: world
    events:
        on player breaks *_ore:
            - define held <player.item_in_hand>
            - if <context.location.drops[<[held]>].size> > 0 && <[held].enchantments.level[silk_touch]> == 0:
                - determine passively cancelled
                - define drop_location <context.location.center.points_between[<player.location>].get[2]||<player.location>>
                - inventory adjust durability:<[held].durability.add[<tern[<util.random.int[1].to[100].is[LESS].than[<element[100].div[<[held].enchantments.level[unbreaking].add[1]>]>]>].pass[1].fail[0]>]> slot:<player.held_item_slot>
                - modifyblock <context.location> air 10
                - drop <context.material.name>_drop quantity:<util.random.int[1].to[<util.random.int[1].to[3].mul[<[held].enchantments.level[fortune]>].add[1]>]> <[drop_location]>
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
        custom_model_data: 1

iron_ore_drop:
    type: item
    material: stick
    display name: <&r>Iron Ore Chunk
    mechanisms:
        custom_model_data: 2

coal_ore_drop:
    type: item
    material: stick
    display name: <&r>Coal Fragment
    mechanisms:
        custom_model_data: 3

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
        custom_model_data: 4

redstone_ore_drop:
    type: item
    material: redstone
    no_id: true

emerald_ore_drop:
    type: item
    material: stick
    display name: <&r>Emerald Fragment
    mechanisms:
        custom_model_data: 5

nether_quartz_ore_drop:
    type: item
    material: quartz
    no_id: true

