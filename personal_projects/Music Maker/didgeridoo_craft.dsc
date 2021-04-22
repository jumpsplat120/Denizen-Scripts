on_craft:
    type: world
    events:
        on player crafts instrument_didgeridoo:
            - flag player didge_slot:<context.inventory.find.scriptname[chisel].sub[1]>
            - define multistack_index <context.inventory.matrix.find_partial[log]>
            - if <[multistack_index].is_integer>:
                - define item <context.inventory.slot[<[multistack_index].add[1]>]>
                - if <[item].quantity> > 1:
                    - adjust def:item quantity:<[item].quantity.sub[1]>
                    - flag player didge_index_2:|:<[item]>|<[multistack_index]>
        after player crafts instrument_didgeridoo:
            - define grid <context.inventory.matrix>
            - define grid <[grid].with[]> chisel
            - flag player didge_index:!
            - adjust <context.inventory> matrix:<[grid]>
