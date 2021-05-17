slowmode:
    type: world
    debug: false
    events:
        on player chats:
        - if <player.has_flag[slowmode]>:
            - narrate "<gray><italic>You're chatting too fast!"
            - determine cancelled
        - flag <player> slowmode expire:3s
