lib_config:
    type: data
    cmd_offset: 0
    color:
        error: <red>
        success: <dark_green>
        warning: <yellow>
        clickable: <aqua><underline>
        soft_server_notice: <gray>
        hard_server_notice: <dark_gray>
        important: <dark_aqua>
        command:
            literal: <white>
            non_literal: <gray>
            forward_slash: <blue>
            bracket: <dark_aqua>
            less_or_greater_than: <dark_gray>
            parenthesis: <dark_aqua>
            curly_bracket: <aqua>
    exclude:
        flags:
            - jlib
            - __interact_step
        mobs:
            - player
            - armor_stand
            - dropped_item