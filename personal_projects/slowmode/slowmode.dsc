# +--------------------
# |
# | Slowmode
# |
# | Slow down the chat
# |
# +----------------------
#
# @author jumpsplat120
# @date 05/17/2021
# @denizen-build 1.2.0-b1739-REL
# @script-version 1.1
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#    * slowmode.dsc
#
# Usage:
#   Anyone with the "slowmode" permission can toggle slowmode by
#   using the `/slow` command. When slow mode is enabled, players
#   are only able to send a message every three seconds, or however
#   long was set with the command.
#
# --------------------END HEADER / START CODE--------------------

slowmode_event:
    type: world
    debug: false
    events:
        on player chats server_flagged:slowmode:
        - if <player.has_flag[slowmode]>:
            - narrate "<&[warning]>You're chatting too fast!"
            - determine cancelled
        - flag <player> slowmode expire:<server.flag[slowmode]>s

slowmode_command:
    type: command
    debug: false
    name: slow
    description: This command allows those with the 'slowmode' permission to toggle on or off slowmode chat for the server. Passing a number allows you to change the default amount of time from 3 seconds.
    permission: slowmode
    usage: /slow (<&lt>seconds<&gt>)
    script:
    - if <server.has_flag[slowmode]>:
        - flag server slowmode:!
        - announce "<&[base]>Slowmode has been disabled."
    - else:
        - define sec <context.args.get[1].if_null[3]>
        - if !<[sec].is_decimal>:
            - define sec 3
        - flag server slowmode:<[sec]>
        - announce "<&[base]>Slowmode has been enabled! You must wait <&[emphasis]><[sec]> seconds <&[base]>between messages."
