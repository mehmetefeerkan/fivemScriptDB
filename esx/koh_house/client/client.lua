ESX  = nil

PlayerData = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.TriggerServerCallback('koh_house:getDoorState', function(doorState)
		for index,state in pairs(doorState) do
			Config.Houses[index].locked = state
		end
	end)
	ESX.TriggerServerCallback('koh_house:getStashState', function(stashState)
		for index,state in pairs(stashState) do
			Config.Houses[index].lockedst = state
		end
	end)
	StartHouse()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	while true do
		Citizen.Wait(5000)
		for k,v in pairs(Config.Houses) do
			ESX.TriggerServerCallback("koh_house:checkItem", function(result)
				if result then
					SetBlipDisplay(v.blip, 4)
				else
					SetBlipDisplay(v.blip, 0)
				end
			end, k) 
		end
	end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    PlayerData.job = job
end)

local uiOpen = false
local usingAdvanced = false
local currentRegister   = 0

---------------- Dooors -------------------

Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())
		for k,v in ipairs(Config.Houses) do
			for k2,v2 in ipairs(v.doors) do
				if v2.object and DoesEntityExist(v2.object) then
					if k2 == 1 then
						v.distanceToPlayer = #(playerCoords - GetEntityCoords(v2.object))
					end
					if v.locked and v2.objHeading and ESX.Math.Round(GetEntityHeading(v2.object)) ~= v2.objHeading then
						SetEntityHeading(v2.object, v2.objHeading)
					end
				else
					v.distanceToPlayer = nil
					v2.object = GetClosestObjectOfType(v2.objCoords, 1.0, v2.objHash, false, false, false)
				end
			end
		end
		Citizen.Wait(700)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		local letSleep = true
		for k,v in ipairs(Config.Houses) do
			if v.distanceToPlayer and v.distanceToPlayer < 50 then
				letSleep = false
				if v.doors then
					for k2,v2 in ipairs(v.doors) do
						FreezeEntityPosition(v2.object, v.locked)
					end
				else
					FreezeEntityPosition(v.object, v.locked)
				end
			end
			if v.distanceToPlayer and v.distanceToPlayer < v.maxDistance then
				if IsControlJustReleased(0, 38) then
					TriggerEvent("koh_house:dooranim")
					ESX.TriggerServerCallback('koh_house:checkItem', function(result)
						if result == true then
							v.locked = not v.locked
							TriggerServerEvent('koh_house:updateState', k, v.locked)
						end
					end, k)
				end
			end
		end
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('koh_house:setDoorState')
AddEventHandler('koh_house:setDoorState', function(index, state) Config.Houses[index].locked = state end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('koh_house:dooranim')
AddEventHandler('koh_house:dooranim', function()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dooropen', 0.3)
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())
end)
----------------------- Kıyafet --------------

