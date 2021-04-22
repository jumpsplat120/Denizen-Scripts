#Requires utilities package

local_chat_config:
    type: data
    min_range: 10
    max_range: 20

local_chat_event:
    type: world
    events:
        on player chats:
            - determine passively cancelled
            - narrate <context.full_text> targets:<player.location.find.players.within[<context.message.proc[lib_has_alpha].and[<context.message.proc[lib_as_alpha].is_uppercase>].if_true[20].if_false[10]>]>