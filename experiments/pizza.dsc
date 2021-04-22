pizza_orderer:
    type: world
    events:
        on player right clicks stone_button:
            - ratelimit 1d
            - if <context.location> == <location[-14,72,-140,world]>:
                - if <player.name> == TheCreeper35 || <player.name> == jumpsplat120:
                    - toast "It's Pizza Time" targets:<server.online_players> icon:pumpkin_pie frame:challenge
                    - webget https://maker.ifttt.com/trigger/pizza/with/key/[INSERT_KEY_HERE] method:POST
                - else:
                    - narrate "Sorry! Looks like you don't have pizza permission."