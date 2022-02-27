# Dependencies

# Installation
- Place folder in resources.
- start thermite in server.cfg

- Make sure you set your order number in the config.lua
- Once your server has started, the mod will request authorization.
- It can take up to 24 hours for the authorization to be approved, so please be patient.
- We recommend disabling the mod once authorization has been requested, and you're waiting for approval.

# Usage
To hook the minigame up to one of your mods, trigger the following event:
- "thermite:start"

Possible parameters:
- callback,difficulty,speed,scoreInc
  
  [arg]        [type]     | [expected] | description
  callback   = (function) |            | the callback function. Both the "result" and "message" are pushed to this function.
  difficulty = (float)    |  0.1-0.9   | the difficulty modifier (regards to key combinations used during minigame)
  speed      = (float)    |  1.0-2.0   | the speed modifier (the rate at which the controls/keys fall)
  scoreInc   = (float)    |  0.1-1.0   | how much to add/remove from the bar per hit/miss?


Example Mod:

MyMod = {
  UsingThermite    = false,
  ThermiteLocation = vector3(111.11,222.22,333.33),
  UseThermiteCtrl  = 38,
}

ThermitePreset = {
  Difficulty = 0.5,
  Speed      = 1.5,
  ScoreInc   = 0.5,
}

ThermiteCallback = function(result,message)
  print("Result: "..tostring(result))
  print("Message: "..tostring(message))

  MyMod.UsingThermite = false
end

Citizen.CreateThread(function(...)
  while true do
    local pPos = GetEntityCoords(PlayerPedId())
    local tPos = MyMod.ThermiteLocation

    local dist = Vdist(pPos.x,pPos.y,pPos.z, tPos.x,tPos.y,tPos.z)
    if dist and dist < 50.0 then
      DrawMarker(4, tPos.x,tPos.y,tPos.z, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.0,1.0,1.0, 255,0,0,155, false,true,2,false)
      if IsControlJustReleased(0, MyMod.UseThermiteCtrl) and dist < 2.0 and not MyMod.UsingThermite then
        MyMod.UsingThermite = true
        TriggerEvent('thermite:start', ThermiteCallback, ThermitePreset.Difficulty, ThermitePreset.Speed, ThermitePreset.ScoreInc)
      end
    end
    Wait(0)
  end
end)
