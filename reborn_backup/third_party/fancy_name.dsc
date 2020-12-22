just_for_jump:
    type: world
    debug: false
    events:
        on player chats:
            - if <player.name.contains_text[jumpsplat120]>:
                - determine "raw_format:<gold>[<dark_aqua>M<gold>] <dark_purple>jumpsplat120 <gold>[<gray><magic>abcdefg<gold>]<white>: <context.message>"