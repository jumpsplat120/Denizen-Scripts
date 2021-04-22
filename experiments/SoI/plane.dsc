soi_flight_events:
    type: world
    debug: false
    events:
        on player right clicks block with:soi_plane_item:
            - spawn soi_plane_obj <context.location.up> save:vehicle
            - flag <entry[vehicle].spawned_entity> vehicle
            - if <player.gamemode> != creative:
                - take iteminhand
        on player right clicks entity_flagged:vehicle:
            - mount <player>|<context.entity>
            - flag <context.entity> accel:0
        on player steers entity:
            - if <context.entity.has_flag[vehicle]>:
                - define accel <tern[<context.jump>].pass[.2].fail[<context.entity.flag[accel]>]>
                - define head <context.entity.armor_pose[head].with_x[<proc[lib_clamp].context[-1|1.2|<[head].x.add[<context.forward.mul[-0.1]>]>]>].with_y[<[head].y.add[<context.sideways.mul[-0.1]>]>]>
                - define y_rot_vec <location[0,0,1].rotate_around_y[<[head].y.mul[-1]>]>
                - adjust <context.entity> armor_pose:head|<[head].x>,<[head].y>,0
                - adjust <context.entity> velocity:<context.entity.velocity.x.add[<[y_rot_vec].x.mul[<[accel]>]>]>,<context.entity.velocity.z.add[<[y_rot_vec].z.mul[<[accel]>]>]>,<proc[lib_clamp].context[-.75|.9|<context.entity.velocity.y.add[<[head].x.sub[0.3].mul[-0.3].mul[<context.entity.velocity.x.power[2].add[<context.entity.velocity.z.power[2]>].sqrt>]>]>]>
                - define accel <[accel].mul[<proc[lib_clamp].context[0|1|<context.entity.velocity.vector_length>]>].mul[.98]>
                - flag <context.entity> accel:<tern[<[accel].is[LESS].than[0.00001]>].pass[0].fail[<[accel]>]>

soi_plane_item:
    type: item
    material: stick
    display name: <reset>Plane
    mechanisms:
        custom_model_data: 121

soi_plane_obj:
    type: entity
    entity_type: armor_stand
    visible: false
    is_small: true
    equipment: <map.with[helmet].as[stick[custom_model_data=121]]>
    disabled_slots: CHEST|FEET|HAND|HEAD|LEGS|OFF_HAND