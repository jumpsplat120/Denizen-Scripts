Wind_Walker_Join:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - 1 Wind_Walker_interact
        
Wind_Walker_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - chat "Have you come seeking to learn the way of the Wind Walker? <gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
                    - wait 2
                    - chat "I can bestow this gift upon you"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I wish to become a Wind Walker
                    script:
                        - chat "very well"
                        - wait 2
                        - chat "An <blue>Elytra <green> will be required to complete your training"
                        - zap 2
                2:
                    trigger: /no/, im just visiting this incredible sanctuary
                    script:
                        - chat "then please, take rest and find your center while you are here"
                3:
                    trigger: /?/, What are Wind Walkers capable of?
                    script:
                        - chat "We are masters of acrobatics, jumping twice as high as anyone else, and we are able to control the air beneath us to slow our fall"
                        - wait 2
                        - chat "this does come with its drawbacks though, the light touch required for this technique will render your mele abilitys much weaker"
        2:
            click trigger:
				script:
				- if <player.inventory.contains.material[elytra]>:
                    - take elytra quantity:1
                    - chat "well done."
                    - wait 2
                    - chat "pay attention as I impart this wisdom to you"
                    - team name:Wind_Walker add:<player.name>
                    - narrate "you mind has cleared and you feel much lighter"
                    - zap 3
                - else:
                    - chat "Have you brought back an <blue>Elytra<green> so you may complete your training?"
                    - wait 2
                    - chat "No? perhaps later then"
        3:
            click trigger:
                script:
                    - chat "Hello <player.name>, I hope your new abilities have brought balance to your life"
                    - wait 2
                    - chat "or do you wish to shed yourself of the Wind Walker? <gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I cannot hold this great power as you can
                    script:
                        - narrate "you feel much heavier..."
                        - team name:Wind_Walker remove:<player.name>
                        - chat "peace be with you"
                        - zap 1
                2:
                    trigger: /no/, I am content
                    script:
                        - chat "to be Content is best"