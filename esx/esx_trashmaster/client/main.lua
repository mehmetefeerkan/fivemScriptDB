ESX                           = nil

local cachedBins = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(5)
    end
end)

-- Citizen.CreateThread(function()

    -- while true do
        -- Citizen.Wait(0)

        -- local playerPed = PlayerPedId()
        -- local entity, entityDst = ESX.Game.GetClosestObject(Config.BinsAvailable)
        

        -- if DoesEntityExist(entity) and entityDst <= 1.5 then

            -- local binCoords = GetEntityCoords(entity)

            -- Draw3DTexts(binCoords + vector3(0.0, 0.0, 0.5), "[~g~E~s~] Çöp karıstır", 0.5)
			-- DrawText3Ds(binCoords + vector3(0.0, 0.0, 0.5), '[~g~E~s~] Çöp karıstır')

            -- if IsControlJustReleased(0, 38) then

               -- if IsPedInAnyVehicle(playerPed, false) then
                    -- TriggerEvent('notification', 'Araçtayken çöp karıştıramazsın!', 2)
               -- else
                -- if not cachedBins[entity] then
                    -- cachedBins[entity] = true

                    -- OpenTrashCan()
                -- else
                    -- exports['mythic_notify']:SendAlert('error', 'Bu çöpü zaten karıştırdın')
                    -- TriggerEvent('notification', 'Bu çöpü zaten karıştırdın', 2)
                -- end
            -- end
            -- end
        -- end
    -- end
-- end)

RegisterCommand('çöptopla', function()
	local playerPed = PlayerPedId()
        local entity, entityDst = ESX.Game.GetClosestObject(Config.BinsAvailable)
        

        if DoesEntityExist(entity) and entityDst <= 1.5 then

            local binCoords = GetEntityCoords(entity)

            --Draw3DTexts(binCoords + vector3(0.0, 0.0, 0.5), "[~g~E~s~] Çöp karıstır", 0.5)
			--DrawText3Ds(binCoords + vector3(0.0, 0.0, 0.5), '[~g~E~s~] Çöp karıstır')

               if IsPedInAnyVehicle(playerPed, false) then
                    TriggerEvent('notification', 'Araçtayken çöp karıştıramazsın!', 2)
               else
                if not cachedBins[entity] then
                    cachedBins[entity] = true

                    OpenTrashCan()
                else
                    -- exports['mythic_notify']:SendAlert('error', 'Bu çöpü zaten karıştırdın')
                    TriggerEvent('notification', 'Bu çöpü zaten karıştırdın', 2)
                end
            end
		else
			TriggerEvent('notification', 'Yakınında çöp yok veya çöpe daha fazla yaklaşmalısın', 2)
        end
end)

function OpenTrashCan()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    FreezeEntityPosition(PlayerPedId(), true)
    exports["t0sic_loadingbar"]:StartDelayedFunction("Çöpü karıştırıyorsun", 10000, function()
    FreezeEntityPosition(PlayerPedId(), false)
	TriggerServerEvent("esx-ecobottles:retrieve")
    ClearPedTasks(PlayerPedId())
	end)
end

Draw3DTexts = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry('STRING')
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(x, y)
		local factors = (string.len(text)) / 600
    DrawRect(x,y+0.0125, 0.015+ factors, 0.03, 41, 11, 41, 100)
	end
end