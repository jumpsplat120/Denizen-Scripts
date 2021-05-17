Wolf_Pack_Join:
    type: assignment
    actions:
        on assignment:
        - trigger name:click state:true
    interact scripts:
    - 1 Wolf_Pack_interact
        
Wolf_Pack_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                    - chat "<player.name> isnt it? have you come to join our pack?"
                    - chat "<gold>[<white>yes<gold>] [<white>no<gold>] [<white>?<gold>]"
                    - wait 2
                    - chat "We are always looking for new strong members"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I wish to join the Wolf Pack
                    script:
                        - chat "HA! you will be a stong member im sure."
                        - wait 2
                        - chat "Prove yourself a hunter and bring me the heads of a <blue>Skeleton, Wither Skeleton, creeper, and Zombie <green>And you shall be a fellow wolf in our pack"
                        - zap 2
                2:
                    trigger: /no/, I'm more of a lone wolf
                    script:
                        - chat "then best wishes is all I can offer you"
                3:
                    trigger: /?/, what happens when I join the Wolf Pack?
                    script:
                        - chat "to be alone is to be vaulnerable and weak, but when we are together we are unstopable!"
                        - wait 2
                        - chat "the more that gather, the stronger we become, howl into the sky and begin the hunt!"
        2:
            click trigger:
				script:
				- if <player.inventory.contains.material[skeleton_skull|wither_skeleton_skull|creeper_head|zombie_head]>:
                    - take skeleton_skull quantity:1
                    - take wither_skeleton_skull quantity:1
                    - take creeper_head quantity:1
                    - take zombie_head quantity:1
                    - chat "Impressive, youve already completed your trial"
                    - wait 2
                    - chat "Ill waist no time with formalities, you are now a fellow pack member!"
                    - team name:Wolf_Pack add:<player.name>
                    - narrate "You are now a member of the Wolf Pack"
                    - zap 3
                - else:
                    - chat "you dont seem to have accomplished your task, return when it is done. bring back the skulls of <blue>Skeleton, Wither Skeleton, creeper, and Zombie"
                    - wait 2
                    - narrate "<npc.name> has a stern look on his face as he stares you down with his one good eye"
        3:
            click trigger:
                script:
                    - chat "welcome back <player.name>, you dont wish to become a lone wolf do you?"
                    - wait 2
                    - chat "you are free to leave if that is what you wish <gold>[<white>yes<gold>] [<white>no<gold>]"
            chat trigger:
                script:
                1:
                    trigger: /yes/, I dont need help, my journy is my own.
                    script:
                        - narrate "suddenly you feel very alone..."
                        - team name:Wolf_Pack remove:<player.name>
                        - chat "You will be missed"
                        - zap 1
                2:
                    trigger: /no/, I would never give this up!
                    script:
                        - chat "I thought not"