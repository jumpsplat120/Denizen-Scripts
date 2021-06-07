# WATERING CANS
## Bonemeal is so 1841!

```
@author jumpsplat120
@date 05/17/2021
@denizen-build 1.2.0-b1741-REL
@script-version 1.0
```

### Installation
Place the following scripts in your scripts folder:
   * watering_cans.dsc
   * /utilities

Add the textures to your server resource pack. Since it is using custom sounds, the resources need to be a server resource pack rather than a client resource pack.

### Usage
To craft a watering can, do the following pattern:
```   R = Resource / B = Bonemeal / O = Bowl / A = Air

             [R][B][A]
             [R][O][R]
             [A][R][A]
```
Right click your watering can in water to fill it up. All watering cans hold the same amount of water (`refill`), but higher level cans affect wider ranges of crop, and will grow plants faster. The `range` and chance to grow (`chance` [1 of x]) are all configurable in wc_config.
