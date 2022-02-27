ESX              = nil
local Categories = {}
local Vehicles   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function VehBuy (accountId, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll([===[
      SELECT * FROM vehicles
      ]===], {}, cb)
  end 

 
RegisterServerEvent('xentablet:veh_getBuy')
AddEventHandler('xentablet:veh_getBuy', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
    VehBuy(nil, function (vehbuyy)
      TriggerClientEvent('xentablet:veh_getBuy', sourcePlayer, vehbuyy)
    end)
end)


