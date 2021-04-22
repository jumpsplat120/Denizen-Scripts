# +----------------------
# |
# |      MUSIC MAKER
# |
# | Adds instruments to the game.
# |
# +----------------------
#
# @author jumpsplat120
# @date 10/04/2020
# @denizen-build b5081-DEV
# @script-version 1.1
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * custom_items.dsc
#     * didgeridoo_craft.dsc
#     * instruments.dsc
#     * music.dsc
#     * music_maker.dsc
#
# Don't forget the textures!
#
# Usage:
# Craft any of the instruments, the right click the instrument to play
# a note. Looking up will play higher notes, while looking down will
# play lower notes.
#
# Feel free to check this video for a more thorough tutorial: https://www.youtube.com/watch?v=54sNH48e9sA
#
# --------------------END HEADER / START CONFIG--------------------

music_maker_config:
    type: data
    custom_model_data_offset: 0

# --------------------END CONFIG / START CODE--------------------

map_range:
    type: procedure
    definitions: from_min|from_max|to_min|to_max|input
    script:
        - determine <[input].sub[<[from_min]>].mul[<[to_max].sub[<[to_min]>]>].div[<[from_max].sub[<[from_min]>]>].add[<[to_min]>]>

rainbow_actionbar:
    type: task
    definitions: a|b
    script:
        - flag player actionbar:!
        - wait 1t
        - flag player actionbar:true
        - define color <color[255,0,0]>
        - repeat 100:
            - if !<player.has_flag[actionbar]>:
                - repeat stop
            - actionbar "<[a].color[<[color]>]> <[b].unescaped.color[<[color]>]>"
            - wait .02t
            - define color <[color].with_hue[<[color].hue.add[3]>]>
        - flag player actionbar:!

music_maker:
    type: world
    set_scale_flags:
        - if !<player.has_flag[scale]>:
            - flag player scale_type:1
            - flag player scale_index:1
            - flag player scale:!|:<script[music].data_key[scale.<script[music].data_key[scale.list].get[<player.flag[scale_type]>]>.<script[music].data_key[notes.list].get[<player.flag[scale_index]>]>]>
    events:
        on player left clicks blocks with:instrument_*:
            - inject set_scale_flags path:music_maker
            - if <player.is_sneaking>:
                - flag player scale_type:++
            - else:
                - flag player scale_index:++
                - if <player.flag[scale_index]> > <script[music].data_key[scale.<script[music].data_key[scale.list].get[<player.flag[scale_type]>]>].size>:
                    - flag player scale_index:1
            - if <player.flag[scale_type]> > <script[music].data_key[scale.list].size>:
                - flag player scale_type:1
            - flag player scale:!|:<script[music].data_key[scale.<script[music].data_key[scale.list].get[<player.flag[scale_type]>]>.<script[music].data_key[notes.list].get[<player.flag[scale_index]>]>]>
            - run rainbow_actionbar def:<script[music].data_key[scale.lang_list].get[<player.flag[scale_type]>]>|<script[music].data_key[notes.lang_list].get[<player.flag[scale_index]>]>
        on player right clicks block with:instrument_*:
            - inject set_scale_flags path:music_maker
            - if <player.is_sneaking>:
                - flag player advanced_mode:<tern[<player.has_flag[advanced_mode]>].pass[!].fail[true]>
                - run rainbow_actionbar def:<element[Advanced&spMode:].unescaped>|<tern[<player.has_flag[advanced_mode]>].pass[True].fail[False]>
            - define percentage <player.location.pitch.add[-90].mul[-1].div[1.8].round>
            - define scale <player.flag[scale]>
            - if <player.has_flag[advanced_mode]>:
                - if <[percentage]> < 25:
                    - define percentage 25
                - else if <[percentage]> > 75:
                    - define percentage 75
                - define note <proc[map_range].context[25|75|0|100|<[percentage]>]>
            - else:
                - define note <[percentage]>
            - define note <[scale].get[<[note].div[<element[100].div[<[scale].size>]>].add[0.000001].round_up.min[<[scale].size>]>]>
            - define note_frequency <script[music].data_key[notes.<[note]>]>
            - define sound <script[music].data_key[instruments.<context.item.scriptname>]>
            - playsound <player.location> sound:<[sound]> volume:1.5 pitch:<[note_frequency]>