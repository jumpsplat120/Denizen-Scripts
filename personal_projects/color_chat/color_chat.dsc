color_chat:
    type: world
    debug: false
    events:
        on player chats:
            - determine <context.message.parse_color>
