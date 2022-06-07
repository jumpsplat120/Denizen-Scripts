lib_entity_stand:
    type: entity
    debug: false
    entity_type: armor_stand
    mechanisms:
        visible: false
        invulnerable: true
        #gravity: false
        is_small: true

lib_entity_shulker:
    type: entity
    debug: false
    entity_type: shulker
    mechanisms:
        color: white
        potion_effects: INVISIBILITY,0,<util.int_max>,false,false,false
        invulnerable: true
        has_ai: false