# custom_model_data: 1 => Alloy Nugget
# custom_model_data: 2 => Alloy Ingot

part_banjo_1:
    type: item
    material: stick
    display name: <&r>Banjo Drum
    mechanisms:
        custom_model_data: 3
    recipes:
        1:
            type: shaped
            input:
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|leather|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks

part_banjo_2:
    type: item
    material: stick
    display name: <&r>Banjo Neck
    mechanisms:
        custom_model_data: 4
    recipes:
        1:
            type: shaped
            input:
                - air|stick|string
                - stick|string|stick
                - string|stick|air

part_basedrum_1:
    type: item
    material: stick
    display name: <&r>Bass Drum Head
    mechanisms:
        custom_model_data: 5
    recipes:
        1:
            type: shaped
            input:
                - leather|leather|leather
                - leather|leather|leather

part_bass_1:
    type: item
    material: stick
    display name: <&r>Bass Neck
    mechanisms:
        custom_model_data: 6
    recipes:
        1:
            type: shaped
            input:
                - air|iron_nugget|string
                - iron_nugget|string|iron_nugget
                - string|iron_nugget|air

part_bass_2:
    type: item
    material: stick
    display name: <&r>Bass Body
    mechanisms:
        custom_model_data: 7
    recipes:
        1:
            type: shaped
            input:
                - air|iron_nugget|air
                - iron_nugget|redstone|iron_nugget
                - iron_nugget|iron_nugget|air

part_chime_1:
    type: item
    material: stick
    display name: <&r>Chime Tube
    mechanisms:
        custom_model_data: 8
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget
                - iron_nugget
                - iron_nugget

part_flute_1:
    type: item
    material: stick
    display name: <&r>Flute Head
    mechanisms:
        custom_model_data: 9
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|air|iron_nugget
                - air|air|air
                - iron_nugget|iron_nugget|iron_nugget

part_flute_2:
    type: item
    material: stick
    display name: <&r>Flute Body
    mechanisms:
        custom_model_data: 10
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|iron_nugget|iron_nugget
                - iron_ingot|iron_ingot|iron_ingot

part_guitar_1:
    type: item
    material: stick
    display name: <&r>Guitar Body
    mechanisms:
        custom_model_data: 11
    recipes:
        1:
            type: shaped
            input:
                - air|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|air
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|air|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|air

part_guitar_2:
    type: item
    material: stick
    display name: <&r>Guitar Neck
    mechanisms:
        custom_model_data: 12
    recipes:
        1:
            type: shaped
            input:
                - air|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|string
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|string|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks
                - string|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|air

part_iron_xylophone_1:
    type: item
    material: stick
    display name: <&r>Iron Xylophone Bars
    mechanisms:
        custom_model_data: 13
    recipes:
        1:
            type: shaped
            input:
                - air|air|iron_nugget
                - iron_nugget|iron_ingot|iron_ingot

part_any_xylophone_1:
    type: item
    material: stick
    display name: <&r>Xylophone Mallets
    mechanisms:
        custom_model_data: 14
    recipes:
        1:
            type: shaped
            input:
                - alloy_nugget
                - stick

part_xylophone_1:
    type: item
    material: stick
    display name: <&r>Xylophone Bars
    mechanisms:
        custom_model_data: 15
    recipes:
        1:
            type: shaped
            input:
                - air|air|alloy_nugget
                - alloy_nugget|alloy_ingot|alloy_ingot

part_pling_1:
    type: item
    material: stick
    display name: <&r>Piano Keys
    mechanisms:
        custom_model_data: 16
    recipes:
        1:
            type: shaped
            input:
                - bone|bone|bone

# custom_model_data: 1 => Chisel

instrument_banjo:
    type: item
    material: wooden_sword
    display name: <&r>Banjo
    mechanisms:
        custom_model_data: 2
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|part_banjo_2
                - part_banjo_1|air

instrument_basedrum:
    type: item
    material: wooden_sword
    display name: <&r>Bass Drum
    mechanisms:
        custom_model_data: 3
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|part_basedrum_1|iron_nugget
                - oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks|air|oak_planks/spruce_planks/birch_planks/jungle_planks/acacia_planks/dark_oak_planks/crimson_planks/warped_planks
                - iron_nugget|part_basedrum_1|iron_nugget

