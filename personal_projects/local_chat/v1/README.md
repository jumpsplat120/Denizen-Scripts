# VERSION 1

```
@author jumpsplat120
@date 05/17/2021
@denizen-build 1.2.0-b1739-REL
@script-version 1.1
```

Any two players whose distance is smaller than `whisper` will be able to hear when they begin and end their message with `whisper_chr`. Any two players whose distance is smaller than `talking` will be able to hear each other with no issues. Be aware that the distance is a straight line, and will go through walls and the like. For two players whose distance is smaller than `shouting` will be able to hear each other, as long as the message is appended with an exclimation point. For two players whose distance is smaller than `screaming` will only be able to hear each other if the player is typing in all caps, and ending the message with an exclimation point. Any two players who are outside of the `screaming` of each other will no longer be able to hear each other at all.