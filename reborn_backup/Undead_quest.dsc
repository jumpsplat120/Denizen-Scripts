Undead_Join:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - 1 Undead_interact
        
Undead_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - chat "do you seek out the blessing of undeath? <gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
                    - wait 2
                    - chat "speak, fragile soul."
            chat trigger:
                script:
                1:
                    trigger: /yes/, I wish to shed my bonds of mortality
                    script:
                        - chat "perhaps then you shall..."
                        - wait 2
                        - chat "bring me the <blue>Totem of Undying <green> of another and the scales shall be balanced and i will make you Undead"
                        - zap 2
                2:
                    trigger: /no/, sorry i just got lost looking around, please dont hurt me!
                    script:
                        - chat "your will is too weak to be one of my undead, be gone..."
                3:
                    trigger: /?/, what will happen to me if i become Undead?
                    script:
                        - chat "You will live as we do, you will be unaturally difficult to kill, poison and rotten flesh part of your diet"
                        - wait 2
                        - chat "suited for below ground you will thrive at digging. beware the sun though... it will be your undoing."
        2:
            click trigger:
				script:
				- if <player.inventory.contains.material[totem_of_undying]>:
                    - take material:totem_of_undying quantity:1
                    - chat "the scales have been balanced..."
                    - wait 2
                    - chat "this will hurt..."
                    - team name:Undead add:<player.name>
                    - narrate "you suddenly feel cold, yet somehow powerful"
                    - zap 3
                - else:
                    - chat "so not return to me until you have the <blue>Totem of Undying<green> of one of your kind"
                    - wait 2
                    - chat "perhaps you would make a better mindless zombie"
        3:
            click trigger:
                script:
                    - chat "<player.name>, welcome back to my sanctum"
                    - wait 2
                    - chat "you dont wish to have your soul back do you? <gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, please! I long to walk in the sun again...
                    script:
                        - narrate "suddenly the world has color again and you feel like yourself once more"
                        - team name:Undead remove:<player.name>
                        - chat "your soul was a poor trade for such a gift anyway"
                        - zap 1
                2:
                    trigger: /no/, Immortality is power
                    script:
                        - chat "indeed"