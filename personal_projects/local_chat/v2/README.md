# VERSION 2

```
@author jumpsplat120
@date 05/17/2021
@denizen-build 1.2.0-b1739-REL
@script-version 2.1
```

Simply chat in game! Any player underneath a **talking limit** divided by the `falloff_point` ((**talking_limit** / `falloff_point`).round) will transmit all letters of their message. If they are above that value, but still underneath the **talking limit**, then characters will be removed from the message (Any character except space will be removed), until they've reached the talking_limit, at which no message will be transmitted.

The `whisper` **talking limit** is when the message begins and ends with the whisper character. `talking` is any regular speech. `shouting` is when the text ends in an exclimation point, and `screaming` is ending in an exclimation while all the alphabetic characters are uppercase. Non-alphabetic characters count as uppercase.