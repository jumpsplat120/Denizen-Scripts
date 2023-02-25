has_alpha:
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
        - determine <[element].to_lowercase.contains_any_text[a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to validate.
                required: true
        description: Returns true if passed element has any alphabetical characters in it.
        determines: elementTag
        usage:
            - narrate "The element <&dq>Hello world!<&dq> has alphabetical characters in it: <element[Hello world!].proc[has_alpha]>"
            - narrate "The element <&dq>$43.12<&dq> has alphabetical characters in it: <element[$43.12].proc[has_alpha]>"

has_numeric:
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
        - determine <[element].contains_any_text[0|1|2|3|4|5|6|7|8|9]>
    data:
        args:
            element:
                type: elementTag
                description: The element you want to validate.
                required: true
        description: Returns true if passed element has any numeric characters in it.
        determines: elementTag
        usage:
            - narrate "The element <&dq>Hello world!<&dq> has alphabetical characters in it: <element[Hello world!].proc[has_numeric]>"
            - narrate "The element <&dq>$43.12<&dq> has alphabetical characters in it: <element[$43.12].proc[has_numeric]>"


has_alphanumeric:
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
        - determine true if:<[element].proc[has_alpha]>
        - determine true if:<[element].proc[has_numeric]>
        - determine false
    data:
        args:
            element:
                type: elementTag
                description: The element you want to validate.
                required: true
        description: Returns true if passed element has any alphanumeric characters in it.
        determines: elementTag
        usage:
            - narrate "The element <&dq>Hello world!<&dq> has alphabetical characters in it: <element[Hello world!].proc[has_alphanumeric]>"
            - narrate "The element <&dq>$43.12<&dq> has alphabetical characters in it: <element[$43.12].proc[has_alphanumeric]>"

has_fake_permission:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define permission <[args.permission].if_null[]>
        - define player     <[args.element].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define permission <[args].if_null[<[null]>]> if:<[permission].equals[]>
        - define player     <player.if_null[<[null]>]> if:<[player].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[permission|<[null]>|<[permission]>|<queue>]>
        - define error <proc[error_missing_check].context[player|<[null]>|<[player]>|<queue>]>     if:<[error].not>
        - define error <proc[error_type_check].context[permission|element|<[permission]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[player|player|<[player]>|<queue>]>          if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - flag <[player]> jlib.perms:<map> if:<[player].flag[jlib.perms].exists.not>
        - define perms    <[player].flag[jlib.perms]>
        - define has_perm <[perms].deep_get[<[permission]>].if_null[false]>
        - determine true if:<[has_perm]>
        - while <[permission].contains[.]> && !<[has_perm]>:
            - define permission <[permission].before_last[.]>
            - define has_perm   <[perms].deep_get[<[permission]>.*].if_null[false]>
        - determine <[has_perm]>
    data:
        args:
            permission:
                type: elementTag
                description: The permission you want to check for.
                required: true
            player:
                type: playerTag
                description: The player you'd like to check has the permission. If no player is specified, will used the linked player. If the script does not have a linked player, then this argument IS required.
                required: false
        description: A simple system that mimics fuller scope permission systems, this proc will simply check for the existence of a permission flag on a player, and recursively check to see if any top level maps might exist as well. This can help if you, for example, have a set of custom commands you want to be able to grant permission to, without having to use a true permission system, such as luckperms or the like. There is no add/remove permission proc as those can be handled by the flag system. To give a permission, simply flag a player with a value at 'jlib.perms.<&lt>permission.path<&gt>'. A permission path that ends with an asterisk includes all permission underneath it.
        determines: elementTag
        usage:
            - flag <player> jlib.perms.my_cmds.spectate:true
            - narrate "The player currently has the permission <&lt>my_cmds.spectate<&gt>: <element[my_cmds.spectate].proc[has_fake_permission]>"
            - narrate "The player currently has the permission <&lt>my_cmds.invincible<&gt>: <element[my_cmds.invincible].proc[has_fake_permission]>"
            - flag <player> jlib.perms.my_cmds.*:true
            - narrate "The player currently has the permission <&lt>my_cmds.spectate<&gt>: <element[my_cmds.spectate].proc[has_fake_permission]>"
            - narrate "The player currently has the permission <&lt>my_cmds.invincible<&gt>: <element[my_cmds.invincible].proc[has_fake_permission]>"
