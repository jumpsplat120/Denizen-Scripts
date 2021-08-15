##IgnoreWarning command_script_usage
##IgnoreWarning tag_trace_failure
##IgnoreWarning bad_tag_part

#Angry about me using procs for usage, because it doesn't start with a forward slash
#tag trace and tag part errors are about the enchantment stuff, which was tweaked
#recently. All the errors are erroneous.

# | [value] == REQUIRED
# | (value) == OPTIONAL
# | {value} == DEFAULT
# | <value> == NON-LITERAL
# |  value  == LITERAL

# Simple permission system. Used internally with all utilities commands.
simple_permissions:
    type: command
    name: perm
    debug: false
    description: Gives a player a permission, using Denizen's flag system.<&nl><&nl>Not a true permission system. If the player argument is not filled, then command defaults to player running the command. By default, command will only run if you have OP level permissions or higher.<&nl>If the first argument is marked as "view", the command will instead display all of the player's current permissions. If the first is marked as "clear", the command will instead remove all of the specified player's permissions after the specified node.<&nl>Uses a node system. A * node counts as a wildcard for everything below that node. In otherwords, if you have perm1.*, you have permissions for everything underneath perm1. Giving a permission of a higher level, which is to say, perm1 over perm1.subperm1, will overwrite all lower level permissions. In other words, if a perm1 was given, then removed, the player would no longer have any perm1 permissions, including perm1.subperm1.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.simple_permissions]>
    allowed help:
        - determine <player.is_op.if_null[true]>
    script:
        - if <player.is_op.if_null[true]>:
            - if <context.args.size> >= 1:
                - if <context.args.size> <= 3:
                    - define arg_map <context.args.to_map[<&co>].if_null[<map>]>
                    - define action <[arg_map].get[action].if_null[set].to_lowercase>
                    - define node <[arg_map].get[node].if_null[null]>
                    - define name <[arg_map].get[name].if_null[<player.name.if_null[server_or_command_block]>]>
                    - if <[arg_map].exclude[action|node|name].size> == 0:
                        - if <[arg_map].size> != 0 || <context.args.size> == 0:
                            - if <[name]> != server_or_command_block:
                                - define player <[name].proc[lib_exact_match_offline_player]>
                                - if <[player].object_type> == Player:
                                    - define perm_map <[player].flag[jlib.permissions].if_null[<map>]>
                                    - choose <[action]>:
                                        - case set:
                                            - if <[node]> != null:
                                                - flag <[player]> jlib.permissions:<[perm_map].deep_with[<[node]>].as[true]>
                                                - narrate "<yellow>Player <white><[player].name><yellow> has gained the permission <gray><[node]>."
                                            - else:
                                                - define err "<script[lib_config].parsed_key[color.error]>Unable to set permission, because no node was ever specified!"
                                        - case view:
                                            - define clean_yaml "<[perm_map].to_yaml.replace_text[:].replace_text[ 'true'].replace_text['*'].with[*].split[<&nl>]>"
                                            - define color_list <[clean_yaml].parse[trim_to_character_set[<&sp>].length.div[2].add[1]].highest.proc[lib_rainbow_list]>
                                            - foreach <[clean_yaml]>:
                                                - define level <[value].trim_to_character_set[<&sp>].length.div[2].add[1]>
                                                - define "result:->:<&nl><[color_list].get[<[level]>]><[level].is[==].to[1].if_true[-].if_false[<element[<bold>╰].pad_left[<[level].add[2]>]>]> <white><[value].replace[ ]>"
                                            - narrate "<gold>----- <white><[player].name><yellow>'s Permissions <gold>-----<[result].unseparated>"
                                        - case clear:
                                            - flag <[player]> jlib.permissions:!
                                            - narrate "<yellow>Player <white><[player].name><yellow> has had all of their permissions cleared."
                                        - default:
                                            - narrate <proc[lib_core_command_error].context[invalid_value|remove_flags|action|<[action]>]>
                                    - if <[err].exists>:
                                        - narrate <[err]>
                                - else:
                                    - narrate <proc[lib_core_command_error].context[invalid_player|remove_flags|<[name]>]>
                            - else:
                                - narrate <proc[lib_core_command_error].context[implicit]>
                        - else:
                             - narrate <proc[lib_core_command_error].context[missing_keys|simple_permissions|<context.args.proc[lib_core_command_extra_keys]>]>
                    - else:
                         - narrate <proc[lib_core_command_error].context[extra_keys|simple_permissions|<[arg_map].keys.proc[lib_core_command_extra_keys]>]>
                - else:
                     - narrate <proc[lib_core_command_error].context[max_args|simple_permissions|3|<context.args.size>]>
            - else:
                 - narrate <proc[lib_core_command_error].context[min_args|simple_permissions|1|<context.args.size>]>
        - else:
             - narrate <proc[lib_core_command_error].context[permission]>

