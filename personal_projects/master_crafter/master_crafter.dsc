# +--------------------
# |
# | MASTER CRAFTER
# |
# | A modified form of tool and armor crafting, adding a non-visible
# | leveling system for roleplay gameplay.
# |
# +----------------------
#
# @author jumpsplat120
# @date 05/19/2021
# @denizen-build 1.2.0-b1739-REL
# @script-version 1.3
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * master_crafter.dsc
#     * utilities [folder]
# Place the master_crafter textures on your server, or if just testing,
# locally on your own client. Reload the textures.
#
# Usage:
# Craft a hammer using basic vanilla materials:
#
#   R = resource (wood/cobblestone/iron/gold/diamond)
#   S = stick
#
#       [R][R][R]
#       [R][S][R]
#       [ ][S][ ]
#
# Once you have crafted a hammer, simply craft your tool as normal. When you
# left click or shift left click on the result, it will vanish, and consume
# the appropriate amount of materials. However, the tool will not be provided
# until you back out of the GUI, and right click on the table with the hammer.
# If you hear a clanging sound, the tool is being crafted. Continue clicking
# on the crafting bench until the tool is provided for you.
#
# If you need to modify you level, and you have operator level permissions,
# you can use the command /set_level (player:<name>) [item:<name>] [level:<number>] to
# automatically set you level to any value. If you do not specify a player,
# the level command will default to the player running the command.
#
# A more detailed walkthrough of the process and the config can be found
# here: https://www.youtube.com/watch?v=Fc98Id7gP60
#
# --------------------END HEADER / START CONFIG--------------------

mc_config:
    type: data
    cmd_offset: 0
    wooden:
        lower_xp_bound: 1
        upper_xp_bound: 3
        enchant_level_max: 1
        enchant_amount_max: 2
        forge_hits: 1
    leather:
        lower_xp_bound: 1
        upper_xp_bound: 3
        enchant_level_max: 1
        enchant_amount_max: 2
        forge_hits: 1
    stone:
        lower_xp_bound: .5
        upper_xp_bound: 2.5
        enchant_level_max: 1
        enchant_amount_max: 3
        forge_hits: 2
    chainmail:
        lower_xp_bound: .5
        upper_xp_bound: 2
        enchant_level_max: 1
        enchant_amount_max: 3
        forge_hits: 2
    iron:
        lower_xp_bound: .5
        upper_xp_bound: 2.5
        enchant_level_max: 2
        enchant_amount_max: 3
        forge_hits: 3
    golden:
        lower_xp_bound: .5
        upper_xp_bound: 2
        enchant_level_max: 4
        enchant_amount_max: 4
        forge_hits: 4
    diamond:
        lower_xp_bound: .5
        upper_xp_bound: 1.5
        enchant_amount_max: 5
        forge_hits: 5
    mastery_multiplier: 2
    unbreakable_chance: 1000
    announcements:
        mastery:
            is_announced: true
            text: "<player.name><yellow><italic> has become a master <gold><[material]> <[tool]> <yellow><italic>crafter!"
        crafted:
            is_announced: true
            text: "<player.name><yellow><italic> has crafted <[display_name]>, <yellow><italic>a <gold><[material]> <[tool]>!"
        unbreakable:
            is_announced: true
            text: "<player.name><yellow><italic> has crafted <[display_name]>, <yellow><italic>a masterwork <gold><[material]> <[tool]>!"
    flavor_adjectives:
        poor:
            - poor
            - weak
            - sub-par
            - feeble
            - inferior
            - insufficient
            - meager
            - miserable
            - shoddy
            - substandard
            - unsatisfactory
            - weak
            - base
            - crude
            - diminutive
            - trifling
            - below-par
            - contemptible
            - faulty
            - incomplete
            - lacking
            - low-grade
            - lowly
            - paltry
            - pitiable
            - pitiful
            - reduced
            - rotten
            - second-rate
            - shabby
            - skimpy
            - sorry
            - trivial
            - valueless
            - worthless
        average:
            - average
            - mediocre
            - moderate
            - ordinary
            - regular
            - boilerplate
            - common
            - commonplace
            - fair
            - familiar
            - general
            - humdrum
            - intermediate
            - medium
            - middling
            - standard
            - customary
            - everyday
            - passable
            - so-so
            - tolerable
            - undistinguished
            - unexceptional
            - usual
            - generic
            - plain
            - simple
            - pedestrian
        good:
            - good
            - acceptable
            - favorable
            - positive
            - satisfactory
            - valuable
            - nice
            - pleasing
            - sound
            - worthy
            - admirable
            - agreeable
            - commendable
            - reputable
            - select
            - splendid
            - advantageous
            - appropriate
            - better
            - convenient
            - decent
            - desirable
            - favorable
            - proper
            - suitable
        great:
            - great
            - excellent
            - fine
            - glorious
            - grand
            - impressive
            - major
            - outstanding
            - remarkable
            - capital
            - notable
            - royal
            - superior
            - dignified
            - distinguished
            - eminent
            - noteworthy
            - sublime
            - amazing
            - astonishing
            - astounding
            - awe-inspiring
            - awesome
            - extraordinary
            - fabulous
            - glorious
    mastery_names:
        prefix:
            - heart
            - black
            - red
            - white
            - night
            - sun
            - moon
        content:
            - abyss
            - aether
            - alpha
            - ancestral
            - angel
            - arch
            - ash
            - aspect
            - astral
            - azure
            - battle
            - bitter
            - blade
            - blaze
            - blood
            - brand
            - bright
            - celestial
            - chain
            - chaos
            - chill
            - cloud
            - cold
            - crimson
            - crown
            - dark
            - dawn
            - death
            - demon
            - devil
            - divine
            - doom
            - dragon
            - dread
            - dream
            - dual
            - dusk
            - earth
            - elder
            - ember
            - end
            - even
            - ever
            - faith
            - fate
            - faye
            - finis
            - fire
            - flame
            - flock
            - fortune
            - frost
            - furor
            - ghost
            - giant
            - god
            - grim
            - heaven
            - horror
            - iron
            - last
            - life
            - light
            - lost
            - moon
            - morn
            - nether
            - obsidian
            - omega
            - omen
            - onyx
            - origin
            - other
            - phoenix
            - pure
            - radiant
            - root
            - serpent
            - shadow
            - silent
            - snow
            - sorrow
            - spark
            - spell
            - spider
            - spirit
            - star
            - stark
            - stellar
            - storm
            - sun
            - tempest
            - thunder
            - timeless
            - totem
            - true
            - truth
            - veil
            - virtue
            - void
            - vortex
            - wicked
            - wild
            - wonder
            - wrath
        suffix:
            - sight
            - soul
            - gift
            - heart
            - touched
            - bright

