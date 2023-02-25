is_alpha:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].to_lowercase.matches_character_set[abcdefghijklmnopqrstuvwxyz]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to check.
                required: true
        description: Returns true if passed element is composed solely of alphabetical characters.
        determines: elementTag
        usage:
            - narrate "The element <&dq>Hello<&dq> is composed only of alphabetical characters: <element[Hello].proc[is_alpha]>"
            - narrate "The element <&dq>Hello world!<&dq> is composed only of alphabetical characters: <element[Hello world!].proc[is_alpha]>"

is_numeric:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].to_lowercase.matches_character_set[0123456789]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to check.
                required: true
        description: Returns true if passed element is composed solely of numeric characters.
        determines: elementTag
        usage:
            - narrate "The element <&dq>123<&dq> is composed only of numeric characters: <element[123].proc[is_numeric]>"
            - narrate "The element <&dq>122.01<&dq> is composed only of numeric characters: <element[122.01].proc[is_numeric]>"


is_alphanumeric:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define element <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define element <[args].if_null[<[null]>]> if:<[element].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[element|<[null]>|<[element]>|<queue>]>
        - define error <proc[error_type_check].context[element|element|<[element]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[element].to_lowercase.matches_character_set[abcdefghijklmnopqrstuvwxyz0123456789]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to check.
                required: true
        description: Returns true if passed element is composed solely of alphanumeric characters.
        determines: elementTag
        usage:
            - narrate "The element <&dq>Hunter2<&dq> is composed only of alphanumeric characters: <element[hunter2].proc[is_alphanumeric]>"
            - narrate "The element <&dq>My name is jumpsplat120<&dq> is composed only of alphanumeric characters: <element[My name is jumpsplat120].proc[is_alphanumeric]>"

is_touching_material:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define location  <[args.location].if_null[]>
        - define direction <[args.direction].if_null[]>
        - define material  <[args.material].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define location <[null]> if:<[location].equals[]>
        - define direction <[null]> if:<[direction].equals[]>
        - define material <[null]> if:<[material].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[location|<[null]>|<[location]>|<queue>]>
        - define error <proc[error_missing_check].context[direction|<[null]>|<[direction]>|<queue>]>    if:<[error].not>
        - define error <proc[error_missing_check].context[material|<[null]>|<[material]>|<queue>]>      if:<[error].not>
        - define error <proc[error_type_check].context[location|location|<[location]>|<queue>]>         if:<[error].not>
        - define error <proc[error_type_check].context[direction|element|<[direction]>|<queue>]>        if:<[error].not>
        - define error <proc[error_type_check].context[material|material,element|<[material]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[location].relative[<[direction].proc[face_to_vector]>].material.equals[<[material]>]> if:<[material].object_type.equals[material]>
        - determine <[location].relative[<[direction].proc[face_to_vector]>].material.advanced_matches[<[material]>]>
    data:
        args:
            location:
                type: locationTag
                description: The location of the intitial block.
                required: true
            direction:
                type: elementTag
                description: The direction (up/down/north/east...) relative to the block that you want to move.
                required: true
            material:
                type: materialTag|elementTag
                description: The material you want to compare against. If the passed object is an elementTag, it will be advanced_matched rather than directly compared.
                required: true
        description: Returns true if the material of a location relative to the initial location matches the one provided.
        determines: elementTag
        usage:
            - narrate "The block I am looking at is sitting on dirt: <proc[is_touching_material].context[location=<player.cursor_on_solid>;direction=down;material=dirt]>"

is_air:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define location <[args.location].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define location <[args].if_null[<[null]>]> if:<[location].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[location|<[null]>|<[location]>|<queue>]>
        - define error <proc[error_type_check].context[location|location|<[location]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[location].material.advanced_matches[*air]>
    data:
        args:
            location:
                type: locationTag
                description: The location you wish to check.
                required: true
        description: Returns true if a material is one of the multiple types of air in minecraft.
        determines: elementTag
        usage:
            - narrate "My player's head is currently in a block of air: <player.eye_location.proc[is_air]>"

is_chicken_jockey:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define entity <[args.entity].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define entity <[args].if_null[<[null]>]> if:<[entity].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[entity|<[null]>|<[entity]>|<queue>]>
        - define error <proc[error_type_check].context[entity|entity|<[entity]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - if <[entity]> matches zombie:
            - determine false if:<[entity].is_baby.not>
            - determine <[entity].vehicle.advanced_matches[chicken].if_null[false]>
        - if <[entity]> matches chicken:
            - determine false if:<[entity].is_empty>
            - determine false if:<[entity].passenger.advanced_matches[zombie].not>
            - determine <[entity].passenger.is_baby.if_null[false]>
        - determine false
    data:
        args:
            entity:
                type: entityTag
                description: The entity you'd like to check is part of a chicken jockey.
                required: true
        description: Returns true if an entity is part of a chicken jockey (a baby zombie riding a chicken). Does not check if it's a naturally generated chicken jockey, but only if the stack of entities forms one.
        determines: elementTag
        usage:
            - narrate "I'm currently looking at a chicken jockey: <player.eye_location.ray_trace[range=10;entities=*].proc[is_chicken_jockey]>"

is_spider_jockey:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define entity <[args.entity].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define entity <[args].if_null[<[null]>]> if:<[entity].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[entity|<[null]>|<[entity]>|<queue>]>
        - define error <proc[error_type_check].context[entity|entity|<[entity]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[entity].vehicle.advanced_matches[*spider].if_null[false]>           if:<[entity].advanced_matches[*skeleton|stray]>
        - determine <[entity].passenger.advanced_matches[*skeleton|stray].if_null[false]> if:<[entity].advanced_matches[*spider]>
        - determine false
    data:
        args:
            entity:
                type: entityTag
                description: The entity you'd like to check is part of a spider jockey.
                required: true
        description: Returns true if an entity is part of a spider jockey (a skeleton/stray riding a spider). Does not check if it's a naturally generated spider jockey, but only if the stack of entities forms one.
        determines: elementTag
        usage:
            - narrate "I'm currently looking at a spider jockey: <player.eye_location.ray_trace[range=10;entities=*].proc[is_spider_jockey]>"

is_skeleton_horseman:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define entity <[args.entity].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define entity <[args].if_null[<[null]>]> if:<[entity].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[entity|<[null]>|<[entity]>|<queue>]>
        - define error <proc[error_type_check].context[entity|entity|<[entity]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <[entity].vehicle.advanced_matches[skeleton_horse].if_null[false]>    if:<[entity].advanced_matches[*skeleton|stray]>
        - determine <[entity].passenger.advanced_matches[*skeleton|stray].if_null[false]> if:<[entity].advanced_matches[skeleton_horse]>
        - determine false
    data:
        args:
            entity:
                type: entityTag
                description: The entity you'd like to check is part of a skeleton horseman.
                required: true
        description: Returns true if an entity is part of a skeleton horseman (a skeleton/stray riding a skeleton horse). Does not check if it's a naturally generated skeleton horseman, but only if the stack of entities forms one.
        determines: elementTag
        usage:
            - narrate "I'm currently looking at a skeleton horseman: <player.eye_location.ray_trace[range=10;entities=*].proc[is_skeleton_horseman]>"
