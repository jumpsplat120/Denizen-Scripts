lib_events:
    type: world
    debug: true
    events:
        #can't do anything to fix custom enchant names not showing up in enchanting table
        #on player prepares item enchant:
        #fix for enchantment lore missing
        on item enchanted:
            - define new_item <context.item>
            - foreach <context.enchants>:
                - define ench <enchantment[<[key]>]>
                - adjust def:new_item lore:<[new_item].lore.if_null[<list>].include[<gray><[ench].full_name[<[value]>]>]> if:<[ench].key.before[:].equals[minecraft].not>
            - determine RESULT:<[new_item]>
        on player prepares anvil craft item:
            - define inv <context.inventory.list_contents>
            - define item <[inv].get[1].if_null[<item[air]>]>
            - define book <[inv].get[2].if_null[<item[air]>]>
            - if <[book].material.name> == enchanted_book:
                - define book_ench_map <[book].enchantment_map>
                - define ench <enchantment[<[book_ench_map].keys.first>]>
                #no need to handle vanilla enchants
                - if <[ench].key.before[:]> != minecraft:
                    - define book_level <[book_ench_map].values.first>
                    - define item_level <[item].enchantment_map.if_null[<map>].get[<[ench].name>].if_null[-1]>
                    - define item_lore <[item].lore.if_null[<list>]>
                    - determine <context.item.with[lore=<[item_level].is_more_than[<[book_level]>].or[<[item_level].add[1].is_more_than[<[ench].max_level>]>].if_true[<[item_lore]>].if_false[<[item_level].equals[-1].if_true[<[item_lore].include[<gray><[ench].full_name[<[book_level]>]>]>].if_false[<[item_lore].set[<gray><[ench].full_name[<[book_level].add[<[item_level].is_less_than[<[book_level]>].if_true[0].if_false[1]>]>]>].at[<[item_lore].find_partial[<[ench].full_name[<[item_level]>]>]>]>]>]>]>
        on player right clicks block with:lib_random_placer_item:
            - ratelimit <player> 0.5t
            - if <proc[lib_has_permission].context[utilities.random_placement|<player>]>:
                - define material <proc[lib_random_by_weight].context[<player.flag[jlib.random_placer].if_null[false]>].if_null[null]>
                - if <[material]> != null:
                    - define facing <proc[lib_block_facing]>
                    - define location <context.location.relative[<[facing]>]>
                    - run lib_simulate_block_placing def:<[location]>|<[material]>
                    - modifyblock <[location]> <[material]>
                    - if <[location].block_facing.exists>:
                        - adjust <[location]> block_facing:<[facing].x.abs>,<[facing].y.abs>,<[facing].z.abs>
                - else:
                    - narrate "<script[lib_config].parsed_key[color.warning]>List is empty."
            - else:
                - narrate "<script[lib_config].parsed_key[color.error]>You do not have permission to use the Random Placer Tool."
        on player right clicks block with:lib_notable_tool_item:
            - ratelimit <player> 1t
            - define map <player.flag[jlib.notable]>
            - if <player.is_sneaking>:
                #change selection type
                - define valid_types <list[location|cuboid|ellipsoid]>
                - define type <[valid_types].get[<proc[lib_cycle_value].context[<[valid_types].find[<[map].get[type]>].add[1]>|1|3]>]>
                - flag player jlib.notable:<map.with[type].as[<[type]>]>
                - inject notable_tool.actionbar
            - else:
                #handle selection
                - define location <context.location.if_null[<player.eye_location.forward[5].round_down>]>
                - define colors <script[lib_config].parsed_key[color]>
                - define soft <[colors].get[soft_server_notice]>
                - define hard <[colors].get[hard_server_notice]>
                - define important <[colors].get[important]>
                #data is data before it becomes valid
                #valid only exists when obj is fully formed
                - choose <[map].get[type]>:
                    - case location:
                        - define valid <[location]>
                        - define msg "<[soft]>Location<[hard]> ( <[soft]>x: <[important]><[location].x> <[soft]>y: <[important]><[location].y> <[soft]>z: <[important]><[location].z><[hard]> )"
                    - case cuboid:
                        - if <[map].get[data].exists>:
                            - define data <[map].get[data].as_location>
                            - define valid <[data].to_cuboid[<[location]>].if_null[null]>
                            - if <[valid]> == null:
                                - narrate "<[err]>Unable to create a cuboid with locations in two different dimenisions!"
                        - else:
                            - define data <[location]>
                        - define msg "<[soft]>Cuboid<[hard]> ( <[important]><[data].x><[soft]>; <[important]><[data].y><[soft]>; <[important]><[data].z> <[soft]>↔ <[important]><[map].get[data].exists.if_true[<[location].x><[soft]>; <[important]><[location].y><[soft]>; <[important]><[location].z>].if_false[?]><[hard]> )"
                    - case ellipsoid:
                        # data = [ index (3 - 5), location, xrad, yrad, zrad]
                        - define data <[map].get[data].if_null[<list>]>
                        - if <[data].size> == 0:
                            - define data <list[2|<[location]>]>
                        - else:
                            - define index <proc[lib_cycle_value].context[3|5|<[data].get[1].add[1]>]>
                            - define e_loc <[data].get[2].sub[<[location]>]>
                            - define radius <list[<[e_loc].x>|<[e_loc].y>|<[e_loc].z>].get[<[index].sub[2]>].abs>
                            - if <[data].size> <= 4:
                                - define data <[data].include[<[radius]>].set[<[index]>].at[1]>
                            - else:
                                - define data <[data].set[<[radius]>].at[<[index]>].set[<[index]>].at[1]>
                            - if <[data].size> == 5:
                                - define valid <[data].get[2].as_location.to_ellipsoid[<[data].get[3]>,<[data].get[4]>,<[data].get[5]>]>
                        - define msg "<[soft]>Ellipsoid<[hard]> ( <[soft]>center: <[important]><[data].get[2].x><[soft]>; <[important]><[data].get[2].y><[soft]>; <[important]><[data].get[2].z> <[soft]>radii: <[hard]><&lb> <[soft]>x: <[important]><[data].size.is_more_than[2].if_true[<[important]><[data].get[3]>].if_false[?]> <[soft]>y: <[important]><[data].size.is_more_than[3].if_true[<[important]><[data].get[4]>].if_false[?]> <[soft]>z: <[important]><[data].size.is_more_than[4].if_true[<[important]><[data].get[5]>].if_false[?]> <[hard]><&rb> <[hard]>)"
                - narrate <[msg]>
                - if <[data].exists>:
                    - flag player jlib.notable.data:<[data]>
                - if <[valid].exists>:
                    - flag player jlib.notable.valid:<[valid]>
                - if <[valid].exists>:
                    - inject locally display_particles
        after player scrolls their hotbar item:lib_notable_tool_item:
            - inject locally display_particles
        on player drops lib_*_item:
            - remove <context.entity>
        on player clicks lib_*_item in inventory:
            - take slot:<context.slot>
        on player drags lib_*_item in inventory:
            - take slot:<context.slot>
    display_particles:
        - define map <player.flag[jlib.notable]>
        - define type <[map].get[type]>
        - define valid <[map].get[valid]>
        - define particle_locations <proc[lib_<[type].equals[location].if_true[outline_location].if_false[<[type].equals[cuboid].if_true[outline_cuboid].if_false[shell_ellipsoid]>]>].context[<[valid]>]>
        - define counter 0
        - flag player jlib.notable.particles:true
        - while <player.item_in_hand.script.name.if_null[false]> == lib_notable_tool_item && <player.flag[jlib.notable.particles].if_null[false]>:
            - flag player jlib.notable.particles:false
            # This loop runs every tick, but only display particles every 5 ticks. This is so that we can
            # be checking every tick if displaying particles is still valid; ie the player still has
            # the tool and whatnot
            - define counter:++
            - if <[counter]> == 5:
                - playeffect effect:flame at:<[particle_locations]> offset:0 targets:<player>
                - define counter 0
            - define map <player.flag[jlib.notable]>
            - if <[map].get[valid].exists>:
                # If valid has changed during the loop, update the particle effects
                - if <[map].get[valid]> != <[valid]>:
                    - define valid <[map].get[valid]>
                    - define particle_locations <proc[lib_<[type].equals[location].if_true[outline_location].if_false[<[type].equals[cuboid].if_true[outline_cuboid].if_false[shell_ellipsoid]>]>].context[<[valid]>]>
            - else:
                - while stop
            - wait 1t
            - flag player jlib.notable.particles:true