# --------------------END CONFIG / START CODE--------------------

mc_data:
    type: data
    command: <[fs]><[l]>set_level <[lp]><[l]>player:<[lt]><[nl]>name<[gt]><[rp]> <[lb]><[l]>item:<[lt]><[nl]>name<[gt]><[rb]> <[lb]><[l]>level:<[lt]><[nl]>number<[gt]><[rb]>
    valid_items:
        prefix:
            - wooden
            - leather
            - stone
            - chainmail
            - iron
            - golden
            - diamond
            - netherite
        suffix:
            - pickaxe
            - shovel
            - axe
            - sword
            - hoe
            - boots
            - leggings
            - chestplate
            - helmet
    wooden:
        durability: 1
        next_tier: stone
    leather:
        durability: 1
        next_tier: chainmail
    stone:
        durability: .7
        next_tier: iron
    chainmail:
        durability: .7
        next_tier: iron
    iron:
        durability: .5
        next_tier: golden
    golden:
        durability: 1.1
        next_tier: diamond
    diamond:
        durability: .3
        next_tier: netherite
    netherite:
        durability: .1
    pickaxe:
        damage:
            - DAMAGE_ALL
            - DAMAGE_ARTHROPODS
            - DAMAGE_UNDEAD
        dig_speed:
            - DIG_SPEED
        durability:
            - DURABILITY
        fire_aspect:
            - FIRE_ASPECT
        knockback:
            - KNOCKBACK
        loot:
            - LOOT_BONUS_MOBS
        mending:
            - MENDING
        mining:
            - SILK_TOUCH
            - LOOT_BONUS_BLOCKS
    shovel:
        damage:
            - DAMAGE_ALL
            - DAMAGE_ARTHROPODS
            - DAMAGE_UNDEAD
        dig_speed:
            - DIG_SPEED
        durability:
            - DURABILITY
        fire_aspect:
            - FIRE_ASPECT
        knockback:
            - KNOCKBACK
        loot:
            - LOOT_BONUS_MOBS
        mending:
            - MENDING
        mining:
            - SILK_TOUCH
            - LOOT_BONUS_BLOCKS
    axe:
        damage:
            - DAMAGE_ALL
            - DAMAGE_ARTHROPODS
            - DAMAGE_UNDEAD
        dig_speed:
            - DIG_SPEED
        durability:
            - DURABILITY
        fire_aspect:
            - FIRE_ASPECT
        knockback:
            - KNOCKBACK
        loot:
            - LOOT_BONUS_MOBS
        mending:
            - MENDING
        mining:
            - SILK_TOUCH
            - LOOT_BONUS_BLOCKS
    sword:
        damage:
            - DAMAGE_ALL
            - DAMAGE_ARTHROPODS
            - DAMAGE_UNDEAD
        dig_speed:
            - DIG_SPEED
        durability:
            - DURABILITY
        fire_aspect:
            - FIRE_ASPECT
        knockback:
            - KNOCKBACK
        loot:
            - LOOT_BONUS_MOBS
        mending:
            - MENDING
        mining:
            - SILK_TOUCH
            - LOOT_BONUS_BLOCKS
        sweeping_edge:
            - SWEEPING_EDGE
    hoe:
        damage:
            - DAMAGE_ALL
            - DAMAGE_ARTHROPODS
            - DAMAGE_UNDEAD
        dig_speed:
            - DIG_SPEED
        durability:
            - DURABILITY
        fire_aspect:
            - FIRE_ASPECT
        knockback:
            - KNOCKBACK
        loot:
            - LOOT_BONUS_MOBS
        mending:
            - MENDING
        mining:
            - SILK_TOUCH
            - LOOT_BONUS_BLOCKS
    boots:
        water_walker:
            - DEPTH_STRIDER
            - FROST_WALKER
        durability:
            - DURABILITY
        mending:
            - MENDING
        protection:
            - PROTECTION_ENVIRONMENTAL
            - PROTECTION_EXPLOSIONS
            - PROTECTION_FALL
            - PROTECTION_FIRE
            - PROTECTION_PROJECTILE
        thorns:
            - THORNS
        soul_speed:
            - SOUL_SPEED
    leggings:
        durability:
            - DURABILITY
        mending:
            - MENDING
        protection:
            - PROTECTION_ENVIRONMENTAL
            - PROTECTION_EXPLOSIONS
            - PROTECTION_FALL
            - PROTECTION_FIRE
            - PROTECTION_PROJECTILE
        thorns:
            - THORNS
    chestplate:
        durability:
            - DURABILITY
        mending:
            - MENDING
        protection:
            - PROTECTION_ENVIRONMENTAL
            - PROTECTION_EXPLOSIONS
            - PROTECTION_FALL
            - PROTECTION_FIRE
            - PROTECTION_PROJECTILE
        thorns:
            - THORNS
    helmet:
        durability:
            - DURABILITY
        mending:
            - MENDING
        protection:
            - PROTECTION_ENVIRONMENTAL
            - PROTECTION_EXPLOSIONS
            - PROTECTION_FALL
            - PROTECTION_FIRE
            - PROTECTION_PROJECTILE
        thorns:
            - THORNS
        oxygen:
            - OXYGEN
        aqua_affinity:
            - WATER_WORKER

