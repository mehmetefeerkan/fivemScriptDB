ESX = nil
local CreatedGangs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kov_gang:spawnServer')
AddEventHandler('kov_gang:spawnServer', function(spwaned)
	if CreatedGangs[spwaned] == false or CreatedGangs[spwaned] == nil then
		TriggerClientEvent('kov_gang:spawnGang', source, spwaned)
		CreatedGangs[spwaned] = true
	end
end)

RegisterServerEvent('kov_gang:DeleteGang')
AddEventHandler('kov_gang:DeleteGang', function(gang)
	if CreatedGangs[gang] == true then
		TriggerClientEvent("kov_gang:deleteGang", source, gang, Config.NPCS[gang].currentscenerio)
		CreatedGangs[gang] = false
	end
end)

RegisterServerEvent('kov_gang:updateCreate')
AddEventHandler('kov_gang:updateCreate', function(num, state)
	CreatedGangs[num] = state
end)

RegisterServerEvent('kov_gangs:printSv')
AddEventHandler('kov_gangs:printSv', function(text)
	print(text)
end)

RegisterServerEvent('kov_gangs:CurrentScenerio')
AddEventHandler('kov_gangs:CurrentScenerio', function(gang, scenerio)
	Config.NPCS[gang].currentscenerio = scenerio
end)

RegisterServerEvent('kov_gangs:GetCurrentScenerio')
AddEventHandler('kov_gangs:GetCurrentScenerio', function(gang)
	TriggerClientEvent('kov_gang:GetCurrentScenerioCl', source, gang, Config.NPCS[gang].currentscenerio) 
end)

ESX.RegisterServerCallback('kov_gang:getState', function(source, cb, num)
	if CreatedGangs[num] ~= nil then
		cb(CreatedGangs[num])
	else
		cb(false)
	end
end)