# Panic command for users.
panic_button:
    type: command
    name: panic
    debug: false
    description: Panic button for the player.<&nl><&nl>Kills all mobs (excluding those on the exclude list) in all loaded chunks in the world the player is in, sets the time to day, heals the player, clears the weather, and feeds the player.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.panic]>
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.panic|<player.if_null[null]>].if_null[true]>
    aliases:
        - a
        - aa
        - aaa
    script:
        - if <proc[lib_has_permission].context[utilities.panic|<player.if_null[server_or_command_block]>].if_null[true]>:
            - if <player.exists>:
                - if <context.args.size> == 0:
                    - define exclude <script[lib_config].data_key[exclude.mobs]>
                    - foreach <player.world.loaded_chunks> as:chunk:
                        - remove <[chunk].entities.filter_tag[<[exclude].contains[<[filter_value].entity_type.to_lowercase>].not>]>
                    - time 0t
                    - heal 20
                    - weather sunny
                    - feed amount:20
                - else:
                    - narrate <proc[lib_core_command_error].context[wrong_args|panic|0|<context.args.size>]>
            - else:
                - narrate <proc[lib_core_command_error].context[implicit]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>

# Removes all flags, excluding flags listed in config, dependent on passed argument. If no value is passed, defaults to player who ran the command.
remove_flags:
    type: command
    name: remove_flags
    debug: false
    description: Removes all flags (excluding those on the exclude list) from the server or player or both.<&nl><&nl>If no player name is specified, then it uses the player who ran the command. If the command is run on the server, and you're removing flags from a player, then the player's name is required.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.remove_flags]>
    aliases:
        - removeflags
        - killflags
        - kill_flags
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.flags|<player.if_null[null]>].if_null[true]>
    script:
        #if has permission or is server or command_block
        - if <proc[lib_has_permission].context[utilities.flags|<player.if_null[null]>].if_null[true]>:
            - if <context.args.size> <= 2:
                - define arg_map <context.args.to_map[<&co>].if_null[<map>]>
                - define action  <[arg_map].get[action].if_null[player].to_lowercase>
                - define name    <[arg_map].get[name].if_null[<player.name.if_null[server_or_command_block]>]>
                - if <[arg_map].exclude[action|name].size> == 0:
                    - if <[arg_map].size> != 0 || <context.args.size> == 0:
                        - if <[name]> != server_or_command_block:
                            - define player <[name].proc[lib_exact_match_offline_player]>
                            - if <[player].object_type> == Player:
                                - define exclude_flags <script[lib_config].data_key[exclude.flags]>
                                - define colors        <script[lib_config].parsed_key[color]>
                                - define notice <[colors].get[hard_server_notice]>
                                - define warn   <[colors].get[warning]>
                                - define item   <[colors].get[soft_server_notice]>
                                - define main   <[colors].get[important]>
                                - choose <[action]>:
                                    - case all:
                                        - inject remove_flags path:remove_server
                                        - inject remove_flags path:remove_player
                                        - if !<[flag_burned].exists>:
                                            - narrate "<[warn]>No flags to remove for <[notice]>'<[item]><[name]><[notice]>'<[warn]>, or from the <[item]>server<[warn]>."
                                    - case player:
                                        - inject remove_flags path:remove_player
                                        - if !<[flag_burned].exists>:
                                            - narrate "<[warn]>No flags to remove for <[notice]>'<[item]><[name]><[notice]>'<[warn]>."
                                    - case server:
                                        - inject remove_flags path:remove_server
                                        - if !<[flag_burned].exists>:
                                            - narrate "<[warn]>No flags to remove from the <[item]>server<[warn]>."
                                    - default:
                                        - narrate <proc[lib_core_command_error].context[invalid_value|remove_flags|action|<[action]>]>
                            - else:
                                - narrate <proc[lib_core_command_error].context[invalid_player|remove_flags|<[name]>]>
                        - else:
                            - narrate <proc[lib_core_command_error].context[implicit]>
                    - else:
                        - narrate <proc[lib_core_command_error].context[missing_keys|remove_flags|<context.args.proc[lib_core_command_extra_keys]>]>
                - else:
                    - narrate <proc[lib_core_command_error].context[extra_keys|remove_flags|<[arg_map].keys.proc[lib_core_command_extra_keys]>]>
            - else:
                - narrate <proc[lib_core_command_error].context[max_args|remove_flags|1|<context.args.size>]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>
    remove_flags:
        - if <[flags].size> > 0:
            - define flag_burned true
            - foreach <[flags]>:
                - narrate "<[notice]>Removed <[main]><[from]><[notice]> flag: <[item]><[value]>"
                - flag <[obj]> <[value]>:!
    remove_server:
        - define flags <server.list_flags.exclude[<[exclude_flags]>]>
        - define obj server
        - define from server
        - inject remove_flags path:remove_flags
    remove_player:
        - define flags <[player].list_flags.exclude[<[exclude_flags]>]>
        - define obj <[player]>
        - define from <[player].name>
        - inject remove_flags path:remove_flags

