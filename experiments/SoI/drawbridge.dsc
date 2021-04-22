soi_animation_event:
    type: world
    debug: false
    events:
        on player right clicks block with:soi_animation_tool:
            - if !<player.has_flag[animation.frame_amount]>:
                - if <player.has_flag[animation.corner2]>:
                    - narrate "Looks like you want to save this animation! Face the direction the frames are lined up, and type in chat the amount of frames that this animation contains: "
                    - flag <player> animation.frame_amount:waiting
                    - waituntil <player.flag[animation.frame_amount].is[!=].to[waiting]>
                    - define amount <player.flag[animation.frame_amount]>
                    - if <[amount].is_decimal>:
                        - define corner_a <player.flag[animation.corner1]>
                        - define corner_b <player.flag[animation.corner2]>
                        - define cuboid <[corner_a].to_cuboid[<[corner_b]>]>
                        - define direction <tern[<list[north|south].contains[<player.location.yaw.simple>]>].pass[z].fail[x]>
                        - announce <[cuboid].size.get[x]>
                        - flag <player> animation:!
                    - else:
                        - narrate "Sorry, I wasn't able to convert '<[amount]>' into a number. Please try again!"
                - else if <player.has_flag[animation.corner1]>:
                    - narrate "Grabbed the second corner!"
                    - flag <player> animation.corner2:<context.location||<player.eye_location.forward[4]>>
                - else:
                    - narrate "Grabbed the first corner!"
                    - flag <player> animation.corner1:<context.location||<player.eye_location.forward[4]>>
        on player chats:
            - if <player.has_flag[animation.frame_amount]>:
                - determine passively cancelled
                - flag <player> animation.frame_amount:<context.message>

soi_animation_tool:
    type: item
    material: stick
    display name: <reset>Animation Tool