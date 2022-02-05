# +--------------------
# |
# | MORPHEUS
# |
# | A democratic sleep system
# |
# +----------------------
#
# @author jumpsplat120
# @date 05/17/2021
# @denizen-build 1.2.0-b1739-REL
# @script-version 1.0
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#    * morpheus.dsc
#
# Usage:
#   Go to sleep! When a percentage of the player population (percentage
#   defined in the config contained within the script) is matched or exceeded,
#   the time will pass! You no longer need the entire server to sleep at the
#   same time for the night to pass.
#
#   For a demo, visit here: https://www.youtube.com/watch?v=-mMESPyLkH4

# --------------------END HEADER / START CONFIG--------------------

morpheus_config:
    type: data
    percent: 0.5
    wake_message: "Wakey, wakey, rise and shine... good morning everyone!"

# --------------------END CONFIG / START CODE--------------------

morpheus_events:
    type: world
    events:
        on player enters bed:
            - ratelimit player 10t
            - wait 10t
            - flag server morpheus:->:<player>
            - inject morpheus_events path:init
            - announce "<player.name> <yellow>is now sleeping. <[msg_addon]>"
            - if <[curr_percentage]> >= <[percentage]>:
                - wait 5t
                - time 0
                - announce <yellow><[config].parsed_key[wake_message]>"
        on player leaves bed:
            - inject morpheus_events path:init
            - flag server morpheus:<-:<player>
            - define period <player.world.time.period>
            - if <[period]> == dusk || <[period]> == night:
                - announce "<player.name> <yellow>left their bed. <[msg_addon]>"
    init:
        - define config          <script[morpheus_config]>
        - define percentage      <[config].data_key[percent]>
        - define sleeping        <server.flag[morpheus].size>
        - define required        <server.online_players.size.mul[<[percentage]>].round_down.max[1]>
        - define curr_percentage <[sleeping].div[<[required]>]>
        - define msg_addon "<gold><[sleeping]>/<[required]> (<[curr_percentage].mul[100].round><&pc>)"