# Removes all notables dependent on passed argument. If no value is passed, defaults to all notables.
remove_notables:
    type: command
    name: remove_notables
    debug: false
    description: Removes all notables of whatever type was passed, or all notables if no argument passed.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.remove_notables]>
    aliases:
        - removenotables
        - killnotables
        - kill_notables
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.notables|<player.if_null[null]>].if_null[true]>
    script:
        - if <proc[lib_has_permission].context[utilities.notables|<player.if_null[null]>].if_null[true]>:
            - if <context.args.size> == 1:
                - define arg_map <context.args.to_map[<&co>].if_null[<map>]>
                - define type <[arg_map].get[type].if_null[all].to_lowercase>
                - if <[arg_map].exclude[type].size> == 0:
                    - if <[arg_map].size> != 0 || <context.args.size> == 0:
                        - if <list[cuboid|ellipsoid|inventory|location|polygon|all].contains[<[action]>]>:
                            - define colors <script[lib_config].parsed_key[color]>
                            - define warn <[colors].get[warning]>
                            - define soft <[colors].get[soft_server_notice]>
                            - define search location
                            - inject locally remove
                            - define search cuboid
                            - inject locally remove
                            - define search ellipsoid
                            - inject locally remove
                            - define search inventory
                            - inject locally remove
                            - define search polygon
                            - inject locally remove
                            - if <[note_burned].exists.not>:
                                - narrate "<[warn]>No notables to remove<[type].equals[all].if_true[].if_false[ from <gray><[type]>]><yellow>."
                        - else:
                            - narrate <proc[lib_core_command_error].context[invalid_value|remove_notables|action|<[action]>]>
                    - else:
                        - narrate <proc[lib_core_command_error].context[missing_keys|remove_notables|<context.args.proc[lib_core_command_extra_keys]>]>
                - else:
                    - narrate <proc[lib_core_command_error].context[extra_keys|remove_notables|<[arg_map].keys.proc[lib_core_command_extra_keys]>]>
            - else:
                - narrate <proc[lib_core_command_error].context[wrong_args|remove_notables|0|<context.args.size>]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>
    remove:
        - if <list[<[search]>|<[search]>s|all].contains[<[type]>]>:
            - define notables <server.notes[<[search]>s]>
            - if <[notables].size> > 0:
                - define note_burned true
                - foreach <[notables]>:
                    - narrate "<[warn]>Removed noted <[soft]><[search]><[warn]>: <white><[value].note_name>"
                    - note remove as:<[value].note_name>

