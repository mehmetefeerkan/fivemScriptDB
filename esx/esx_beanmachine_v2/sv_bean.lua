ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('icelimmi')
AddEventHandler('icelimmi', function(id, item, count, label)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  		
	TriggerClientEvent('icecekhazirladim', _source)
	Citizen.Wait(9700)
	xPlayer.addInventoryItem(item, count)		
end)

