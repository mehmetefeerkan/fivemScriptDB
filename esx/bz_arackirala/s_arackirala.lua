ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pantokirala')
AddEventHandler('pantokirala', function()

local xPlayer = ESX.GetPlayerFromId(source)
local money = xPlayer.getMoney()
local para = Config.Panto

if money >= Config.Panto then
	xPlayer.removeMoney(para)
	  TriggerClientEvent('esx:showNotification', source, 'Araç Kiraladın')
      TriggerClientEvent('bz:pantocikart', source)
     else
     TriggerClientEvent('esx:showNotification', source, 'Paran Yetersiz')
    end
end)

RegisterServerEvent('bmxkirala')
AddEventHandler('bmxkirala', function()

local xPlayer = ESX.GetPlayerFromId(source)
local money = xPlayer.getMoney()
local paraa = Config.Bmx

if money >= Config.Bmx then
	xPlayer.removeMoney(paraa)
	  TriggerClientEvent('esx:showNotification', source, 'Bisiklet Kiraladın')
      TriggerClientEvent('bz:bmxcikart', source)
     else
     TriggerClientEvent('esx:showNotification', source, 'Paran Yetersiz')
    end
end)
