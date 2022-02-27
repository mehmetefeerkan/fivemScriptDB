ESX                             = nil
Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end) 

local wait = 5000
local iyilesme = false
local armorarti = false
function hasananim()
  Anim("mp_arresting", "a_uncuff") 
  exports["np-taskbar"]:taskBar(wait, "Kullanılıyor ")
 ClearPedTasks(PlayerPedId())
end

function Anim(lib, anim)
ESX.Streaming.RequestAnimDict(lib, function()
  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end)
end

RegisterNetEvent("hasan:useitemifak")
AddEventHandler("hasan:useitemifak",function()
  hasananim()
  iyilesme = true
  local health = GetEntityHealth(PlayerPedId())
  if (health < 200)  then
      TriggerEvent("notifiction","Yavaş yavaş iyileşiyorsun")
        while GetEntityHealth(PlayerPedId()) < 200 and iyilesme == true do
            Citizen.Wait(3000)
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
        end
  elseif (health == 200) then
        TriggerEvent("notification","Sağlıyın şuanlık iyi")
  end
end)

RegisterNetEvent("hasan:useitemmarul")
AddEventHandler("hasan:useitemmarul",function()
local ped = PlayerPedId()
local armor = GetPedArmour(ped)
ExecuteCommand('e iç')
  armorarti = true
  if (armor < 100 and armor >= 10 )  then
      TriggerEvent("notification","Yavaş yavaş iyileşiyorsun")
      TriggerEvent("notification","Stressin azaldı",2)
        while armor < 100 and armorarti == true do
            Citizen.Wait(2000)
           SetPedArmour(PlayerPedId(),GetPedArmour(PlayerPedId()) + 1 )
        end
  elseif (armor == 100) then
        TriggerEvent("notification","Buna ihtiyacın yok",2)
  end
end)

function Anim(lib, anim)
ESX.Streaming.RequestAnimDict(lib, function()
  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end)
end

local wait = 5000
local iyilesme = false
RegisterNetEvent("hasan:useitemkan")
AddEventHandler("hasan:useitemkan",function()
  ExecuteCommand('e iç')
  exports["np-taskbar"]:taskBar(4500, "Kan Donduruluyor")
  iyilesme = true
  local health = GetEntityHealth(PlayerPedId())
  if (health < 200)  then
      TriggerEvent("notifiction","Yavaş yavaş iyileşiyorsun")
        while GetEntityHealth(PlayerPedId()) < 200 and iyilesme == true do
            Citizen.Wait(2000)
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
        end
  elseif (health == 200) then
        TriggerEvent("notification","Sağlıyın şuanlık iyi")
  end
end)