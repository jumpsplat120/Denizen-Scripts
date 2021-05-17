# +--------------------
# |
# | SUFFIX SELECTOR
# |
# | A system integrated with luckperms
# | to facilitate adding suffixes to
# | usernames.
# |
# +----------------------
#
# @author jumpsplat120
# @date 03/15/2021
# @denizen-build b5405-DEV
# @script-version 1.0
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#     * suffix-selector.dsc
#
# Requirements:
#     * LuckPerms
#
# Usage:
#   To add a suffix, use the /suffix command. A gui will pop up
#   displaying the suffixes the user has available to them. Simply
#   clicking on an item in the gui will give the user said suffix;
#   when chatting in game, the suffix will show up after the users
#   name but before their message.
#
#   To remove the suffix, you can click the remove suffix button
#   in the gui, and if there are more suffixes available then can
#   be seen in the gui, the previous/next page buttons will become
#   colored and allow you to navigate around. The suffix the user
#   currently has selected is highlighted; the item will have an
#   enchant glow.
#
#   In the gui, the default_icon is the backup icon if there is
#   no assigned icon for the permission, as well as a fallback
#   in case an icon was mispelled.
#   gui allows you to change the min/max amount of rows. There is
#   a min of at least 1 row, and a max of 6 rows, although be
#   aware that there is only room for 6 rows total, so 5 and 6 rows
#   will look functionally the same. Format is the bit of text
#   in front of the text that pops up when a suffix is assigned.
#   There are five default groups, as well as a special group. The
#   five groups are water, fire, earth, air and citizen and contain
#   a shared icon amongst all of the suffixes it contains. Under the
#   people entry is key value pairs, where the key is the permission,
#   and the value is the displayed suffix.
#   Under special, the formatting is different. Each entry uses it's
#   key as the permission, but contains another map with an icon and
#   a title. Icons are what item should be displayed for just the one
#   suffix, and title is the suffix itself. If the icon is set to
#   tilde (~), then it uses the default icon.
#
#   Questions? Get in touch at discord@jumpsplat120#0001
#
# --------------------END HEADER / START CONFIG--------------------

