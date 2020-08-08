# +--------------------
# |
# | FUNCTIONAL BOOKSHELVES
# |
# | Extra roleplay geared functionality for vanilla bookshelves, made for play.antebellummc.com
# |
# +----------------------
#
# @author jumpsplat120
# @date 08/07/2020
# @denizen-build b4994-DEV
# @script-version 1.0
#
# Installation:
# Just put the script in your scripts folder and reload.
#
# Usage:
# Left click on a bookshelf with a written book to place it on the shelf, or
# to check out a transient copy of the book, if one already exists on the
# shelf.
#
# Right click on a bookshelf to view the author and title of a book.
#
# Shift left click on a bookshelf to remove the book placed there, if you
# were the one who put it there. While only the original player can remove
# the book via shift left clicking, the book will drop automatically
# if the bookshelf is burned down or exploded.
#
# --------------------END HEADER / START CONFIG--------------------

# Formatting goes in front of every line. Change the formatting to change how every line appears,
# or add <reset> in front a specific line to add custom formatting for that line specifically.

narration:
    type: data
    formatting: <gray><italic>
    placed: "You place the book on the shelf."
    exists: "There already seems to be a book here."
    remove: "You remove the book from the shelf."
    fake: "You are unable to place this temporary copy on the shelf."
    prevent: "A magical force prevents you from removing the book from the shelf."
    copy: "The bookshelf gives you a temporary copy, when interacted with will fade away."
    none: "There don't seem to be any books here."
    single: "You can only check out one book at a time."
    look: "A book on the shelf catches your eye:"
    fade: "The book faded away."

# --------------------------END CONFIG--------------------------

drop_books_if_appropriate:
    type: task
    debug: false
    script:
        - if <server.has_flag[<context.location>]>:
            - determine passively <list[<server.flag[<context.location>].get[1].as_item>|<item[book]>|<item[book]>]>
            - flag server <context.location>:!

item_is_axe:
    type: procedure
    debug: false
    definitions: item
    script:
        - define axe_list <list[<material[wooden_axe]>|<material[stone_axe]>|<material[iron_axe]>|<material[golden_axe]>|<material[diamond_axe]>|<material[netherite_axe]>]>
        - determine <[axe_list].find[<[item].material>]>

get_rid_of_book:
    type: task
    debug: false
    script:
        - if <player.has_flag[checked_out]>:
            - if <player.flag[checked_out]> == <context.item>:
                - if <[type]> == remove:
                    - remove <context.entity>
                - else if <[type]> == take:
                    - take slot:<context.slot>
                - else:
                    - stop
            - flag player checked_out:!
            - define n <script[narration]>
            - narrate <[n].data_key[formatting].parsed><[n].data_key[fade]>

check_out_book:
    type: task
    debug: false
    script:
        - narrate <[fmt]><[n].data_key[copy]>
        - give <[book]>
        - flag player checked_out:<[book]>

bookshelf:
    type: world
    debug: false
    events:
        on player left clicks bookshelf:
            - ratelimit <player> 5t
            - if !<proc[item_is_axe].context[<context.item>]>:
                - define n <script[narration]>
                - define fmt <[n].data_key[formatting].parsed>
                - define shelf_has_book <server.has_flag[<context.location>]>
                - define checked <player.has_flag[checked_out]>
                - if <context.item.material> == <material[written_book]>:
                    - if !<[shelf_has_book]>:
                        - if <player.flag[checked_out]> == <context.item>:
                            - narrate <[fmt]><[n].data_key[fake]>
                            - stop
                        - define item <context.item>
                        - adjust def:item quantity:1
                        - flag server <context.location>:|:<[item]>|<player>
                        - take iteminhand
                    - narrate <[fmt]><tern[<[shelf_has_book]>].pass[<[n].data_key[exists]>].fail[<[n].data_key[placed]>]>
                - else:
                    - if <[shelf_has_book]>:
                        - define list <server.flag[<context.location>]>
                        - define book <[list].get[1].as_item>
                        - if <player.is_sneaking>:
                            - define is_player <[list].get[2].is[==].to[<player>]>
                            - if <[is_player]>:
                                - give <[book]>
                                - flag server <context.location>:!
                            - narrate <[fmt]><tern[<[is_player]>].pass[<[n].data_key[remove]>].fail[<[n].data_key[prevent]>]>
                        - else if <[checked]>:
                            - narrate <[fmt]><[n].data_key[single]>
                        - else:
                            - inject check_out_book
                    - else:
                        - narrate <[fmt]><[n].data_key[none]>
        on player right clicks bookshelf:
            - ratelimit <player> 5t
            - define fmt <script[narration].data_key[formatting].parsed>
            - define exists <server.has_flag[<context.location>]>
            - if <[exists]>:
                - define book <server.flag[<context.location>].get[1].as_item>
            - narrate "<[fmt]><tern[<[exists]>].pass[<script[narration].data_key[look]><&nl><reset><[book].book_title><[fmt]> by <reset><[book].book_author>].fail[<script[narration].data_key[none]>]>"
        on player drops written_book:
            - define type remove
            - inject get_rid_of_book
        on player clicks written_book in player:
            - define type take
            - inject get_rid_of_book
        on player breaks bookshelf with:wooden_axe:
            - inject drop_books_if_appropriate
        on player breaks bookshelf with:stone_axe:
            - inject drop_books_if_appropriate
        on player breaks bookshelf with:iron_axe:
            - inject drop_books_if_appropriate
        on player breaks bookshelf with:golden_axe:
            - inject drop_books_if_appropriate
        on player breaks bookshelf with:diamond_axe:
            - inject drop_books_if_appropriate
        on player breaks bookshelf with:netherite_axe:
           - inject drop_books_if_appropriate
        on bookshelf burns:
            - if <server.has_flag[<context.location>]>:
                - drop <server.flag[<context.location>].get[1].as_item>|<item[book]>|<item[book]> <context.location>
                - flag server <context.location>:!
        on primed_tnt explodes:
            - foreach <context.blocks>:
                - if <[value].material> == <material[bookshelf]>:
                    - if <server.has_flag[<[value]>]>:
                        - drop <server.flag[<[value]>].get[1].as_item>|<item[book]>|<item[book]> <[value]>
                        - flag server <[value]>:!