#Mentor system??
master_crafter:
    type: world
    debug: false
    definitions: hammer
    events:
        on player breaks block with:*_hammer:
            - run master_crafter path:hammer_durability def.hammer:<player.item_in_hand>
        on player crafts *_pickaxe:
            - inject master_crafter path:store_item
        on player crafts *_axe:
            - inject master_crafter path:store_item
        on player crafts *_shovel:
            - inject master_crafter path:store_item
        on player crafts *_hoe:
            - inject master_crafter path:store_item
        on player crafts *_sword:
            - inject master_crafter path:store_item
        on player crafts *_boots:
            - inject master_crafter path:store_item
        on player crafts *_leggings:
            - inject master_crafter path:store_item
        on player crafts *_chestplate:
            - inject master_crafter path:store_item
        on player crafts *_helmet:
            - inject master_crafter path:store_item
        on player right clicks crafting_table with:*_hammer location_flagged:stored_items:
            - determine passively cancelled
            - ratelimit player 1t
            - define loc <context.location>
            - define config <script[mc_config]>
            - define data   <script[mc_data]>
            - define item       <[loc].flag[stored_items].first>
            - define item_name  <[item].material.name>
            - define material   <[item_name].before[_].to_titlecase>
            - define tool       <[item_name].after[_].to_titlecase>
            - define mat_config <[config].data_key[<[material]>]>
            - playsound <player.location> sound:block_anvil_land pitch:<proc[lib_random_pitch]>
            - flag <[loc]> mc_forge_hits:++
            - run master_crafter path:hammer_durability def.hammer:<context.item>
            - if <[config].data_key[<[material]>].get[forge_hits]> <= <[loc].flag[mc_forge_hits]>:
                - if !<player.has_flag[master_crafter.<[item_name]>]>:
                    - flag player master_crafter.<[item_name]>:<map.with[level].as[0].with[prev_mastery].as[false]>
                - define flag <player.flag[master_crafter.<[item_name]>]>
                - define old_level <[flag].get[level]>
                - define mult <[flag].get[prev_mastery].if_true[<[config].data_key[mastery_multiplier]>].if_false[1]>
                - flag player master_crafter.<[item_name]>.level:+:<util.random.decimal[<[mat_config].get[lower_xp_bound].mul[<[mult]>]>].to[<[mat_config].get[upper_xp_bound].mul[<[mult]>]>]>
                - define new_level <player.flag[master_crafter.<[item_name]>.level]>
                - define max_durability <[item].max_durability>
                - define durability <[max_durability].sub[<[new_level].is_less_than_or_equal_to[75].if_true[<[max_durability].div[75].mul[<[new_level]>].round>].if_false[<[max_durability]>]>]>
                - if <[new_level]> >= 90:
                    - define enchant_list <[data].data_key[<[tool]>]>
                    - define categories <[enchant_list].keys>
                    - repeat <[mat_config].get[enchant_amount_max].proc[lib_between]>:
                        - define category <[categories].random>
                        - define enchants:->:<[enchant_list].get[<[category]>].random>,<[material].equals[Netherite].if_true[<[new_level].div[10].sqrt.round_down>].if_false[<[mat_config].get[enchant_level_max]>].proc[lib_between]>
                        - define enchant_data:<-:<[category]>
                - if <[new_level]> >= 100:
                    - define name_type    <list[prefix|suffix].random>
                    - define name_affix   <[config].parsed_key[mastery_names.<[name_type]>].random>
                    - define name_base    <[config].parsed_key[mastery_names.content].random>
                    - define display_name <[name_type].equals[prefix].if_true[<[name_affix]><[name_base]>].if_false[<[name_base]><[name_affix]>]>
                    - define unbreakable  <[config].data_key[unbreakable_chance].proc[lib_between].equals[1]>
                    - define display_name "<[unbreakable].if_true[<proc[lib_rainbow_text].context[Infinity <[display_name].to_titlecase>]>].if_false[<proc[lib_random_color]><[display_name].to_titlecase>]>"
                    - define name         <player.name>
                    - if <[old_level]> < 100:
                        - flag player master_crafter.<[data].get[<[material]>.next_tier]>_<[tool]>.prev_mastery
                        - toast "<[material]> <[tool]> Mastery" icon:<[item]> frame:challenge
                        - if <[config].data_key[announcements.mastery.is_announced]>:
                            - announce <[config].parsed_key[announcements.mastery.text]>
                    - else if <[config].parsed_key[announcements.unbreakable.is_announced]>:
                        - announce <[config].parsed_key[announcements.unbreakable.text]>
                    - else if <[config].parsed_key[announcements.crafted.is_announced]>:
                        - announce <[config].parsed_key[announcements.crafted.text]>
                - else:
                    - define display_name "<reset><[config].data_key[flavor_adjectives].get[<[new_level].is_more_than_or_equal_to[75].if_true[great].if_false[<[new_level].is_more_than_or_equal_to[50].if_true[good].if_false[<[new_level].is_more_than_or_equal_to[25].if_true[average].if_false[poor]>]>]>].random.to_titlecase> <[item].material.translated_name>"
                - drop <[item].with[durability=<[durability]>;enchantments=<[enchants].if_null[<list>]>;unbreakable=<[unbreakable].if_null[false]>;hides=unbreakable;display_name=<[display_name]>]> <[loc].center.up>
                - flag <[loc]> stored_items:<-:<[item]>
                - if <[loc].flag[stored_items].is_empty>:
                    - flag <[loc]> stored_items:!
                - flag <[loc]> mc_forge_hits:0
    hammer_durability:
        - inventory flag durability:+:<script[mc_data].data_key[<[hammer].script.name.after[mc_].before[_hammer]>.durability]> slot:<player.held_item_slot>
        - if <[hammer].flag[durability]> >= <[hammer].max_durability>:
            - run def:<[hammer]> lib_simulate_item_breaking
            - take iteminhand
        - else:
            - inventory adjust durability:<[hammer].flag[durability].round_down> slot:<player.held_item_slot>
    store_item:
        - determine passively cancelled
        - define inv <context.inventory>
        - define amt <context.amount>
        - adjust <[inv]> matrix:<[inv].matrix.parse_tag[<[parse_value].quantity.is_more_than[0].if_true[<[parse_value].with[quantity=<[parse_value].quantity.sub[<[amt]>]>]>].if_false[air]>]>
        - flag <player.eye_location.precise_cursor_on_block> stored_items:|:<context.item.repeat_as_list[<[amt]>]>

