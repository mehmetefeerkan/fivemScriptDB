Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			Citizen.Wait(0)
		end

		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end

		ESX.PlayerData = ESX.GetPlayerData()
	end
)

RegisterCommand('livery', function(source, args, raw)

    local pos = {x = 424.1820, y =-1001.69, z = 30.709}



    local pedcoords = GetEntityCoords(PlayerPedId())
local dst = GetDistanceBetweenCoords(pedcoords, pos.x, pos.y, pos.z, true)



    local coords = GetEntityCoords(PlayerPedId())

    local vehicle = GetVehiclePedIsIn(PlayerPedId())

    if tonumber(args[1]) ~= nil and  ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'ambulance' and GetVehicleLiveryCount(vehicle) - 1 >= tonumber(args[1]) then
        if  dst <= 100.0 and not receptionOpen then
        SetVehicleLivery(vehicle, tonumber(args[1]))
        else
            exports['mythic_notify']:DoHudText('error', 'Polis Karakolunun Çevresinde Olman Gerekiyor.')
        end
    else    
        exports['mythic_notify']:DoHudText('error', 'Belirli Bir Değer Girmen Gerekiyor')
    end

end)