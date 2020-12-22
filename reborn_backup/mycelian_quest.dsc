Enoki_Join:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
    - 1 Enoki_Join_interact
        
Enoki_Join_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - chat "It is you... <player.name>, have you come to join the collective? <gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
                - wait 2
                - chat ".........."
            chat trigger:
                script:
                1:
                    trigger: /yes/, I wish to be one
                    script:
                    - chat "you must provide an offering then"
                    - wait 2
                    - chat "Bring us the <blue>4 fungi <green>and I will bestow my blessing upon you"
                    - zap 2
                2:
                    trigger: /no/, ew.. thats gross...
                    script:
                    - chat "I would not expect you to understand the power of our gift"
                3:
                    trigger: /?/, What will happen to me if I join?
                    script:
                    - chat "when you become a Mycelian you will find the different spores of the land very... empowering"
                    - wait 2
                    - chat "you will be protected and fed wherever the great fungi grows..."
                    - wait 2
                    - chat "But to stray from our land can be great struggle to a Mycelian"
        2:
            click trigger:
				script:
                - if <player.inventory.contains.material[warped_fungus|crimson_fungus|brown_mushroom|red_mushroom]>:
                    - take warped_fungus quantity:1
                    - take crimson_fungus quantity:1
                    - take brown_mushroom quantity:1
                    - take red_mushroom quantity:1
                    - chat "Very good, you have brought the <blue>Fungi"
                    - wait 2
                    - chat "Welcom, Mycelian..."
                    - team name:mycelian add:<player.name>
                    - narrate "something has changed in you... you are now Mycelian...!"
                    - zap 3
                - else:
                    - chat "why have you returned without the <blue>Fungi <green>dissapointing...."
                    - wait 2
                    - narrate "<npc.name> seems to go back into a trance."
        3:
            click trigger:
                script:
                    - chat "Greetings Mycelian, have you come to rid yourself of the spore?"
                    - wait 2
                    - chat "We can be rid of you if that is what you want?  <gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I wasnt expecting all of this
                    script:
                        - narrate "you feel Enokis's blessing leave you"
                        - team name:mycelian remove:<player.name>
                        - chat "Be gone..."
                        - zap 1
                2:
                    trigger: /no/, of course not.
                    script:
                        - chat "of course not...."