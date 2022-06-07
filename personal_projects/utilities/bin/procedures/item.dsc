# calculate_fortune: Follows the minecraft formula for calculating extra fortune drops. This only accounts for the multiplier, and will not be accurate for discrete items (melons, glowstone, etc) or for chance drops (flint, etc)
# apply_enchant: Applies the enchantments to the item. Since it's a procedure, it will return the item with the enchantments applied, rather than adjust an item in an inventory.
lib_calculate_fortune:
    type: procedure
    debug: false
    definitions: item
    script:
        - define level <[item].enchantment_map.get[fortune].if_null[0]>
        - determine 1 if:<[level].is_less_than_or_equal_to[0].or[<util.random_chance[<element[2].div[<[level].add[2]>]>]>]>
        - determine <util.random.int[2].to[<[level].add[1]>]>

lib_apply_enchantment:
    type: procedure
    debug: false
    definitions: item|enchantment|level|allow_conflicts|allow_invalid_enchants|allow_over_max_level
    script:
        - define item_enchants <[item].enchantment_map>
        - define existing_enchant_lvl <[item_enchants].get[<[enchantment].name>].if_null[0]>
        - define item_enchants:<-:<[enchantment].name> if:<[existing_enchant_lvl].is_more_than[0]>
        - determine <[item]> if:<[existing_enchant_lvl].equals[<[level]>]>
        - determine <[item]> if:<[allow_over_max_level].is_truthy.not.and[<[enchantment].min_level.is_more_than[<[level]>].or[<[level].is_more_than[<[enchantment].max_level>]>]>]>
        - determine <[item]> if:<[allow_invalid_enchants].is_truthy.not.and[<[enchantment].can_enchant[<[item]>].not>]>
        - foreach <[item_enchants]> if:<[allow_conflicts].is_truthy.not>:
            - determine <[item]> if:<[enchantment].is_compatible[<enchantment[<[key]>]>].not>
        - define item_enchants:->:<map[<[enchantment]>=<[level]>]>
        - define lore:|:<[item].lore.if_null[<list>]>
        - define lore:->:<gray><[enchantment].full_name[<[level]>]> if:<[enchantment].key.before[:].equals[minecraft].not>
        - define lore:<-:<reset><gray><[enchantment].full_name[<[existing_enchant_lvl]>]> if:<[existing_enchant_lvl].equals[<[level]>].not.and[<[existing_enchant_lvl].equals[0].not>]>
        - adjust <[item]> enchantments:<[item_enchants]>
        - adjust <[item]> lore:<[lore]>
        - determine <[item]>

lib_vanilla_modifiers:
    type: procedure
    debug: false
    definitions: item
    script:
        - define data <script[lib_generic_data].data_key[attributes.<[item].material.name>]>
        - define attributes <map>
        - foreach <[data].exclude[slot]>:
            - define attributes <[attributes].with[generic_<[key]>].as[<list[<map[operation=add_number;amount=<[value]>;slot=<[data].get[slot]>]>]>]>
        - determine <[attributes]>

lib_custom_breaking_time:
    type: procedure
    debug: false
    definitions: item|hardness|is_hand_valid|best_tools
    script:
        - determine <util.int_max> if:<[hardness].equals[-1]>
        - determine 0              if:<[hardness].equals[0]>
        - define mat_name    <[item].material.name>
        - define can_harvest false
        - if <[mat_name]> in <[best_tools].keys>:
            - define speed <[best_tools].get[<[mat_name]>]>
            - define can_harvest true
        - else if <[is_hand_valid]>:
            - define speed 1
            - define can_harvest true
        - else:
            - define speed 1
        - define efficiency_lvl <[item].enchantment_map.get[efficiency].if_null[0]>
        - if <[can_harvest]> and <[efficiency_lvl]> > 0:
            - define speed:+:<[efficiency_lvl].mul[<[efficiency_lvl]>].add[1]>
        - if <player.has_effect[fast_digging]>:
            - define speed:*:<player.list_effects.filter[starts_with[fast_digging]].first.after[,].before[,].mul[0.2].add[1]>
        - if <player.has_effect[slow_digging]>:
            - define level <player.list_effects.filter[starts_with[slow_digging]].first.after[,].before[,].max[-1]>
            - define speed:*:<[level].equals[0].if_true[0.3].if_false[<[level].equals[1].if_true[0.09].if_false[<[level].equals[2].if_true[0.0027].if_false[0.00081]>]>]> if:<[level].is_more_than[-1]>
        - if <player.eye_location.material.advanced_matches[*water]> and !<player.equipment_map.get[helmet].if_null[false].enchantment_map.get[aqua_affinity].exists>:
            - define speed:/:5
        - if !<player.is_on_ground>:
            - define speed:/:5
        - define damage <[speed].div[<[hardness]>].mul[<[can_harvest].if_true[0.0333333].if_false[0.01]>]>
        - determine 0 if:<[damage].is_more_than[1]>
        - determine <element[1].div[<[damage]>].round_up.div[20]>

lib_vanilla_to_custom_potion:
    type: procedure
    debug: false
    definitions: item
    script:
        - define data <[item].effects_data.first.if_null[]>
        - if !<[item].material.advanced_matches[*potion|tipped_arrow]>:
            - debug error "Item is not a valid material. Expected splash potion, lingering potion, potion, or tipped arrow, but got <[item].material.name>."
        - else if <[data]> == <empty>:
            - debug error "Item has no effects_data."
        - else if !<[data].get[upgraded].exists>:
            - debug error "Item has no upgraded entry; most likely using comma separated potion data. This proc only works if the item was made recently within vanilla, and is using the map format."
        - else:
            - determine <item[lib_<[item].material.name>_<[data].get[type].to_lowercase><[data].get[upgraded].if_true[_upgraded].if_false[]><[data].get[extended].if_true[_extended].if_false[]>]>