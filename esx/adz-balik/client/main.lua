ESX = nil

cachedData = {
	
}

Citizen.CreateThread(function()
	while not ESX do
		--Fetching esx library, due to new to esx using this.

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end

	if Config.Debug then
		ESX.UI.Menu.CloseAll()

		RemoveLoadingPrompt()

		SetOverrideWeather("EXTRASUNNY")

		Citizen.Wait(2000)

		TriggerServerEvent("esx:useItem", Config.FishingItems["rod"]["name"])
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

RegisterNetEvent("james_fishing:tryToFish")
AddEventHandler("james_fishing:tryToFish", function()
	TryToFish()
end)

Citizen.CreateThread(function()
	Citizen.Wait(500) -- Init time.

	HandleCommand()

	HandleStore()

	while true do
		local sleepThread = 500

		local ped = cachedData["ped"]
		
		if DoesEntityExist(cachedData["storeOwner"]) then
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = #(pedCoords - GetEntityCoords(cachedData["storeOwner"]))

			if dstCheck < 3.0 then
				sleepThread = 5

				local displayText = not IsEntityDead(cachedData["storeOwner"]) and "Balığı satmak için ~INPUT_CONTEXT~ tuşuna bas." or "Adam ölü, doğal olarak balığı ona satamazsın."
	
				if IsControlJustPressed(0, 38) then
					SellFish()
				end

				ESX.ShowHelpNotification(displayText)
			end
		end
		
		Citizen.Wait(sleepThread)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)

		local ped = PlayerPedId()

		if cachedData["ped"] ~= ped then
			cachedData["ped"] = ped
		end
	end
end)