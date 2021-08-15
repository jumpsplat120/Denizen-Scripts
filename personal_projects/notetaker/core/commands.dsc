##IgnoreWarning command_script_usage
##IgnoreWarning bad_execute

nt_write_command:
    type: command
    debug: false
    name: note
    aliases:
        - write_note
    description: A command that allows you to write a note. If more text is written than can fit on a note, multiple notes will be spawned. If no arguments are passed, such as "bg" or "text_color", then it will be assumed all text passed is text meant to be written on the note.<n>The "bg" argument allows you to set an image as the background, instead of the background being a plain color. The url must lead to a jpg. "text_color" allows you to change the color of the text that goes on top of the image, and "bg_color" allows you to change the color of the background, provided you didn't pass an alternate image to use as the background instead. "x_align" and "y_align" allow you to change how the text is aligned on the note. "x_align" accepts left, right, center, while "y_align" accepts top, middle, bottom.<n>Once you've run the command setting all the settings you'd like, you can make as many notes as you'd like and they will be created using those settings. If you added a background image and wanted to remove it, simply do "bg:!", and you will go back to using your background color instead.
    usage: <proc[lib_command_usage].context[nt_config|usage]>
    allowed_help:
        - determine <player.has_permission[notetaker.<script[nt_config].parsed_key[permission.help]>].global>
    permission: notetaker.<script[nt_config].parsed_key[permission.use_command]>
    script:
        - if <player.exists>:
            - if !<player.has_flag[notetaker.command]>:
                - flag player notetaker.command:<map.with[text_color].as[000000].with[bg_color].as[FFFFFF].with[x_align].as[center].with[y_align].as[middle].with[bg].as[true]>
            - if <context.args.size> == 0:
                #rewriting the vanilla help command just to avoid using this
                #excute is feature creep. I can do that some other time, or
                #possibly monkey will get around to adding a thing for it.
                - execute as_player "help note"
            - else:
                - define arg_map    <context.args.to_map[<&co>].if_null[<map>]>
                - define cmd_flags  <player.flag[notetaker.command]>
                - define text_color <[arg_map].get[text_color].if_null[<[cmd_flags].get[text_color]>]>
                - define bg_color   <[arg_map].get[bg_color].if_null[<[cmd_flags].get[bg_color]>]>
                - define x_align    <[arg_map].get[x_align].if_null[<[cmd_flags].get[x_align]>].to_lowercase>
                - define y_align    <[arg_map].get[y_align].if_null[<[cmd_flags].get[y_align]>].to_lowercase>
                - define bg         <[arg_map].get[bg].if_null[<[cmd_flags].get[bg]>]>
                - if <[arg_map].size> > 0:
                    - if <list[left|right|center].contains[<[x_align]>]>:
                        - if <list[top|bottom|middle].contains[<[y_align]>]>:
                            - flag player notetaker.command:<map.with[text_color].as[<[text_color]>].with[bg_color].as[<[bg_color]>].with[x_align].as[<[x_align]>].with[y_align].as[<[y_align]>].with[bg].as[<[bg].equals[!].if_true[true].if_false[<[bg]>]>]>
                            - define cmd_flags  <player.flag[notetaker.command]>
                            - narrate "<green>Your note settings are:"
                            - narrate "   - <dark_aqua>Text Color: <&color[<color[#<[cmd_flags].get[text_color]>]>]><[cmd_flags].get[text_color]>"
                            - narrate "   - <dark_aqua>Background Color: <&color[<color[#<[cmd_flags].get[bg_color]>]>]><[cmd_flags].get[bg].if_true[].if_false[<strikethrough>]><[cmd_flags].get[bg_color]>"
                            - narrate "   - <dark_aqua>X Alignment: <white><[cmd_flags].get[x_align]>"
                            - narrate "   - <dark_aqua>Y Alignment: <white><[cmd_flags].get[y_align]>"
                            - narrate "   - <dark_aqua>Background Image: <white><[cmd_flags].get[bg].if_true[<gray>n/a].if_false[<[cmd_flags].get[bg]>]>"
                        - else:
                            - narrate "<gray><[y_align]> <red>is not a valid y alignment."
                    - else:
                        - narrate "<gray><[x_align]> <red>is not a valid x alignment."
                - else:
                    - ~run nt_generate_map def:<context.raw_args>|<[bg]>|<color[#<[bg_color]>]>|<color[#<[text_color]>]>|<[x_align]>|<[y_align]> save:map_list
                    - foreach <entry[map_list].created_queue.determination.first>:
                        - give nt_written_note[map=<[value]>]
                    - narrate "<dark_green>Note created."
        - else:
            - narrate <proc[lib_core_command_error].context[implicit]>