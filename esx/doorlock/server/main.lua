ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local doorInfo = {}

RegisterServerEvent('rl-doorlock:server:setupDoors')
AddEventHandler('rl-doorlock:server:setupDoors', function()
	local src = source
	TriggerClientEvent("rl-doorlock:client:setDoors", RLConfig.Doors)
end)

RegisterServerEvent('rl-doorlock:server:updateState')
AddEventHandler('rl-doorlock:server:updateState', function(doorID, state)
	local src = source
	local Player = ESX.GetPlayer(src)
	
	RLConfig.Doors[doorID].locked = state

	TriggerClientEvent('rl-doorlock:client:setState', -1, doorID, state)
end)