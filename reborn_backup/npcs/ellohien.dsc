ellohien:
    type: assignment
    debug: true
    actions:
        on move proximity:
            - define config <script[master_config].data_key[d1]>
            - define room <cuboid[<[config].get[cuboid].get[ellohien_room]>]>
            - if <[room].players.contains[<player>]>:
                - if <player.flag[ellohien_step]||0> < 1:
                    - define name_format <script[master_config].data_key[general.npc.name_format].parsed>
                    - run flag_list def:ellohien_step|1|<cuboid[<[config].get[cuboid].get[whole_dungeon]>].players.escaped>
                    - foreach <[config].get[ellohien].get[lines1]>:
                        - if <[loop_index]> == 1:
                            - narrate "<[name_format]> <[value].parsed>" targets:<[room].players>
                        - else:
                            - ~run wait_and_narrate def:<[name_format]>|<[value].parsed>|<[room].players.escaped>
        on spawn:
            - trigger name:proximity state:true radius:1000
    default constants:
        class: Undead
