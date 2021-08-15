nt_generate_map:
    type: task
    debug: false
    definitions: text|bg_image|bg_color|text_color|y|x
    script:
        - define config <script[nt_config]>
        - define api <[config].data_key[api_address]>
        - define text "<[text].if_true[ ].if_false[<[text]>].if_null[ ]>"
        - define bg_color <[bg_color].if_true[FFFFFF].if_false[<[bg_color].hex.replace_text[<&ns>].if_null[FFFFFF]>].if_null[FFFFFF]>
        - define bg_image <[bg_image].if_true[null].if_false[<[bg_image]>].if_null[null]>
        - define text_color <[text_color].if_true[000000].if_false[<[text_color].hex.replace_text[<&ns>].if_null[000000]>].if_null[000000]>
        - define y <[y].if_true[middle].if_false[<[y]>].if_null[middle]>
        - define x <[x].if_true[center].if_false[<[x]>].if_null[center]>
        - define result <list>
        - define background <[bg_image].equals[null].if_true[https://via.placeholder.com/1280/<[bg_color]>/<[bg_color]>.jpg].if_false[<[bg_image]>]>
        #40 words/175 found from just testing how much can fit size 128.
        #Nothing clever about it lol
        - define too_many_chars <[text].length.is_more_than[175]>
        - if <[too_many_chars]> || <[text].split.size.is_more_than[40]>:
            - ~run nt_generate_map def:<[too_many_chars].if_true[<[text].substring[1,175]>].if_false[<[text].split.get[40].to[last].space_separated>]>|<[bg_image].equals[null].if_true[true].if_false[<[bg_image]>]>|<[bg_color]>|<color[<&ns><[text_color]>]>|<[x]>|<[y]> save:result
            - define result:|:<entry[result].created_queue.determination.first>
            - define text <[too_many_chars].if_true[<[text].substring[176,<[text].length>]>].if_false[<[text].split.get[1].to[39].space_separated>]>
        - map new:<player.world> image:<[api]>image?image_url=<[background].url_encode>&text=<[text].url_encode>&text_color=<[text_color]>FF&text_size=128&y_align=<[y]>&x_align=<[x]> resize save:mail
        - determine <[result].include[<entry[mail].created_map>]>