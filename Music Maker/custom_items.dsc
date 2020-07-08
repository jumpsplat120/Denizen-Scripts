alloy_nugget:
    type: item
    material: stick
    display name: <&r>Alloy Nugget
    mechanisms:
        custom_model_data: 1
    recipes:
        1:
            type: shapeless
            output_quantity: 3
            input: iron_nugget|iron_nugget|gold_nugget
        2:
            type: shaped
            output_quantity: 9
            input:
                - alloy_ingot

alloy_ingot:
    type: item
    material: stick
    display name: <&r>Alloy Ingot
    mechanisms:
        custom_model_data: 2
    recipes:
        1:
            type: shapeless
            output_quantity: 3
            input: iron_ingot|iron_ingot|gold_ingot
        2:
            type: shaped
            output_quantity: 1
            input:
                - alloy_nugget|alloy_nugget|alloy_nugget
                - alloy_nugget|alloy_nugget|alloy_nugget
                - alloy_nugget|alloy_nugget|alloy_nugget

chisel:
    type: item
    material: wooden_sword
    display name: <&r>Chisel
    mechanisms:
        custom_model_data: 1
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|iron_ingot
                - stick|air