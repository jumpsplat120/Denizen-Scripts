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
# @date 10/04/2020
# @denizen-build b5081-DEV
# @script-version 1.2
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * master_crafter.dsc
#     * /utilities
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
# you can use the command /set_level <player> <tool_name> <level> to
# automatically set you level to any value. If you do not specify a player,
# the level command will default to the player running the command.
#
# A more detailed walkthrough of the process and the config can be found
# here: https://www.youtube.com/watch?v=Fc98Id7gP60
#
# --------------------END HEADER / START CONFIG--------------------

master_crafter_config:
    type: data
    custom_model_data_offset: 0
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
            text: "<[name]><yellow><italic> has become a master <gold><[material]> <[tool]> <yellow><italic>crafter!"
        crafted:
            is_announced: true
            text: "<[name]><yellow><italic> has crafted <[tool_name]>, <yellow><italic>a <gold><[material]> <[tool]>!"
        unbreakable:
            is_announced: true
            text: "<[name]><yellow><italic> has crafted <[tool_name]>, <yellow><italic>a masterwork <gold><[material]> <[tool]>!"
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

mc_mastery_key:
    type: data
    wooden: false
    leather: false
    stone: wooden
    chainmail: leather
    golden: iron
    diamond: golden
    pickaxe: stone
    shovel: stone
    hoe: stone
    sword: stone
    axe: stone
    boots: chainmail
    leggings: chainmail
    chestplate: chainmail
    helmet: chainmail

mc_durability_key:
    type: data
    wooden: 1
    stone: .7
    iron: .5
    golden: .3
    diamond: .1

mc_tool_map:
    type: data
    map:
        wooden_pickaxe: false
        stone_pickaxe: false
        golden_pickaxe: false
        iron_pickaxe: false
        diamond_pickaxe: false
        wooden_shovel: false
        stone_shovel: false
        golden_shovel: false
        iron_shovel: false
        diamond_shovel: false
        wooden_hoe: false
        stone_hoe: false
        golden_hoe: false
        iron_hoe: false
        diamond_hoe: false
        wooden_sword: false
        stone_sword: false
        golden_sword: false
        iron_sword: false
        diamond_sword: false
        wooden_axe: false
        stone_axe: false
        golden_axe: false
        iron_axe: false
        diamond_axe: false
        leather_boots: false
        chainmail_boots: false
        iron_boots: false
        golden_boots: false
        diamond_boots: false
        leather_leggings: false
        chainmail_leggings: false
        iron_leggings: false
        golden_leggings: false
        diamond_leggings: false
        leather_chestplate: false
        chainmail_chestplate: false
        iron_chestplate: false
        golden_chestplate: false
        diamond_chestplate: false
        leather_helmet: false
        chainmail_helmet: false
        iron_helmet: false
        golden_helmet: false
        diamond_helmet: false

mc_sorted_enchants:
    type: data
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

mc_mastery_formatter:
    type: procedure
    definitions: name|material|tool
    debug: false
    script:
        - determine <script[master_crafter_config].data_key[announcements].get[mastery].get[text].parsed>

mc_crafted_formatter:
    type: procedure
    definitions: name|material|tool|tool_name
    debug: false
    script:
        - determine <script[master_crafter_config].data_key[announcements].get[crafted].get[text].parsed>

mc_unbreakable_formatter:
    type: procedure
    definitions: name|material|tool|tool_name
    debug: false
    script:
        - determine <script[master_crafter_config].data_key[announcements].get[unbreakable].get[text].parsed>

mc_xp_formula:
    type: procedure
    definitions: material|tool
    debug: false
    script:
        - define values <script[master_crafter_config].data_key[<[material]>]>
        - define multiplier <tern[<player.flag[master_crafter].as_map.get[<tern[<[material].is[==].to[iron]>].pass[<script[mc_mastery_key].data_key[<[tool]>]>].fail[<script[mc_mastery_key].data_key[<[material]>]>]>_<[tool]>]||false>].pass[<[config].data_key[mastery_multiplier]>].fail[1]>
        - determine <util.random.decimal[<[values].get[lower_xp_bound].mul[<[multiplier]>]>].to[<[values].get[upper_xp_bound].mul[<[multiplier]>]>]>

