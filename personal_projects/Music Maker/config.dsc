# +----------------------
# |
# |      MUSIC MAKER
# |
# | Adds instruments to the game.
# |
# +----------------------
#
# @author jumpsplat120
# @date 05/22/21
# @denizen-build 5578-DEV
# @script-version 1.2.1
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * /core
#       >- events.dsc
#       >- custom_items.dsc
#       >- data.dsc
#     * config
#
# Feel free to use the provided textures, or to make your own.
#
# Usage:
# Craft any of the instruments, the right click the instrument to play
# a note. Looking up will play higher notes, while looking down will
# play lower notes.
#
# Feel free to check this video for a more thorough tutorial: https://www.youtube.com/watch?v=54sNH48e9sA
#
# --------------------END HEADER / START CONFIG--------------------
mm_config:
    type: data
    cmd_offset: 0
    scale:
        1:
            lang: Major
            intervals:
                - 0
                - 2
                - 4
                - 5
                - 7
                - 9
                - 11
                - 12
        2:
            lang: Natural Minor
            intervals:
                - 0
                - 2
                - 3
                - 5
                - 7
                - 8
                - 10
                - 12
        3:
            lang: Harmonic Minor
            intervals:
                - 0
                - 2
                - 3
                - 5
                - 7
                - 8
                - 11
                - 12
        4:
            lang: Melodic Minor (Ascending)
            intervals:
                - 0
                - 2
                - 3
                - 5
                - 7
                - 9
                - 11
                - 12
        5:
            lang: Melodic Minor (Descending)
            intervals:
                - 12
                - 10
                - 8
                - 7
                - 5
                - 3
                - 2
                - 0
        6:
            lang: Ionian
            intervals:
                - 0
                - 2
                - 4
                - 5
                - 7
                - 9
                - 11
                - 12
        7:
            lang: Dorian
            intervals:
                - 0
                - 2
                - 3
                - 5
                - 7
                - 9
                - 10
                - 12
        8:
            lang: Phygrian
            intervals:
                - 0
                - 1
                - 3
                - 5
                - 7
                - 8
                - 10
                - 12
        9:
            lang: Lydian
            intervals:
                - 0
                - 2
                - 4
                - 6
                - 7
                - 9
                - 11
                - 12
        10:
            lang: Mixolydian
            intervals:
                - 0
                - 2
                - 4
                - 5
                - 7
                - 9
                - 10
                - 12
        11:
            lang: Aeolian
            intervals:
                - 0
                - 2
                - 3
                - 5
                - 7
                - 8
                - 10
                - 12
        12:
            lang: Locrian
            intervals:
                - 0
                - 1
                - 3
                - 5
                - 6
                - 8
                - 10
                - 12
        13:
            lang: Blues Penatonic Major
            intervals:
                - 0
                - 2
                - 3
                - 4
                - 7
                - 9
                - 12
        14:
            lang: Blues Penatonic Minor
            intervals:
                - 0
                - 3
                - 5
                - 6
                - 7
                - 10
                - 12