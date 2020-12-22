Terrian_Join:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - 1 Terrian_interact
        
Terrian_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - chat "hmmm... you wish have rock power? <gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
                    - wait 2
                    - chat "hmmm..."
            chat trigger:
                script:
                1:
                    trigger: /yes/, I wish to be like you
                    script:
                        - chat "you want be Terrian... hmmm..."
                        - wait 2
                        - chat "bring <blue>Redstone, coal, Iron, lapis, Gold, Emerald, Diamond block <green> and you be Terrian too"
                        - zap 2
                2:
                    trigger: /no/, uh.. no thanks?
                    script:
                        - chat "hmmm..."
                3:
                    trigger: /?/, Whats it like being a Terrian?
                    script:
                        - chat "become strong, use power in ore"
                        - wait 2
                        - chat "rock good, all other bad."
        2:
            click trigger:
				script:
                - if <player.inventory.contains[redstone_block|coal_block|iron_block|lapis_block|gold_block|emerald_block|diamond_block]>:
                    - take coal_block quantity:1
                    - take redstone_block quantity:1
                    - take iron_block quantity:1
                    - take lapis_block quantity:1
                    - take gold_block quantity:1
                    - take emerald_block quantity:1
                    - take diamond_block quantity:1
                    - chat "hmmm... yummm"
                    - wait 2
                    - chat "You are Terrian..."
                    - team name:Terrian add:<player.name>
                    - narrate "you suddenly feel energy coming from the stone beneath you"
                    - zap 3
                - else:
                    - chat "hmmm... still need ores <blue>Redstone, coal, Iron, lapis, Gold, Emerald, Diamond block<green>"
                    - wait 2
                    - chat "hmmm..."
        3:
            click trigger:
                script:
                    - chat "<player.name>, you are back"
                    - wait 2
                    - chat "you dont want be Terrian? <gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, sorry, not anymore...
                    script:
                    - narrate "suddenly it feels as if a very large part of you is gone"
                    - team name:Terrian remove:<player.name>
                    - chat "hmmm... I take back"
                    - zap 1
                2:
                    trigger: /no/, no way rock buddy!
                    script:
                    - chat "hmmm..."