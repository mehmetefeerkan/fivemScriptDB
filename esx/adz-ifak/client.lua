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
ExecuteCommand('e ot')
exports["np-taskbar"]:taskBar(4000, "Yaktın ve İciyorsun")
  armorarti = true
  if (armor < 100 and armor >= 0 )  then
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
  ExecuteCommand('e ot')
  exports["np-taskbar"]:taskBar(4000, "Kan Donduruluyor")
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

RegisterNetEvent('hasan:onDalgictupu')
AddEventHandler('hasan:onDalgictupu', function()
	local playerPed = GetPlayerPed(-1)
	exports['mythic_progbar']:Progress({
		name = "dalgictupu",
		duration = 7000,
		label = 'Dalgıç tüpü kullanılıyor...',
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			local pCoords = GetEntityCoords(playerPed)
			local boneIndex  = GetPedBoneIndex(playerPed, 12844)
			local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
			local mask = CreateObject(GetHashKey('p_s_scuba_mask_s'), pCoords.x, pCoords.y, pCoords.z - 3, 1, 1, 1)
			local tank = CreateObject(GetHashKey('p_s_scuba_tank_s'), pCoords.x, pCoords.y, pCoords.z - 3, 1, 1, 1)
			AttachEntityToEntity(tank, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			AttachEntityToEntity(mask, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			SetPedDiesInWater(playerPed, false)
			
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Dalgıç tüpünü giydin.'})
			Citizen.Wait(120000)
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Oksijen tüpünde kalan: %75'})
			Citizen.Wait(100000)
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Oksijen tüpünde kalan: %35'})
			Citizen.Wait(100000)
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Oksijen tüpünde kalan: %0'})
			
			SetPedDiesInWater(playerPed, true)
			DeleteObject(mask)
			DeleteObject(tank)
			ClearPedSecondaryTask(playerPed)
		end
	end)
end)