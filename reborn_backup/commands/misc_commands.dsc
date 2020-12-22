upload_timer:
	type: command
	name: upload
	description: Starts a 1 minute timer, mainly for git pushes/pulls.
	usage: /upload
	debug: false
	script:
		- if <player.is_op>:
			- define chime <list[1.0|1.25875|1.415|1.6825|1.59125]>
			- narrate "Waiting..."
			- wait 1m
			- repeat 5:
				- playsound <player> sound:BLOCK_NOTE_BLOCK_CHIME pitch:<[chime].get[<[value]>]>
				- wait 2t
			- reload
			- narrate "Done!"

notif_nickname:
	type: command
	name: name
	description: Gives you a nickname which can others can use to refer to you as in chat. When a player uses this nickname, you'll be pinged. You can have as many nicknames as you'd like. Nicknames are not case sensitive. If you type a nickname without specifing add or remove, or the second argument is not recognized (e.g. spelled wrong), it will default to adding a new nickname. Once your nickname was added, you will get a success message, including if you try to remove a nickname you do not have, or add one you already have, since any potential issues will be gracefully handled.
	usage: <gray>/name <aqua><&lt><white>nickname<aqua><&gt> <white>remove<aqua><green>/<aqua><&lb><white>add<aqua><&rb>
	debug: false
	script:
		- define new_nick <context.args.get[1].to_lowercase||false>
		- if <[new_nick]> == false:
			- narrate "<red>You did not pass in a nickname to be added. Usage: <white>/<gray>name <aqua><&lt><white>nickname<aqua><&gt> <white>remove<aqua> <green>/ <aqua><&lb><white>add<aqua><&rb>"
		- else:
			- define remove <context.args.get[2].to_lowercase.is[==].to[remove]||false>
			- define master_nicknames <server.flag[all_chat_nicknames]||<list>>
			- define nicknames <player.flag[chat_nicknames]||<list>>
			- define master_nicknames <tern[<[remove]>].pass[<[master_nicknames].exclude[<[new_nick]>]>].fail[<[master_nicknames].include[<[new_nick]>]>].deduplicate>
			- define nicknames <tern[<[remove]>].pass[<[nicknames].exclude[<[new_nick]>]>].fail[<[nicknames].include[<[new_nick]>]>].deduplicate>
			- flag <player> chat_nicknames:!|:<[nicknames]>
			- flag server all_chat_nicknames:!|:<[master_nicknames]>
			- narrate "<yellow>You have successfully <gray><tern[<[remove]>].pass[removed].fail[added]> <yellow>the nickname <white><[new_nick]><yellow>."

activate_sel:
	type: command
	name: sel
	aliases:
		- selection
		- select
	description: Toggles on or off cuboid or location selection. Pass the type of selection (cuboid/location) you'd like toggled on/off. If you turn cuboid or location on, then pass the other selection type, it will toggle off the first selection type, and toggle on the second type. If the first argument passed is the word saved, you will save the currently selected valid cuboid or location as the second passed argument. If no name is specified, the notable will be saved with a default name (specified in master_config), and a number. The location or cuboid will then be cleared for you to select a new one. While selecting a cuboid, if a cuboid has been selected, and you continue to choose more locations, the cuboid will be expanded to include those new locations. In practice, this means you can make a bigger cuboid by selecting more space, however, it may include extra space you did not account for, as well as making it impossible to shrink the cuboid. If that happens, simply toggle off, then on, cuboid selection again.
	usage: <gray>/sel <aqua><&lt><white>selection_type<aqua><&gt><green>/<white>save <aqua><&lt><white>notable_name<aqua><&gt>
	debug: false
	script:
		- if <player.is_op>:
			- define config <script[master_config]>
			- define selection_flag <player.flag[selection]||false>
			- define selection_type <context.args.get[1].to_lowercase||<&sp>>
			- define valid_types <list[cuboid|location|save]>
			- if <[valid_types].contains[<[selection_type]>]>:
				- if <[selection_type]> == save:
					- define notable_name <context.args.get[2].to_lowercase||<[config].data_key[selection_tool.default_notable_name]>>
					- define sel_obj <player.flag[selection_obj].as_map||<map.with[valid].as[false]>>
					- if <[sel_obj].get[valid]>:
						- define notable <[sel_obj].get[data]>
						- note <[notable]> as:<[notable_name]>
						- narrate "Created notable <[notable].type>: <[notable_name]>"
						- flag player selection_obj:<map.with[valid].as[false]>
					- else:
						- narrate "Unable to create valid <[selection_flag]>."
				- else if <[selection_flag]> == false || <[selection_flag]> != <[selection_type]>:
					- flag player selection:<[selection_type]>
					- narrate "Current selection mode: <[selection_type]>"
				- else:
					- flag player selection:!
					- flag player selection_obj:<map.with[valid].as[false]>
					- narrate "Selection mode toggled off."
			- else:
				- narrate "'<[selection_type]>' is not a valid selection type."
		- else:
			- narrate <[config].data_key[general.not_op_message].parsed>

