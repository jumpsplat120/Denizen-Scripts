prepend_text:
    type: procedure
    debug: false
    definitions: text|color_map
    script:
        - define color_list <[color_map].values>
        - define color <[text].last_color>
        - define color_stack:->:<[color].equals[<empty>].if_true[<white>].if_false[<[color]>]>
        - define result <list>
        - define toggle_map <map[open=close;close=open]>
        - while true:
            - define old_list <[color_list]>
            - define color_list:!
            - define closest 999999999
            #~-~-~- REMOVE NON RELEVANT MAPS FROM LIST; FIND CLOSEST OPEN/CLOSE DELIMETER ~-~-~-#
            - foreach <[old_list]> as:map:
                - define state <[map].get[state]>
                - define search <[map].get[<[state]>]>
                - define index_of <[text].index_of[<[search]>]>
                - define first_exists <[index_of].is_more_than[0]>
                - define second_exists <[text].after[<[search]>].contains_text[<[map].get[<[toggle_map].get[<[state]>]>]>]>
                - if ( <[state]> == open and <[first_exists]> and <[second_exists]> ) or ( <[state]> == close and <[first_exists]> ):
                    - if <[index_of]> < <[closest]>:
                        - define closest_search <[search]>
                        - define closest <[index_of]>
                    - define color_list:->:<[map]>
            - while stop if:<[color_list].exists.not>
            - define old_list <[color_list]>
            - define color_list:!
            #~-~-~- FIND RELEVANT MAP ENTRY AND ADD COLORING; ADD COLORS TO STACK ~-~-~-#
            - foreach <[old_list]> as:map:
                - define state <[map].get[state]>
                - if <[map].get[<[state]>]> == <[closest_search]>:
                    - if <[state]> == open:
                        - define color_stack:->:<[map].get[color]>
                        - define map.state:close
                    - else:
                        - define color_stack <[color_stack].remove[last]>
                        - define map.state:open
                    - define result:->:<[text].before[<[closest_search]>]><[color_stack].get[<[color_stack].size>]>
                    - define text <[text].after[<[closest_search]>]>
                - define color_list:->:<[map]>
        - determine <[result].include_single[<[color_stack].get[<[color_stack].size>]><[text]>].unseparated>

colored_messages:
    type: world
    debug: false
    events:
        on player chats:
            - definemap colors:
                yellow:
                    color: <yellow>
                    state: open
                    open: &y
                    close: /&y
                blue:
                    color: <blue>
                    state: open
                    open: &b
                    close: /&b
                gold:
                    color: <gold>
                    state: open
                    open: &g
                    close: /&g
            - determine <context.message.proc[prepend_text].context[<[colors]>]>