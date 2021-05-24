# Master Crafter
## A modified form of tool and armor crafting, adding a non-visible leveling system for roleplay gameplay

```
@author jumpsplat120
@date 05/19/2021
@denizen-build 1.2.0-b1739-REL
@script-version 1.3
```

### Installation
Place the following scripts in your scripts folder and reload:
   * master_crafter.dsc
   * /utilities

Place the textures on your server, or if just testing, locally on your own client. Reload the textures.

### Usage
Craft a hammer using basic vanilla materials:
```
   R = resource (wood/cobblestone/iron/gold/diamond)
   S = stick

       [R][R][R]
       [R][S][R]
       [ ][S][ ]
```
Once you have crafted a hammer, simply craft your tool as normal. When you left click or shift left click on the result, it will vanish, and consume the appropriate amount of materials. However, the tool will not be provided until you back out of the GUI, and right click on the table with the hammer. If you hear a clanging sound, the tool is being crafted. Continue clicking on the crafting bench until the tool is provided for you. If you need to modify you level, and you have operator level permissions, you can use the command /set_level (player:<name>) [item:<name>] [level:<number>] to automatically set you level to any value. If you do not specify a player, the level command will default to the player running the command.
