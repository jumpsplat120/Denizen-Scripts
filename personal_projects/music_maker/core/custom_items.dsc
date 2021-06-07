mm_alloy_nugget:
    type: item
    debug: false
    material: stick
    display name: <&r>Alloy Nugget
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[1]>
    recipes:
        1:
            type: shapeless
            output_quantity: 3
            input: iron_nugget|iron_nugget|gold_nugget
        2:
            type: shapeless
            output_quantity: 9
            input: mm_alloy_ingot

mm_alloy_ingot:
    type: item
    debug: false
    material: stick
    display name: <&r>Alloy Ingot
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[2]>
    recipes:
        1:
            type: shapeless
            output_quantity: 3
            input: iron_ingot|iron_ingot|gold_ingot
        2:
            type: shaped
            output_quantity: 1
            input:
                - mm_alloy_nugget|mm_alloy_nugget|mm_alloy_nugget
                - mm_alloy_nugget|mm_alloy_nugget|mm_alloy_nugget
                - mm_alloy_nugget|mm_alloy_nugget|mm_alloy_nugget

mm_chisel:
    type: item
    debug: false
    material: wooden_sword
    display name: <&r>Chisel
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[1]>
        hides: attributes
        nbt_attributes: generic.attack_damage/mainhand/0/-3.5|generic.attack_speed/mainhand/1/4.0
    allow in material recipes: true
    recipes:
        1:
            type: shaped
            input:
                - air|iron_ingot
                - stick|air

mm_banjo_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Banjo Drum
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[3]>
    recipes:
        1:
            type: shaped
            input:
                - *_planks|*_planks|*_planks
                - *_planks|leather|*_planks
                - *_planks|*_planks|*_planks

mm_banjo_p2:
    type: item
    debug: false
    material: stick
    display name: <reset>Banjo Neck
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[4]>
    recipes:
        1:
            type: shaped
            input:
                - air|stick|string
                - stick|string|stick
                - string|stick|air

mm_basedrum_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Bass Drum Head
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[5]>
    recipes:
        1:
            type: shaped
            input:
                - leather|leather|leather
                - leather|leather|leather

mm_bass_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Bass Neck
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[6]>
    recipes:
        1:
            type: shaped
            input:
                - air|iron_nugget|string
                - iron_nugget|string|iron_nugget
                - string|iron_nugget|air

mm_bass_p2:
    type: item
    debug: false
    material: stick
    display name: <reset>Bass Body
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[7]>
    recipes:
        1:
            type: shaped
            input:
                - air|iron_nugget|air
                - iron_nugget|redstone|iron_nugget
                - iron_nugget|iron_nugget|air

mm_chime_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Chime Tube
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[8]>
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget
                - iron_nugget
                - iron_nugget

mm_flute_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Flute Head
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[9]>
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|air|iron_nugget
                - air|air|air
                - iron_nugget|iron_nugget|iron_nugget

mm_flute_p2:
    type: item
    debug: false
    material: stick
    display name: <reset>Flute Body
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[10]>
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|iron_nugget|iron_nugget
                - iron_ingot|iron_ingot|iron_ingot

mm_guitar_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Guitar Body
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[11]>
    recipes:
        1:
            type: shaped
            input:
                - air|*_planks|air
                - *_planks|air|*_planks
                - *_planks|*_planks|air

mm_guitar_p2:
    type: item
    debug: false
    material: stick
    display name: <reset>Guitar Neck
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[12]>
    recipes:
        1:
            type: shaped
            input:
                - air|*_planks|string
                - *_planks|string|*_planks
                - string|*_planks|air

mm_iron_xylophone_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Iron Xylophone Bars
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[13]>
    recipes:
        1:
            type: shaped
            input:
                - air|air|iron_nugget
                - iron_nugget|iron_ingot|iron_ingot

mm_any_xylophone_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Xylophone Mallets
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[14]>
    recipes:
        1:
            type: shaped
            input:
                - mm_alloy_nugget
                - stick

mm_xylophone_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Xylophone Bars
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[15]>
    recipes:
        1:
            type: shaped
            input:
                - air|air|mm_alloy_nugget
                - mm_alloy_nugget|mm_alloy_ingot|mm_alloy_ingot

mm_pling_p1:
    type: item
    debug: false
    material: stick
    display name: <reset>Piano Keys
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[16]>
    recipes:
        1:
            type: shaped
            input:
                - bone|bone|bone

mm_i_banjo:
    type: item
    debug: false
    material: stick
    display name: <reset>Banjo
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[17]>
    recipes:
        1:
            type: shaped
            input:
                - air|mm_banjo_p2
                - mm_banjo_p1|air

