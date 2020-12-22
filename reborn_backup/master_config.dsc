master_config:
    type: data
    general:
        no_permission_message: <red>Sorry <white><player.name><red>, you are unable to use this command because you do not have the permission <white>'<gray><permission><white>'<red>!
        not_op_message: <red>Sorry <white><player.name><red>, you are unable to use this command because you do not have operator privileges!
        npc:
            talking_speed: 12
            name_format: <green><npc.name> <gold><&lb><gray><npc.constant[class]||ERR><gold><&rb><white><&co>
    wishing_well:
        whisper: <gray><italic>You hear a watery voice whisper from deep within the well, answering the question within your heart...
        ratelimit: 4
        wait:
            min: 30
            max: 60
        options:
            - It is certain...
            - As I see it, yes...
            - Reply hazy, try again...
            - Do not count on it...
            - It is decidedly so...
            - Most likely...
            - Ask again later...
            - My reply is no...
            - My sources say no...
            - Maybe some day...
            - Yes, definitely...
            - Yes...
            - I can not see the outcome...
            - I do not see the outcome...
            - The outlook... is not so good...
            - You may rely on it...
            - All the signs point to yes...
            - Concentrate, and ask again...
            - Focus, and ask once more...
            - Very doubtful...
            - It would be better not to tell you now...
            - Without a doubt...
            - I am confident...
            - I believe so...
            - I am unsure...
            - It is not clear...
            - Ask once more...
    particle_pressure_plate:
        size_radius: .5
        swirl_amount: 3
        layer_spacing: .125
        layer_amount: 15
        delay: 3
        effect: soul_fire_flame
    wizard_tower:
        xp_requirement: 4
        stand_still: <dark_blue>{ <blue>Stand still within the circle until you hear a sound.<dark_blue> }
        missing_xp: <gray><italic>You do not have enough xp to use the power of the wizard's tower...
        start_effect: <gray><italic>You can feel the tower consuming your experience to
        buffer_time: 35
        time_speed: 5
        ratelimit: 5
        clear:
            attempt: rid the skies of foul weather...
            success: <gray><italic>The powerful magics have brought peace to the skies.
            fail: <gray><italic>But the sky was already at peace...
        day:
            attempt: to wake the sun...
            success: <gray><italic>The powerful magics have revealed the morning sun.
            fail: <gray><italic>But the sun had not yet dipped...
        night:
            attempt: to reach to the witching hour...
            success: <gray><italic>The powerful magics have painted the sky black.
            fail: <gray><italic>But night was still upon the world...
        rain:
            attempt: to call forth a powerful storm...
            success: <gray><italic>The powerful magics have summoned a fierce storm.
            fail: <gray><italic>But a storm was already raging...
    d1:
        trigger_word: Dominus Mortuorum
        cuboid:
            dominus_warp_zone: d1_dominus_warp_room
            ellohien_room: ellohien_room
            whole_dungeon: d1_underground
        location:
            teleport_to_boss: d1_warp_to_location
        ellohien:
            lines1:
                - <player.name>, you have freed my soul, and for that, I am incredibly grateful.
                - However, I beg of you, this can not be the end of your quest!
                - The evil necromancer who had trapped me here <italic>must<&r> be stopped!
                - In order to get into his inner sanctum, you must use his portal.
                - It is activated with a phrase... one that is burned into my memory from when he captured me long ago.
                - <gold><italic><element[<script[master_config].data_key[d1.trigger_word].parsed>].with_insertion[<script[master_config].data_key[d1.trigger_word].parsed>]><white>.
                - Please, go now, and ensure that this will never happen to anyone else.
        portal_explanation: <gray><italic>You feel as though the words that Ellohien gave you should be said here... <dark_blue>{ <blue>Shift left click the yellow words!<dark_blue> }
        teleport_message: <gray><italic>You feel strange, as the world around you begins to shift...
    selection_tool:
        default_notable_name: generic
    cartography:
        cancel_message: <red>You are unable to make a copy of this item.
        uncraftable_tags:
            - maplock
    squish:
        terminal_velocity: 98
        damage_multiplier: 1.25
        squish_range: 1.25
        terminal_squish_range: 2
    shulker_box:
        shift_click: <red>Shift-clicking shulker boxes is disabled.
        hotbar: <red>Hotbar hotkeys are disabled for shulker boxes.
        chest: <red>The chest isn't big enough for that.
        ender_chest: <red>The ender chest isn't big enough for that.
        barrel: <red>The barrel isn't big enough for that.
        hopper: <red>The hopper isn't big enough for that.
        enchanting: <red>You can only enchant empty shulker chests.
        workbench: <red>You can only color empty shulkers on a crafting table.
        blast_furnace: <red>Shulkers do not belong in a blast furnace.
        furnace: <red>Shulkers do not belong in a furnace.
    emote:
        cooldown:
            ticks: 70
            message: <red>Emote is on cooldown!
        grin:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmFiYzI3NDU0MzUxZWY1Yjk0NjQxNTgxOTgzMjJhNjU2NmY2MzNiOTkwMzMyYWI5NDZlNDVmMjc2ZDRjYjcifX19
            uuid: 21ea013f-072a-44e5-85af-0d9f35d6c642
        smile:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNDU4NjUzNmRmOTMwNmNjMWFjNmY0OTg5NDRiNDVmOGEwYmUyMDRmMzc4NmQ5ZGFiNzIxMWQ1YWRjY2JlNjkyIn19fQ==
            uuid: 08918b23-63ba-4886-b08f-59a271b91575
        straight:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvODY3Mjk2NjJmMjA0YzZlNjM0YjM5MzFlMDdlNTRkMWM2MzQyNDRiOGU2ZmViMTI3M2JhNmE1Y2M0YWM4YjcifX19
            uuid: cd2e8f12-3703-4289-acab-73239545085f
        cheeky:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOTA2YzI2OTk1OTk1MjNjMTEzNWE3MWZmM2FkMzc5ZjMyZTUzNTQ4MjU1ZGRmNzc3YzM3NDU3YmJiZjczIn19fQ==
            uuid: 01c5c10e-fb64-4aee-9dbe-cdf99acf5ea2
        sad:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjhiOWMzYmU1ODRjMTBiOGY0ODc1ZGY2NjcyNTQ0ZGNjMTI4Y2ZhMmNhNjY4ZGFlYmM1MTI0ZjM3ZmM4YzdiIn19fQ==
            uuid: 051472ab-756d-4cd4-92f4-d00393969e30
        angry:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNmI5YjdiNzVkOTVkZmVhMTI0MzFkMzg2YWQyYjg4NTMyYTA0NDY1ZDBhYTk0MTkzMGMwZjQzZmVkMjIxZWE1In19fQ==
            uuid: 34cca4a8-56e3-47c5-b953-37647975b11a
        wink:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZmJiN2MxYTViZGZmMjlhNWUzYzY3ZTNkZGUwNTQzNjgwMjZjNGM5ZWM3MzY3ZWUzYTYxNTE1MmIzMjdkMjE1In19fQ==
            uuid: af5c1f87-b63a-4033-afac-cb3fa80b52cd
        surprised:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZTBmMDkyOTc1MGI5NDRjMzQyMzFhZjIxNTY1OWQ3Mzc5OGFiNTgzM2Y1YmEzNmVkMjRmYzJmMTg0ZTI0YTlhIn19fQ==
            uuid: 0c5be661-7d7f-4322-8d5a-ceefebbdb479
        coy:
            blob: eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvY2MzOTU3OTBjYTMyY2NkNDgwNDY0YWVmOGIzYzgyNjczZWM3NWRlNjc5Y2M3N2IyMmYyZjFjMjIzN2EwMjVhNCJ9fX0=
            uuid: 547861a8-8ce4-4ac3-9aaf-85d379752d6b