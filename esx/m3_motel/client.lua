local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

local currentmotel = nil
local closestroom = nil
local pinkcagecoord = vector3(326.747, -208.35, 54.0866)
local pinkcage = {
    [1] = {door = vector3(307.57, -213.29, 54.22), h = 68.9096, doortext = vector3(307.318, -213.26, 54.2199), stash = vector3(306.71, -208.50, 54.22), obj = nil, clothe = vector3(302.58, -207.35, 54.22), locked = true},
    [2] = {door = vector3(311.36, -203.46, 54.22), h = 68.9096, doortext = vector3(311.108, -203.39, 54.2199), stash = vector3(310.51, -198.61, 54.22), obj = nil, clothe = vector3(306.32, -197.45, 54.22), locked = true},
    [3] = {door = vector3(315.79, -194.79, 54.22), h = 338.946, doortext = vector3(315.829, -194.65, 54.2267), stash = vector3(320.45, -194.13, 54.22), obj = nil, clothe = vector3(321.79, -189.81, 54.22), locked = true},
    [4] = {door = vector3(315.84, -219.66, 58.02), h = 158.946, doortext = vector3(314.827, -219.78, 58.0220), stash = vector3(310.17, -220.36, 58.02), obj = nil, clothe = vector3(308.85, -224.63, 58.02), locked = true},
    [5] = {door = vector3(307.35, -213.24, 58.02), h = 68.9096, doortext = vector3(307.322, -213.25, 58.0151), stash = vector3(306.78, -208.53, 58.02), obj = nil, clothe = vector3(302.52, -207.23, 58.02), locked = true},
    [6] = {door = vector3(311.22, -203.35, 58.02), h = 68.9096, doortext = vector3(311.107, -203.40, 58.0151), stash = vector3(310.64, -198.74, 58.02), obj = nil, clothe = vector3(306.33, -197.41, 58.02), locked = true},
    [7] = {door = vector3(315.78, -194.62, 58.02), h = 338.946, doortext = vector3(315.817, -194.64, 58.0151), stash = vector3(320.51, -194.11, 58.02), obj = nil, clothe = vector3(321.73, -189.70, 58.02), locked = true},
    [8] = {door = vector3(339.20, -219.47, 54.22), h = 248.909, doortext = vector3(339.316, -219.52, 54.2199), stash = vector3(339.93, -224.19, 54.22), obj = nil, clothe = vector3(344.24, -225.47, 54.22), locked = true},
    [9] = {door = vector3(342.93, -209.50, 54.22), h = 248.909, doortext = vector3(343.130, -209.61, 54.2199), stash = vector3(343.61, -214.35, 54.22), obj = nil, clothe = vector3(348.01, -215.56, 54.22), locked = true},
    [10]= {door = vector3(346.78, -199.66, 54.22), h = 248.909, doortext = vector3(346.927, -199.74, 54.2199), stash = vector3(347.34, -204.44, 54.22), obj = nil, clothe = vector3(351.86, -205.67, 54.22), locked = true},
    [11]= {door = vector3(335.00, -227.38, 58.02), h = 158.946, doortext = vector3(334.916, -227.47, 58.0150), stash = vector3(330.27, -228.04, 58.02), obj = nil, clothe = vector3(328.99, -232.40, 58.02), locked = true},
    [12]= {door = vector3(339.27, -219.49, 58.02), h = 248.909, doortext = vector3(339.301, -219.53, 58.0150), stash = vector3(339.85, -224.16, 58.02), obj = nil, clothe = vector3(344.21, -225.51, 58.02), locked = true},
    [13]= {door = vector3(343.08, -209.54, 58.02), h = 248.909, doortext = vector3(343.094, -209.64, 58.0150), stash = vector3(343.63, -214.27, 58.02), obj = nil, clothe = vector3(347.95, -215.52, 58.02), locked = true},
    [14]= {door = vector3(346.69, -199.66, 58.02), h = 248.909, doortext = vector3(346.924, -199.73, 58.0150), stash = vector3(347.49, -204.41, 58.02), obj = nil, clothe = vector3(351.77, -205.64, 58.02), locked = true},
}

local firstSpawn = true
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        -- TriggerServerEvent('m3:motel:server:getLockStates')
        currentmotel = math.random(1, #pinkcage)
        notify('inform', 'Yeni motel odası verildi! Oda numaran: '..currentmotel)
        firstSpawn = false
    end
end)

