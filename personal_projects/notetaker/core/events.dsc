nt_events:
    type: world
    debug: false
    events:
        on item recipe formed:
            - if <context.inventory.contains_item[nt_empty_note]>:
                - if <context.recipe_id> != denizen:nt_empty_note:
                    #Don't use empty notes as sticks
                    - determine cancelled
                - else if !<context.inventory.contains_item[*_dye]>:
                    #Remove result if you removed dye. This doesn't trigger on empty_note formed
                    #because we are "unforming" the recipe.
                    - determine air
        on nt_empty_note recipe formed:
            - if <context.inventory.contains_item[*_dye]>:
                - define hex <script[lib_generic_data].data_key[dye_hex_colors]>
                - define paper <context.recipe.get[5]>
                - define is_empty_note <[paper].script.name.equals[nt_empty_note].if_null[false]>
                - if <[is_empty_note]>:
                    - define top_color <[paper].flag[top_color]>
                    - define bot_color <[paper].flag[bot_color]>
                - if <[paper].material.name> == paper || <[is_empty_note]>:
                    - foreach <context.recipe.get[1].to[3].filter[material.advanced_matches[*_dye]].parse[material.name.before[_dye]]>:
                        - define color <color[<&ns><[hex].get[<[value]>]>]>
                        - define top_color <[top_color].exists.if_true[<[top_color].mix[<[color]>]>].if_false[<[color]>]>
                    - foreach <context.recipe.get[7].to[9].filter[material.advanced_matches[*_dye]].parse[material.name.before[_dye]]>:
                        - define color <color[<&ns><[hex].get[<[value]>]>]>
                        - define bot_color <[bot_color].exists.if_true[<[bot_color].mix[<[color]>]>].if_false[<[color]>]>
                    - define top_color <color[white]> if:<[top_color].exists.not>
                    - define bot_color <color[white]> if:<[bot_color].exists.not>
                    - if <script[color_name].exists>:
                        - ~run color_name def:<[top_color]> save:top_color
                        - ~run color_name def:<[bot_color]> save:bot_color
                        - define ink_color <entry[top_color].created_queue.determination.first>
                        - define pap_color <entry[bot_color].created_queue.determination.first>
                    - define ink_hex <[top_color].hex.after[<&ns>].to_uppercase>
                    - define pap_hex <[bot_color].hex.after[<&ns>].to_uppercase>
                    #due to the waiting for color_name, this can determine a second time
                    #after the recipe has already been crafted. Just checking that the
                    #crafting table isn't empty right before avoids that issue
                    - determine "<item[nt_empty_note].with_flag[top_color:<[top_color]>].with_flag[bot_color:<[bot_color]>].with[lore=<script[nt_empty_note].parsed_key[lore].include[<empty>|<dark_gray>------------------------|<empty>|<dark_aqua>Ink Color: <&color[<[top_color]>]><[ink_color].exists.if_true[<[ink_color]> (<[ink_hex]>)].if_false[<[ink_hex]>]>|<dark_aqua>Paper Color: <&color[<[bot_color]>]><[pap_color].exists.if_true[<[pap_color]> (<[pap_hex]>)].if_false[<[pap_hex]>]>]>]>" if:<context.inventory.is_empty.not>
            - determine cancelled
        on player right clicks block with:nt_empty_note:
            - take iteminhand
            - define wait <script[nt_config].data_key[wait]>
            - define wait_amt <[wait].substring[1,<[wait].length.sub[1]>]>
            - narrate "<gray><italic>Type in chat whatever message you would like to appear on your note. Be aware that you are limited to 40 words, or 175 characters, which ever comes first. If nothing is typed after <[wait_amt]> <script[lib_generic_data].data_key[duration.<script[nt_config].data_key[wait].char_at[<[wait].length>]>]><[wait_amt].is_more_than[1].if_true[s].if_false[]>, the note will not be written."
            - flag player notetaker.writing:<context.item>
            - wait <script[nt_config].data_key[wait]>
            - if <player.has_flag[notetaker.writing]>:
                - narrate "<yellow>Nothing was written."
                - give <player.flag[notetaker.writing]> quantity:1
                - flag player notetaker.writing:!
        on player chats flagged:notetaker.writing:
            - determine cancelled passively
            - narrate "<green><italic>You wrote a note! Give time for the ink to dry..."
            - define nt <player.flag[notetaker.writing]>
            - ~run nt_generate_map def:<context.message.strip_color>|true|<[nt].flag[bot_color]>|<[nt].flag[top_color]>|top|left save:map_list
            - give "nt_written_note[map=<entry[map_list].created_queue.determination.first.first>;lore=<empty>|<gray><italic>Note was written by|<dark_aqua><player.name> <gray><italic>on <dark_aqua><proc[lib_formatted_date]>]"
            - flag player notetaker.writing:!
