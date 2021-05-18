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
# @script-version 1.1
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#    * local_chat.dsc
#    * utilities [folder]
#
# Usage:
#   Any two players whose distance is smaller than `whisper` will be able to
#   hear when they begin and end their message with `whisper_chr`. Any two
#   players whose distance is smaller than `talking` will be able to hear each
#   other with no issues. Be aware that the distance is a straight line, and will
#   go through walls and the like. For two players whose distance is smaller than
#   `shouting` will be able to hear each other, as long as the message is appended
#   with an exclimation point. For two players whose distance is smaller than
#   `screaming` will only be able to hear each other if the player is typing in
#   all caps, and ending the message with an exclimation point. Any two players who are
#   outside of the `screaming` of each other will no longer be able to hear each
#   other at all.
#
#   For more information, visit here: https://www.youtube.com/watch?v=EUyFUi9-Ixk
#
# --------------------END HEADER / START CONFIG--------------------

lc_config:
    type: data
    whisper_chr: ~
    whisper: 3
    talking: 8
    shouting: 14
    screaming: 20

# --------------------END CONFIG / START CODE--------------------

lc_event:
    type: world
    debug: false
    events:
        on player chats:
            - determine passively cancelled
            - define m <context.message>
            - define c <script[lc_config]>
            - define w <[c].parsed_key[whisper_chr]>
            - narrate <context.full_text> targets:<player.location.find.players.within[<[c].data_key[<[m].ends_with[!].and[<[m].proc[lib_as_alpha].is_uppercase>].if_true[screaming].if_false[<[m].ends_with[!].if_true[shouting].if_false[<[m].starts_with[<[w]>].and[<[m].ends_with[<[w]>]>].if_true[whisper].if_false[talking]>]>]>]>]>