# Tool for randomly placing blocks
random_placement:
    type: command
    name: random_placer
    debug: false
    description: Gives tool for placing blocks randomly, based on a predefined list, or defines list.<&nl>If running the command with no arguments, recieve the random placement tool. It should look like a bedrock block by default, or if you have the utilities texture pack installed, will be an animated block. When the block is placed, it will choose one of the blocks previously defined with the random_placer command, based on weight. The higher the weight, the more chance the block will be placed. If no blocks have been defined, will recieve an error message.<&nl>If you'd like to add a block to the list, simply type the command, along with the name of the block that you would use if you were using the give command (i.e., redstone_ore instead of Redstone Ore), as well as the weight you'd like for that block. Weights can be any number above 1. If you don't provide a weight, block will be added with a weight of 1. If you'd like to create a new list, you can clear your previous list by simply passing "clear" as the first argument.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.random_placement]>
    aliases:
        - rand_placer
        - rplace
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.random_placement|<player.if_null[null]>].if_null[true]>
    script:
        - if <proc[lib_has_permission].context[utilities.random_placement|<player.if_null[null]>].if_null[true]>:
            - if <player.exists>:
                - if <context.args.size> == 0:
                    - give <proc[lib_unstackable].context[lib_random_placer_item]>
                    - if <player.has_flag[jlib.random_placer].not>:
                        - flag player jlib.random_placer:<map>
                - else if <context.args.size> <= 3:
                    - define arg_map <context.args.to_map[<&co>].if_null[<map>]>
                    - define action  <[arg_map].get[action].if_null[set].to_lowercase>
                    - define block   <[arg_map].get[block].if_null[null]>
                    - define weight  <[arg_map].get[weight].if_null[1]>
                    - define colors  <script[lib_config].parsed_key[color]>
                    - if <[arg_map].exclude[action|block|weight].size> == 0:
                        - if <[arg_map].size> != 0 || <context.args.size> == 0:
                            - choose <[action]>:
                                - case clear:
                                    - flag player jlib.random_placer:<map>
                                    - narrate "<[colors].get[warning]>List cleared."
                                - case set:
                                    - if <[block].as_material.exists>:
                                        # numbers like this (.4) don't parse as decimal, so we add a 0 in front first
                                        # so they can pass.
                                        - if <[weight].starts_with[.]>:
                                            - define weight 0<[weight]>
                                        - if <[weight].is_decimal>:
                                            - if <[weight]> > 0:
                                                - flag player jlib.random_placer:<player.flag[jlib.random_placer].with[<[block]>].as[<[weight]>]>
                                                - narrate "<[colors].get[soft_server_notice]>Added <[colors].get[important]><[block]><[colors].get[soft_server_notice]> with a weight of <[colors].get[important]><[weight]><[colors].get[soft_server_notice]>."
                                            - else:
                                                - narrate "<[colors].get[error]>A weight of <[colors].get[soft_server_notice]><[weight]> <[colors].get[error]>is less than zero, and therefore is the same as not putting it into the list at all."
                                        - else:
                                            - narrate "<[colors].get[soft_server_notice]><[weight]> <[colors].get[error]>isn't a valid decimal number!"
                                    - else:
                                        - narrate "<[colors].get[soft_server_notice]><[block]> <[colors].get[error]>isn't a valid minecraft material!"
                                - default:
                                    - narrate <proc[lib_core_command_error].context[invalid_value|random_placement|action|<[action]>]>
                        - else:
                            - narrate <proc[lib_core_command_error].context[missing_keys|random_placement|<context.args.proc[lib_core_command_extra_keys]>]>
                    - else:
                        - narrate <proc[lib_core_command_error].context[extra_keys|random_placement|<[arg_map].keys.proc[lib_core_command_extra_keys]>]>
                - else:
                    - narrate <proc[lib_core_command_error].context[max_args|random_placement|1|<context.args.size>]>
            - else:
                - narrate <proc[lib_core_command_error].context[implicit]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>

