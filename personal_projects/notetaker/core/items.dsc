nt_empty_note:
    type: item
    debug: false
    material: stick
    display name: <reset>Empty Note
    allow in material recipes: true
    mechanisms:
        custom_model_data: <script[nt_config].data_key[cmd_offset].add[1]>
    lore:
        - <empty>
        - <gray><italic>Craft this item with various colors of dye to change
        - <gray><italic>the color of the paper and ink. The three slots
        - <gray><italic>above the item will change the ink, and the three
        - <gray><italic>slots below will change the color of the paper.
        - <gray><italic>Right click to begin writing your note.
    recipes:
        1:
            type: shaped
            recipe_id: nt_empty_note
            input:
                - material:*_dye/air|material:*_dye/air|material:*_dye/air
                - air|material:stick/paper|air
                - material:*_dye/air|material:*_dye/air|material:*_dye/air

nt_written_note:
    type: item
    debug: false
    material: filled_map
    display name: <reset>Written Note
    mechanisms:
        custom_model_data: <script[nt_config].data_key[cmd_offset].add[2]>