mc_make_item:
    type: task
    definitions: material|tool|level|is_master
    debug: false
    script:
        - define config <script[master_crafter_config]>
        - define max_durability <item[<[material]>_<[tool]>].max_durability>
        - define durability <[max_durability].sub[<tern[<[level].is[OR_LESS].than[75]>].pass[<proc[map_range].context[0|75|0|<[max_durability]>|<[level]>].round>].fail[<[max_durability]>]>]>
        - define enchants <list[]>
        - if <[level]> >= 90:
            - define enchant_limits <[config].data_key[<[material]>]>
            - define enchant_list <script[mc_sorted_enchants].data_key[<[tool]>].values>
            - repeat <util.random.int[1].to[<[enchant_limits].get[enchant_amount_max]>]>:
                - define used_enchant_index <util.random.int[1].to[<[enchant_list].size>]>
                - define used_enchant <[enchant_list].get[<[used_enchant_index]>].random>
                - define enchants <[enchants].include[<[used_enchant]>,<util.random.int[1].to[<tern[<[material].is[==].to[diamond]>].pass[<[level].div[10].sqrt.round_down>].fail[<[enchant_limits].get[enchant_level_max]>]>]>]>
                - define enchant_list <[enchant_list].remove[<[used_enchant_index]>]>
        - if <[is_master]>:
            - define unbreakable <util.random.int[1].to[<[config].data_key[unbreakable_chance]>].is[==].to[1]>
            - define pre_or_suf <list[prefix|suffix].random>
            - if <[pre_or_suf]> == prefix:
                - define display_name <element[<[config].data_key[mastery_names].get[<[pre_or_suf]>].random><[config].data_key[mastery_names].get[content].random>].to_titlecase>
            - else:
                - define display_name <element[<[config].data_key[mastery_names].get[content].random><[config].data_key[mastery_names].get[<[pre_or_suf]>].random>].to_titlecase>
            - if <[unbreakable]>:
                - define color <proc[random_color]>
                - define color_jump 0
                - define display_name "Infinity <[display_name]>"
                - define display_list <[display_name].split[]>
                - define display_name <list[]>
                - foreach <[display_list]>:
                    - if <[value]> == <&sp>:
                        - define display_name <[display_name].include[<[value]>]>
                    - else:
                        - define display_name <[display_name].include[<&color[<[color].with_hue[<proc[cycle_value].context[0|359|<[color].hue.add[<[color_jump]>]>]>]>]><[value]>]>
                        - define color_jump <[color_jump].add[15]>
                - define display_name <[display_name].unseparated>
            - else:
                - define display_name <&color[<proc[random_color]>]><[display_name]>
        - else:
            - define display_name "<&f><element[<[config].data_key[flavor_adjectives].get[<tern[<[level].is[OR_MORE].than[75].and[<[level].is[LESS].than[100]>]>].pass[great].fail[<tern[<[level].is[OR_MORE].than[50].and[<[level].is[LESS].than[75]>]>].pass[good].fail[<tern[<[level].is[OR_MORE].than[25].and[<[level].is[LESS].than[50]>]>].pass[average].fail[poor]>]>]>].random> <[material]> <[tool]>].to_titlecase>"
        - determine <item[<[material]>_<[tool]>].with[durability=<[durability]>;enchantments=<[enchants]>;unbreakable=<[unbreakable]||false>;hides=<list[UNBREAKABLE]>;display_name=<[display_name]>]>

mc_inventory:
    type: task
    debug: false
    script:
        - define mat <[inv].matrix>
        - define amt <[mat].parse[quantity]>
        - define new_amt <[amt].parse[sub[<tern[<context.amount.is[MORE].than[1]>].pass[<[amt].exclude[0].lowest>].fail[1]>]].replace[-1].with[0]>
        - foreach <[mat]>:
            - define curr_amt <[new_amt].get[<[loop_index]>]>
            - define mat <[mat].set_single[<tern[<[curr_amt].is[==].to[0]>].pass[<item[air]>].fail[<[value].with[quantity=<[curr_amt]>]>]>].at[<[loop_index]>]>
        - adjust <[inv]> matrix:<[mat]>