mm_i_basedrum:
    type: item
    debug: false
    material: stick
    display name: <reset>Bass Drum
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[18]>
    recipes:
        1:
            type: shaped
            input:
                - iron_nugget|mm_basedrum_p1|iron_nugget
                - *_planks|air|*_planks
                - iron_nugget|mm_basedrum_p1|iron_nugget

mm_i_bass:
    type: item
    debug: false
    material: stick
    display name: <reset>Bass Guitar
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[19]>
    recipes:
        1:
            type: shaped
            input:
                - air|mm_bass_p1
                - mm_bass_p2|air
        2:
            type: shaped
            input:
                - mm_bass_p1|air
                - air|mm_bass_p2

mm_i_bell:
    type: item
    debug: false
    material: stick
    display name: <reset>Bell
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[20]>
    recipes:
        1:
            type: shaped
            input:
                - air|gold_nugget|air
                - gold_nugget|air|gold_nugget
                - gold_nugget|air|gold_nugget

mm_i_bit:
    type: item
    debug: false
    material: stick
    display name: <reset>Turntable
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[21]>
    recipes:
        1:
            type: shaped
            input:
                - music_disc_*
                - iron_nugget|iron_nugget|iron_nugget

mm_i_chime:
    type: item
    debug: false
    material: stick
    display name: <reset>Chimes
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[22]>
    recipes:
        1:
            type: shaped
            input:
                - string|string|string
                - mm_chime_p1|mm_chime_p1|mm_chime_p1

mm_i_cow_bell:
    type: item
    debug: false
    material: stick
    display name: <reset>Cowbell
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[23]>
    recipes:
        1:
            type: shaped
            input:
                - air|mm_alloy_nugget|air
                - mm_alloy_nugget|air|mm_alloy_nugget
                - mm_alloy_nugget|air|mm_alloy_nugget

# recipe uses "wooden_sword" instead of chisel, event handles verifying the item is the chisel
#https://discord.com/channels/315163488085475337/315163488085475337/845064258551021578
mm_i_didgeridoo:
    type: item
    debug: false
    material: stick
    display name: <reset>Didgeridoo
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[24]>
    recipes:
        1:
            type: shapeless
            input: material:wooden_sword|material:stripped_*

mm_i_flute:
    type: item
    debug: false
    material: stick
    display name: <reset>Flute
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[25]>
    recipes:
        1:
            type: shaped
            input:
                - mm_flute_p1|air
                - air|mm_flute_p2
        2:
            type: shaped
            input:
                - air|mm_flute_p1
                - mm_flute_p2|air

mm_i_guitar:
    type: item
    debug: false
    material: stick
    display name: <reset>Guitar
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[26]>
    recipes:
        1:
            type: shaped
            input:
                - mm_guitar_p2|air
                - air|mm_guitar_p1
        2:
            type: shaped
            input:
                - air|mm_guitar_p2
                - mm_guitar_p1|air

mm_i_harp:
    type: item
    debug: false
    material: stick
    display name: <reset>Harp
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[27]>
    recipes:
        1:
            type: shaped
            input:
                - air|gold_ingot|gold_ingot
                - gold_ingot|string|gold_ingot
                - gold_ingot|gold_ingot|gold_ingot

mm_i_hat:
    type: item
    debug: false
    material: stick
    display name: <reset>High Hat
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[28]>
    recipes:
        1:
            type: shaped
            input:
                - air|mm_alloy_ingot|air
                - mm_alloy_ingot|air|mm_alloy_ingot

mm_i_iron_xylophone:
    type: item
    debug: false
    material: stick
    display name: <reset>Iron Xylophone
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[29]>
    recipes:
        1:
            type: shaped
            input:
                - mm_any_xylophone_p1|mm_iron_xylophone_p1|mm_any_xylophone_p1

mm_i_pling:
    type: item
    debug: false
    material: stick
    display name: <reset>Keytar
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[30]>
    recipes:
        1:
            type: shaped
            input:
                - air|mm_pling_p1|iron_nugget
                - iron_nugget|redstone|iron_nugget
                - iron_nugget|iron_nugget|iron_nugget

mm_i_snare:
    type: item
    debug: false
    material: stick
    display name: <reset>Snare
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[31]>
    recipes:
        1:
            type: shaped
            input:
                - leather|leather|leather
                - iron_ingot|air|iron_ingot
                - iron_ingot|iron_ingot|iron_ingot


mm_i_xylophone:
    type: item
    debug: false
    material: stick
    display name: <reset>Xylophone
    mechanisms:
        custom_model_data: <script[mm_config].data_key[cmd_offset].add[32]>
    recipes:
        1:
            type: shaped
            input:
                - mm_any_xylophone_p1|mm_xylophone_p1|mm_any_xylophone_p1