RegisterCommand('yenimotelodasi', function()
    currentmotel = math.random(1, #pinkcage)
    notify('inform', 'Yeni motel odası verildi! Oda numaran: '..currentmotel)
end)

RegisterCommand('motelcik', function()
    local player = PlayerPedId()
    local playercoords = GetEntityCoords(player)
    local moteldistance = #(playercoords - pinkcagecoord)

    if moteldistance <= 45.0 then
        SetEntityCoords(player, 311.491, -206.25, 58.0151, 0, 0, 0, 0)
        SetEntityHeading(player, 242.37)
        notify('inform', 'Odadan ayrıldın.')
    end
end)

-- RegisterNetEvent('m3:motel:client:sendDoorlockState')
-- AddEventHandler('m3:motel:client:sendDoorlockState', function(doorlocktable)
--     for i=1, #pinkcage, 1 do
--         pinkcage[i].locked = doorlocktable[i].locked
--     end
-- end)

-- RegisterNetEvent('m3:motel:client:sendDoorlockState2')
-- AddEventHandler('m3:motel:client:sendDoorlockState2', function(doorid, lockstate)
--     pinkcage[doorid].locked = lockstate
-- end)

Citizen.CreateThread(function()
    local gblip = AddBlipForCoord(pinkcagecoord)
    SetBlipSprite(gblip, 475)
    SetBlipDisplay(gblip, 4)
    SetBlipScale (gblip, 0.6)
    SetBlipColour(gblip, 27)
    SetBlipAsShortRange(gblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pink Cage Motel")
    EndTextCommandSetBlipName(gblip)
end)

-- Citizen.CreateThread(function()
--     while true do
--         local player = PlayerPedId()
--         local playercoords = GetEntityCoords(player)
--         local moteldistance = #(playercoords - pinkcagecoord)

--         if moteldistance <= 45.0 then
--             for j = 1, #pinkcage, 1 do
--                 local doordistance = #(playercoords - pinkcage[j].door)
--                 if pinkcage[j].obj == nil or not DoesEntityExist(pinkcage[j].obj) then
--                     pinkcage[j].obj = GetClosestObjectOfType(pinkcage[j].door, 1.2, -1156992775, false, false, false) ---1156992775 door hash
--                     FreezeEntityPosition(pinkcage[j].obj, pinkcage[j].locked)
--                 else
--                     FreezeEntityPosition(pinkcage[j].obj, pinkcage[j].locked)
--                     if pinkcage[j].locked then
--                         SetEntityHeading(pinkcage[j].obj, pinkcage[j].h)
--                     end
--                 end
--                 if doordistance <= 30.0 and currentmotel == j then
--                     DrawMarker(2, pinkcage[j].doortext.x, pinkcage[j].doortext.y, pinkcage[j].doortext.z - 0.3, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
--                 end
--                 if doordistance <= 2.0 then
--                     if pinkcage[j].locked and currentmotel == j then 
--                         closestroom = j
--                         closestString = "[Oda: "..j.."] - [E] - Kilitli"
--                         DrawText3D(pinkcage[j].doortext, closestString) 
--                     elseif not pinkcage[j].locked and currentmotel == j then 
--                         closestString = "[Oda: "..j.."] - [E] - Açık"
--                         DrawText3D(pinkcage[j].doortext, closestString) 
--                     elseif pinkcage[j].locked and currentmotel ~= j then
--                         closestString = "[Oda: "..j.."] - Kilitli"
--                         DrawText3D(pinkcage[j].doortext, closestString) 
--                     elseif not pinkcage[j].locked and currentmotel ~= j then
--                         closestString = "[Oda: "..j.."] - Açık"
--                         DrawText3D(pinkcage[j].doortext, closestString)
--                     end
--                     if (doordistance <= 1.5 and currentmotel == j) then
--                         if IsControlJustReleased(0, 38) then
--                             TriggerServerEvent('m3:motel:server:toggleDoorlock', j, not pinkcage[j].locked)
--                             openHouseAnim()
--                         end
--                     end
--                 end
--                 -- Citizen.Wait(0)
--             end
--         else
--             Citizen.Wait(500)
--         end
--         Citizen.Wait(5)
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        if currentmotel ~= nil then
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local stashdistance = #(playercoords - pinkcage[currentmotel].stash)
            local clothedistance = #(playercoords - pinkcage[currentmotel].clothe)
            local doordistance = #(playercoords - pinkcage[currentmotel].doortext)
            local moteldistance = #(playercoords - pinkcagecoord)

            if moteldistance <= 45.0 then
                if doordistance <= 30.0 then
                    DrawMarker(2, pinkcage[currentmotel].doortext.x, pinkcage[currentmotel].doortext.y, pinkcage[currentmotel].doortext.z - 0.3, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                end

                -- if stashdistance <= 3.0 then
                    -- DrawMarker(2, pinkcage[currentmotel].stash.x, pinkcage[currentmotel].stash.y, pinkcage[currentmotel].stash.z - 0.3, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                    if stashdistance <= 1.5 then
                        DrawText3D(pinkcage[currentmotel].stash, '[~g~E~w~] - Sandık')
                        if IsControlJustReleased(0, 38) then
                            OpenMotelInventory()
                        end
                    end
                -- end
                -- if clothedistance <= 3.0 then
                    -- DrawMarker(2, pinkcage[currentmotel].clothe.x, pinkcage[currentmotel].clothe.y, pinkcage[currentmotel].clothe.z - 0.3, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                    if clothedistance <= 1.5 then
                        DrawText3D(pinkcage[currentmotel].clothe, '[~g~E~w~] - Gardrop')
                        if IsControlJustReleased(0, 38) then
                            OpenMotelWardrobe()
                        end
                    end
                -- end
            else
                Citizen.Wait(500)
            end
        end
        Citizen.Wait(5)
    end
end)

function openHouseAnim()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(400)
    ClearPedTasks(PlayerPedId())
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(5)
    end
end

function OpenMotelWardrobe()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',{
		title    = 'Gardrop',
		align    = 'right',
		elements = {
            {label = 'Kıyafetler', value = 'player_dressing'},
	        {label = 'Kıyafet Sil', value = 'remove_cloth'}
        }
	}, function(data, menu)

		if data.current.value == 'player_dressing' then 
            menu.close()
			ESX.TriggerServerCallback('m3:motel:server:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = 'Kıyafetler',
					align    = 'right',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('m3:motel:server:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then
            menu.close()
			ESX.TriggerServerCallback('m3:motel:server:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = 'Kıyafet Sil',
					align    = 'right',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('m3:motel:server:removeOutfit', data2.current.value)
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Kıyafet silindi!'})
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
        menu.close()
	end)
end

function OpenMotelInventory()
    TriggerEvent('m3:inventoryhud:client:openStash', 'Motel', 'all')
end

function notify(type, text, time)
    if length == nil then length = 5000 end 
    TriggerEvent('mythic_notify:client:SendAlert', { type = type, text = text, length = length})
end

function DrawText3D(coord, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(coord.x, coord.y, coord.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.3
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
	end
end