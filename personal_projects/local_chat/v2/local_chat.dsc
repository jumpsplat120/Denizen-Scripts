# +--------------------
# |
# | LOCAL CHAT
# |
# | A system for local in game chat to
# | facilitate roleplay.
# |
# +----------------------
#
# @author jumpsplat120
# @date 10/04/2020
# @denizen-build b5081-DEV
# @script-version 2.0
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * local_chat_v2.dsc
#     * utilities.dsc
#
# Usage:
#   Simply chat in game! Any player underneath the upper_talking_limit
#   divided by the falloff point ((utl / fop).round) will transmit all
#   letters of their message. If they are above that value, but still
#   underneath the utl, then characters will be removed from the
#   message (Any character except space will be removed), until they've
#   reached the utl, at which no message will be transmitted.
#
#   All of the above also holds true for the upper_shouting_limit, as
#   long as the message is in all caps (if there are no alphabetic
#   letters, the message is automatically characterized as all caps.)
#
#   For more information, visit here: https://www.youtube.com/watch?v=8Fn0w_dI0V4
#
# --------------------END HEADER / START CONFIG--------------------

local_chat_config:
    type: data
    upper_talking_limit: 21
    upper_shouting_limit: 39
    falloff_point: 3

# --------------------END CONFIG / START CODE--------------------

local_chat:
    type: world
    debug: false
    events:
        on player chats:
            - determine passively cancelled
            - define config <script[local_chat_config]>
            - define upper_limit <tern[<proc[is_uppercase].context[<context.message>]>].pass[<[config].data_key[upper_shouting_limit]>].fail[<[config].data_key[upper_talking_limit]>]>
            - define clear <player.location.find.players.within[<[upper_limit].div[<[config].data_key[falloff_point]>].round>]>
            - narrate "<&lt><player.name><&gt> <context.message>" targets:<[clear]>
            - foreach <player.location.find.players.within[<[upper_limit]>].exclude[<[clear]>]>:
                - define target <[value]>
                - define list <context.message.to_list>
                - define space_list "<[list].find_all[ ]>"
                - define list <[list].remove[<[space_list]>]>
                - repeat <[list].size.sub[<[space_list].size>].mul[<proc[map_range].context[<[upper_limit].div[<[config].data_key[falloff_point]>]>|<[upper_limit]>|0|1|<[target].location.distance[<player.location>]>]>].round>:
                    - define list "<[list].set_single[ ].at[<util.random.int[1].to[<[list].size>]>]>"
                - foreach <[space_list]>:
                    - define list "<[list].insert[ ].at[<[value]>]>"
                - narrate "<&lt><player.name><&gt> <[list].unseparated>" targets:<[target]>