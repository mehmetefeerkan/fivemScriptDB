ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local BandanaNames = {}

for k,v in pairs(Config.NPCS) do
	ESX.RegisterUsableItem(v.bandanaName, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('kov_gangs:bandans', source, v.bandanaid, k)
		BandanaNames[v.bandanaName] = v.bandanaid
	end)
end

----------------------------------------Data

local JobNameToBandanaId = {}

Citizen.CreateThread(function()	
	Citizen.Wait(300)
	for id, f in pairs(Config.NPCS) do
		JobNameToBandanaId[f.job] = f.bandanaid
	end
end)

local datafl = assert(io.open(Config.DataLocation .. "/"..Config.DataFlName..".txt", "r+"))
local PlayersBandanas = nil
local datasstr = datafl:read("*a") 
PlayersBandanas = json.decode(datasstr)
if PlayersBandanas == nil then
   	PlayersBandanas = {}
end
datafl:close()

RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(data)
    local player = ESX.GetPlayerFromId(data)
	local identifier = player.identifier
	if PlayersBandanas[identifier] ~= nil then
		TriggerClientEvent('kov_gangs:giveBandanaAuto', data, JobNameToBandanaId[PlayersBandanas[identifier]])
	end
end)

RegisterServerEvent('kov_gangs:ChangePlBandana')
AddEventHandler('kov_gangs:ChangePlBandana', function(num)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local identifier = xPlayer.identifier
	if num ~= nil then
		PlayersBandanas[identifier] = Config.NPCS[num].job
	else
		PlayersBandanas[identifier] = nil
	end
end)

RegisterServerEvent('kov_gangs:getPlBandanaSv')
AddEventHandler('kov_gangs:getPlBandanaSv', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local identifier = xPlayer.identifier
	TriggerClientEvent('kov_gangs:PlayerBandana', src, PlayersBandanas[identifier])
end)

RegisterServerEvent('kov_gangs:AddRemoveItem')
AddEventHandler('kov_gangs:AddRemoveItem', function(bandanaNum)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	for k,v in pairs(BandanaNames) do
		if v == bandanaNum then
			local namebandana = k
			Citizen.Wait(10)
			xPlayer.addInventoryItem(namebandana, 1)
		end
	end
end)

RegisterServerEvent('kov_gangs:RemoveItem')
AddEventHandler('kov_gangs:RemoveItem', function(bandanaNum)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	for k,v in pairs(BandanaNames) do
		if v == bandanaNum then
			local namebandana = k
			Citizen.Wait(10)
			xPlayer.removeInventoryItem(namebandana, 1)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(20)
        local t = os.clock()
        while os.clock() - t <= 10 do
            Citizen.Wait(5000)
        end
        local datawl = assert(io.open(Config.DataLocation .. "/"..Config.DataFlName..".txt", "w"))
        datawl:write(json.encode(PlayersBandanas))
        datawl:close()
    end
end)