suffix_selector_config:
    type: data
    default_icon: diamond
    gui:
        min_rows: 3
        max_rows: 6
        format: <gold>[<aqua>TLB<gold>]
    water:
        icon: water_bucket
        people:
            Sokka: <aqua>Sokka
            Katara: <aqua>Katara
            Tarrlok: <aqua>Tarrlock
            Hama: <aqua>Hama
            Kya: <&3>Kya
    fire:
        icon: blaze_powder
        people:
            Mako: <&4>Mako
            Zuko: <&4>Zuko
            Azula: <&4>Azula
            Iroh: <&4>Iroh
            Ozai: <&c>Ozai
            Mai: <gold>Mai
            TyLee: <gold>Ty Lee
    earth:
        icon: dirt
        people:
            Bolin: <&2>Bolin
            Toph: <&2>Toph
            Kuvira: <&2>Kuvira
            Kyoshi: <&a>Kyoshi
            Bumi: <&a>Bumi
            Boulder: <&2>The Boulder
            Gopher: <&2>The Gopher
            Pebble: <&2>The Pebble
            suki: <gold>Suki
    air:
        icon: glass_pane
        people:
            Momo: <&7>Momo
            Appa: <&7>Appa
            Aang: <&7>Aang
            Tenzin: <&8>Tenzin
            Kai: <&7>Kai
            TwinkleToes: <&7>Twinkle Toes
    citizens:
        icon: redstone
        people:
            Sato: <gold>Sato
            Asami: <gold>Asami
    special:
        Tide:
            icon: water_bucket
            title: <aqua>The Tide
        Flowing:
            icon: water_bucket
            title: <aqua>The Flowing
        PuppetMaster:
            icon: totem_of_undying
            title: <aqua>PuppetMaster
        Inferno:
            icon: blaze_powder
            title: <&4>The Inferno
        Dragon:
            icon: dragon_head
            title: <&4>The Inferno
        Spark:
            icon: nether_star
            title: <&e>The Spark
        Swift:
            icon: glass_pane
            title: <&7>The Swift
        Monk:
            icon: glass_pane
            title: <&8>The Monk
        duelist:
            icon: crossbow
            title: <gold>The Duelist
        Striker:
            icon: iron_sword
            title: <gold>The Striker
        Calm:
            icon: ~
            title: <gold>The Calm
        Champion:
            icon: ~
            title: <&5>Champion
        Challenger:
            icon: ~
            title: <&8>Challenger
        lotus:
            icon: ~
            title: <aqua><&l>Lotus
        sage:
            icon: ~
            title: <aqua><&l>Sage
        lord:
            icon: ~
            title: <aqua><&l>Lord
        spirit:
            icon: ~
            title: <aqua><&l>Spirit
        judge:
            icon: ~
            title: <&5>Judge
        architect:
            icon: ~
            title: <&d>Architect
        sculpter:
            icon: ~
            title: <&d>Sculpter
        artist:
            icon: ~
            title: <&d>Artist
        Intern:
            icon: ~
            title: <&8>Intern
        Balanced:
            icon: ~
            title: <gold>Balanced
        Mechanic:
            icon: ~
            title: <&d>Mechanic
        Plumber:
            icon: ~
            title: <&3>Plumber
        Maker:
            icon: ~
            title: <&d>Maker
        Artisan:
            icon: ~
            title: <&d>Artisan
        Harmony:
            icon: ~
            title: <gold>Harmony
        Designer:
            icon: ~
            title: <&d>Designer
        Artificer:
            icon: ~
            title: <&d>Artificer
        Creator:
            icon: ~
            title: <&d>Creator
        Overeasy:
            icon: ~
            title: <gold><&l>Over Easy
        Omelette:
            icon: ~
            title: <gold><&l>Omelette
        Deviled:
            icon: ~
            title: <gold><&l>Deviled
        Scrambled:
            icon: ~
            title: <gold>Scrambled
        Eggspert:
            icon: ~
            title: <gold>Eggspert
        misfortune:
            icon: ~
            title: <&4>Misfortune
        lucky:
            icon: ~
            title: <&e>Lucky
        aimbot:
            icon: ~
            title: <&9>Aimbot
        FireFerret:
            icon: ~
            title: <&c>Fire Ferret
        SkyBison:
            icon: ~
            title: <&7>Sky Bison
        Smartie:
            icon: ~
            title: <&a>Smartie
        og:
            icon: ~
            title: <&d><&l>OG
        Bob:
            icon: ~
            title: <&color[#DD2527]>B<&color[#F18F44]>o<&color[#DD2527]>b
        Aviator:
            icon: ~
            title: <&color[#494949]>A<&color[#5B5B5B]>v<&color[#6C6C6C]>i<&color[#7E7E7E]>a<&color[#8F8F8F]>t<&color[#A1A1A1]>o<&color[#B2B2B2]>r
        Demolisher:
            icon: ~
            title: <&color[#F8D305]>D<&color[#E3C209]>e<&color[#CFB10C]>m<&color[#BAA010]>o<&color[#A68F14]>l<&color[#917F18]>i<&color[#7C6E1B]>s<&color[#685D1F]>h<&color[#534C23]>e<&color[#3F3B26]>r
        Spooky:
            icon: ~
            title: <&color[#4D473F]>S<&color[#5D4D39]>p<&color[#6D5432]>o<&color[#7D5A2C]>o<&color[#8D6025]>k<&color[#9D671F]>y
        Haunted:
            icon: ~
            title: <&color[#242424]>H<&color[#312025]>a<&color[#3F1C25]>u<&color[#4C1826]>n<&color[#5A1527]>t<&color[#671128]>e<&color[#750D28]>d
        HalloweenJudge:
            icon: ~
            title: <&color[#8F0D27]>J<&color[#85133E]>u<&color[#7B1955]>d<&color[#71206B]>g<&color[#672682]>e
        HalloweenWinner:
            icon: ~
            title: <&color[#2F414A]>N<&color[#363F57]>i<&color[#3D3C65]>g<&color[#443A72]>h<&color[#4B377F]>t<&color[#53358D]>m<&color[#5A329A]>a<&color[#6130A7]>r<&color[#682DB5]>e
        HalloweenRunner:
            icon: ~
            title: <&5>Nightmare
        Snowman:
            icon: ~
            title: <&color[#97E8F0]>S<&color[#A6EBF2]>n<&color[#B5EFF4]>o<&color[#C4F2F6]>w<&color[#D2F5F9]>m<&color[#E1F8FB]>a<&color[#F0FCFD]>n
        Chilly:
            icon: ~
            title: <&color[#9DDAE0]>C<&color[#8FD2DC]>h<&color[#80C9D8]>i<&color[#72C1D5]>l<&color[#64B8D1]>l<&color[#55B0CD]>y
        Reindeer:
            icon: ~
            title: <&color[#78541C]>R<&color[#824C1A]>e<&color[#8B4418]>i<&color[#953C15]>n<&color[#9E3413]>d<&color[#A82B11]>e<&color[#B1230F]>e<&color[#BB1B0C]>r
        Festive:
            icon: ~
            title: <&color[#008F1F]>F<&color[#40AB57]>e<&color[#80C78F]>s<&color[#BFE3C7]>t<&color[#FFFFFF]>i<&color[#EBB0AD]>v<&color[#D8625C]>e
        Seasonal:
            icon: ~
            title: <&color[#A32607]>Seasonal
        SeasonalWinners:
            icon: ~
            title: <&color[#A32607]>S<&color[#933607]>e<&color[#834507]>a<&color[#725507]>s<&color[#626507]>o<&color[#527407]>n<&color[#428407]>a<&color[#319307]>l
        Media:
            icon: ~
            title: <&color[#3C0D6C]>Media
        custom.poepoeee:
            icon: ~
            title: <&5>I ♥ Towwy
        custom.jortt:
            icon: ~
            title: <&7>Wan Shi Ton
        custom.prideJudge:
            icon: ~
            title: <&c>J<gold>u<&e>d<&a>g<&9>e
        custom.habtal:
            icon: ~
            title: <&5>Strawberry
        custom.Milo:
            icon: ~
            title: <&color[#B82612]>P<&color[#AB1D0E]>V<&color[#9C180C]>P <&color[#8C130A]>B<&color[#7D0F09]>R<&color[#6B0707]>O
        custom.Myst:
            icon: ~
            title: <&color[#A2E4F2]>H<&color[#9FDDED]>y<&color[#9DDAEB]>d<&color[#96D1E3]>r<&color[#94CFE3]>o<&color[#90CBE0]> H<&color[#8AC4DB]>o<&color[#88C2DB]>m<&color[#81BBD6]>i<&color[#7DB4D1]>e
        custom.pride:
            icon: ~
            title: <&7>Pride
        custom.prideRainbow:
            icon: ~
            title: <&c>P<&6>r<&e>i<&a>d<&9>e
        Presents2020.Top:
            icon: ~
            title: <&color[#42E0F5]>G<&color[#42D3F5]>i<&color[#42C6F5]>f<&color[#42BAF5]>t<&color[#42ADF5]>e<&color[#42A0F5]>d
        Presents2020.Participation:
            icon: ~
            title: <&color[#099C4E]>Present
        Valentines.Winner:
            icon: ~
            title: <&color[#C44B59]>A<&color[#CC546A]>d<&color[#D15A76]>o<&color[#D96283]>r<&color[#E06991]>e<&color[#E874A1]>d
        Valentines.Runnerup:
            icon: ~
            title: <&color[#C44B59]>Adored

# --------------------END HEADER / START CODE--------------------

suffix_command:
    type: command
    debug: false
    name: suffix
    description: Set your chat suffix with a GUI.
    usage: /suffix
    aliases:
        - suf
    script:
        - if <player.has_permission[tlb.suffix].global>:
            # ~~~ Init defines ~~~ #
            - define config <script[suffix_selector_config]>
            - define min_rows <[config].data_key[gui.min_rows]>
            - define max_rows <[config].data_key[gui.max_rows]>
            # ~~~ Error checking ~~~ #
            - if <[min_rows].is[OR_LESS].than[<[max_rows]>]>:
                - if <[min_rows].is[OR_LESS].than[6]>:
                    - if <[max_rows].is[OR_LESS].than[6]>:
                        - if <[min_rows].is[OR_MORE].than[1]>:
                            - if <[max_rows].is[OR_MORE].than[1]>:
                                # ~~~ The rest of the defines ~~~ #
                                - define min_amount <tern[<[min_rows].is[==].to[6]>].pass[5].fail[<[min_rows]>].mul[9]>
                                - define max_amount <tern[<[max_rows].is[==].to[6]>].pass[5].fail[<[max_rows]>].mul[9]>
                                - define suffix_amount 0
                                - define item_list <list>
                                - define default_icon <item[<[config].data_key[default_icon]>]||nil>
                                - define inv_pages <list>
                                - define generic_inv <inventory[generic_inventory]>
                                - define air <item[air]>
                                - define remove <item[remove_suffix]>
                                - define next_page <item[next_page]>
                                - define prev_page <item[prev_page]>
                                - define no_next_page <item[no_next_page]>
                                - define no_prev_page <item[no_prev_page]>
                                - define cur_suf <player.chat_suffix>
                                # ~~~ Validate default icon ~~~ #
                                #   If the default icon isn't parseable to an item,
                                #   throws an error, but changes default icon to
                                #   diamond and continues from there
                                - if <[default_icon]> == nil:
                                    - narrate "<dark_red>Config has been misconfigured! Please report this to an admin. (default icon '<[default_icon]>' is not a valid item)"
                                    - define default_icon <item[diamond]>
                                # ~~~ Get list of all permissions user has ~~~ #
                                #   water, fire, air, earth and citizens are all formatted
                                #   so that they use the same icon. So each entry under
                                #   .people is just key:value. The key is also the perm node.
                                #   The value is the actual suffix value. For special, each
                                #   entry can have it's own icon. Therefore, the entry is
                                #   a map itself, with an icon entry and title entry, which
                                #   do what you expect them to. We count the suffix's as
                                #   well here, and icons that are a a tilde (~) are set to
                                #   the default icon. If the result is still not an actual
                                #   item (say it was mispelled or something), then it also
                                #   reverts to default, but will also throw an err in chat
                                #   saying which one is missing a valid icon. It will also
                                #   add an enchantment effect to the item representing the
                                #   suffix the player currently has.
                                - foreach <list[water|fire|air|earth|citizens|special]> as:section:
                                    - define is_special <[section].is[==].to[special]>
                                    - foreach <[config].data_key[<[section]><tern[<[is_special]>].pass[].fail[.people]>]>:
                                        - if <player.has_permission[tlb.title.<[key].unescaped>].global>:
                                            - define suffix_amount:++
                                            - define icon <tern[<[is_special]>].pass[<[value].get[icon]>].fail[<[config].data_key[<[section]>.icon]>]>
                                            - define item <tern[<[icon].is[!=].to[~]>].pass[<item[<[icon]>]||nil>].fail[<[default_icon]>]>
                                            - define display <reset><tern[<[is_special]>].pass[<[value].get[title]>].fail[<[value]>].parsed>
                                            - if <[item]> == nil:
                                                - narrate "<dark_red>Config has been misconfigured! Please report this to an admin. (Icon '<[icon]>' is not a valid item)"
                                                - define item <[default_icon]>
                                            - define item <[item].with[display=<[display]>]>
                                            - if <[display]> == <[cur_suf]>:
                                                - define item <[item].with[hides=enchants;enchantments=<map.with[protection].as[1]>]>
                                            - define item_list:->:<[item]>
                                # ~~~ Pad item list with air ~~~ #
                                #   Size must be a multiple of 9.
                                - repeat <element[9].sub[<[item_list].size.mod[9]>]>:
                                    - define item_list:->:<[air]>
                                - if <[item_list].size> > <[max_amount]>:
                                    # ~~~ Handle pagination ~~~ #
                                    #   When the amount of items in the list is greater than
                                    #   max amount, we need to split into pages. We determine
                                    #   The amount of pages by dividing and rounding up, meaning
                                    #   There will be one page at the end that has empty entries.
                                    #   We loop through, defining inv_contents by getting from
                                    #   1 - max_amount, or, if it's the last loop, 1 - list.size;
                                    #   then we include an extra row which has next page, prev
                                    #   page and remove suffix buttons. We insert the contents into
                                    #   a list called inv_pages for flagging later, then remove
                                    #   the items we just added from item list.
                                    - define loop_amt <[item_list].size.div[<[max_amount]>].round_up>
                                    - repeat <[loop_amt]>:
                                        - define to <tern[<[item_list].size.is[MORE].than[<[max_amount]>]>].pass[<[max_amount]>].fail[<[item_list].size>]>
                                        #Getting items...
                                        - define inv_contents <[item_list].get[1].to[<[to]>]>
                                        #Padding the final page...
                                        - if <[to]> != <[max_amount]>:
                                            - repeat <[max_amount].sub[<[to]>]> as:_:
                                                - define inv_contents:->:<[air]>
                                        #Adding pagination row...
                                        - define inv_contents <[inv_contents].include[<tern[<[value].is[==].to[1]>].pass[<[no_prev_page]>].fail[<[prev_page]>]>|<[air]>|<[air]>|<[air]>|<[remove]>|<[air]>|<[air]>|<[air]>|<tern[<[value].is[==].to[<[loop_amt]>]>].pass[<[no_next_page]>].fail[<[next_page]>]>]>
                                        - define inv_pages:->:<[inv_contents]>
                                        - define item_list <[item_list].remove[1].to[<[to]>]>
                                - else if <[item_list].size> < <[max_amount]> && <[item_list].size> > <[min_amount]>:
                                    # ~~~ Handle being in range ~~~ #
                                    #   If we're in range, the size of the gui can change.
                                    #   We've already padded with air, so we can take item_list
                                    #   and just add the final row that contains our remove
                                    #   button and false next and prev buttons. We still add
                                    #   it to a list so that way we can handle the results the
                                    #   the same whether there's 1 page or 10.
                                    - define inv_contents <[item_list].include[<[no_prev_page]>|<[air]>|<[air]>|<[air]>|<[remove]>|<[air]>|<[air]>|<[air]>|<[no_next_page]>]>
                                    - define inv_pages:->:<[inv_contents]>
                                - else:
                                    # ~~~ Handle being below min ~~~ #
                                    #   If we are below min range, we basically want to do the
                                    #   same thing as being in range, but also fill the list with
                                    #   empty slots until we reach our min. Then we add our final
                                    #   row and add to inv_pages.
                                    - define inv_contents <[item_list]>
                                    - repeat <[min_amount].sub[<[item_list].size>]>:
                                        - define inv_contents:->:<[air]>
                                    - define inv_contents <[inv_contents].include[<[no_prev_page]>|<[air]>|<[air]>|<[air]>|<[remove]>|<[air]>|<[air]>|<[air]>|<[no_next_page]>]>
                                    - define inv_pages:->:<[inv_contents]>
                                # ~~~ Flag, adjust, open ~~~ #
                                #   We adjust our generic inventory to be the size it needs
                                #   to be, and make the contents our first page. We then flag
                                #   the player with the inventory pages for pagination in the
                                #   click event. We also flag the current page which always
                                #   starts at one. Then we open the inventory.
                                - adjust <[generic_inv]> size:<[inv_pages].first.size>
                                - adjust <[generic_inv]> contents:<[inv_pages].first>
                                - flag player suffix.inv_pages:<[inv_pages]>
                                - flag player suffix.current_gui_page:1
                                - inventory open d:<[generic_inv]>
                            - else:
                                - narrate "<dark_red>Config has been misconfigured! Please report this to an admin. (Max is smaller than 1)"
                        - else:
                            - narrate "<dark_red>Config has been misconfigured! Please report this to an admin. (Min is smaller than 1)"
                    - else:
                        - narrate "<dark_red>Config has been misconfigured! Please report this to an admin. (Max is bigger than 6)"
                - else:
                  - narrate "<dark_red>Config has been misconfigured! Please report this to an admin. (Min is bigger than 6)"
            - else:
               - narrate "<dark_red>Config has been misconfigured! Please report this to an admin. (Min is bigger than max)"
        - else:
            - narrate "<dark_red>You do not have access to that command."

suffix_world:
    type: world
    debug: false
    events:
        on player drags in inventory:
            - inject locally change_suffix
        on player clicks in inventory:
            - inject locally change_suffix
        on player closes inventory:
            - flag player suffix:!
    change_suffix:
        # ~~~ Check if suffix flag is set, and make sure inventory contents match current inventory page ~~~ #
        #   The inventory for the suffix selector is dynamic, so we can't make an inventory script out of it.
        #   All we have to do is check that the contents of the inventory that we're clicking it is the same
        #   as the contents of the dynamic inventory (including the page) that we're on. Since the inventory
        #   contains a barrier block, player's won't be able to form this in survival and you shouldn't ever
        #   end up with a chest becoming an unwitting suffix selector gui.
        - if <player.has_flag[suffix]> && <context.clicked_inventory.list_contents> == <player.flag[suffix.inv_pages].get[<player.flag[suffix.current_gui_page]>]>:
            # ~~~ No takey the items ~~~ #
            - determine passively cancelled
            # ~~~ Defines ~~~ #
            - define config <script[suffix_selector_config]>
            - define script_name <context.item.script.name||nil>
            - define format <[config].data_key[gui.format].parsed><reset>
            - define flag <player.flag[suffix]>
            - define inv_pages <[flag].get[inv_pages]>
            - define cur_page <[flag].get[current_gui_page]>
            # ~~~ Check for nil script name ~~~ #
            #   If it's nil, then it's an item (or an empty slot),
            #   otherwise, it'll be a button that we want to handle.
            - if <[script_name]> != nil:
                - if <[script_name]> == remove_suffix:
                    # ~~~ Remove suffix, close inv, remove suffix flag ~~~ #
                    - inject locally remove_suffix
                    - narrate "<[format]> Your suffix has been removed."
                    - inventory close
                    - flag player suffix:!
                - else if <[script_name]> == next_page:
                    # ~~~ Index handling ~~~ #
                    #   This is true for next_page and prev_page. We want
                    #   to make sure that we don't go farther than is
                    #   possible, ie we don't want to go the 4th page when
                    #   there is only three pages. On next, we need to make
                    #   sure we haven't gone over, and on prev we want to
                    #   make sure we haven't gone under.
                    - define next_page_index <[cur_page].add[1]>
                    - define new_page_index <tern[<[next_page_index].is[MORE].than[<[inv_pages].size>]>].pass[<[inv_pages].size>].fail[<[next_page_index]>]>
                    - adjust <context.inventory> contents:<[inv_pages].get[<[new_page_index]>]>
                    - flag player suffix.current_gui_page:<[new_page_index]>
                - else if <[script_name]> == prev_page:
                    # ~~~ Index handling ~~~ #
                    - define next_page_index <[cur_page].sub[1]>
                    - define new_page_index <tern[<[next_page_index].is[LESS].than[1]>].pass[<[inv_pages].size>].fail[<[next_page_index]>]>
                    - adjust <context.inventory> contents:<[inv_pages].get[<[new_page_index]>]>
                    - flag player suffix.current_gui_page:<[new_page_index]>
            - else if <context.item.material.name> != air:
                # ~~~ Check and add suffix ~~~ #
                - inject locally remove_suffix
                - execute as_server "lp user <player.name> meta addsuffix 1 <&dq><&8>[<context.item.display><&8>]<&dq>"
                - narrate "<[format]> Your suffix is now <context.item.display>."
                - inventory close
                - flag player suffix:!
    remove_suffix:
        - execute as_server "lp user <player.name> meta clear suffixes"

generic_inventory:
    type: inventory
    inventory: chest
    title: <reset>Suffix Selector
    size: 9

remove_suffix:
    type: item
    material: barrier
    display name: <reset>Remove Suffix

next_page:
    type: item
    material: lime_stained_glass_pane
    display name: <reset>Next Page

prev_page:
    type: item
    material: red_stained_glass_pane
    display name: <reset>Previous Page

no_next_page:
    type: item
    material: gray_stained_glass_pane
    display name: <reset>Next Page

no_prev_page:
    type: item
    material: gray_stained_glass_pane
    display name: <reset>Previous Page