# Gives you a tool that allows you to note locations, cuboids, and ellipsoids with a visual effect for extra clarity.
notable_tool:
    type: command
    name: notable_tool
    debug: false
    description: Gives a tool that allows you to specify locations, cuboids and ellipsoids, and save (note) them.<&nl>To recieve the tool, simply pass the command with no arguments. To change between selection type, shift right click. NOTE! If you change selection type, you will LOSE the previous selection.<&nl>For locations, you only need to right click on the single block to set the location. For cuboids, the first right click will set one corner, and every click after will set the other corner. If you need to change the location of the first corner, pass the "clear" argument to the command.<&nl>Ellipsoids are a little more complicated. The first right click will set the center of the ellipsoid. The second, third and fourth clicks will set the X, Y, and Z radii. If you click for a fifth time, you will set the X radius again, the sixth click will set the Y a radius, and so on. If you need to recenter the ellipsoid, pass the "clear" argument.<&nl>Once you've decided you have the right selection, pass the save argument, along with the name of the notable. Make sure there are no spaces in the notable's name or the command will fail.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.notable_tool]>
    aliases:
        - ntool
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.notable_tool|<player.if_null[null]>].if_null[true]>
    script:
        - if <proc[lib_has_permission].context[utilities.notable_tool|<player.if_null[null]>].if_null[true]>:
            - if <player.exists>:
                - if <context.args.size> == 0:
                    - give <proc[lib_unstackable].context[lib_notable_tool_item]>
                    - define type location
                    - inject locally actionbar
                - else if <context.args.size> <= 2:
                    - define arg_map <context.args.to_map[<&co>].if_null[<map>]>
                    - define action  <[arg_map].get[action].if_null[save].to_lowercase>
                    - define name    <[arg_map].get[save].if_null[null].to_lowercase>
                    - if <[arg_map].exclude[action|save].size> == 0:
                        - if <[arg_map].size> != 0 || <context.args.size> == 0:
                            - define colors <script[lib_config].parsed_key[color]>
                            - define soft <[colors].get[soft_server_notice]>
                            - define err  <[colors].get[error]>
                            - choose <[action]>:
                                - case save:
                                    - define map  <player.flag[jlib.notable]>
                                    - define type <[map].get[type]>
                                    - define data <[map].get[data].if_null[null]>
                                    - define size <[data].size.if_null[0]>
                                    - define success "<[soft]><[type]> <[colors].get[important]><[name]> <[colors].get[success]>was saved."
                                    - if <[map].get[valid].exists>:
                                        - narrate <[success]>
                                        - note <[map].get[valid]> as:<[name]>
                                    - else:
                                        - if <[data].size> > 0:
                                            # no location case since if location was set, it's valid.
                                            - narrate "<[type].equals[cuboid].if_true[<[soft]>Cuboid <[err]>is missing <[soft]><element[2].sub[<[size]>]><[err]> location<[size].equals[1].if_true[].if_false[s]>!].if_false[<[err]>Missing <[soft]><[size].equals[1].if_true[center].if_false[<[size].equals[2].if_true[x-radius].if_false[<[size].equals[3].if_true[y-radius].if_false[z-radius]>]>]><[err]> for <[soft]>ellipsoid<[err]>.]>"
                                        - else:
                                            - narrate "<[err]>No <[soft]><[type]> <[err]>has been set!"
                                - case clear:
                                    - define type <player.flag[jlib.notable.type]>
                                    - narrate "<[soft]><[type].to_titlecase><[colors].get[warning]> selection cleared."
                                    - flag player jlib.notable:<map.with[type].as[<[type]>].with[data].as[<list>]>
                                - default:
                                    - narrate <proc[lib_core_command_error].context[invalid_value|random_placement|action|<[action]>]>
                        - else:
                            - narrate <proc[lib_core_command_error].context[missing_keys|notable_tool|<context.args.proc[lib_core_command_extra_keys]>]>
                    - else:
                        - narrate <proc[lib_core_command_error].context[extra_keys|notable_tool|<[arg_map].keys.proc[lib_core_command_extra_keys]>]>
                - else:
                    - narrate <proc[lib_core_command_error].context[min_args|notable_tool|1|<context.args.size>]>
            - else:
                - narrate <proc[lib_core_command_error].context[implicit]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>
    actionbar:
        - flag player jlib.notable.type:<[type]>
        - wait 1t
        - flag player jlib.notable.actionbar
        - foreach <proc[lib_animated_rainbow_text].context[<[type].to_uppercase>|<proc[lib_random_color_tag].with_saturation[255].with_brightness[255]>|10|5|100]>:
            - if <player.has_flag[jlib.notable.actionbar]>:
                - wait 1t
                - actionbar "Current selection type: <[value]>"
            - else:
                - foreach stop
        - flag player jlib.notable.actionbar:!

