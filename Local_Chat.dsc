Local Chat:
    type: world
    events:
        on player chats:
			- determine passively cancelled
			#is_uppercase fails if a string contains numbers or symbols, so we remove all of that first
            - define alpha_string <context.message.replace_text[regex:<element[[^A-Za-z]]>]
			#Default range
			- define range 10
            - if <[alpha_string].is_uppercase>:
				#Range if yelling
                - define range 20
			#We could also consider adding an "emphasis" def, where for each exclamation point the text has, the range can increase, maybe using a curve so you can't just keep adding more to speak to everyone. We could also have a device that sort of bypasses all of this if the device is being held, so that it goes out to the entire server. And maybe a permission so that admins can toggle on or off this ability for themselves
            - define nearby_players <player.location.find.players.within[<[range]>]>
			#context.full_text includes the name eg, "<PlayerName> hello world" as well as any color formatting. context.message is just plain text. That's why we compaire with the plain text message, but output the full_text
            - narrate <context.full_text> targets:<[nearby_players]>
