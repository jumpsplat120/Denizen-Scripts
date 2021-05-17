# +--------------------
# |
# | FUNCTIONAL BOOKSHELVES
# |
# | Extra roleplay geared functionality for vanilla bookshelves, made for play.antebellummc.com
# |
# +----------------------
#
# @author jumpsplat120
# @date 05/17/2021
# @denizen-build 1.2.0-b1739-REL
# @script-version 1.2
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
# --------------------END HEADER / START CONFIG--------------------

# Formatting goes in front of every line. Change the formatting to change how every line appears,
# or add <reset> in front a specific line to add custom formatting for that line specifically.

narration:
    type: data
    formatting: <gray><italic>
    prevent: "A magical force prevents you from removing the book from the shelf."
    single: "You can only check out one book at a time."
    exists: "There already seems to be a book here."
    remove: "You remove the book from the shelf."
    placed: "You place the book on the shelf."
    copy: "The bookshelf gives you a temporary copy, when interacted with will fade away."
    fake: "You are unable to place this temporary copy on the shelf."
    none: "There don't seem to be any books here."
    look: "A book on the shelf catches your eye:"
    fade: "The book faded away."

# --------------------------END CONFIG--------------------------

bookshelf:
    type: world
    debug: false
    events:
        on player left clicks bookshelf:
            - ratelimit <player> 5t
            - define item <context.item>
            - if !<[item].material.advanced_matches[*_axe]>:
                - define n              <script[narration]>
                - define f              <[n].parsed_key[formatting]>
                - define item_is_book   <[item].material.name.equals[written_book]>
                - define shelf_contents <context.location.flag[bookshelf].if_null[empty]>
                - if <[item_is_book]>:
                    - if !<[shelf_contents].equals[empty]>:
                        - narrate <[f]><[n].parsed_key[exists]>
                    - else if <[item].has_flag[temp_book]>:
                        - narrate <[f]><[n].data_key[fake]>
                    - else:
                        - adjust def:item quantity:1
                        - flag <context.location> bookshelf:|:<[item]>|<player>
                        - take iteminhand
                        - narrate <[f]><[n].data_key[placed]>
                - else if !<[shelf_contents].equals[empty]>:
                    - define book <[shelf_contents].get[1].as_item>
                    - if <player.is_sneaking> && <[shelf_contents].get[2].is[==].to[<player>]>:
                        - give <[book]>
                        - flag <context.location> bookshelf:!
                        - narrate <[f]><[n].parsed_key[remove]>
                    - else if <player.is_sneaking>:
                        - narrate <[f]><[n].parsed_key[prevent]>
                    - else if <player.has_flag[checked_out]>:
                        - narrate <[f]><[n].parsed_key[single]>
                    - else:
                        - flag player checked_out
                        - give "<[book].with[flag=temp_book;lore=<gray>by <[book].book_author>|<gray>Ghostly;hides=item_data]>"
                        - narrate <[f]><[n].parsed_key[copy]>
                - else:
                    - narrate <[f]><[n].parsed_key[none]>
        on player right clicks bookshelf:
            - ratelimit <player> 5t
            - define n    <script[narration]>
            - define f    <[n].parsed_key[formatting]>
            - define book <context.location.flag[bookshelf].get[1].as_item.if_null[null]>
            - narrate "<[f]><[book].equals[null].if_true[<[n].parsed_key[none]>].if_false[<[n].parsed_key[look]><&nl><reset><[book].book_title><[f]> by <reset><[book].book_author>]>"
        on player drops written_book:
            - define type remove
            - inject bookshelf path:get_rid_of_book
        on player clicks written_book in player:
            - define type take
            - inject bookshelf path:get_rid_of_book
        on player breaks bookshelf location_flagged:bookshelf:
            - determine <list[<context.location.flag[bookshelf].get[1].as_item>|book|book]>
            - flag <context.location> bookshelf:!
        on bookshelf burns location_flagged:bookshelf:
            - drop <context.location.flag[bookshelf].get[1].as_item>|book|book <context.location>
            - flag <context.location> bookshelf:!
        on primed_tnt explodes:
            - foreach <context.blocks>:
                - if <[value].has_flag[bookshelf]>:
                    - drop <[value].flag[bookshelf].get[1].as_item>|book|book <[value]>
                    - flag <[value]> bookshelf:!
    get_rid_of_book:
        - if <context.item.has_flag[temp_book]>:
            - flag player checked_out:!
            - narrate <script[narration].parsed_key[formatting]><script[narration].parsed_key[fade]>
            - if <[type]> == remove:
                - remove <context.entity>
            - else:
                - take slot:<context.slot>
