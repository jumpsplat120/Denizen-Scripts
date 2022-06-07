##IgnoreWarning tag_trace_failure
##IgnoreWarning bad_tag_part
# lerp: Lerp between first and second location, at a certain percentage
# ease: ease between first and second location, at a certain percentage, with a specified type and direction
# cross_product: Get the cross product between two locations.
# plane_normal: Get a location that is a perpendicular normal vector formed from 3 points forming a plane.
# midpoint: Get the midpoint between two locations.
# perpendicular: Get a perpendicular point of any arbitrary length from three points.
# rotate_a_around_b: Rotate point a around point b a certain percentage. 1 == a full rotation, 0.5 is half a rotation. Rotates clockwise.
# slerp: Denizen style slerp between two points. Percentage is how much rotation there is, and tension is how close to a flat line it is. 0 is no tension, which is just a circle where it rotates about the midpoint, and as tension approaches infinity, it gets flatter and flatter. angle is the rotation of rotation, which informs on which plane we are rotating about.
# to_pitch_yaw: Takes a vector, normalizes it, and calculates the pitch/yaw, then reapplies it to the passed vector. This allows you to take a vector with no direction and give it a "forward" direction, so that you can use direction tags.
# rotate_around: Provide a point, and a direction vector that has a pitch/yaw, and rotate around. 0 == 1, and 0.5 is a half rotation around the center.
# rotation_range: Take a location, and return the same location with the pitch and yaw snapped to a offset. For example, if the you passed a yaw of 90, and the rotation was 92, then it would snap to 90. Pass a value of zero if you don't want it to snap.
# adjacent_blocks: Helper function that gets all the blocks adjacent to a location. Faster than using a .find function, since it's just doing some basic vector math. Does NOT return the location itself.
# surrounding_blocks: Helper function that gets all the blocks that surround a location, including corners. Does NOT return the location itself.

lib_cross_product:
    type: procedure
    debug: false
    definitions: a|b
    script:
        - determine <[a].with_x[<[a].y.*[<[b].z>].-[<[a].z.*[<[b].y>]>]>].with_y[<[a].z.*[<[b].x>].-[<[a].x.*[<[b].z>]>]>].with_z[<[a].x.*[<[b].y>].-[<[a].y.*[<[b].x>]>]>]>

lib_dot_product:
    type: procedure
    debug: false
    definitions: a|b
    script:
        - determine <[a].x.*[<[b].x>].+[<[a].y.*[<[b].y>]>].+[<[a].z.*[<[b].z>]>]>

lib_plane_normal:
    type: procedure
    debug: false
    definitions: a|b|c
    script:
        - define direction <[b].sub[<[a]>].proc[lib_cross_product].context[<[c].sub[<[a]>]>]>
        - determine <[direction].div[<[direction].length>].normalize>

lib_midpoint:
    type: procedure
    debug: false
    definitions: a|b
    script:
        - determine <[a].with_x[<[a].x.+[<[b].x>].*[0.5]>].with_y[<[a].y.+[<[b].y>].*[0.5]>].with_z[<[a].z.+[<[b].z>].*[0.5]>]>

lib_perpendicular:
    type: procedure
    debug: false
    definitions: a|b|c|length
    script:
        - determine <[a].proc[lib_midpoint].context[<[b]>].add[<[a].proc[lib_plane_normal].context[<[b]>|<[c]>].mul[<[length]>]>]>

lib_nlerp:
    type: procedure
    debug: false
    definitions: a|b|percent
    script:
        - determine <[a].proc[lib_lerp].context[<[b]>|<[percent]>].normalize>

lib_slerp:
    type: procedure
    debug: false
    definitions: a|b|center|percent
    script:
        - define c <[a].sub[<[center]>]>
        - define d <[b].sub[<[center]>]>
        - define omega <[c].proc[lib_dot_product].context[<[d]>].div[<[a].distance[<[center]>].power[2]>].acos>
        - define sin <[omega].sin>
        - determine <[center].add[<[c].mul[<element[1].-[<[percent]>].*[<[omega]>].sin./[<[sin]>]>]>].add[<[d].mul[<[percent].*[<[omega]>].sin./[<[sin]>]>]>]>