discord_link:
	type: command
	name: discord
	description: Gives the link to the Reborn Gaming Discord.
	usage: /discord
	debug: false
	script:
		- narrate "<aqua><italic>Make sure to visit the <white>Reborn Gaming<aqua><italic> discord! <gold><&lb> <dark_purple><&n><element[Click Here].on_click[https://discord.com/invite/wh2GCGa].type[OPEN_URL]><gold> <&rb>"

edit_sign:
    type: command
    name: editsign
    description: Edit an already placed sign using Denizen formatting.
    usage: <gray>/editsign <aqua><&lt><white>denizen_text_formatting<aqua><&gt>
	aliases:
		- edit_sign
    permission: editsign.use
    permission message: <script[master_config].data_key[no_permission_message].parsed>
	debug: false
    script:
		- define sign <player.location.cursor_on>
		- if <[sign].material.name> == sign:
			- sign type:automatic "<context.args.get[1]>" <[sign]>
			- narrate "<gray><italic>Sign edit was successful."

ignite:
	type: command
	name: ignite
	description: Sets a player on fire.
	usage: <gray>/ignite <aqua><&lt><white>player_name<aqua><&gt>
    permission: ignite.player
	permission message: <script[master_config].data_key[no_permission_message].parsed>
	debug: false
	script:
		- define player <server.match_player[<context.args.get[1]||null>]||null>
		- if <[player]> != null:
			- narrate "<gray><italic>You have successfully ignited <white><[player].name><gray><italic>."
			#- narrate "<gray><italic>You have been smote by a vengeful god." targets:<[player]>
			- burn <[player]> duration:5s
		- else:
			- narrate "<red>Unable to ignite <white><[player].name><red> as no player on the server matched that name."

decrement_slot_reel:
    type: command
    name: decslotreel
    description: Decrement the nearest item frame's map, if it's a slot reel
    usage: (inside a command block) /decslotreel
	debug: false
    script:
		- define frame <context.command_block_location.find.entities[item_frame].within[4].get[1]>
		- define map_id <[frame].framed_item.map.sub[1]>
		- if <[map_id]> < 120 && <[map_id]> > -1:
			- if <[map_id].mod[40]> == 0:
				- define map_id <[map_id].add[40]>
		- adjust <[frame]> framed:<[frame].framed_item.with[map=<[map_id]>]>

shoptutorial:
    type: command
    name: shop
    description: Gives a link to a video tutorial on player shops.
    usage: <gray>/shop
    script:
		- narrate "<aqua><italic>This is a video tutorial on player shops! <gold><&lb> <dark_purple><&n><element[Click Here].on_click[https://youtu.be/MXCpwJaxozg].type[OPEN_URL]><gold> <&rb>"

# - Maybe we should combine all the one off scripts that just give you a link to something. We could also add in the voteshop stuff as well