mc_result:
    type: task
    debug: false
    script:
        - determine passively cancelled
        - define config <script[master_crafter_config]>
        - define item_name <context.item.material.name>
        - define parsed_name <[item_name].split[_]>
        - define material <[parsed_name].first>
        - define tool <[parsed_name].last>
        - define inv <context.inventory>
        - define crafting_table_loc <player.location.find.blocks[crafting_table].within[5].first>
        - define loop_amt <context.amount>
        - inject mc_inventory
        - repeat <[loop_amt]>:
            - define announce false
            - if <player.flag[<[item_name]>]||0> >= 100:
                - if <[material]> == diamond:
                    - flag player <[item_name]>:+:<proc[mc_xp_formula].context[diamond|<[tool]>]>
                - run mc_make_item def:<[material]>|<[tool]>|<player.flag[<[item_name]>]>|true save:new_item
                - define item <entry[new_item].created_queue.determination.first>
            - else:
                - if <player.has_flag[<[item_name]>]>:
                    - flag player <[item_name]>:+:<proc[mc_xp_formula].context[<[material]>|<[tool]>]>
                - else:
                    - flag player master_crafter:<script[mc_tool_map].data_key[map].as_map>
                    - flag player <[item_name]>:1
                - if <player.flag[<[item_name]>]> >= 100:
                    - if <[config].data_key[announcements].get[mastery].get[is_announced]>:
                        - define announce true
                    - flag player master_crafter:<player.flag[master_crafter].as_map.with[<[item_name]>].as[true]>
                - run mc_make_item def:<[material]>|<[tool]>|<player.flag[<[item_name]>]>|<player.flag[master_crafter].as_map.get[<[item_name]>]> save:new_item
                - define item <entry[new_item].created_queue.determination.first>
            - flag server <[crafting_table_loc]>:->:<map.with[item].as[<[item]>].with[is_master].as[<player.flag[master_crafter].as_map.get[<[item_name]>]>].with[gained_mastery].as[<[announce]>]>
#Mentor system??
master_crafter:
    type: world
    debug: false
    events:
        on player crafts *_hammer:
            - define item <context.item>
            - determine "<[item].with[nbt=flag_id/<[item].display.split[ ].first.to_lowercase>_<util.random.int[100000].to[999999]>;display_name=<&f><[item].display>]>"
        on player breaks block with:*_hammer:
            - define item_id <context.item.nbt[flag_id]>
            - flag player <[item_id]>:+:2
            - if <player.flag[<[item_id]>]> >= <context.item.max_durability>:
                - flag player <[item_id]>:!
        on player crafts *_pickaxe:
            - inject mc_result
        on player crafts *_axe:
            - inject mc_result
        on player crafts *_shovel:
            - inject mc_result
        on player crafts *_hoe:
            - inject mc_result
        on player crafts *_sword:
            - inject mc_result
        on player crafts *_boots:
            - inject mc_result
        on player crafts *_leggings:
            - inject mc_result
        on player crafts *_chesplate:
            - inject mc_result
        on player crafts *_helmet:
            - inject mc_result
        on player right clicks crafting_table with:mc_*_hammer:
            - determine passively cancelled
            - ratelimit player 1t
            - if !<player.has_flag[mc_forge_hits]>:
                - flag player mc_forge_hits:0
            - if <server.has_flag[<context.location>]>:
                - define config <script[master_crafter_config]>
                - define list <server.flag[<context.location>].as_list>
                - define map <[list].first>
                - define item <[map].get[item]>
                - define announce_type <tern[<[item].unbreakable>].pass[unbreakable].fail[crafted]>
                - define name_list <[item].material.name.split[_]>
                - define material <proc[first_letter_uppercase].context[<[name_list].first>]>
                - define tool <proc[first_letter_uppercase].context[<[name_list].last>]>
                - define context_list <list[<player.name>|<[material]>|<[tool]>]>
                - playsound <player> sound:BLOCK_ANVIL_LAND pitch:<proc[random_pitch]>
                - flag player mc_forge_hits:++
                - define hammer_mat <context.item.scriptname.split[_].get[2].to_lowercase>
                - define adjust <script[mc_durability_key].data_key[<[hammer_mat]>]>
                - define item_id <context.item.nbt[flag_id]>
                - flag player <[item_id]>:+:<tern[<player.has_flag[<[item_id]>]>].pass[<[adjust]>].fail[1]>
                - if <player.flag[<[item_id]>]> >= <context.item.max_durability>:
                    - take iteminhand
                    - playsound <player> sound:ENTITY_ITEM_BREAK
                    - flag player <[item_id]>:!
                - else:
                    - inventory adjust durability:<player.flag[<[item_id]>].round_down> slot:<player.held_item_slot>
                - if <[config].data_key[<[material]>].get[forge_hits]> <= <player.flag[mc_forge_hits]>:
                    - drop <[item]> <context.location.center.up> save:dropped_tool
                    - if <[map].get[gained_mastery]>:
                        - if <[config].data_key[announcements].get[mastery].get[is_announced]>:
                            - announce <proc[mc_mastery_formatter].context[<[context_list]>]>
                        - toast "<[material]> <[tool]> Mastery" icon:<[item]> frame:challenge
                    - if <[map].get[is_master]> && <[config].data_key[announcements].get[<[announce_type]>].get[is_announced]>:
                        - announce <proc[mc_<[announce_type]>_formatter].context[<[context_list].include[<[item].display>]>]>
                    - define new_list <[list].remove[first]>
                    - flag server <context.location>:<tern[<[new_list].is_empty>].pass[!].fail[!|:<[new_list]>]>
                    - flag player mc_forge_hits:0