mc_command_proc:
    type: procedure
    debug: false
    script:
        - define c <script[lib_config].parsed_key[color.command]>
        - define l <[c].get[literal]>
        - define fs <[c].get[forward_slash]><[l]>
        - define lb <[c].get[left_bracket]><[l]>
        - define rb <[c].get[right_bracket]><[l]>
        - define lt <[c].get[less_than]><[l]>
        - define gt <[c].get[greater_than]><[l]>
        - define lp <[c].get[left_parenthesis]><[l]>
        - define rp <[c].get[right_parenthesis]><[l]>
        - define rc <[c].get[right_curly_bracket]><[l]>
        - define lc <[c].get[left_curly_bracket]><[l]>
        - define nl <[c].get[non_literal]>
        - determine <script[mc_data].parsed_key[command]>

mc_command:
    type: command
    name: set_level
    description: Sets your master crafter level for a specified tool.
    usage: <proc[mc_command_proc]>
    allowed help:
        - determine <proc[lib_has_permission].context[master_crafter|<player.if_null[null]>].if_null[true]>
    script:
        - if <proc[lib_has_permission].context[master_crafter|<player.if_null[null]>].if_null[true]>:
            - if <context.args.size> >= 2:
                - if <context.args.size> < 4:
                    - define arg_map <context.args.to_map[<&co>].if_null[<map>]>
                    - define player  <[arg_map].get[player].if_null[<player.name.if_null[implicit]>]>
                    - define level   <[arg_map].get[level].if_null[null]>
                    - define item    <[arg_map].get[item].if_null[null]>
                    - if <[player]> != implicit:
                        - define player <server.match_offline_player[<[player]>].if_null[null]>
                        - if <[arg_map].exclude[player|level|item].size> == 0:
                            - if <[arg_map].size> != 0 || <context.args.size> == 0:
                                - if <[player].object_type> == Player:
                                    - if <[level].is_decimal>:
                                        - define valid <script[mc_data].data_key[valid_items]>
                                        - if <[valid].get[suffix].contains[<[item].after[_].if_null[null]>]> && <[valid].get[prefix].contains[<[item].before[_].if_null[null]>]>:
                                            - define color <script[lib_config].parsed_key[color]>
                                            - if <[level]> >= 0:
                                                - flag <[player]> master_crafter.<[item]>.level:<[level]>
                                                - narrate "<[color].get[success]>Set <[color].get[soft_server_notice]><[player].name><[color].get[success]>'s <[color].get[important]><[item]><[color].get[success]> level to <[color].get[important]><[level]><[color].get[success]>."
                                            - else:
                                                - narrate "<[color].get[error]>Unable to set <[color].get[hard_server_notice]>'<[color].get[soft_server_notice]>level<[color].get[hard_server_notice]>'<[color].get[error]> to a negative value."
                                        - else:
                                            - narrate "<proc[lib_core_command_error].context[invalid_value|mc_command_proc|levelable item|<[item]>]>"
                                    - else:
                                        - narrate <proc[lib_core_command_error].context[invalid_value|mc_command_proc|level|<[level]>]>
                                - else:
                                    - narrate <proc[lib_core_command_error].context[invalid_value|mc_command_proc|player|<[player]>]>
                            - else:
                                - narrate <proc[lib_core_command_error].context[extra_keys|mc_command_proc|<[arg_map].keys.proc[lib_core_command_extra_keys]>]>
                        - else:
                            - narrate <proc[lib_core_command_error].context[missing_keys|mc_command_proc|<context.args.proc[lib_core_command_extra_keys]>]>
                    - else:
                        - narrate <proc[lib_core_command_error].context[implicit]>
                - else:
                    - narrate <proc[lib_core_command_error].context[min_args|mc_command_proc|3|<context.args.size>]>
            - else:
                - narrate <proc[lib_core_command_error].context[max_args|mc_command_proc|2|<context.args.size>]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>