function OpenWardrobe()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',
	{
		title    = 'Kıyafetlerin',
		align    = 'top-left',
		elements = {
            {label = 'Kıyafet Dolabın', value = 'player_dressing'},
			{label = 'Kıyafet Sil', value = 'remove_cloth'}
        }
	}, function(data, menu)
		if data.current.value == 'player_dressing' then 
            menu.close()
			ESX.TriggerServerCallback('koh_house:getPlayerDressing', function(dressing)
				elements = {}
				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = 'Kıyafet Dolabın',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('koh_house:getPlayerOutfit', function(clothes)
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
			ESX.TriggerServerCallback('koh_house:getPlayerDressing', function(dressing)
				elements = {}
				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = 'Kıyafet Sil',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('koh_house:removeOutfit', data2.current.value)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
        menu.close()
	end)
end

function StartHouse()																																										
	Citizen.CreateThread(function()																																							
		while true do																																										
			Citizen.Wait(20)
			if IsControlJustReleased(0, 38) then																																							
				local playerPed = PlayerPedId()																																					
				local coords = GetEntityCoords(playerPed)																																		
				local playerCoords = GetEntityCoords(PlayerPedId())																																
				local letSleep = true																																							
				for k,v in pairs(Config.Houses) do																																				
					distancecl =  GetDistanceBetweenCoords(coords, v.Coords.clothe, true)																										
					if distancecl < 1.2 then																																					
						local coordsclothex, coordsclothey, coordsclothez = table.unpack(v.Coords.clothe)																																									
						DrawMarker(2, coordsclothex, coordsclothey, coordsclothez - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 0, 0, 155, false, false, 2, false, 0, 0, 0, 0)  
						ESX.TriggerServerCallback("koh_house:checkItem", function(result)
							if result then
								OpenWardrobe()
							end
						end, k) 
					end
					distancest =  GetDistanceBetweenCoords(coords, v.Coords.stash, true)
					if distancest < 1.2 then
						local coordsstashx, coordsstashy, coordsstashz = table.unpack(v.Coords.stash)
						DrawMarker(2, coordsstashx, coordsstashy, coordsstashz - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 0, 0, 155, false, false, 2, false, 0, 0, 0, 0)
						if not v.lockedst then
							OpenStash(k)
						end
					end
				end
				distancere = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Emlakci.coords, true)
				if distancere < 1.2 then
					local coordsemlakx, coordsemlaky, coordsemlakz = table.unpack(Config.Emlakci.coords)
					DrawText3D(coordsemlakx, coordsemlaky, coordsemlakz, "[~r~E~w~] Emlakçı Menüsü", 0.40)
					DrawMarker(27, coordsemlakx, coordsemlaky, coordsemlakz - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
					OpenEmlakciMenu()
				end
			end
		end
	end)
end

function AddBlips()
    for i=1, #Config.Houses, 1 do
		Config.Houses[i].blip = AddBlipForCoord(Config.Houses[i].doors[1].objCoords)
        SetBlipSprite(Config.Houses[i].blip , 357)
        SetBlipScale(Config.Houses[i].blip , 0.5) -- Blip boyutunu ayarlar
        SetBlipColour(Config.Houses[i].blip , 0)
        SetBlipAsShortRange(Config.Houses[i].blip , true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Ev-' .. tostring(i))
        EndTextCommandSetBlipName(Config.Houses[i].blip)
    end
end

Citizen.CreateThread(function()
	AddBlips()
end)

function OpenEmlakciMenu()
	ESX.TriggerServerCallback('koh_house:checkPlayerHouses', function(ownedhouses)
		if not ownedhouses then
			ESX.TriggerServerCallback('koh_house:getEmptyHouses', function(emptyhouses)
				local elements = {
					{label = 'Menü Kapat', value = 'close'},
				}

				for k,v in ipairs(emptyhouses) do
					table.insert(elements, {
						label     = 'Ev - ' .. tostring(v),
						value	  = tostring(v)
					})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BuyHouse', {
					title    = Config.Emlakci.name,
        		    align    = 'top-left',
        		    elements = elements
				}, function(data, menu)
					if data.current.value == 'close' then
						menu.close()
					else
						TriggerServerEvent('koh_house:BuyHouse', data.current.value)
						ESX.ShowNotification('Ev Satın Aldın ' .. data.current.label)
						menu.close()
					end
				end, function(data, menu)
					menu.close()
				end)
			end)
		else
			ESX.TriggerServerCallback('koh_house:getPlayerHouses', function(plhouses)
				local elements = {
					{label = 'Menü Kapat', value = 'close'},
				}

        		for k,id in ipairs(plhouses) do
        		    table.insert(elements, {
        		        label     = 'Ev - ' .. id.houseid,
        		        value	  = id.houseid
        		    })
        		end

        		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'HouseOwnKeys', {
					title    = Config.Emlakci.name,
        		    align    = 'top-left',
        		    elements = elements
				}, function(data, menu)
					if data.current.value == 'close' then
						menu.close()
					else
						menu.close()

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'HouseOwnKeysoptions', {
							title    = data.current.label,
							align    = 'top-left',
							elements = {{label = 'Menü Kapat', value = 'closeoptions'}, {label = 'Evi Geri Sat', value = 'deletehouse'}, {label = 'Ev Yedek Anahtarını Al', value = 'copyhousekey'}}
						}, function(data2, menu2)
							if data2.current.value == 'closeoptions' then
								menu.close()
								menu2.close()
							elseif data2.current.value == 'deletehouse' then
								TriggerServerEvent('koh_house:deleteHouse', data.current.value)
								ESX.ShowNotification('Ev Geri Satıldı ' .. data.current.label)
								menu.close()
								menu2.close()
							elseif data2.current.value == 'copyhousekey' then
								TriggerServerEvent('koh_house:copyKey', data.current.value)
								ESX.ShowNotification('Ev Anahtarı Kopyalandı ' .. data.current.label)
								menu.close()
								menu2.close()
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end
				end, function(data, menu)
					menu.close()
				end)
			end)
		end
	end)
end

RegisterNetEvent('koh_house:setStashState')
AddEventHandler('koh_house:setStashState', function(index, state)
	Config.Houses[index].lockedst = state
end)

function OpenStash(houseId)
	TriggerEvent('disc-inventoryhud:openInventory', {
		["type"] = 'house',
		["owner"] = 'house_' .. tostring(houseId),
		["slots"] = 80,
	})
end

function ToggleStash(v, k)
	RequestAnimDict("anim@heists@keycard@")
	while not HasAnimDictLoaded("anim@heists@keycard@") do
		Citizen.Wait(1)
	end
	local ped = PlayerPedId()
	v.lockedst = not v.lockedst
	TriggerServerEvent('koh_house:toggleStash', k, v.lockedst)
	TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 8.0, 8.0, 1000, 1, 1, 0, 0, 0)
	TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dooropen', 0.3)
	Citizen.Wait(1000)
	ClearPedTasks(ped)
end

RegisterCommand(Config.stashlockcom, function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	for k,v in pairs(Config.Houses) do
		distancest =  GetDistanceBetweenCoords(coords, v.Coords.stash, true)
		if distancest < 1.2 then
			ESX.TriggerServerCallback("koh_house:checkItem", function(result)
				if result then
					ToggleStash(v, k)
				end
			end, k)
        end
    end
end)

---------------[KOV]---------------
function DisableControl() DisableControlAction(0, 73, false) DisableControlAction(0, 24, true) DisableControlAction(0, 257, true) DisableControlAction(0, 25, true) DisableControlAction(0, 263, true) DisableControlAction(0, 32, true) DisableControlAction(0, 34, true) DisableControlAction(0, 31, true) DisableControlAction(0, 30, true) DisableControlAction(0, 45, true) DisableControlAction(0, 22, true) DisableControlAction(0, 44, true) DisableControlAction(0, 37, true) DisableControlAction(0, 23, true) DisableControlAction(0, 288, true) DisableControlAction(0, 289, true) DisableControlAction(0, 170, true) DisableControlAction(0, 167, true) DisableControlAction(0, 73, true) DisableControlAction(2, 199, true) DisableControlAction(0, 47, true) DisableControlAction(0, 264, true) DisableControlAction(0, 257, true) DisableControlAction(0, 140, true) DisableControlAction(0, 141, true) DisableControlAction(0, 142, true) DisableControlAction(0, 143, true) end
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