#Allows you to simulate taking control of an NPC
puppet_npc:
    type: command
    name: puppet
    debug: false
    description: Allows you to "puppet" an NPC.<&nl>Run the command with an NPC's name to puppet that NPC on the map specifically, or run it with no name to puppet the closest NPC within 5 blocks. If there are multiple NPC's with the same name, it will puppet the one with the name that is closest to you.<&nl>Run the command a second time to stop puppeting the NPC. Players will be set to survival when beginning the puppet, then set to spectator when cancelling the puppet.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.puppet]>
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.puppet|<player.if_null[null]>].if_null[true]>
    script:
        - if <proc[lib_has_permission].context[utilities.random_placement|<player.if_null[null]>].if_null[true]>:
            - if <player.exists>:
                - else if <context.args.size> <= 1:
                    - define arg_map <context.args.to_map[<&co>].if_null[<map>]>
                    - define name    <[arg_map].get[npc].if_null[closest].to_lowercase>
                    - if <[arg_map].exclude[npc].size> == 0:
                        - if <[arg_map].size> != 0 || <context.args.size> == 0:
                            - define colors <script[lib_config].parsed_key[color]>
                            - define npc <context.args.size.equals[1].if_true[<player.location.find.npcs.within[5].first.if_null[null]>].if_false[<proc[lib_find_nearest_npc_by_name].context[<[name]>|<player.location>]>].if_null[null]>
                            - if <[npc]> != null:
                                - if <player.has_flag[jlib.puppet]>:
                                    - spawn <player.flag[jlib.puppet.npc]> <player.location>
                                    - heal
                                    - adjust <player> gamemode:spectator
                                    - adjust <player> display_name:<player.flag[jlib.puppet.name]>
                                    - adjust <player> skin_blob:<player.flag[jlib.puppet.skin]>
                                    - flag player jlib.puppet:!
                                - else:
                                    - flag player jlib.puppet:<map.with[name].as[<player.name>].with[skin].as[<player.skin_blob>].with[npc].as[<[npc]>]>
                                    - teleport <player> <[npc].location>
                                    - adjust <player> display_name:<[npc].nickname>
                                    - adjust <player> health:<[npc].health>
                                    - adjust <player> skin_blob:<[npc].skin_blob>
                                    - adjust <player> gamemode:survival
                                    - despawn <[npc]>
                            - else:
                                - narrate "<[name].equals[closest].if_true[<[colors].get[error]>Unable to find an npc within 5 blocks of you!].if_false[<[colors].get[soft]><[name]> <[colors].get[error]>is not a valid npc name!]>"
                        - else:
                            - narrate <proc[lib_core_command_error].context[missing_keys|puppet|<context.args.proc[lib_core_command_extra_keys]>]>
                    - else:
                        - narrate <proc[lib_core_command_error].context[extra_keys|puppet|<[arg_map].keys.proc[lib_core_command_extra_keys]>]>
                - else:
                    - narrate <proc[lib_core_command_error].context[max_args|puppet|1|<context.args.size>]>
            - else:
                - narrate <proc[lib_core_command_error].context[implicit]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>

#Ends all currently running queues
end_queues:
    type: command
    name: end_queues
    debug: false
    description: Allows you to end all currently running queues on the server.<&nl>WARNING<&co> This is a nuclear option! This is only meant to be used in cases where you have infintely looping queues that you want to end without wanting to restart the whole server. Do not use this command within a script!
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.end_queues]>
    aliases:
        - killqueues
        - kill_queues
        - killqs
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.end_queues|<player.if_null[null]>].if_null[true]>
    script:
        - if <proc[lib_has_permission].context[utilities.end_queues|<player.if_null[server_or_command_block]>].if_null[true]>:
            - if <player.exists>:
                - if <context.args.size> == 0:
                    - define warn <script[lib_config].parsed_key[color.warning]>
                    - define soft <script[lib_config].parsed_key[color.soft_server_notice]>
                    - if <queue.list.size> > 1:
                        - foreach <queue.list.exclude[<queue>]> as:queue:
                            - narrate "<[warn]>Ending queue <[soft]><[queue].id>..."
                            - queue stop <[queue]>
                    - else:
                        - narrate "<[warn]>No currently running queues!"
                - else:
                    - narrate <proc[lib_core_command_error].context[wrong_args|end_queues|0|<context.args.size>]>
            - else:
                - narrate <proc[lib_core_command_error].context[implicit]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>
