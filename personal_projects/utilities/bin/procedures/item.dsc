calculate_fortune:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define item <[args.item].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define item <[args].if_null[<[null]>]> if:<[item].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[item|<[null]>|<[item]>|<queue>]>
        - define error <proc[error_type_check].context[item|item|<[item]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define level <[item].enchantment_map.get[fortune].if_null[0]>
        - determine 1 if:<[level].is_less_than_or_equal_to[0]>
        - determine 1 if:<util.random_chance[<element[2].div[<[level].add[2]>]>]>
        - determine <util.random.int[2].to[<[level].add[1]>]>
    data:
        args:
            item:
                type: itemTag
                description: The item that contains the fortune enchantment.
                required: true
        description: Returns a number based on the minecraft formula for calculating extra fortune drops. This currently only accounts for the multiplier, and will not be accurate for discrete items (melons, glowstone, etc) or for chance-based drops (flint, etc).
        determines: elementTag
        usage:
            - narrate "The tool in my hand, when breaking a fortune enabled block, will drop..."
            - repeat 5:
                - narrate " • <player.item_in_hand.proc[calculate_fortune]>"
            - narrate ...items.

generate_enchantment_tooltips:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define item <[args.item].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define item <[args].if_null[<[null]>]> if:<[item].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[item|<[null]>|<[item]>|<queue>]>
        - define error <proc[error_type_check].context[item|item|<[item]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - foreach <[item].enchantment_map> key:name as:level:
            - define enchant <[name].as[enchantment].full_name[<[level]>].strip_color>
            - define enchant <[name].as[enchantment].full_name[1].before[1]><[level].to_roman_numerals> if:<[enchant].split[].last.starts_with[enchantment]>
            - define result:->:<gray><[enchant].strip_color>
        - determine <[result].if_null[<list>]>
    data:
        args:
            item:
                type: itemTag
                description: The item containing the enchantments.
                required: true
        description: Takes an item, and returns list of vanilla styled tooltips representing the items on the tool. If the enchant's level doesn't have a value (by default, an enchant level that goes over 5, unless a resource pack has filled in the missing values), then it will instead use to_roman_numerals on the level, to continue the vanilla styled naming scheme.
        determines: listTag<&lt>elementTag<&gt>
        usage:
            - narrate "The tool in my hand contains the following enchantments:"
            - foreach <player.item_in_hand.proc[generate_enchantment_tooltips]>:
                - narrate " • <[value]>"

apply_enchantment:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define item      <[args.item].if_null[]>
        - define enchant   <[args.enchant].if_null[]>
        - define level     <[args.level].if_null[]>
        - define conflicts <[args.allow_conflicts].if_null[]>
        - define invalids  <[args.allow_invalid_enchants].if_null[]>
        - define overlevel <[args.allow_over_max_level].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define item      <[item].if_null[<[null]>]>    if:<[item].equals[]>
        - define enchant   <[enchant].if_null[<[null]>]> if:<[enchant].equals[]>
        - define level     1                             if:<[level].equals[]>
        - define conflicts true                          if:<[conflicts].equals[]>
        - define invalids  true                          if:<[invalids].equals[]>
        - define overlevel true                          if:<[overlevel].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[item|<[null]>|<[item]>|<queue>]>
        - define error <proc[error_missing_check].context[enchant|<[null]>|<[enchant]>|<queue>]>             if:<[error].not>
        - define error <proc[error_type_check].context[level|element|<[level]>|<queue>]>                     if:<[error].not>
        - define error <proc[error_type_check].context[allow_conflicts|element|<[conflicts]>|<queue>]>       if:<[error].not>
        - define error <proc[error_type_check].context[allow_invalid_enchants|element|<[invalids]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[allow_over_max_level|element|<[overlevel]>|<queue>]>  if:<[error].not>
        - define error <proc[error_type_check].context[enchant|element,enchantment|<[item]>|<queue>]>        if:<[error].not>
        - define error <proc[error_number_check].context[level|<[level]>|<queue>]>                           if:<[error].not>
        - define error <proc[error_boolean_check].context[allow_conflicts|<[conflicts]>|<queue>]>            if:<[error].not>
        - define error <proc[error_boolean_check].context[allow_invalid_enchants|<[invalids]>|<queue>]>      if:<[error].not>
        - define error <proc[error_boolean_check].context[allow_over_max_level|<[overlevel]>|<queue>]>       if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define enchant    <[enchant].as[enchantment]>
        - define enchants   <[item].enchantment_map>
        - define curr_level <[enchants.<[enchant].name>].if_null[0]>
        - define enchants.<[enchant].name>:! if:<[curr_level].is_more_than[0]>
        - determine <[item]> if:<[curr_level].equals[<[level]>]>
        - determine <[item]> if:<[overlevel].is_truthy.not.and[<[level].min[<[enchant].min_level>].max[<[enchant].max_level>].equals[<[level]>].not>]>
        - determine <[item]> if:<[invalids].is_truthy.not.and[<[enchant].can_enchant[<[item]>].not>]>
        - determine <[item]> if:<[conflicts].is_truthy.not.and[<[enchants].parse_tag[<[parse_value].as[enchantment].is_compatible[<[enchant]>]>].contains[false]>]>
        - define enchants.<[enchant].name>:<[level]>
        - define lore <[item].lore.if_null[<list>]>
        - foreach <[lore]>:
            - define potential_enchant "<[value].split[].get[first].to[-2].strip_color.replace[ ].with[_].as[enchantment].if_null[]>"
            - define lore:<-:<[value]> if:<[potential_enchant].equals[].not>
        - if <[item].has_flag[lore]>:
            - define lore <list>
            - define lore:|:<[item].flag[lore]>
        - define lore:|:<[item].proc[generate_enchantment_tooltips]>
        - adjust <[item]> enchantments:<[enchants]>
        - adjust <[item]> lore:<[lore]>
        - determine <[item]>
    data:
        args:
            item:
                type: itemTag
                description: The item that you wish to apply the enchant to.
                required: true
            enchant:
                type: enchantmentTag|elementTag
                description: The enchantment you want to add to the item. If the enchantment is an element, it will be coereced into an enchantmentTag, so for custom enchantments, use the appropriate key.
                required: true
            level:
                type: elementTag
                description: The level of the enchantment you want to apply. If no level is specified, defaults to 1.
                required: false
            allow_conflicts:
                type: elementTag
                description: Wether you want the enchantment to be applied, even if it conflicts with an enchant already on the item. If not specified, defaults to false.
                required: false
            allow_invalid_enchants:
                type: elementTag
                description: Wether you want the enchantment to be applied, even if it is an invalid enchantment for the item. If not specified, defaults to false.
                required: false
            allow_over_max_level:
                type: elementTag
                description: Wether you want the enchantment to be applied, even if it is greater than the max level allowed for the enchant. If not specified, defaults to false.
                required: false
        description: Takes an item, and returns a copy of the item with an enchantment applied to it. This takes a set of options, such as the proc should or should not ignore invalid enchantments, overlevelled enchantments, and conflicting enchantments. It will also apply vanilla styled enchantment tooltips to the description. If the item contains a "lore" flag, it will apply that to the item, and then append the enchantment tooltips. Otherwise, it will *attempt* to intelligently only remove existing enchantment tooltips and rebuild them.
        determines: itemTag
        usage:
            - narrate "The following item will be a copy of whatever was in my hand, with knockback 5 on it."
            - give <proc[apply_enchantment].context[item=<player.item_in_hand>;enchant=knockback;level=5;allow_invalid_enchants=true]>

breaking_time:
    type: procedure
    debug: false
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define hardness <[args.hardness].if_null[]>
        - define item     <[args.item].if_null[]>
        - define hand     <[args.is_hand_valid].if_null[]>
        - define tools    <[args.valid_tools].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define hardness <[args].if_null[<[null]>]> if:<[hardness].equals[]>
        - define item     <item[air]>                if:<[item].equals[]>
        - define hand     false                      if:<[hand].equals[]>
        - define tools    <list>                     if:<[tools].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[hardness|<[null]>|<[hardness]>|<queue>]>
        - define error <proc[error_type_check].context[item|item|<[item]>|<queue>]>            if:<[error].not>
        - define error <proc[error_type_check].context[is_hand_vaid|element|<[hand]>|<queue>]> if:<[error].not>
        - define error <proc[error_type_check].context[valid_tools|list|<[tools]>|<queue>]>    if:<[error].not>
        - foreach <[tools]>:
            - define error <proc[error_type_check].context[valid_tools[<[loop_index]>]|item,element|<[value]>|<queue>]> if:<[error].not>
        - define error <proc[error_boolean_check].context[is_hand_vaid|<[hand]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - determine <util.int_max> if:<[hardness].equals[<util.int_max>]>
        - determine 0              if:<[hardness].equals[-1]>
        - determine 0.30           if:<[hardness].equals[0]>
        - foreach <[tools]>:
            - if <[item]> matches <[key]>:
                - define speed <[value]>
                - define harvestable true
                - foreach stop
        - define speed          <empty> if:<[speed].if_null[true]>
        - define in_air         <player.location.material.is_solid.not>
        - define in_water       <player.eye_location.material.advanced_matches[*water]>
        - define aqua_affinity  <player.equipment_map.filter_tag[<[filter_value].enchantment_map.get[aqua_affinity].exists>].any>
        - define haste          <player.effects_data.filter_tag[<[filter_value.type].equals[fast_digging]>].first.if_null[]>
        - define fatigue        <player.effects_data.filter_tag[<[filter_value.type].equals[slow_digging]>].first.if_null[]>
        - define efficiency     <[item].enchantment_map.get[efficiency].if_null[]>
        - define harvestable false
        - define haste       0    if:<[haste].equals[]>
        - define fatigue     0    if:<[fatigue].equals[]>
        - define efficiency  0    if:<[efficiency].equals[]>
        - define speed       1    if:<[speed].equals[]>
        - define harvestable true if:<[hand].is_truthy>
        - define speed:+:<[efficiency].mul[<[efficiency]>].add[1]> if:<[harvestable].and[<[efficiency].is_more_than[0]>]>
        - define speed:*:<[haste].mul[0.2].add[1]>                 if:<player.has_effect[fast_digging]>
        - define speed:*:<element[0.3].power[<[fatigue].min[4]>]>  if:<player.has_effect[slow_digging]>
        - if <[in_air]> and not <[aqua_affinity]>:
            - define speed:/:5
        - else if <[in_air]>:
            - define speed:/:5
        - define damage <[speed].div[<[hardness]>]>
        - if <[harvestable]>:
            - define damage:*:0.03333333
        - else:
            - define damage:*:0.01
        # If the tool and enchantments immediately exceed the hardness times 30, the block breaks with no delay
        - determine 0   if:<[damage].is_more_than[<[hardness].mul[30]>]>
        - determine 0.3 if:<[damage].is_more_than[1]>
        - determine <element[1].div[<[damage]>].round_up.div[20]>
    data:
        args:
            hardness:
                type: elementTag
                description: A number between -1 and <util.int_max>. <util.int_max> is treated as an infinite break time, and will return <util.int_max> seconds. A hardness of zero returns a break time of zero, which is a delayed infinite break time (similiar to breaking blocks in creative while just holding down left click). A hardness of -1 is treated as a no delay break time, similar to mining stone with an Efficency 5 diamond pickaxe and Haste 3. Everything else uses the vanilla breaking formula which can be found <&click[https://minecraft.fandom.com/wiki/Breaking#:~:text=Combining<&pc>20all<&pc>20of<&pc>20the<&pc>20information<&pc>20above].on_click[open_url]>here<&end_click>.
                required: true
            valid_tools:
                type: mapTag<&lt>itemTag|elementTag=elementTag<&gt>
                description: A map of items/item names, with the speed at which the item can break the block at. For example, you may want an iron sword to be twice as effective as a wooden sword, so you'd create a map that looked something like <&lt>map[iron_sword=10;wooden_sword=5]<&gt>. You can also input item script names, or use a matcher, such as *sword. These values are used in the process of finding the breaking speed, and are not directly translatable to amount of time. The vanilla values of tool materials can be found <&click[https://minecraft.fandom.com/wiki/Breaking#:~:text=Tool<&pc>20Speed].on_click[open_url]>here<&end_click>.
                required: false
            is_hand_valid:
                type: elementTag
                description: Whether a hand is a valid "tool" to break with. If this is true, it effectively overwrites valid_tools, since every tool is valid if a hand is valid. If not specified, defaults to false.
                required: false
            item:
                type: itemTag
                description: The item you're using to break with. If no item is provided, the equation is run assuming a hand. An air item is also treated as attempting to break with a hand.
                required: false
        description: Takes an item, and a hardness value, and calculates the amount of seconds it would take to be mined. Attempts to follow vanilla Minecraft breaking logic, based on the information from the <&click[https://minecraft.fandom.com/wiki/Breaking].on_click[open_url]>Breaking<&end_click> page on the Minecraft wiki.
        determines: elementTag
        usage:
            - define tools:->:<player.item_in_hand>
            - define hardness <player.eye_location.ray_trace[return=block].material.hardness>
            - narrate "It will take <proc[breaking_time].context[valid_tools=<[tools]>;item=<[tools].first>;hardness=<[hardness]>]> seconds to break the block I'm looking at with the tool in my hand."

vanilla_to_custom_potion:
    type: procedure
    debug: true
    definitions: args
    script:
        - define args <[args].as[map].if_null[<[args]>]> if:<[args].object_type.equals[element]>
        - define null <util.random_decimal>
        # ~~~ ARGS ~~~ #
        - define item <[args.item].if_null[]>
        # ~~~ DEFAULTS ~~~ #
        - define item <[args].if_null[<[null]>]> if:<[item].equals[]>
        # ~~~ ERROR CHECKING ~~~ #
        - define error <proc[error_missing_check].context[item|<[null]>|<[item]>|<queue>]>
        - define error <proc[error_type_check].context[item|item|<[item]>|<queue>]> if:<[error].not>
        - determine <empty> if:<[error]>
        # ~~~ LOGIC ~~~ #
        - define effect   <[item].effects_data.first.if_null[]>
        - define material <[item].material.name.if_null[]>
        - define type     <[effect.type].to_lowercase.if_null[]>
        - define upgraded <[effect.upgraded].is_truthy.if_true[_upgraded].if_false[]>
        - define extended <[effect.extended].is_truthy.if_true[_extended].if_false[]>
        - define custom   <item[custom_<[material]>_<[type]><[upgraded]><[extended]>].if_null[]>
        - determine <[custom]> if:<[custom].equals[].not>
        - debug error "VANILLA_TO_CUSTOM_POTION: 'custom_<[material]>_<[type]><[upgraded]><[extended]>' is not a valid custom potion item. Did you attempt to pass in an item without a potion effect?"
    data:
        args:
            item:
                type: itemTag
                description: The vanilla potion item you want to turn into a custom Denizen item. Regular potions, splash potions, lingering potions, and tipped arrows are all valid.
                required: true
        description: Vanilla items that have potion effects are stored in a format different than a custom potion. In Denizen, an item with potion effects is a mapTag with "type", "duration", "amplifier", "ambient", "particles" and "icon", while vanilla potions use the "upgraded" and "extended" keys. This takes a vanilla potion item and returns a "custom" one with identical effects, but in the Denizen style. This is useful for simply adjusting the duration of a potion, or toggling on/off particles and the like. Since it is not a vanilla potion anymore, it most likely won't be able to be used in a recipe that used a vanilla potion. Potion items can include regular potions, splash potions, lingering potions and potion tipped arrows.
        determines: itemTag
        usage:
            - narrate "I'm going to give myself a custom version of a vanilla potion item."
            - give <player.item_in_hand.proc[vanilla_to_custom_potion]>