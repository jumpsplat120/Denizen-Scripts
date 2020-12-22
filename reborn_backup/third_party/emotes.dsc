#Emotes Script by Kiryll :: @kiryllp on Twitter#

emotes:
    type: command
    name: emote
    description: Emote manager command. Pass the command with no arguments to open the emotes menu manually. Pass the 'auto' command to toggle auto emotes on or off. When auto emotes are on, you will automatically display the emote head by typing the corresponding emote in chat.
    usage: /emote <aqua><&lt><white>auto<aqua><&gt>
    debug: false
    aliases:
        - emotes
        - emoticon
        - emoticons
        - em
    script:
        - if <context.args.get[1].to_lowercase.is[==].to[auto]||false>:
            - define has_flag <player.has_flag[auto_emote]>
            - actionbar "Auto Emote™ toggled <gray><tern[<[has_flag]>].pass[OFF].fail[ON]>"
            - flag player auto_emote:<tern[<[has_flag]>].pass[!].fail[true]>
        - else:
            - if <player.has_flag[emote_cooldown]>:
                - actionbar <script[master_config].data_key[cooldown.message].parsed>
            - else:
                - inventory open d:emote_inventory

emote_inventory:
    type: inventory
    inventory: chest
    title: <gray>Emotes
    size: 9
    debug: false
    slots:
        - [emote_head_grin] [emote_head_smile] [emote_head_straight] [emote_head_cheeky] [emote_head_sad] [emote_head_angry] [emote_head_wink] [emote_head_surprised] [emote_head_coy]

emote_head_grin:
    type: item
    material: player_head
    display name: <dark_gray>Ecstatic
    lore:
        - <gray>Chat Shortcut -> :D
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.grin.uuid]>|<script[master_config].data_key[emote.grin.blob]>
        
emote_head_smile:
    type: item
    material: player_head
    display name: <dark_gray>Happy
    lore:
        - <gray>Chat Shortcut -> :)
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.smile.uuid]>|<script[master_config].data_key[emote.smile.blob]>

emote_head_straight:
    type: item
    material: player_head
    display name: <dark_gray>Unamused
    lore:
        - <gray>Chat Shortcut -> :|
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.straight.uuid]>|<script[master_config].data_key[emote.straight.blob]>

emote_head_cheeky:
    type: item
    material: player_head
    display name:  <dark_gray>Cheeky
    lore:
        - <gray>Chat Shortcut -> :.
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.cheeky.uuid]>|<script[master_config].data_key[emote.cheeky.blob]>

emote_head_sad:
    type: item
    material: player_head
    display name:  <dark_gray>Sad
    lore:
        - <gray>Chat Shortcut -> :(
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.sad.uuid]>|<script[master_config].data_key[emote.sad.blob]>

emote_head_angry:
    type: item
    material: player_head
    display name:  <dark_gray>Angry
    lore:
        - <gray>Chat Shortcut -> <&gt>:(
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.angry.uuid]>|<script[master_config].data_key[emote.angry.blob]>

emote_head_wink:
    type: item
    material: player_head
    display name: <dark_gray>Flirtatious
    lore:
        - <gray>Chat Shortcut -> ;)
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.wink.uuid]>|<script[master_config].data_key[emote.wink.blob]>

emote_head_surprised:
    type: item
    material: player_head
    display name: <dark_gray>Suprised
    lore:
        - <gray>Chat Shortcut -> :o
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.surprised.uuid]>|<script[master_config].data_key[emote.surprised.blob]>

emote_head_coy:
    type: item
    material: player_head
    display name: <dark_gray>Coy
    lore:
        - <gray>Chat Shortcut -> :3
    mechanisms:
        skull_skin: <script[master_config].data_key[emote.coy.uuid]>|<script[master_config].data_key[emote.coy.blob]>

emote_display:
    type: task
    debug: false
    definitions: itemscript
    script:
        - define config <script[master_config].data_key[emote]>
        - if <player.has_flag[emote_cooldown]>:
            - actionbar <[config].get[cooldown].get[message].parsed>
        - else:
            - define helmet <player.inventory.slot[40]>
            - define cooldown <[config].get[cooldown].get[ticks]>
            - define emote_type <[itemscript].after[emote_head_]>
            - flag player emote_cooldown duration:<[cooldown]>t
            - equip <player> head:<item[<[itemscript]>]>
            - actionbar "Currently displaying: <gray><[emote_type].to_uppercase><white> emote"
            - if <[emote_type]> == flirtatious:
                - playeffect effect:Heart at:<player.location.add[0,2,0]> visibility:50 quantity:1 offset:0.0
                - wait <[cooldown]>t
            - else if <[emote_type]> == angry:
                - repeat <[cooldown].div[5].round_down>:
                    - playeffect effect:smoke at:<player.location.add[0,2,0]> visibility:50 quantity:2 offset:0.0 velocity:20
                    - wait 5t
            - else:
                - wait <[cooldown]>t
            - equip <player> head:<[helmet]>

emote_events:
    type: world
    debug: false
    events:
        on player clicks in emote_inventory:
            - define config <script[master_config].data_key[emote]>
            - inventory close
            - run emote_display def:<context.item.scriptname>
        on player clicks in inventory:
            - if <player.has_flag[emote_cooldown]> && <context.item.scriptname.starts_with[emote_head_]||false>:
                - determine cancelled
        on player chats:
            - if <player.has_flag[auto_emote]>:
                - foreach <list[<&co>D|<&co>)|<&co>.|<&co>(|<&gt><&co>(|;)|<&co>o|<&co>3].include_single[<&co>|]>:
                    - if <context.message> == <[value]>:
                        - determine passively cancelled
                        - run emote_display def:emote_head_<list[grin|smile|cheeky|sad|angry|wink|surprised|coy|straight].get[<[loop_index]>]>


                