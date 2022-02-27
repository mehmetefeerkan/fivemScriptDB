ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_armour:armourkod')
AddEventHandler('esx_armour:armourkod', function()
		local playerPed = PlayerPedId()
		Citizen.CreateThread(function()
				SetPedArmour(playerPed, 100)			
		end)
end)

RegisterNetEvent('esx_armour:armour')
AddEventHandler('esx_armour:armour', function()
		local playerPed = PlayerPedId()
		Citizen.CreateThread(function()
			armourAnim()
			exports["t0sic_loadingbar"]:StartDelayedFunction("Ağır zırh giyiyorsun", 3200, function()
				SetPedArmour(playerPed, 100)
				ClearPedTasks(playerPed)			
			end)
		end)
end)

RegisterNetEvent('esx_armour:armourhalf')
AddEventHandler('esx_armour:armourhalf', function()
		local playerPed = PlayerPedId()
		
		Citizen.CreateThread(function()
			armourAnim()
			exports["t0sic_loadingbar"]:StartDelayedFunction("Hafif zırh giyiyorsun", 3200, function()
				SetPedArmour(playerPed, 50)
				ClearPedTasks(playerPed)
			end)
		end)
end)

function armourAnim()
	local animdict = "missmic4"
	local anim = "michael_tux_fidget"
	local playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	loadAnimDict(animdict) 
	TaskPlayAnim(playerPed, animdict, anim, 8.0, 1.0, -1, 51, 0, 0, 0, 0)
	--ClearPedTasks(playerPed)
end


function loadAnimDict( dict )
		while ( not HasAnimDictLoaded( dict ) ) do
			RequestAnimDict( dict )
			Citizen.Wait( 0 )
		end
end