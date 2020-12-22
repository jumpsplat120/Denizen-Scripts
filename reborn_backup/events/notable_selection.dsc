notable_selection:
    type: world
    debug: false
    events:
        on player right clicks block:
            - define sel_type <player.flag[selection]||false>
            - if <[sel_type]> != false:
                - choose <[sel_type]>:
                    - case location:
                        - narrate "Current selection: <context.location>"
                        - flag player selection_obj:<map.with[valid].as[true].with[data].as[<context.location>]>
                    - case cuboid:
                        - define sel_obj <player.flag[selection_obj].as_map||<map.with[valid].as[false]>>
                        - define sel_data <[sel_obj].get[data]||false>
                        - if <[sel_obj].get[valid]>:
                            - flag player selection_obj:<map.with[valid].as[true].with[data].as[<[sel_data].include[<context.location>]>]>
                            - narrate "Added <context.location> into cuboid."
                        - else if <[sel_data]> != false:
                            - define cuboid <[sel_data].to_cuboid[<context.location>]>
                            - flag player selection_obj:<map.with[valid].as[true].with[data].as[<[cuboid]>]>
                            - narrate "Created cuboid:<[cuboid].min> <&lt>-<&gt> <[cuboid].max>"
                        - else:
                            - flag player selection_obj:<map.with[valid].as[false].with[data].as[<context.location>]>
                            - narrate "Current selection: <context.location>"