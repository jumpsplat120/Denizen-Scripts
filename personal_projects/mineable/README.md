# Mineable
## Changes drops of ore blocks to decrease progression rate of vanilla game.

```
@author jumpsplat120
@date 05/19/21
@denizen-build 1.2.0-b1739-REL
@script-version 1.0.1
```

### Installation
Place the following scripts in your scripts folder and reload:
   * mineable.dsc
   * /utilities

Place the textures on your server, or if just testing, locally on your own client. Reload the textures.

### Usage
Simply mine any vanilla ore, and the drops will instead be ore pieces (or in the case of some ores, the drops will be the same [nether gold ore, redstone ore, lapis ore, nether quartz ore]). Fragments can be combined in a crafting table to get one whole material, and in the case of gold and iron, will need to be smelted into nuggets first.

The block has a 10% chance of breaking on each mine, meaning that there is technically a higher return on ores with this plugin, but time spent and randomness means it won't be any noticeable amount. Drops are affected by fortune. The equation for resource drops is `rand(1, rand(1, 3) * fortune_level)`. What this means is each fortune level, the theoretical maximum upper limit increases by three. On average, the upper limit is `fortune_level * 1.5`. XP for diamond or emerald ore is `rand(1, 3)`, while XP for everything else is `rand(0, 1)`.