mc_chainmail_boots:
    type: item
    material: chainmail_boots
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|air|iron_nugget
                - iron_nugget|air|iron_nugget

mc_chainmail_leggings:
    type: item
    material: chainmail_leggings
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|iron_nugget|iron_nugget
                - iron_nugget|air|iron_nugget
                - iron_nugget|air|iron_nugget

mc_chainmail_chestplate:
    type: item
    material: chainmail_chestplate
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|air|iron_nugget
                - iron_nugget|iron_nugget|iron_nugget
                - iron_nugget|iron_nugget|iron_nugget

mc_chainmail_helmet:
    type: item
    material: chainmail_helmet
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|iron_nugget|iron_nugget
                - iron_nugget|air|iron_nugget

mc_wooden_hammer:
    type: item
    material: wooden_sword
    display name: <&r>Wooden Hammer
    mechanisms:
        custom_model_data: <script[mc_config].data_key[cmd_offset].add[1]>
        hides: attributes
        flag: durability:0
    recipes:
        1:
            type: shaped
            input:
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|stick|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks
                - air|stick|air

mc_stone_hammer:
    type: item
    material: wooden_sword
    display name: <&r>Stone Hammer
    mechanisms:
        custom_model_data: <script[mc_config].data_key[cmd_offset].add[2]>
        hides: attributes
        flag: durability:0
    recipes:
        1:
            type: shaped
            input:
                - cobblestone|cobblestone|cobblestone
                - cobblestone|stick|cobblestone
                - air|stick|air

mc_iron_hammer:
    type: item
    material: wooden_sword
    display name: <&r>Iron Hammer
    mechanisms:
        custom_model_data: <script[mc_config].data_key[cmd_offset].add[3]>
        hides: attributes
        flag: durability:0
    recipes:
        1:
            type: shaped
            input:
                - iron_ingot|iron_ingot|iron_ingot
                - iron_ingot|stick|iron_ingot
                - air|stick|air

mc_golden_hammer:
    type: item
    material: wooden_sword
    display name: <&r>Golden Hammer
    mechanisms:
        custom_model_data: <script[mc_config].data_key[cmd_offset].add[4]>
        hides: attributes
        flag: durability:0
    recipes:
        1:
            type: shaped
            input:
                - gold_ingot|gold_ingot|gold_ingot
                - gold_ingot|stick|gold_ingot
                - air|stick|air

mc_diamond_hammer:
    type: item
    material: wooden_sword
    display name: <&r>Diamond Hammer
    mechanisms:
        custom_model_data: <script[mc_config].data_key[cmd_offset].add[5]>
        hides: attributes
        flag: durability:0
    recipes:
        1:
            type: shaped
            input:
                - diamond|diamond|diamond
                - diamond|stick|diamond
                - air|stick|air