cross_product:
    type: procedure
    debug: true
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define a <[args.a].if_null[]>
        - define b <[args.b].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define a <[null]> if:<[a].equals[]>
        - define b <[null]> if:<[b].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[a|<[null]>|<[a]>|<queue>]>
        - define error <proc[error_missing_check].context[b|<[null]>|<[b]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[a|location|<[a]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[b|location|<[b]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[a].with_x[<[a].y.mul[<[b].z>].sub[<[a].z.mul[<[b].y>]>]>].with_y[<[a].z.mul[<[b].x>].sub[<[a].x.mul[<[b].z>]>]>].with_z[<[a].x.mul[<[b].y>].sub[<[a].y.mul[<[b].x>]>]>]>
    data:
        args:
            a:
                type: locationTag
                description: The first location.
                required: true
            b:
                type: locationTag
                description: The second location.
                required: true
        description: Gets the cross product/vector product of two locations. The cross product of two vectors returns the vector that is perpendicular to the two locations. The output is in respect to the right-hand rule; that is to say, if you're holding out your thumb, forefinger and middle finger to form three axises, your forefinger will follow axis a, your middle finger will follow axis b, and your cross product will be your thumb. Therefore, if you want your result to go the "other" direction, then you need to reverse the input of a and b.
        determines: locationTag
        usage:
            - define a <player.eye_location.forward.sub[<player.eye_location>]>
            - define b <player.location.sub[<player.eye_location>]>
            - narrate "The cross product of the look vector and location of my player is <proc[cross_product].context[a=<[a]>;b=<[b]>]>"

dot_product:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define a <[args.a].if_null[]>
        - define b <[args.b].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define a <[null]> if:<[a].equals[]>
        - define b <[null]> if:<[b].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[a|<[null]>|<[a]>|<queue>]>
        - define error <proc[error_missing_check].context[b|<[null]>|<[b]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[a|location|<[a]>|<queue>]>    if:<[error].not>
        - define error <proc[error_type_check].context[b|location|<[b]>|<queue>]>    if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[a].x.mul[<[b].x>].add[<[a].y.mul[<[b].y>]>].add[<[a].z.mul[<[b].z>]>]>
    data:
        args:
            a:
                type: locationTag
                description: The first location.
                required: true
            b:
                type: locationTag
                description: The second location.
                required: true
        description: Gets the dot product of two locations. The dot product is the sum of the products of the corresponding entries of the two sequences of numbers; or in other words, x1 * x2 + y1 * y2 + z1 * z2. Some of the use cases for a dot product of two vectors can be found <&click[https://math.stackexchange.com/questions/414776/what-is-the-use-of-the-dot-product-of-two-vectors].on_click[open_url]>here<&end_click>.
        determines: elementTag
        usage:
            - define a <player.eye_location.forward.sub[<player.eye_location>]>
            - define b <player.location.sub[<player.eye_location>]>
            - narrate "The dot product of the look vector and location of my player is <proc[dot_product].context[a=<[a]>;b=<[b]>]>"

plane_normal:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define a <[args.a].if_null[]>
        - define b <[args.b].if_null[]>
        - define c <[args.c].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define a <[null]> if:<[a].equals[]>
        - define b <[null]> if:<[b].equals[]>
        - define c <[null]> if:<[c].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[a|<[null]>|<[a]>|<queue>]>
        - define error <proc[error_missing_check].context[b|<[null]>|<[b]>|<queue>]> if:<[error].not>
        - define error <proc[error_missing_check].context[c|<[null]>|<[c]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[a|location|<[a]>|<queue>]>    if:<[error].not>
        - define error <proc[error_type_check].context[b|location|<[b]>|<queue>]>    if:<[error].not>
        - define error <proc[error_type_check].context[c|location|<[c]>|<queue>]>    if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define direction <proc[cross_product].context[a=<[a].sub[<[c]>]>;b=<[b].sub[<[c]>]>]>
        - determine <[direction].normalize>
    data:
        args:
            a:
                type: locationTag
                description: The first location.
                required: true
            b:
                type: locationTag
                description: The second location.
                required: true
            c:
                type: locationTag
                description: The third location.
                required: true
        description: Taking three points to form a plane/surface, get the normal vector of that plane. A normal vector is the vector that is pependicular to the plane. For example, if you assume that you had three points representing the x/z axises as your plane, then you'd have a vector of 0,1,0, as straight up is perpendicular to the plane. As the result is derived from using the cross product of the passed vectors, the result follows the right hand rule; that is to say, if you're holding out your thumb, forefinger and middle finger to form three axises, the tip of your forefinger is vector a, the tip of your middle finger will follow axis b, the intesection between your forefinger and middle finger is vector c, and your normal is your thumb. Therefore, if you want your result to go the "other" direction, then you need to reverse the input of a and b.
        determines: locationTag
        usage:
            - define a test
            - define b <player.eye_location.random_offset[3]>
            - define c <player.eye_location.random_offset[3]>
            - define format sx/sy/sz
            - narrate "Forming a random 2d plane from <[a].format[<[format]>]>, <[b].format[<[format]>]>, and <[c].format[<[format]>]>, the normal is <proc[plane_normal].context[a=<[a]>;b=<[b]>;c=<[c]>].format[<[format]>]>"

midpoint:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define a <[args.a].if_null[]>
        - define b <[args.b].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define a <[null]> if:<[a].equals[]>
        - define b <[null]> if:<[b].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[a|<[null]>|<[a]>|<queue>]>
        - define error <proc[error_missing_check].context[b|<[null]>|<[b]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[a|location|<[a]>|<queue>]>    if:<[error].not>
        - define error <proc[error_type_check].context[b|location|<[b]>|<queue>]>    if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[a].with_x[<[a].x.add[<[b].x>].mul[0.5]>].with_y[<[a].y.add[<[b].y>].mul[0.5]>].with_z[<[a].z.add[<[b].z>].mul[0.5]>]>
    data:
        args:
            a:
                type: locationTag
                description: The first location.
                required: true
            b:
                type: locationTag
                description: The second location.
                required: true
        description: Returns the midpoint between two locations; in other words, if you were to treat a and b as forming a line, this returns the location in the middle of that line.
        determines: locationTag
        usage:
            - narrate "<proc[midpoint].context[a=<player.eye_location>;b=<player.location>].format[sx/sy/sz]> is my center."

lerp_location:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define a       <[args.a].if_null[]>
        - define b       <[args.b].if_null[]>
        - define percent <[args.percent].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define a       <[null]> if:<[a].equals[]>
        - define b       <[null]> if:<[b].equals[]>
        - define percent <[null]> if:<[percent].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[a|<[null]>|<[a]>|<queue>]>
        - define error <proc[error_missing_check].context[b|<[null]>|<[b]>|<queue>]>             if:<[error].not>
        - define error <proc[error_missing_check].context[percent|<[null]>|<[percent]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[a|location|<[a]>|<queue>]>                if:<[error].not>
        - define error <proc[error_type_check].context[b|location|<[b]>|<queue>]>                if:<[error].not>
        - define error <proc[error_type_check].context[percent|element|<[percent]>|<queue>]>     if:<[error].not>
        - define error <proc[error_number_check].context[percent|<[percent]>|<queue>]>           if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[a].mul[<[percent]>].add[<[b].mul[<element[1].sub[<[percent]>]>]>]>
    data:
        args:
            a:
                type: locationTag
                description: The first location.
                required: true
            b:
                type: locationTag
                description: The second location.
                required: true
            percent:
                type: elementTag
                description: The percentage from a to b that you'd like to get the value of.
                required: true
        description: Returns a location that is some amount of the way between location a and location b. 0 percent is equivilent to a, and 1 is equivilent to b. Values beyond 1 or below 0 will extrapolate from the line given by the two locations.
        determines: locationTag
        usage:
            - define a <player.location>
            - define b <player.eye_location>
            - narrate "<proc[lerp_location].context[a=<[a]>;b=<[b]>;percent=0.25].format[sx/sy/sz]> is halfway from my feet to my eyes."

rotate_around:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define center  <[args.center].if_null[]>
        - define axis    <[args.axis].if_null[]>
        - define percent <[args.percent].if_null[]>
        - define size    <[args.size].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define center  <[null]>   if:<[center].equals[]>
        - define percent <[null]>   if:<[percent].equals[]>
        - define axis    <[center]> if:<[axis].equals[]>
        - define size    1          if:<[size].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[center|<[null]>|<[center]>|<queue>]>
        - define error <proc[error_missing_check].context[percent|<[null]>|<[percent]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[center|location|<[center]>|<queue>]>      if:<[error].not>
        - define error <proc[error_type_check].context[axis|location|<[axis]>|<queue>]>          if:<[error].not>
        - define error <proc[error_type_check].context[percent|element|<[percent]>|<queue>]>     if:<[error].not>
        - define error <proc[error_type_check].context[size|element|<[size]>|<queue>]>           if:<[error].not>
        - define error <proc[error_number_check].context[percent|<[percent]>|<queue>]>           if:<[error].not>
        - define error <proc[error_number_check].context[size|<[size]>|<queue>]>                 if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define tau <util.tau.mul[<[percent]>]>
        - determine <[center].with_pitch[<[axis].pitch>].with_yaw[<[axis].yaw>].left[<[tau].cos.mul[<[size]>]>].up[<[tau].sin.mul[<[size]>]>]>
    data:
        args:
            center:
                type: locationTag
                description: The center of the rotation.
                required: true
            percent:
                type: elementTag
                description: The amount of rotation around the circle you'd like to move. 0 and 1 will return the same value, and values beyond 1 or less than 0 will be extrapolated. The start/end point of the circle is based on the pitch/yaw provided by the axis; that is to say, for a pitch of 0 and a yaw of 0, the start point is towards positive X.
                required: true
            axis:
                type: locationTag
                description: The axis of rotation you'd like to rotate around. If no axis is provided, then the pitch/yaw of the center point provided is used. If the location is derived mathmatically, or pulled from a non entity, than generally the pitch and yaw will equal zero, giving a rotation around the Z axis. However, if the center location is pulled from an entity, then it's likely that the rotation of the entity will have an effect.
                required: false
            size:
                type: elementTag
                description: The size of the circle you'd like to make. If no value is provided, defaults to a size of 1.
                required: false
        description: Given a center location, usually an axis, and some percent value, rotate around the axis. The axis is determined off of the pitch/yaw, rather than using the location as a vector, as may be expected. Size is based on blocks, so a size of 1 is equivilant to a radius of 1 block.
        determines: locationTag
        usage:
            - define seconds   5
            - define particles 20
            - narrate "I'm a good Denizzle!"
            - repeat <[seconds].mul[20]>:
                - define locations:!
                - repeat <[particles]>:
                    - define locations:->:<proc[rotate_around].context[center=<player.eye_location.up[0.4].with_pitch[<player.eye_location.pitch.add[90]>]>;percent=<[value].div[<[particles]>]>;size=0.5]>
                - playeffect at:<[locations]> effect:redstone special_data:0.5|yellow offset:0
                - wait 1t

to_pitch_yaw:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define location <[args.location].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define location  <[args].if_null[<[null]>]> if:<[location].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[location|<[null]>|<[location]>|<queue>]>
        - define error <proc[error_type_check].context[location|location|<[location]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define normal <[location].normalize>
        - determine <[location].with_pitch[<[normal].y.asin.to_degrees.mul[-1]>].with_yaw[<[normal].z.atan2[<[normal].x>].to_degrees>]>
    data:
        args:
            normal:
                type: locationTag
                description: The location to pitch/yawify.
                required: true
        description: Takes a location, and returns the same location with the pitch/yaw modified, based on the location's position relative to 0,0,0. In other words, if a player's eyes were at 0,0,0, and they were looking towards the location provided, the pitch/yaw of the player is what we are attempting to get.
        determines: locationTag
        usage:
            - narrate "A location of 0,1,0 is pitch/yawified into <location[0,1,0].proc[to_pitch_yaw].format[pitch: spitch, yaw: syaw]>."

ease_location:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define start     <[args.start].if_null[]>
        - define end       <[args.end].if_null[]>
        - define percent   <[args.percent].if_null[]>
        - define type      <[args.ease_type].if_null[]>
        - define direction <[args.direction].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define start     <[null]> if:<[start].equals[]>
        - define end       <[null]> if:<[end].equals[]>
        - define percent   <[null]> if:<[percent].equals[]>
        - define type      sine     if:<[type].equals[]>
        - define direction in       if:<[direction].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[start|<[null]>|<[start]>|<queue>]>
        - define error <proc[error_missing_check].context[end|<[null]>|<[end]>|<queue>]>         if:<[error].not>
        - define error <proc[error_missing_check].context[percent|<[null]>|<[percent]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[start|location|<[start]>|<queue>]>        if:<[error].not>
        - define error <proc[error_type_check].context[end|location|<[end]>|<queue>]>            if:<[error].not>
        - define error <proc[error_type_check].context[percent|element|<[percent]>|<queue>]>     if:<[error].not>
        - define error <proc[error_type_check].context[type|element|<[type]>|<queue>]>           if:<[error].not>
        - define error <proc[error_type_check].context[direction|element|<[direction]>|<queue>]> if:<[error].not>
        - define error <proc[error_number_check].context[percent|<[percent]>|<queue>]>           if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - definemap map:
            percent: <[percent]>
            type: <[type]>
            direction: <[direction]>
        - determine <[start].with_x[<[map].with[start].as[<[start].x>].with[end].as[<[end].x>].proc[ease_numeric]>].with_y[<[map].with[start].as[<[start].y>].with[end].as[<[end].y>].proc[ease_numeric]>].with_z[<[map].with[start].as[<[start].z>].with[end].as[<[end].z>].proc[ease_numeric]>]>
    data:
        args:
            start:
                type: locationTag
                description: The starting location.
                required: true
            end:
                type: locationTag
                description: The location to ease towards.
                required: true
            percent:
                type: elementTag
                description: A percent value representing how far along the ease you want to go.
                required: true
            type:
                type: elementTag
                description: The type of ease that you want to do; sine, quad, cubic, quart, quint, exp, circ, back, elastic or bounce. Defaults to sine.
                required: false
            direction:
                type: elementTag
                description: The direction you'd like to ease; in, out or both. Defaults to in.
                required: false
        description: Takes two locations, and eases from one location to the next. The process of easing is like lerp, but instead of it being linear, the interpolation is whatever was specified in 'type'. There are a number of eases, and the best way to determine what fits your use case is to check <&click[https://easings.net/].type[open_url]>easings.net<&end_click>, which will show you a visual example of what the easing process looks like. Values below 0 or above 1 are extrapolated, but, since it is not linear, may quickly go to places unexpected.
        determines: locationTag
        usage:
            - define start <player.eye_location.forward[1].left[1]>
            - define end <player.eye_location.forward[1].right[1]>
            - narrate "The following is a particle easing from left to right over 2 seconds."
            - repeat 40:
                - playeffect at:<[start]> effect:redstone special_data:0.7|green offset:0
                - playeffect at:<[end]> effect:redstone special_data:0.7|red offset:0
                - playeffect at:<proc[ease_location].context[start=<[start]>;end=<[end]>;percent=<[value].div[40]>]> effect:redstone special_data:0.5|blue offset:0
                - wait 1t

location_in_cuboid:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define location <[args.location].if_null[]>
        - define low      <[args.low].if_null[]>
        - define high     <[args.high].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define location <[null]> if:<[location].equals[]>
        - define low      <[null]> if:<[low].equals[]>
        - define high     <[null]> if:<[high].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[location|<[null]>|<[location]>|<queue>]>
        - define error <proc[error_missing_check].context[low|<[null]>|<[low]>|<queue>]>        if:<[error].not>
        - define error <proc[error_missing_check].context[high|<[null]>|<[high]>|<queue>]>      if:<[error].not>
        - define error <proc[error_type_check].context[location|location|<[location]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[low|location|<[low]>|<queue>]>           if:<[error].not>
        - define error <proc[error_type_check].context[high|location|<[high]>|<queue>]>         if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine false if:<[low].x.is_less_than_or_equal_to[<[location].x>].and[<[high].x.is_more_than_or_equal_to[<[location].x>]>].not>
        - determine false if:<[low].y.is_less_than_or_equal_to[<[location].y>].and[<[high].y.is_more_than_or_equal_to[<[location].y>]>].not>
        - determine false if:<[low].z.is_less_than_or_equal_to[<[location].z>].and[<[high].z.is_more_than_or_equal_to[<[location].z>]>].not>
        - determine true
    data:
        args:
            location:
                type: locationTag
                description: The location you want to see is contained in a cuboid.
                required: true
            low:
                type: locationTag
                description: The point of the cuboid with the highest values. For example, if you have a cuboid that goes between 0,0,0 and 1,1,1, the low point is the 0,0,0.
                required: true
            high:
                type: locationTag
                description: The point of the cuboid with the highest values. For example, if you have a cuboid that goes between 0,0,0 and 1,1,1, the high point is the 1,1,1.
                required: true
        description: Takes a location, and returns whether or not it is contained within a cuboid. The reason this doesn't use cuboidTags is because cuboid tags don't hold precision. If you wanted one that goes from 0,0,0 to 0.5,0.5,0.5, you'll find that your cuboid becomes "rounded" to just be 0,0,0 -> 0,0,0. This can be a problem if you're trying to do something, like see if a point is within an entities bounding box. The world, pitch, and yaw of any of the locations are not regarded when calculating.
        determines: elementTag
        usage:
            - define point <player.eye_location.forward>
            - define nearest <player.location.find_entities[!player].within[10]>
            - if <[nearest].any>:
                - define entity <[nearest].get[1]>
                - define bounds <[entity].bounding_box>
                - define entity_type <[entity].entity_type.replace_text[_].with[<&sp>].to_titlecase>
                - define point_in_bounds <proc[location_in_cuboid].context[location=<[point]>;low=<[bounds].first>;high=<[bounds].last>]>
                - narrate "Is the point in front of my eyes is inside the nearby <[entity_type]>?"
                - if <[point_in_bounds]>:
                    - narrate "Yes it is!"
                - else:
                    - narrate "No it is not."
            - else:
                - narrate "There are no entities nearby to compare against."

adjacent_blocks:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define location          <[args.location].if_null[]>
        - define exclude_air       <[args.exclude_air].if_null[]>
        - define exclude_lava      <[args.exclude_lava].if_null[]>
        - define exclude_water     <[args.exclude_water].if_null[]>
        - define exclude_non_solid <[args.exclude_non_solid].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define location          <[args].if_null[<[null]>]> if:<[location].equals[]>
        - define exclude_air       false if:<[exclude_air].equals[]>
        - define exclude_lava      false if:<[exclude_lava].equals[]>
        - define exclude_water     false if:<[exclude_water].equals[]>
        - define exclude_non_solid false if:<[exclude_non_solid].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[location|<[null]>|<[location]>|<queue>]>
        - define error <proc[error_type_check].context[location|location|<[location]>|<queue>]>                  if:<[error].not>
        - define error <proc[error_type_check].context[exclude_air|element|<[exclude_air]>|<queue>]>             if:<[error].not>
        - define error <proc[error_type_check].context[exclude_lava|element|<[exclude_lava]>|<queue>]>           if:<[error].not>
        - define error <proc[error_type_check].context[exclude_water|element|<[exclude_water]>|<queue>]>         if:<[error].not>
        - define error <proc[error_type_check].context[exclude_non_solid|element|<[exclude_non_solid]>|<queue>]> if:<[error].not>
        - define error <proc[error_boolean_check].context[exclude_air|<[exclude_air]>|<queue>]>                  if:<[error].not>
        - define error <proc[error_boolean_check].context[exclude_lava|<[exclude_lava]>|<queue>]>                 if:<[error].not>
        - define error <proc[error_boolean_check].context[exclude_water|<[exclude_water]>|<queue>]>               if:<[error].not>
        - define error <proc[error_boolean_check].context[exclude_non_solid|<[exclude_non_solid]>|<queue>]>       if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - foreach <list[1,0,0|0,1,0|0,0,1|-1,0,0|0,-1,0|0,0,-1]>:
            - define result:->:<[location].add[<[value]>]>
        - determine <[result].filter[material.is_solid]> if:<[exclude_non_solid]>
        - define result <[result].filter[advanced_matches[*air].not]> if:<[exclude_air]>
        - define result <[result].filter[advanced_matches[*water].not]> if:<[exclude_water]>
        - define result <[result].filter[advanced_matches[*lava].not]> if:<[exclude_lava]>
        - determine <[result]>
    data:
        args:
            location:
                type: locationTag
                description: The location you want to get the adjacent blocks to.
                required: true
            exclude_air:
                type: elementTag
                description: A boolean that lets you exclude locations that do not have a block. Defaults to false.
                required: false
            exclude_water:
                type: elementTag
                description: A boolean that lets you exclude locations that have a water like material. Defaults to false.
                required: false
            exclude_lava:
                type: elementTag
                description: A boolean that lets you exclude locations that have a lava like material. Defaults to false.
                required: false
            exclude_non_solid:
                type: elementTag
                description: A boolean that lets you exclude locations that have non solid materials. This flag effectively overwrites all the others, as water, lava, and air are all non solid materials. Defaults to false.
                required: false
        description: Returns the locations that are adjacent to the location that was passed.
        determines: listTag<&gt>locationTag<&lt>
        usage:
            - define point <player.location.below[2].random_offset[3]>
            - define adjacent <proc[adjacent_blocks].context[location=<[point]>;exclude_non_solid=true]>
            - narrate "Is the point <[point].format[sx/sy/sz]> surrounded by solid blocks?"
            - if <[adjacent].size> == 6:
                - narrate "Yes it is! All six sides have solid materials!"
            - else:
                - narrate "No it isn't. There are <[adjacent].size.sub[6].abs> non solid blocks adjacent to it."

icosphere:
    type: procedure
    debug: false
    definitions: subdivisions
    script:
        - define lookup <map>
        - define verts:->:<static[<location[-1,1.618033988749895,0].normalize>]>
        - define verts:->:<static[<location[1,1.618033988749895,0].normalize>]>
        - define verts:->:<static[<location[-1,-1.618033988749895,0].normalize>]>
        - define verts:->:<static[<location[1,-1.618033988749895,0].normalize>]>
        - define verts:->:<static[<location[0,-1,1.618033988749895].normalize>]>
        - define verts:->:<static[<location[0,1,1.618033988749895].normalize>]>
        - define verts:->:<static[<location[0,-1,-1.618033988749895].normalize>]>
        - define verts:->:<static[<location[0,1,-1.618033988749895].normalize>]>
        - define verts:->:<static[<location[1.618033988749895,0,-1].normalize>]>
        - define verts:->:<static[<location[1.618033988749895,0,1].normalize>]>
        - define verts:->:<static[<location[-1.618033988749895,0,-1].normalize>]>
        - define verts:->:<static[<location[-1.618033988749895,0,1].normalize>]>
        - define faces:->:<static[<list[1|12|6]>]>
        - define faces:->:<static[<list[1|6|2]>]>
        - define faces:->:<static[<list[1|2|8]>]>
        - define faces:->:<static[<list[1|8|11]>]>
        - define faces:->:<static[<list[1|11|12]>]>
        - define faces:->:<static[<list[2|6|10]>]>
        - define faces:->:<static[<list[6|12|5]>]>
        - define faces:->:<static[<list[12|11|3]>]>
        - define faces:->:<static[<list[11|8|7]>]>
        - define faces:->:<static[<list[8|2|9]>]>
        - define faces:->:<static[<list[4|10|5]>]>
        - define faces:->:<static[<list[4|5|3]>]>
        - define faces:->:<static[<list[5|3|7]>]>
        - define faces:->:<static[<list[4|7|9]>]>
        - define faces:->:<static[<list[4|9|10]>]>
        - define faces:->:<static[<list[5|10|6]>]>
        - define faces:->:<static[<list[3|5|12]>]>
        - define faces:->:<static[<list[7|3|11]>]>
        - define faces:->:<static[<list[9|7|8]>]>
        - define faces:->:<static[<list[10|9|2]>]>
        - repeat <[subdivisions]>:
            - define face_subdivisions <list>
            - foreach <[faces]> as:triangle:
                - define new_verts <list>
                - foreach 1,2|2,3|3,1 as:tuple:
                    - define indices <[tuple].split[,]>
                    - define i1 <[triangle].get[<[indices].first>]>
                    - define i2 <[triangle].get[<[indices].last>]>
                    - define min <[i1].min[<[i2]>]>
                    - define max <[i1].max[<[i2]>]>
                    - define key <[min]>_<[max]>
                    - if not <[lookup.<[key]>].exists>:
                        - define verts:->:<proc[midpoint].context[a=<[verts].get[<[min]>]>;b=<[verts].get[<[max]>]>].normalize>
                        - define lookup.<[key]>:<[verts].size>
                    - define new_verts:->:<[lookup.<[key]>]>
                - define face_subdivisions:->:<list[<[triangle].get[1]>|<[new_verts].get[1]>|<[new_verts].get[3]>]>
                - define face_subdivisions:->:<list[<[triangle].get[2]>|<[new_verts].get[2]>|<[new_verts].get[1]>]>
                - define face_subdivisions:->:<list[<[triangle].get[3]>|<[new_verts].get[3]>|<[new_verts].get[2]>]>
                - define face_subdivisions:->:<list[<[new_verts].get[1]>|<[new_verts].get[2]>|<[new_verts].get[3]>]>
            - define faces <[face_subdivisions]>
        - determine <[verts]>
    data:
        usage:
            - define points <proc[icosphere].context[3].parse[add[<player.eye_location.forward[1]>].with_world[<player.location.world>]]>
            - repeat 5:
                - repeat 20:
                    - playeffect effect:redstone at:<[points]> offset:0 special_data:0.5|red
                    - wait 1t