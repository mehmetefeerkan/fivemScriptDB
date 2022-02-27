thermite.init = function()
  thermite.uiMsg("Init")
  thermite.uiMsg("ApplyConfig",uiCfg)
end

Citizen.CreateThread(thermite.init)

thermite.uiMsg = function(f,a)
  SendNUIMessage({
    ["function"] = f,
    ["arguments"] = a,
  })
end

thermite.uiFocus = function(f)
  SetNuiFocus(f,f)
end

thermite.startMinigame = function(callback,diff,speed,inc)
  if cfg.useESX and cfg.useItem then
    for k,v in pairs(ESX.GetPlayerData().inventory) do
      if v.name == cfg.itemName then
        if v.count <= 0 then
          if callback then
            callback(false,messages.notEnoughItem)
            return
          end
        end
      end
    end
  end

  local settings = {
    scoreInc   = (inc   or uiCfg.scoreInc),
    difficulty = (diff  or uiCfg.difficulty),
    speedScale = (speed or uiCfg.speedScale),
  }

  thermite.result = false

  thermite.uiMsg("ApplyConfig",settings)
  thermite.uiMsg("SetAlpha",1.0)
  thermite.uiMsg("Start")
  thermite.uiFocus(true)

  if callback then
    while not thermite.result do Wait(0); end
    local success = (thermite.result == 1 and true or false)
    local msg = thermite.resultMsg

    thermite.result = false
    thermite.resultMsg = false

    callback(success,msg)
    return
  end
end

thermite.onStart = function(...)
  --print("On Start")
end

thermite.onStop = function(...)
  --print("On Stop")  
end

thermite.onStartCountdown = function(...)
  --print("On Start Count")  
end

thermite.onCount = function(...)
  --print("On Count")  
end

thermite.onHit = function(...)
  --print("On Hit")  
end

thermite.onMiss = function(...)
  --print("On Miss")  
end

thermite.onFail = function(...)
  Wait(2000)
  thermite.uiMsg("SetAlpha",0.0)
  thermite.uiFocus(false)

  if cfg.fireOnFail then
    local r = math.random(100)
    if r <= cfg.fireChance then
      StartEntityFire(PlayerPedId())
    end
  end

  if cfg.useESX and cfg.useItem and cfg.takeItemOnFail then
    TriggerServerEvent('thermite:takeThermite',cfg.takeOnFailCount)
  end

  thermite.resultMsg = messages.failMsg
  thermite.result    = 0  
end

thermite.onSuccess = function(...)
  Wait(2000)
  thermite.uiMsg("SetAlpha",0.0)
  thermite.uiFocus(false)

  if cfg.useESX and cfg.useItem and cfg.takeItemOnSuccess then
    TriggerServerEvent('thermite:takeThermite',cfg.takeOnSuccessCount)
  end

  FreezeEntityPosition(PlayerPedId(),true)

  local ply = PlayerPedId()
  local weapon = GetHashKey('WEAPON_PETROLCAN')
  GiveWeaponToPed(ply, weapon, 1, false, true)
  SetCurrentPedWeapon(ply, weapon, true)

  local dict2 = "weapon@w_sp_jerrycan"
  local anim2 = "fire"
  while not HasAnimDictLoaded(dict2) do RequestAnimDict(dict2) Citizen.Wait(0); end;

  TaskPlayAnim(ply, dict2, anim2, 8.0, 8.0, 2000, 1, 1.0, 0,0,0);

  local started = GetGameTimer()
  while (GetGameTimer() - started) < 2000 do Wait(0); end

  RemoveWeaponFromPed(ply,weapon)

  FreezeEntityPosition(PlayerPedId(),false)

  local pos = GetEntityCoords(PlayerPedId())
  local dist = utils.vecDist(pos,GetEntityCoords(PlayerPedId()))

  local temp = utils.drawTextTemplate()
  temp.x = 0.5
  temp.y = 0.8
  temp.font = 7
  temp.colour1 = 255
  temp.colour2 = 255
  temp.colour3 = 255
  temp.colour2 = 255
  temp.text = "Move away from the thermite to trigger the explosion."

  while dist < 6.0 do
    dist = utils.vecDist(pos,GetEntityCoords(PlayerPedId()))
    utils.drawText(temp)
    Wait(0)
  end

  local fire = thermite.startExplosion(pos)

  thermite.resultMsg = messages.successMsg
  thermite.result    = 1  

  thermite.endFire(fire)
end

thermite.startExplosion = function(pos)
  local explosionType = 3
  local radius = 1.0
  local damage = 50.0

  local found,z = GetGroundZFor_3dCoord(pos.x,pos.y,pos.z)
  AddExplosion(pos.x,pos.y,pos.z, 0, damage, true,false,radius,false,false,1.0)
  local fire = StartScriptFire(pos.x,pos.y,(found and z or pos.z), 25, false)
  return fire
end

thermite.endFire = function(fire)
  Citizen.CreateThread(function(...)
    local startTime = GetGameTimer()
    while (GetGameTimer() - startTime) < 15000 do Wait(0); end
    RemoveScriptFire(fire)
  end)
end

RegisterNUICallback('onStart',thermite.onStart)
RegisterNUICallback('onStop',thermite.onStop)
RegisterNUICallback('onStartCountdown',thermite.onStartCountdown)
RegisterNUICallback('onCount',thermite.onCount)
RegisterNUICallback('onHit',thermite.onHit)
RegisterNUICallback('onMiss',thermite.onMiss)
RegisterNUICallback('onFail',thermite.onFail)
RegisterNUICallback('onSuccess',thermite.onSuccess)

if cfg.debug then
  RegisterCommand('testtherm', function(...) thermite.startMinigame(); end)
end

AddEventHandler('thermite:start',thermite.startMinigame)


MyMod = {
  UsingThermite    = false,
  ThermiteLocation = vector3(122.29,214.05,107.31),
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