#Simpler enchanting command
denchant:
    type: command
    name: denchant
    debug: false
    description: A better enchantment command.<&nl>The denchant command will enchant your item with the enchantment specified, at the level you choose (or at level 1, if no level is specified.) Enchantments pull from properly registered enchantments, which are all vanilla enchantments, custom denizen enchantments, and enchantments from any plugin that registers correctly. Lore is also correctly added (or updated) on the item when required, and uses correct roman numeralization up to ~3000. The command will also let you know if the enchantment is out of range of vanilla, if the enchantment will function like expected on the item, or if the enchantment conflicts with an existing enchantment. The command will not halt if it encounters any of this, it just lets you know if you're trying to keep within vanilla enchantment bounds. The command also will not double enchant an item, and enchanting an item with a higher level or lower level enchant of the same enchant will raise/lower the enchant on the item appropriately. Lastly, when denchant is used on a regular book, it will create an enchantment book, rather than a regular book with an enchantment on it.
    usage: <proc[lib_command_usage].context[lib_generic_data|command.usage.denchant]>
    aliases:
        - dchant
    allowed help:
        - determine <proc[lib_has_permission].context[utilities.denchant|<player.if_null[null]>].if_null[false]>
    tab completions:
        1: <server.enchantment_keys>
        2: <proc[lib_numeric_list].context[<server.enchantment_start_level[<context.args.first>]>|<server.enchantment_max_level[<context.args.first>]>]>
    script:
        - if <proc[lib_has_permission].context[utilities.denchant|<player.if_null[server_or_command_block]>].if_null[true]>:
            - if <player.exists>:
                - if <context.args.size> <= 2:
                    - if <context.args.size> >= 1:
                        - define enchantment <enchantment[<context.args.first>].if_null[null]>
                        - if <[enchantment]> != null:
                            - define level <context.args.get[2].if_null[1]>
                            - define colors <script[lib_config].parsed_key[color]>
                            - define soft <[colors].get[soft_server_notice]>
                            - define hard <[colors].get[hard_server_notice]>
                            - define warn <[colors].get[warning]>
                            - define item <player.item_in_hand>
                            - define item_enchants <[item].enchantment_map.if_null[<map>]>
                            - define prev_enchant <[item_enchants].get[<[enchantment].name>].if_null[null]>
                            - if <[prev_enchant]> == null || <[prev_enchant]> != <[level]>:
                                - define item_enchants <[item_enchants].exclude[<[enchantment].name>]> if:<[prev_enchant].equals[null].not>
                                #books, which get turned into enchanted books, are always valid, regardless of what can_enchant says
                                - define always_valid true if:<[item].advanced_matches[*book]>
                                - if <[item].material.name> == book:
                                    - inventory adjust slot:<player.held_item_slot> material:enchanted_book
                                - inventory adjust slot:<player.held_item_slot> enchantments:<[item_enchants].with[<[enchantment]>].as[<[level]>]>
                                - inventory adjust slot:<player.held_item_slot> lore:<[item].lore.if_null[<list>].include[<gray><[enchantment].full_name[<[level]>]>]> if:<[enchantment].key.before[:].equals[minecraft].not>
                                - narrate "<[colors].get[success]>You successfully enchanted a <[soft]><[item].material.translated_name><[colors].get[success]> with <[colors].get[important]><[enchantment].full_name[<[level]>]>"
                                - foreach <[item_enchants]>:
                                    - define ench <enchantment[<[key]>]>
                                    - define conflicts:->:<[ench].full_name> if:<[enchantment].is_compatible[<[ench]>].not>
                                - foreach <[conflicts].if_null[<list>]>:
                                    - define conflict_str "<[conflict_str].if_null[]><[loop_index].equals[1].if_true[].if_false[<[loop_index].equals[<[conflicts].size>].if_true[ and ].if_false[, ]>]><[value]>"
                                - narrate "<[warn]>The level you enchanted at is outside the range normally obtainable in vanilla." if:<[enchantment].min_level.is_more_than[<[level]>].or[<[level].is_more_than[<[enchantment].max_level>]>]>
                                - narrate "<[warn]>This enchantment does not work on this item." if:<[enchantment].can_enchant[<[item]>].not.and[<[always_valid].exists.not>]>
                                - narrate "<[warn]>This enchantment conflicts with <[soft]><[conflict_str]><[warn]>." if:<[conflicts].exists>
                            - else:
                                - narrate "<[colors].get[error]>Unable to enchant as the item already has this enchantment on it."
                        - else:
                            - narrate <proc[lib_core_command_error].context[invalid_value|denchant|enchantment|<[enchantment]>]>
                    - else:
                        - narrate <proc[lib_core_command_error].context[missing_keys|denchant|<context.args.proc[lib_core_command_extra_keys]>]>
                - else:
                    - narrate <proc[lib_core_command_error].context[extra_keys|denchant|<context.args.proc[lib_core_command_extra_keys]>]>
            - else:
                - narrate <proc[lib_core_command_error].context[implicit]>
        - else:
            - narrate <proc[lib_core_command_error].context[permission]>