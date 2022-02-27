
ESX = nil

Citizen.CreateThread(function()
	while not ESX do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(100)
	end
end)

function CreateBlip3(coords)
	local blip3 = AddBlipForCoord(coords)

	SetBlipSprite(blip3, 52)
	SetBlipScale(blip3, 1.0)
	SetBlipColour(blip3, 2)
	SetBlipDisplay(blip3, 4)
	SetBlipAsShortRange(blip3, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Market")
	EndTextCommandSetBlipName(blip3)

	return blip3
end

local ShowNearestGasStationOnly = true

if ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentShopBlip = 0

		while true do
			Citizen.Wait(10000)

			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for k,v in pairs(Config.Shops) do
				local dstcheck = GetDistanceBetweenCoords(coords, v)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = v
				end
			end

			if DoesBlipExist(currentShopBlip) then
				RemoveBlip(currentShopBlip)
			end

			currentShopBlip = CreateBlip3(closestCoords)
		end
	end)
elseif not ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		for k,v in pairs(Config.Shops) do
			CreateBlip3(v)
		end
	end)
end


function CreateBlip4(coords)
	local blip4 = AddBlipForCoord(coords)

	SetBlipSprite(blip4, 93)
	SetBlipScale(blip4, 1.0)
	SetBlipColour(blip4, 2)
	SetBlipDisplay(blip4, 2)
	SetBlipAsShortRange(blip4, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Bar")
	EndTextCommandSetBlipName(blip4)

	return blip4
end


if ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentBarBlip = 0

		while true do
			Citizen.Wait(10000)

			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for k,v in pairs(Config.Bars) do
				local dstcheck = GetDistanceBetweenCoords(coords, v)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = v
				end
			end

			if DoesBlipExist(currentBarBlip) then
				RemoveBlip(currentBarBlip)
			end

			currentBarBlip = CreateBlip4(closestCoords)
		end
	end)
elseif not ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		for k,v in pairs(Config.Bars) do
			CreateBlip4(v)
		end
	end)
end

function CreateBlip5(coords)
	local blip5 = AddBlipForCoord(coords)

	SetBlipSprite(blip5, 108)
	SetBlipScale(blip5, 1.0)
	SetBlipColour(blip5, 2)
	SetBlipDisplay(blip5, 2)
	SetBlipAsShortRange(blip5, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Banka")
	EndTextCommandSetBlipName(blip5)

	return blip5
end


if ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentBankBlip = 0

		while true do
			Citizen.Wait(10000)

			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for k,v in pairs(Config.Bank) do
				local dstcheck = GetDistanceBetweenCoords(coords, v)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = v
				end
			end

			if DoesBlipExist(currentBankBlip) then
				RemoveBlip(currentBankBlip)
			end

			currentBankBlip = CreateBlip5(closestCoords)
		end
	end)
elseif not ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		for k,v in pairs(Config.Bank) do
			CreateBlip5(v)
		end
	end)
end


function CreateBlip6(coords)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 361)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 4)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Benzin Istasyonu")
	EndTextCommandSetBlipName(blip)

	return blip
end

if Config.ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentGasBlip = 0

		while true do
			Citizen.Wait(10000)

			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for k,v in pairs(Config.GasStations) do
				local dstcheck = GetDistanceBetweenCoords(coords, v)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = v
				end
			end

			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end

			currentGasBlip = CreateBlip6(closestCoords)
		end
	end)
elseif Config.ShowAllGasStations then
	Citizen.CreateThread(function()
		for k,v in pairs(Config.GasStations) do
			CreateBlip6(v)
		end
	end)
end