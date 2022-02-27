ESX = nil
local cd = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent("ak4y:checkPed")
		Citizen.Wait(2*60000)
		cd=true
end)

RegisterNetEvent("ak4y:loadPed")
AddEventHandler("ak4y:loadPed", function(pedModel)
    if pedModel ~= nil then
        local mhash = GetHashKey(pedModel)
			while not HasModelLoaded(mhash) do
				RequestModel(mhash)
				Citizen.Wait(10)
			end
		Citizen.Wait(200)
		SetPlayerModel(PlayerId(),mhash)
		SetPedMaxHealth(PlayerPedId(),200)
		SetEntityHealth(PlayerPedId(),200)
		SetPedDefaultComponentVariation(PlayerPedId())
    end
end)

RegisterNetEvent("ak4y:loadDefault")
AddEventHandler("ak4y:loadDefault", function()
	TriggerEvent('esx_skin:karakterYukle')
end)

RegisterNetEvent("ak4y:setNewPed")
AddEventHandler("ak4y:setNewPed", function(model)
	TriggerServerEvent("ak4y:savePed", model)
	Citizen.Wait(200)
	TriggerServerEvent("ak4y:checkPed")
end)

RegisterCommand("pedfix", function()
	TriggerServerEvent("ak4y:checkPed")
end)

RegisterCommand("pedsil", function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		local isMale = skin.sex == 0

		TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
			end)
		end)

	end)
end)