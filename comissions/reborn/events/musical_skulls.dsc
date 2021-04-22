musical_script:
    type: world
    debug: false
    events:
        on player right clicks skeleton_skull:
            - playsound <player.location> sound:BLOCK_NOTE_BLOCK_XYLOPHONE volume:10 pitch:<util.random.decimal[0.6].to[1.4]>
        on player right clicks wither_skeleton_skull:
            - playsound <player.location> sound:BLOCK_NOTE_BLOCK_XYLOPHONE volume:10 pitch:<util.random.decimal[0.5].to[0.75]>