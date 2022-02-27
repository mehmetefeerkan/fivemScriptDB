ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local playersGunpowderStatuses = {}
RegisterServerEvent('guntest:storePlayerGunpowderStatus')
AddEventHandler('guntest:storePlayerGunpowderStatus', function()
	local _source = source
	-- spara source (serverId) i arrayen
	table.insert(playersGunpowderStatuses, _source)
end)

RegisterServerEvent('guntest:removePlayerGunpowderStatus')
AddEventHandler('guntest:removePlayerGunpowderStatus', function()
	-- tar bort spelaren från arrayen, reverse order for loop för att man inte ska ta bort ett element och sedan få nil
	for i=#playersGunpowderStatuses, 1, -1 do
		if playersGunpowderStatuses[i] == source then
			table.remove(playersGunpowderStatuses, i)
		end
	end
end)

ESX.RegisterServerCallback('guntest:hasPlayerRecentlyFiredAGun', function(source, cb, target)
	local playerHasGunpowder = false

	-- loopa igenom alla spelare som har krutstänk på sig (behöver inte va reverse order)
	for i=#playersGunpowderStatuses, 1, -1 do
		if playersGunpowderStatuses[i] == target then
			playerHasGunpowder = true
		end
	end

	cb(playerHasGunpowder)
end)

local Cops = {
	"steam:100000000000",
}

RegisterServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon")
AddEventHandler("PoliceVehicleWeaponDeleter:askDropWeapon", function(wea)
	local isCop = false
	for _,k in pairs(Cops) do
		if(k == getPlayerID(source)) then
			isCop = true
			break;
		end
	end
	if(not isCop) then
		print(1)
		TriggerClientEvent("PoliceVehicleWeaponDeleter:drop", source, wea)
	end
end)


function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end
