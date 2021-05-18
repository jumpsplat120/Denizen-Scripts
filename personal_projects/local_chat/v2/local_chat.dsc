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
# @date 05/17/2021
# @denizen-build 1.2.0-b1739-REL
# @script-version 2.1
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * local_chat.dsc
#     * utilities [folder]
#
# Usage:
#   Simply chat in game! Any player underneath a talking limit divided by the
#   falloff point ((talking_limit / fop).round) will transmit all
#   letters of their message. If they are above that value, but still
#   underneath the talking_limit, then characters will be removed from the
#   message (Any character except space will be removed), until they've
#   reached the talking_limit, at which no message will be transmitted.
#
#   The whisper talking limit is when the message begins and ends with the
#   whisper character. Talking is any regular speech. Shouting is when the
#   text ends in an exclimation point, and screaming is ending in an
#   exclimation while all the alphabetic characters are uppercase. Non-alphabetic
#   characters count as uppercase.
#
#   For more information, visit here: https://www.youtube.com/watch?v=8Fn0w_dI0V4
#
# --------------------END HEADER / START CONFIG--------------------

lc_config:
    type: data
    replacement_chr: <&sp>
    whisper_chr: ~
    whisper: 9
    talking: 24
    shouting: 42
    screaming: 60
    falloff_point: 3

# --------------------END CONFIG / START CODE--------------------

lc_event:
    type: world
    debug: false
    events:
        on player chats:
            - determine passively cancelled
            - define c           <script[lc_config]>
            - define m           <context.message>
            - define w           <[c].parsed_key[whisper_chr]>
            - define r           <[c].parsed_key[replacement_chr]>
            - define chrs        <context.message.to_list>
            - define range       <[c].data_key[<[m].is_uppercase.and[<[m].ends_with[!]>].if_true[screaming].if_false[<[m].ends_with[!].if_true[shouting].if_false[<[m].starts_with[<[w]>].and[<[m].ends_with[<[w]>]>].if_true[whisper].if_false[talking]>]>]>]>
            - define falloff     <[range].div[<[c].data_key[falloff_point]>]>
            - define fully_within <player.location.find.players.within[<[falloff]>]>
            - narrate <context.full_text> targets:<[fully_within]>
            - foreach <player.location.find.players.within[<[range]>].exclude[<[fully_within]>]> as:target:
                - define spaces <[chrs].find_all[<&sp>]>
                - define chrs   <[chrs].remove[<[spaces]>]>
                - repeat <[chrs].size.mul[<proc[lib_map_range].context[<[falloff]>|<[range]>|0|1|<[target].location.distance[<player.location>]>]>].round>:
                    - define chrs[<util.random.int[1].to[<[chrs].size>]>]:<[r]>
                - define chrs <[spaces].filter_tag[<[chrs].set_single[<&sp>].at[<[filter_value]>]>]>
                - narrate "<&lt><player.name><&gt> <[chrs].unseparated>" targets:<[target]>
