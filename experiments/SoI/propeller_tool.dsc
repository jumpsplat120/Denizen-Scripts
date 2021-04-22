soi_propeller_data:
    type: data
    face_lut:
        west: -0.8,0,-0.3
        east: 0.7,0,-0.3
        south: 0,0,0.7
        north: 0,0,-0.8
        up: 0,0.7,-0.25
        down: 0,-0.9,-0.25
    head_lut:
        west: 0,0,<[angle]>
        east: 0,0,<[angle]>
        south: 0,0,<[angle]>
        north: 0,0,<[angle]>
        up: <util.tau.mul[.25]>,<[angle]>,0
        down: <util.tau.mul[.25]>,<[angle]>,0
    rotate_lut:
        west: 0,0,<[pose].z.add[0.01]>
        east: 0,0,<[pose].z.add[0.01]>
        south: 0,0,<[pose].z.add[0.01]>
        north: 0,0,<[pose].z.add[0.01]>
        up: <[pose].x>,<[pose].y.add[0.01]>,0
        down: <[pose].x>,<[pose].y.add[0.01]>,0

soi_propeller_events:
    type: world
    debug: false
    events:
        on player right clicks block with:soi_propeller_item:
            - define dir <proc[lib_block_face]>
            - define arm_type <tern[<[dir].is[==].to[east].or[<[dir].is[==].to[west]>]>].pass[soi_ew_propeller_arm].fail[soi_propeller_arm]>
            - spawn <[arm_type]>|<[arm_type]>|<[arm_type]>|<[arm_type]> <proc[lib_center_armor_stand_on_head].context[<context.location>].relative[<script[soi_propeller_data].data_key[face_lut.<[dir]>]>]> save:arms
            - define arms <entry[arms].spawned_entities>
            - define offset <element[1].div[<[arms].size>]>
            - foreach <[arms]> as:arm:
                - define angle <util.tau.mul[<[offset].mul[<[loop_index]>]>]>
                - adjust <[arm]> armor_pose:head|<script[soi_propeller_data].parsed_key[head_lut.<[dir]>]>
                - if <[dir]> == west || <[dir]> == east:
                    - ~rotate <[arm]> yaw:<util.tau.mul[.25].to_degrees> duration:1t
            - wait 5s
            - flag server propellers:->:<map.with[dir].as[<[dir]>].with[arms].as[<[arms]>]>
        on tick:
            - if <server.has_flag[propellers]>:
                - foreach <server.flag[propellers]> as:map:
                    - if <[map].get[arms].first.location.chunk.is_loaded>:
                        - foreach <[map].get[arms]> as:arm:
                            - define pose <[arm].armor_pose[HEAD]>
                            - adjust <[arm]> armor_pose:head|<script[soi_propeller_data].parsed_key[rotate_lut.<[map].get[dir]>]>

soi_propeller_arm:
    type: entity
    entity_type: armor_stand
    gravity: false
    visible: false
    equipment: <map.with[helmet].as[redstone]>

soi_ew_propeller_arm:
    type: entity
    entity_type: armor_stand
    gravity: false
    visible: false
    equipment: <map.with[helmet].as[redstone]>

soi_propeller_item:
    type: item
    material: stick
    display name: <reset>Propeller
    mechanisms:
        custom_model_data: 123
