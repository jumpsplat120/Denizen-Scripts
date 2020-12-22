# - wishing_well - #
# execute if score #CSGTimerMod60 temp matches 0 run tellraw @p {"text":"It is certain...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 1 run tellraw @p {"text":"As I see it, yes...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 2 run tellraw @p {"text":"Reply hazy, try again...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 3 run tellraw @p {"text":"Don't count on it...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 4 run tellraw @p {"text":"It is decidedly so...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 5 run tellraw @p {"text":"Most likely...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 6 run tellraw @p {"text":"Ask again later...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 7 run tellraw @p {"text":"My reply is no...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 8 run tellraw @p {"text":"My sources say no...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 9 run tellraw @p {"text":"Maybe some day...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 10 run tellraw @p {"text":"Yes definitely...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 11 run tellraw @p {"text":"Yes...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 12 run tellraw @p {"text":"Cannot predict now...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 13 run tellraw @p {"text":"Outlook not so good...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 14 run tellraw @p {"text":"You may rely on it...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 15 run tellraw @p {"text":"Signs point to yes...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 16 run tellraw @p {"text":"Concentrate and ask again...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 17 run tellraw @p {"text":"Very doubtful...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 18 run tellraw @p {"text":"Better not tell you now...","italic":true,"color":"aqua"}
# execute if score #CSGTimerMod60 temp matches 19 run tellraw @p {"text":"Without a doubt...","italic":true,"color":"aqua"}

magic_eight_well:
    type: world
    debug: false
    events:
        on player drops item in:wishing_well_toss_range:
            - define config <script[master_config].data_key[wishing_well]>
            - ratelimit <player> <[config].get[ratelimit]>s
            - wait 2s
            - if <cuboid[magic_eight_well].contains_location[<context.entity.location>]>:
                - narrate <[config].get[whisper].parsed> targets:<cuboid[wishing_well_toss_range].players>
                - wait <util.random.int[<[config].get[wait].get[min]>].to[<[config].get[wait].get[max]>]>t
                - narrate "<green>Mysterious Voice <gold><&lb><gray>?<gold><&rb><white><&co> <[config].get[options].random>" targets:<cuboid[wishing_well_toss_range].players>
                - remove <context.entity>