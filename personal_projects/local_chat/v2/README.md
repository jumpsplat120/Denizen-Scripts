# VERSION 2

```
@author jumpsplat120
@date 05/17/2021
@denizen-build 1.2.0-b1739-REL
@script-version 2.1
```

Any two players whose distance is smaller than `whisper_range` will be able to hear when they begin and end their message with `whisper_character`. Any two players whose distance is larger than `whisper_range` and smaller than `talking_range` will be able to hear each other with no issues. Be aware that the distance is a straight line, and will go through walls and the like. For two players whose distance is larger than `talking_range`, but smaller than `shouting_range` will be able to hear each other, as long as the message is appended with an exclimation point. For two players whose distance is larger than `shouting_range` but smaller than `screaming_range` will only be able to hear each other if the player is typing in all caps, and ending the message with an exclimation point. Any two players who are outside of the `screaming_range` of each other will no longer be able to hear each other at all.

Any player underneath the upper_talking_limit divided by the falloff point ((utl / fop).round) will transmit all letters of their message. If they are above that value, but still underneath the utl, then characters will be removed from the message (Any character except space will be removed), until they've reached the utl, at which no message will be transmitted.

All of the above also holds true for the upper_shouting_limit, as long as the message is in all caps (if there are no alphabetic letters, the message is automatically characterized as all caps.)

For more information, visit here: https://www.youtube.com/watch?v=8Fn0w_dI0V4