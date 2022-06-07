custom_potion:
    type: command
    debug: false
    name: custom_potion
    description: Gives you a potion with the specified name and effects. The effect_type needs to be got from the potion_effect_type enum. The amplifier is a number. The duration is in ticks. Ambient is a boolean. show_particles is a boolean. Icon is a boolean. You can add multiple effects, by simple repeating the set of effect values.
    usage: /custom_potion [<&lt>name<&gt>] [<&lt>color<&gt>] <&lt>effect_type<&gt> <&lt>effect_amplifier<&gt> <&lt>effect_duration<&gt> <&lt>ambient<&gt> <&lt>show_particles<&gt> <&lt>icon<&gt>
    aliases:
        - potion
    tab complete:
        # When you type the first letter, there's now a new argument, so it tab completes for the next argument. This checks
        # if there is a space after the expected argument, and if so, *then* it tab completes for the next argument. Otherwise
        # it assumes you're trying to tab complete for the current argument.
        - define index <context.args.size.add[<context.raw_args.ends_with[<&sp>].if_true[-2].if_false[-3]>]>
        - if <[index]> == -2 or <context.args.is_empty>:
            - determine <util.list_numbers_to[10].parse_tag[<util.random.duuid.after[DUUID_]>]>
        - else if <[index]> == -1:
            - determine <util.list_numbers_to[10].parse_tag[<color[random].hex>]>
        - else:
            - choose <[index].mod[6]>:
                - case 0:
                    - determine <server.potion_effect_types>
                - case 1 2:
                    - determine <util.list_numbers_to[100]>
                - case 3 4 5:
                    - determine true|false
    script:
        - if <context.source_type> == PLAYER:
            - if <player.is_op>:
                - define arg_amount <context.args.size.sub[2]>
                - if <[arg_amount].mod[6]> == 0:
                    - define item <item[potion].with[display=<reset><context.args.get[1].parsed>]>
                    - define effects:->:<map[type=AWKWARD;upgraded=false;extended=false;color=<color[<context.args.get[2]>]>]>
                    - repeat <[arg_amount].div[6]>:
                        - define value:--
                        - define value:*:6
                        - define value:+:2
                        - define effects:->:<map[type=<context.args.get[<[value].add[1]>]>;amplifier=<context.args.get[<[value].add[2]>]>;duration=<context.args.get[<[value].add[3]>]>t;ambient=<context.args.get[<[value].add[4]>]>;particles=<context.args.get[<[value].add[5]>]>;icon=<context.args.get[<[value].add[6]>]>]>
                    - give <[item].with[potion_effects=<[effects]>]>
                - else:
                    - narrate "<red> Invalid amount of arguments!"
            - else:
                - narrate "<red> Only op's are allowed to run this command!"
        - else:
            - narrate "<red>This command can only be run by players!"