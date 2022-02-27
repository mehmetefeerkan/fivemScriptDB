ESX = nil
bandana = false
local currentbandananum = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('kov_gangs:bandans')
AddEventHandler('kov_gangs:bandans', function(bandanaNum, jobNum)
   	local ad, ads = "missheist_agency2ahelmet", "mp_masks@standard_car@ds@"
   	local player = PlayerPedId()
   	loadAnimDict(ad)
   	loadAnimDict(ads)
	if not bandana then
		RequestAnimDict(dict)
		TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		Wait(600)
		ClearPedSecondaryTask(PlayerPedId())
		bandana = true
		currentbandananum = bandanaNum
		SetPedPropIndex(GetPlayerPed(-1), 0, 14, bandanaNum, 2)
		TriggerServerEvent('kov_gangs:ChangePlBandana', jobNum)
		TriggerServerEvent('kov_gangs:RemoveItem', currentbandananum)
	elseif bandana then
		--
	end
end)

-- Bencede Bu ikinciye gerek yoktu ama daha basitti napam
RegisterNetEvent('kov_gangs:giveBandanaAuto')
AddEventHandler('kov_gangs:giveBandanaAuto', function(bandanaNum)
   	local ad, ads = "missheist_agency2ahelmet", "mp_masks@standard_car@ds@"
   	local player = PlayerPedId()
   	loadAnimDict(ad)
   	loadAnimDict(ads)
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait(600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, bandanaNum, 2)
	currentbandananum = bandanaNum
end)

RegisterCommand(Config.BandanaCommand, function()
	if bandana then
		SetPedPropIndex(GetPlayerPed(-1), 0, 14,  currentbandananum, 2)
		bandana = false
		TriggerServerEvent('kov_gangs:AddRemoveItem', currentbandananum)
		currentbandananum = nil
		RequestAnimDict(dict)
		TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		Wait(600)
		ClearPedSecondaryTask(PlayerPedId())
		ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
		TriggerServerEvent('kov_gangs:ChangePlBandana')
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end