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
            forward_slash: <blue>/
            left_bracket: <dark_aqua><&lb>
            right_bracket: <dark_aqua><&rb>
            less_than: <dark_gray><&lt>
            greater_than: <dark_gray><&gt>
            left_parenthesis: <dark_aqua>(
            right_parenthesis: <dark_aqua>)
            right_curly_bracket: <aqua><&rc>
            left_curly_bracket: <aqua><&lc>
    exclude:
        flags:
            - jlib
            - __interact_step
        mobs:
            - player
            - armor_stand
            - dropped_item