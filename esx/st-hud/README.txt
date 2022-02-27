FIVEM SALES & TRADING
http://discord.gg/5bskZZ7
-------------------------------------------------

NOPIXEL V2 STATUS HUD
_________________________________________________


NOTE: Some people have reported the Oxygen bar overflowing the box.
This seems apparently different for each person.

If you have this issue I recommended editing the following code, you may need to play with it a bit to find what suits you.

client.lua > line 81
local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 4

Thank you :)