mc_command:
    type: command
    name: set_level
    description: Sets your master crafter level for a specified tool.
    usage: /set_level <&lt>item_name<&gt> <&lt>level<&gt>
    script:
        - if <player.is_op>:
            - if <context.args.size> == 2 || <context.args.size> == 3:
                - define double <context.args.size.is[==].to[2]>
                - define player <tern[<[double]>].pass[<player.name>].fail[<context.args.first>]>
                - define item <tern[<[double]>].pass[<context.args.first>].fail[<context.args.get[2]>]>
                - define level <context.args.last>
                - if <[level].is_integer>:
                    - if <[level]> >= 0:
                        - if <script[mc_tool_map].data_key[map].keys.contains[<[item]>]||false>:
                            - if <server.player_is_valid[<[player]>]>:
                                - define player_obj <server.match_player[<[player]>]>
                                - flag <[player_obj]> <[item]>:<[level]>
                                - if <[level]> < 100:
                                    - flag <[player_obj]> master_crafter:<tern[<[player_obj].has_flag[master_crafter]>].pass[<[player_obj].flag[master_crafter].as_map.with[<[item]>].as[true]>].fail[<script[mc_tool_map].data_key[map]>]>
                                - narrate "Set <[player]>'s <[item]> level to <[level]>."
                            - else:
                                - narrate "<red>Unable to set level for player '<[player]>'."
                        - else:
                            - narrate "<red>Unable to set level for '<[item]>'."
                    - else:
                        - narrate "<red>Unable to set level to negative value."
                - else:
                    - narrate "<red>Unable to set level to '<[level]>'."
            - else if <context.args.size> > 3:
                - narrate "<red>Too many arguments! Did you add a space somehere?"
            - else:
                - narrate "<red>Incomplete command; set_level requires an item name and a level argument:"
                - narrate "<gray>/set_level <context.raw_args><red> <italic><--[HERE]"
        - else:
            - narrate "<red>You do not have permission to execute this command!"

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
        custom_model_data: <script[master_crafter_config].data_key[custom_model_data_offset].add[1]>
        nbt: flag_id/wooden_000001
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
        custom_model_data: <script[master_crafter_config].data_key[custom_model_data_offset].add[2]>
        nbt: flag_id/stone_000001
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
        custom_model_data: <script[master_crafter_config].data_key[custom_model_data_offset].add[3]>
        nbt: flag_id/iron_000001
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
        custom_model_data: <script[master_crafter_config].data_key[custom_model_data_offset].add[4]>
        nbt: flag_id/golden_000001
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
        custom_model_data: <script[master_crafter_config].data_key[custom_model_data_offset].add[5]>
        nbt: flag_id/diamond_000001
    recipes:
        1:
            type: shaped
            input:
                - diamond|diamond|diamond
                - diamond|stick|diamond
                - air|stick|air