instrument_bass:
    type: item
    material: wooden_sword
    display name: <&r>Bass Guitar
    mechanisms:
        custom_model_data: 4
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|part_bass_1
                - part_bass_2|air
        2:
            type: shaped
            input:
                - part_bass_1|air
                - air|part_bass_2

instrument_bell:
    type: item
    material: wooden_sword
    display name: <&r>Bell
    mechanisms:
        custom_model_data: 5
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|gold_nugget|air
                - gold_nugget|air|gold_nugget
                - gold_nugget|air|gold_nugget

instrument_bit:
    type: item
    material: wooden_sword
    display name: <&r>Turntable
    mechanisms:
        custom_model_data: 6
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - music_disc_13/music_disc_cat/music_disc_blocks/music_disc_chirp/music_disc_far/music_disc_mall/music_disc_mellohi/music_disc_stal/music_disc_strad/music_disc_ward/music_disc_11/music_disc_wait/music_disc_pigstep|redstone|music_disc_13/music_disc_cat/music_disc_blocks/music_disc_chirp/music_disc_far/music_disc_mall/music_disc_mellohi/music_disc_stal/music_disc_strad/music_disc_ward/music_disc_11/music_disc_wait/music_disc_pigstep
                - iron_nugget|iron_nugget|iron_nugget

instrument_chime:
    type: item
    material: wooden_sword
    display name: <&r>Chimes
    mechanisms:
        custom_model_data: 7
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - string|string|string
                - part_chime_1|part_chime_1|part_chime_1

instrument_cow_bell:
    type: item
    material: wooden_sword
    display name: <&r>Cowbell
    mechanisms:
        custom_model_data: 8
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|alloy_nugget|air
                - alloy_nugget|air|alloy_nugget
                - alloy_nugget|air|alloy_nugget

instrument_didgeridoo:
    type: item
    material: wooden_sword
    display name: <&r>Didgeridoo
    mechanisms:
        custom_model_data: 9
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shapeless
            input: chisel|stripped_oak_log/stripped_spruce_log/stripped_birch_log/stripped_jungle_log/stripped_acacia_log/stripped_dark_oak_log

instrument_flute:
    type: item
    material: wooden_sword
    display name: <&r>Flute
    mechanisms:
        custom_model_data: 10
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - part_flute_1|air
                - air|part_flute_2
        2:
            type: shaped
            input:
                - air|part_flute_1
                - part_flute_2|air

instrument_guitar:
    type: item
    material: wooden_sword
    display name: <&r>Guitar
    mechanisms:
        custom_model_data: 11
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - part_guitar_2|air
                - air|part_guitar_1
        2:
            type: shaped
            input:
                - air|part_guitar_2
                - part_guitar_1|air

instrument_harp:
    type: item
    material: wooden_sword
    display name: <&r>Harp
    mechanisms:
        custom_model_data: 12
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|gold_ingot|gold_ingot
                - gold_ingot|string|gold_ingot
                - gold_ingot|gold_ingot|gold_ingot

instrument_hat:
    type: item
    material: wooden_sword
    display name: <&r>High Hat
    mechanisms:
        custom_model_data: 13
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|alloy_ingot|air
                - alloy_ingot|air|alloy_ingot

instrument_iron_xylophone:
    type: item
    material: wooden_sword
    display name: <&r>Iron Xylophone
    mechanisms:
        custom_model_data: 14
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - part_any_xylophone_1|part_iron_xylophone_1|part_any_xylophone_1

instrument_pling:
    type: item
    material: wooden_sword
    display name: <&r>Keytar
    mechanisms:
        custom_model_data: 15
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - air|part_pling_1|iron_nugget
                - iron_nugget|redstone|iron_nugget
                - iron_nugget|iron_nugget|iron_nugget

instrument_snare:
    type: item
    material: wooden_sword
    display name: <&r>Snare
    mechanisms:
        custom_model_data: 16
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - leather|leather|leather
                - iron_ingot|air|iron_ingot
                - iron_ingot|iron_ingot|iron_ingot


instrument_xylophone:
    type: item
    material: wooden_sword
    display name: <&r>Xylophone
    mechanisms:
        custom_model_data: 17
        hides: attributes|unbreakable
        unbreakable: true
        nbt_attributes: generic.attack_damage/mainhand/0/0.0|generic.attack_speed/mainhand/0/4.0
    recipes:
        1:
            type: shaped
            input:
                - part_any_xylophone_1|part_xylophone_1|part_any_xylophone_1