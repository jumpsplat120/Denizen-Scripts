Mermot_Join:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
        - 1 Mermot_Join_interact
        
Mermot_Join_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - chat "Hello <player.name>, Have you come to seek my blessing? <gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
                    - wait 2
                    - chat "speak up, or be gone with you..."
            chat trigger:
                script:
                1:
                    trigger: /yes/, I Seek your blessing
                    script:
                        - chat "Then you must bring me an offering"
                        - wait 2
                        - chat "Bring me a <blue>Conduit <green>and I will bestow my blessing upon you"
                        - zap 2
                2:
                    trigger: /no/, I dont think im ready for that
                    script:
                        - chat "then be gone from here! you are not welcome in this sacred grotto!"
                3:
                    trigger: /?/, What does it mean to recieve your blessing?
                    script:
                        - chat "You will be able to walk the ocean floors, swim at great speeds, and live as I do"
                        - wait 2
                        - chat "But be warned, you will no long walk the land as you are acustomed to..."
        2:
            click trigger:
				script:
				- if <player.inventory.contains.material[conduit]>:
                    - take conduit quantity:1
                    - chat "Impresive.. you have the <blue>conduit"
                    - wait 2
                    - chat "As promised, you may now recieve my blessing"
                    - team name:Mer add:<player.name>
                    - narrate "You feel empowered, you are now a Mer!"
                    - zap 3
                - else:
                    - chat "still no <blue>conduit <green>hm? how dissapointing"
                    - wait 2
                    - narrate "<npc.name> seems to be annoyed"
        3:
            click trigger:
                script:
                    - chat "Welcome back my child, the blessing has not become a burden to you has it?"
                    - wait 2
                    - chat "would you like me to take it back?  <gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, it has become too much for me.. atleast for now
                    script:
                        - narrate "you feel Mermot's blessing leave you"
                        - team name:Mer remove:<player.name>
                        - chat "It is done..."
                        - zap 1
                2:
                    trigger: /no/, of course not.
                    script:
                        - chat "A wise decision"