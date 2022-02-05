# +--------------------
# |
# |   FRAGILE GLASS
# |
# | Be careful, it shatters
# |
# +----------------------
#
# @author jumpsplat120
# @date 09/28/2021
# @denizen-build 1.2.0-b1739-REL
# @script-version 1.0
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#    * fragile_glass.dsc
#
# Usage:
#   Any arrow that collides with glass panes or glass blocks will
#   instead break through the glass. The faster the arrow is moving,
#   the more blocks it can break through. Feel free to tweak the
#   strength of glass panes/blocks, as well as the percent it is
#   slowed down by. 0 means it loses all speed, 1 means it keeps
#   it's speed, and greater than 1 means that it would actually gain
#   speed when breaking a block.
#
#   For a demo, visit here: https://www.youtube.com/watch?v=IqpOFSrBaOM

# --------------------END HEADER / START CONFIG--------------------

fw_config:
    type: data
    map:
        pane:
            strength: 1
            slowdown: 0.8
        block:
            strength: 2
            slowdown: 0.6

# --------------------END CONFIG / START CODE--------------------

fragile_windows_event:
    type: world
    debug: false
    events:
        after entity shoots bow:
            - define arrow  <context.projectile>
            - define config <script[fw_config].parsed_key[map]>
            - define weak   <[config].deep_get[block.strength].min[<[config].deep_get[pane.strength]>]>
            - define zero   <[arrow].location.with_x[0].with_y[0].with_z[0]>
            - define mag <[arrow].velocity.vector_length>
            - while <[arrow].velocity.vector_length> > <[weak]> || <[mag]> == <[arrow].velocity.vector_length>:
                - define in_front <[arrow].location.add[<[arrow].velocity.normalize>]>
                - define glass <list[<[zero].with_y[0.325]>|<[zero].with_x[0.325]>|<[zero].with_y[-0.325]>|<[zero].with_x[-0.325]>|<[zero]>].parse[add[<[in_front]>]].filter[material.advanced_matches[*glass*]]>
                - if !<[glass].is_empty>:
                    - foreach <[glass]>:
                        - modifyblock <[value]> air
                    - adjust <[arrow]> velocity:<[arrow].velocity.mul[<[config].deep_get[<[glass].first.material.name.contains_text[pane].if_true[pane].if_false[block]>.slowdown]>]>
                    - playsound <[glass].first> sound:BLOCK_GLASS_BREAK pitch:<proc[lib_random_pitch]>
                - define mag <[arrow].velocity.vector_length>
                - wait 1t
