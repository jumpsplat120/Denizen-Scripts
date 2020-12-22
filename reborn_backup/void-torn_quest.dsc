voidtorn_join:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - 1 voidtorn_interact
        
voidtorn_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - chat "Why have you come to us?"
                    - wait 2
                    - chat "is your will to become us? <gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I do...
                    script:
                        - chat "we have seen this"
                        - wait 2
                        - chat "you will bring us the <blue>Dragon head and Ender Pearl<green> and we will have accepted it"
                        - zap 2
                2:
                    trigger: /no/, I was only curious what that big rip in space was
                    script:
                        - chat "This won't have been when we shall make you us"
                3:
                    trigger: /?/, What are you?
                    script:
                        - chat "We are Void-torn, walkers between the planes. the ender pearl our greatest asset, able to travel great distance and cause temporal shifts"
                        - wait 2
                        - chat "It is not so easy to walk between realities, best to be still when tear through space and time."
        2:
            click trigger:
				script:
                - if <player.inventory.contains.material[dragon_head|ender_pearl]>:
                    - take dragon_head quantity:1
                    - chat "as we have seen it, you joined us at this very moment"
                    - wait 2
                    - chat "the void expands ever further....."
                    - team name:Void-Torn add:<player.name>
                    - narrate "we are whole"
                    - zap 3
                - else:
                    - chat "now is not when you have brought us the Dragon head and Ender Pearl<green>"
                    - wait 2
                    - chat "you will have it later"
        3:
            click trigger:
                script:
                    - chat "Is it time we part already?"
                    - wait 2
                    - chat "<gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I... I think so..
                    script:
                        - narrate "suddenly you feel very alone..."
                        - team name:Void-Torn remove:<player.name>
                        - chat "We will have been one before"
                        - zap 1
                2:
                    trigger: /no/, We have not come to that time yet
                    script:
                        - chat "We know"