lib_lerp:
    type: procedure
    debug: false
    definitions: a|b|percent
    script:
        - determine <[a].mul[<[percent]>].add[<[b].mul[<element[1].sub[<[percent]>]>]>]>

lib_rotate_around:
    type: procedure
    debug: false
    definitions: center|axis|size|percent
    script:
        - determine <[center].with_pitch[<[axis].pitch>].with_yaw[<[axis].yaw>].left[<util.tau.mul[<[percent]>].cos.mul[<[size]>]>].up[<util.tau.mul[<[percent]>].sin.mul[<[size]>]>]>

lib_get_some_rotation_points:
    type: procedure
    debug: false
    definitions: value|start|end|axis|size|density|rate
    script:
        - repeat <[density].sub[1]> as:i:
            - define progress <[i].div[<[density]>]>
            - define points:->:<[start].proc[lib_lerp].context[<[end]>|<[progress]>].proc[lib_rotate_around].context[<[axis]>|<[size]>|<[value].sub[<[progress]>].div[<[rate]>]>]>
        - define points:->:<[start].proc[lib_rotate_around].context[<[axis]>|<[size]>|<[value].div[<[rate]>]>]>
        - determine <[points]>

lib_ease_location:
    type: procedure
    debug: false
    definitions: percent|a|b|type|dir
    script:
        - determine <[a]> if:<[percent].is_less_than_or_equal_to[0]>
        - determine <[b]> if:<[percent].is_more_than_or_equal_to[1]>
        - determine <[a].with_x[<proc[lib_ease].context[<[percent]>|<[type]>|<[dir]>|<[a].x>|<[b].x>]>].with_y[<proc[lib_ease].context[<[percent]>|<[type]>|<[dir]>|<[a].y>|<[b].y>]>].with_z[<proc[lib_ease].context[<[percent]>|<[type]>|<[dir]>|<[a].z>|<[b].z>]>]>

lib_to_pitch_yaw:
    type: procedure
    debug: false
    definitions: dir
    script:
        - define n <[dir].normalize>
        - determine <[dir].with_pitch[<[n].y.asin.to_degrees.mul[-1]>].with_yaw[<[n].z.atan2[<[n].x>].to_degrees.sub[90]>]>

lib_loc_in_box:
    type: procedure
    debug: false
    definitions: a|low|high
    script:
        - determine false if:<[low].x.is_less_than_or_equal_to[<[a].x>].and[<[high].x.is_more_than_or_equal_to[<[a].x>]>].not>
        - determine false if:<[low].y.is_less_than_or_equal_to[<[a].y>].and[<[high].y.is_more_than_or_equal_to[<[a].y>]>].not>
        - determine false if:<[low].z.is_less_than_or_equal_to[<[a].z>].and[<[high].z.is_more_than_or_equal_to[<[a].z>]>].not>
        - determine true

lib_rotation_snap:
    type: procedure
    debug: false
    definitions: a|pitch|yaw
    script:
        - determine <[a].with_pitch[<proc[lib_round_to].context[input=<[a].pitch>;to=<[pitch]>].if_null[<[a].pitch>]>].with_yaw[<proc[lib_round_to].context[input=<[a].yaw>;to=<[yaw]>].if_null[<[a].yaw>]>]>

lib_adjacent_blocks:
    type: procedure
    debug: false
    definitions: location
    script:
        - foreach <list[1,0,0|0,1,0|0,0,1|-1,0,0|0,-1,0|0,0,-1]>:
            - define result:->:<[location].add[<[value]>]>
        - determine <[result]>

lib_surrounding_blocks:
    type: procedure
    debug: false
    definitions: location
    script:
        - determine <[location].add[-1,-1,-1].to_cuboid[<[location].add[1,1,1]>].blocks.exclude[<[location]>]>
