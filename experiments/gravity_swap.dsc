start_gravity_swap:
    type: command
    debug: false
    name: gswap
    usage: /gswap
    description: Starts or stops the gravity swap minigame. If the game is running, will stop the game. If game is not running, will stop the game.
    script:
        - flag server gravity_swap:<server.has_flag[gravity_swap].if_true[!].if_false[false]>
        - narrate "<server.has_flag[gravity_swap].if_true[Starting].if_false[Ending]> the gravity swap game!"

gravity_swap:
    type: world
    debug: false
    events:
        on tick server_flagged:gravity_swap:
            - if <server.flag[gravity_swap]>:
                - foreach <server.online_players> as:player:
                    #divide by .98 to maintain some of that horizontal motion they lose initially.
                    - adjust <[player]> velocity:<[player].velocity.x.div[0.98]>,<[player].velocity.y.sub[-0.136].mul[0.98]>,<[player].velocity.z.div[0.98]>
                    - debug log <[player].velocity>
        on delta time secondly every:15 server_flagged:gravity_swap:
            - announce "Swapping in one minute!"
            - wait 30s
            - announce "Swapping in thirty seconds!"
            - wait 20s
            - announce "Swapping in ten seconds!"
            - wait 10s
            - flag server gravity_swap:<server.flag[gravity_swap].if_true[false].if_false[true]>