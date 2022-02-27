ESX = nil
local timing = math.ceil(1 * 60000)

local Device
local copsOnline
local RobbingATM = false
local HackingATM = false

local streetName
local _

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


-- Refresh police online:
function refreshPlayerWhitelisted()	
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	if Config.PoliceDatabaseName == ESX.PlayerData.job.name then
		return true
	end

	return false
end

function isNight()
 local hour = GetClockHours()
 if hour >= 0 and hour <= 6 then
  return true
 end
end


RegisterNetEvent('atm:item')
AddEventHandler('atm:item', function()
local pos = GetEntityCoords(PlayerPedId())
	if not RobbingATM then
	if not HackingATM then
	for k,v in pairs(Config.ATMs) do
if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.5 then
if isNight() then
startRobbingATM()
	else
	TriggerEvent('notification', 'Soygun yapmak için gece olmasını bekle!', 2)
				end
			end
		end
	end
end
end)


-- Starting ATM Robbery:
function startRobbingATM()
	ESX.TriggerServerCallback("esx_atmRobbery:isRobbingPossible", function(cooldownATM)
		if not cooldownATM then
			ESX.TriggerServerCallback('esx_atmRobbery:getOnlinePoliceCount', function(policeCount)
				if policeCount then
					ESX.TriggerServerCallback('esx_atmRobbery:getHackerDevice', function(hackerDevice)
						if hackerDevice then
							RobbingATM = true
							TriggerServerEvent("esx_atmRobbery:CooldownATM")
							FreezeEntityPosition(player,true)
							local player = PlayerPedId()
							local playerPos = GetEntityCoords(player)
								
							-- animation 1:
							local animDict = "random@atmrobberygen@male"
							local animName = "idle_a"
							
							RequestAnimDict(animDict)
							while not HasAnimDictLoaded(animDict) do
								Citizen.Wait(0)
							end
							
							TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
							exports["t0sic_loadingbar"]:StartDelayedFunction("HACK CIHAZI TAKILIYOR", 12000, function()
							TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
							TriggerEvent("utk_fingerprint:Start", 4, 6, 2, hackingEvent)
							if Config.PoliceNotfiyEnabled then	
								Citizen.Wait(40000)
								TriggerEvent('police:atmRobbery')
							end
							HackingATM = true
							end)
						else
							RobbingATM = false
						end
					end)
				else
					RobbingATM = false
				end
			end)
		else
			RobbingATM = false
		end
	end)
end

-- Hacking Event:
function hackingEvent(success)
	local player = PlayerPedId()
    FreezeEntityPosition(player,false)
    if success then
		TriggerServerEvent("esx_atmRobbery:success")	
		TriggerEvent('notification', 'ATM Başarıyla Hacklendi!', 1)
    else
		TriggerEvent('notification', 'Hack Girişimi Başarısız Oldu!', 2)
		TriggerEvent('notification', 'Hacker Cihazını Makina Bozdu!', 2)
		TriggerServerEvent('itemsil', source)
	end
	ClearPedTasks(player)
	ClearPedSecondaryTask(player)	
	RobbingATM = false
	HackingATM = false
end


-- Thread for Police Notify
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		streetName,_ = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

-- Draw 3D text Function:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

