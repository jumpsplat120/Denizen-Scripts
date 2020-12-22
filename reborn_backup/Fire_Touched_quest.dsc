Fire_Touched_Join:
    type: assignment
    actions:
        on assignment:
            - trigger name:click state:true
    interact scripts:
        - 1 Fire_Touched_interact
        
Fire_Touched_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - chat "<player.name>... Is it true power that you seek?"
                    - chat "<gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
                    - wait 2
                    - chat "Answer, BEFORE I CUT YOU DOWN!"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I Seek your power
                    script:
                        - chat "Of course you do"
                        - wait 2
                        - chat "Deliver to me a <blue>Nether Star <green>And I will make you one of my Fire Touched"
                        - zap 2
                2:
                    trigger: /no/, on second thought I dont think it's for me
                    script:
                        - chat "You will die a cold husk..."
                3:
                    trigger: /?/, what does it mean to be Fire Touched?
                    script:
                        - chat "The flame will never hurt you, it will embrace you, healing your wounds and make you faster"
                        - wait 2
                        - chat "But you must never let the fire die out... Water will be the death of you"
        2:
            click trigger:
				script:
				- if <player.inventory.contains.material[nether_star]>:
                    - take nether_star quantity:1
                    - chat "HAHAHAAAA!!! YOU HAVE IT! <blue>nether star"
                    - wait 2
                    - chat "With the offering of this nether star I make you one of my Fire Touched!"
                    - team name:Fire_Touched add:<player.name>
                    - narrate "Flames crawl up you, yet you do not burn. You are Fire Touched"
                    - zap 3
                - else:
                    - chat "Why are you here?! Dont return until you have retrieved the <blue>nether star"
                    - wait 2
                    - narrate "<npc.name> has a very deadly look in his glowing eyes"
        3:
            click trigger:
                script:
                    - chat "welcome back <player.name>, The Flame has become more than you can bare has it?"
                    - wait 2
                    - chat "do you wish to be cold once more? <gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I cannot hold this great power as you can
                    script:
                        - narrate "you feel Caine's power leave you"
                        - team name:Fire_Touched remove:<player.name>
                        - chat "Perhaps you where never worthy"
                        - zap 1
                2:
                    trigger: /no/, I would never give this up!
                    script:
                        - chat "HAHAHAAA! of course not"