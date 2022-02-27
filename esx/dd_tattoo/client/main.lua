local currentTattoos = {}
local back = 1
local opacity = 1
local scaleType = nil
local scaleString = ""
local mx,inks,glove=false,false,false
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	playerIdent = ESX.GetPlayerData().identifier
end)

AddEventHandler('skinchanger:modelLoaded', function()
setPedSkin()
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		if tattooList then
			ClearPedDecorations(PlayerPedId())
				for k,v in pairs(tattooList) do
				SetPedDecoration(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
			end
			currentTattoos = tattooList
		end
	end)
end)




function OpenShopMenu(target, PlayercurrentTattoos)
	local elements = {}

	for k,v in pairs(Config.TattooCategories) do
		table.insert(elements, {label= v.name, value = v.value})
	end


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop', {
		css = 'tattoo',
		title = _U('tattoos'),
		align = 'bottom-right',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		if data.current.value then
			elements = {{label = _U('go_back_to_menu'), value = nil}}

			for k,v in pairs(Config.TattooList[data.current.value]) do
				table.insert(elements, {
					label = v.zone.. " - " ..v.name,
					value = k
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop_categories', {
				css = 'tattoo',
				title = _U('tattoos') .. ' | '..currentLabel,
				align = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				if data2.current.value ~= nil then
					TriggerServerEvent('esx_tattooshop:purchaseTattoo', PlayercurrentTattoos, target, {collection = currentValue, texture = data2.current.value})

				else
					OpenShopMenu(target)
					TriggerServerEvent("esx_tattooshop:resetSkin", target)
				end

			end, function(data2, menu2)
				menu2.close()
				TriggerServerEvent("esx_tattooshop:setPedSkin", target)
				--setPedSkin()
			end, function(data2, menu2) -- when highlighted
				if data2.current.value ~= nil then
					--drawTattoo(data2.current.value, currentValue)
					TriggerServerEvent("esx_tattooshop:change", target, currentValue, data2.current.value)
				end
			end)
		end
	end, function(data, menu)
		menu.close()
		TriggerServerEvent("esx_tattooshop:setPedSkin", target)
	end)
end


function setPedSkin()

	for k,v in pairs(currentTattoos) do
		SetPedDecoration(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end
end


function drawTattoo(current, collection)
	--SetEntityHeading(PlayerPedId(), 297.7296)
	ClearPedDecorations(PlayerPedId())

	for k,v in pairs(currentTattoos) do
		SetPedDecoration(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end

	SetPedDecoration(PlayerPedId(), GetHashKey(collection), GetHashKey(Config.TattooList[collection][current].nameHash))
end

function cleanPlayer()
	ClearPedDecorations(PlayerPedId())
	for k,v in pairs(currentTattoos) do
		SetPedDecoration(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end
end

--Use item
RegisterNetEvent("Iz_tattoo:tattoo_use")
AddEventHandler("Iz_tattoo:tattoo_use", function()
	local target, distance = GetClosestPlayer()
	if mx then
		if inks then
			if glove then
				if(target ~= -1 and distance < 3.0) then
					TriggerServerEvent('esx_tattooshop:jecherche', target)
				else
					exports['okokNotify']:Alert("", "There is no one around", 5000, 'error')
				end
			else
				exports['okokNotify']:Alert("", "Use gloves", 5000, 'error')
			end
		else
			exports['okokNotify']:Alert("", "Get inks", 5000, 'error')
		end
	else
		exports['okokNotify']:Alert("", "Get Machine", 5000, 'error')
	end
end)
--



RegisterNetEvent("esx_tattooshop:getSkin")
AddEventHandler("esx_tattooshop:getSkin", function(target)
	TriggerEvent('skinchanger:getSkin', function(skin)
		skinBefore = skin
		TriggerServerEvent('esx_tattooshop:jecherche', skin, target, currentTattoos)
	end)
end)

local check = false
RegisterNetEvent("esx_tattooshop:setSkin")
AddEventHandler("esx_tattooshop:setSkin", function(target, PlayercurrentTattoos)
	PlayercurrentTattoos = PlayercurrentTattoos
	--currentTattoos = PlayercurrentTattoos
	if check then
		check =false
		OpenShopMenu(target, PlayercurrentTattoos)
	else
		TriggerServerEvent('esx_tattooshop:jecherche', target)
		check =true
	end
end)

RegisterNetEvent('esx_tattooshop:buySuccess')
AddEventHandler('esx_tattooshop:buySuccess', function()
	-- ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
	-- 	if quantity > 0 then
			exports['okokNotify']:Alert("", "You are tattooed, FOCUS", 5000, 'error')
			RequestAnimDict('random@shop_tattoo')
        
			while not HasAnimDictLoaded('random@shop_tattoo') do
				Citizen.Wait(0)
			end
			local ped = GetPlayerPed(-1)
			--ClearPedSecondaryTask(ped)
			FreezeEntityPosition(ped, true)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop_name = "v_ilev_ta_tatgun"
			Jointsupp = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
			AttachEntityToEntity(Jointsupp, ped, GetPedBoneIndex(ped, 28422), -0.0, 0.03, 0, 0, -270.0, -20.0, true, true, false, true, 1, true)
			TaskPlayAnim(ped, "random@shop_tattoo", "artist_artist_finishes_up_his_tattoo", 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0) --player_artist_finishes_up_his_tattoo
			Wait(8000)
			exports['okokNotify']:Alert("", "You have finished tattooing, well done!", 5000, 'success')
			TriggerServerEvent('Iz_tattoo:removeencre')
			--table.insert(currentTattoos, tattoo)
			DeleteObject(Jointsupp)
			DetachEntity(Jointsupp, 1, true)
			ClearPedTasksImmediately(ped)
			ClearPedSecondaryTask(ped)
			FreezeEntityPosition(ped, false)
	-- 	else
	-- 		exports['okokNotify']:Alert("", "And yes! you need ink to tattoo", 5000, 'info')
	-- 	end
	-- end, 'encre')
end)


RegisterNetEvent("esx_tattooshop:change")
AddEventHandler("esx_tattooshop:change", function(collection, name)
	drawTattoo(name, collection)
end)


RegisterNetEvent("esx_tattooshop:resetSkin")
AddEventHandler("esx_tattooshop:resetSkin", function()
	cleanPlayer()
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		if tattooList then
			for k,v in pairs(tattooList) do
				SetPedDecoration(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)


RegisterNetEvent("esx_tattooshop:setPedSkin")
AddEventHandler("esx_tattooshop:setPedSkin", function()
	setPedSkin()
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		if tattooList then
			for k,v in pairs(tattooList) do
				SetPedDecoration(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)


  

function GetClosestPlayer()
	local player = -1
	local minDistance = 1000.0

	local myCoords = GetEntityCoords(PlayerPedId())
	for _, id in pairs(GetActivePlayers()) do
		if(id ~= PlayerId()) then
		local ped = GetPlayerPed(id)
		local coords = GetEntityCoords(ped)
		local distance = #(myCoords-coords)

		if(distance < minDistance) then
			minDistance = distance
			player = GetPlayerServerId(id)
		end
		end
	end

	return player, minDistance
end
  

RegisterNetEvent("dd_tattoo:TattooMenu")
AddEventHandler("dd_tattoo:TattooMenu", function()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local playerPed = PlayerPedId()
	local isClose = false
	for k, v in pairs (Config.TattooShop) do
		local stash_name = v.stash_name
		local shopkey = v.shopkey
		local shop_name = v.shop_name
		local shop = v.shop
		local price = v.BusinePrice
		local shop_dist = GetDistanceBetweenCoords(playerCoords, shop.x, shop.y, shop.z, 1)
		if shop_dist <= 2.0 then
			isClose = true
			ESX.TriggerServerCallback('dd_tattoo:checkAvailability', function(checkShop)
				ShopMenu(k, checkShop, shop_name, shopkey, price)
			end, k)
		end
	end
end)
function ShopMenu(k, hasShop, stashName, shopkey, price)
	local elements = {}
	
	if hasShop then
		-- table.insert(elements, {label = 'Door Function', value = 'door_menu'})
		table.insert(elements, {label = 'Your Shop | Stop Renting Shop?', value = 'stop_renting'})
	end
	if not hasShop then
		table.insert(elements, {label = 'Buy Business | Price: <span style="color: green;">$' .. ESX.Math.GroupDigits(price) .. '</span> | Daily Shop Rent - <span style="color: green;">P' .. ESX.Math.GroupDigits(Config.DailyRentPrice) .. '</span>', value = 'start_shop'})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_menu', {
		title    = stashName,
		align    = 'top',
		elements = elements
	}, function(data, menu)
		-- if data.current.value == 'door_menu' then
		-- 	TriggerEvent('doordoordoor')
		-- 	menu.close()
		if data.current.value == 'start_shop' then
			ConfirmShopRent(k, stashName, shopkey, price)
			menu.close()
		elseif data.current.value == 'stop_renting' then
			StopShopRent(k, stashName, shopkey)
			menu.close()
		elseif data.current.value == 'close' then 
			menu.close()
		end

	end, function(data, menu)
		menu.close()
	end)

end

function ConfirmShopRent(k, stashName, shopkey, price)

    local elements = {
        {label = 'Yes', value = 'buy_yes'},
        {label = 'No', value = 'buy_no'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_rent_shop', {
        title    = 'Start renting ' .. stashName .. '',
        align    = 'top',
        elements = elements
    }, function(data, menu)

		if data.current.value == 'buy_yes' then
			menu.close()
			ESX.TriggerServerCallback('esx_license:checkLicense', function(hasPoliceClearance)
				if hasPoliceClearance then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasCitizenClearance)
						if hasCitizenClearance then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasMedicalClearance)
								if hasMedicalClearance then
									exports.pNotify:SendNotification({text = "<b>Licensing</b></br>Please wait while we are processing your Business Permits.", timeout = 10000})
									Citizen.Wait(10000)
									TriggerServerEvent('dd_tattoo:startRenting', k, stashName, shopkey, price)
									exports['okokNotify']:Alert("", "Successfully bought business!", 8000, 'success')
								else
									exports['okokNotify']:Alert("", "Please apply for a Medical Clearance at HP", 8000, 'info')
								end
							end, GetPlayerServerId(PlayerId()), 'mclearance')
						else
							exports['okokNotify']:Alert("", "Please apply for a Citizenship Clearance at City Hall", 8000, 'info')
						end
					end, GetPlayerServerId(PlayerId()), 'cclearance')
				else
					exports['okokNotify']:Alert("", "Please apply for a police Clearance at PD", 8000, 'info')
				end
			end, GetPlayerServerId(PlayerId()), 'pclearance')
			
        elseif data.current.value == 'buy_no' then
            menu.close()
        end

    end, function(data, menu)
        menu.close()
    end)  
end

function StopShopRent(k, stashName, shopkey)

    local elements = {
        {label = 'Yes', value = 'buy_yes'},
        {label = 'No', value = 'buy_no'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cancel_rent_shop', {
        title    = 'Stop Renting ' .. stashName .. '',
        align    = 'top',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'buy_yes' then
			menu.close()
			TriggerServerEvent('dd_tattoo:stopRenting', k, stashName,shopkey)
        elseif data.current.value == 'buy_no' then
            menu.close()
        end

    end, function(data, menu)
        menu.close()
    end)  
end

RegisterNetEvent("dd_tattoo:RoomStash")
AddEventHandler("dd_tattoo:RoomStash", function(stashName)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local playerPed = PlayerPedId()
	local isClose = false

	for k, v in pairs (Config.TattooShop) do
		local stash_name = v.stash_name
		local stash_loc = v.stash
		local stash_dist = GetDistanceBetweenCoords(playerCoords, stash_loc.x, stash_loc.y, stash_loc.z, 1)
		
		if stash_dist <= 2.0 then
			isClose = true
			ESX.TriggerServerCallback('dd_tattoo:checkAvailability', function(checkShop)
				StashMenu(k, checkShop, stash_name, stashName)
			end, k)
		end			
	end
end)
function StashMenu(k, hasShop, shopName, stashName)
	if hasShop then
		OpenStash(k, playerIdent, shopName, stashName)
	else
		exports['okokNotify']:Alert("", "You don't own this shop", 5000, 'error')
	end
end
function OpenStash(lockerId, identifier, shopName, stashName)
	exports["mf-inventory"]:openOtherInventory(stashName)
end

RegisterNetEvent("dd_tattoo:ShopKits")
AddEventHandler("dd_tattoo:ShopKits", function()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local playerPed = PlayerPedId()
	local isClose = false

	for k, v in pairs (Config.TattooShop) do
		local locker_name = v.locker_name
		local dress_name = v.dress
		local loc_dress = v.clothes
		local dress_dist = GetDistanceBetweenCoords(playerCoords, loc_dress.x, loc_dress.y, loc_dress.z, 1)
		
		if dress_dist <= 2.0 then
			isClose = true
			ESX.TriggerServerCallback('dd_tattoo:checkAvailability', function(checkShop)
				DressMenu(k, checkShop, dress_name)
			end, k)
		end			
	end
end)
function DressMenu(k, hasShop, kitsName)
	if hasShop then
		OpenDress1(k, hasShop, kitsName)
	else
		exports['okokNotify']:Alert("", "You don't own this shop", 3000, 'success')
	end
end
function OpenDress1(k, hasShop, kitsName)
	local elements = {}

		table.insert(elements, {label = 'Tattoo Machine', value = 'tattoo_mx'})
		table.insert(elements, {label = 'Surgical Gloves', value = 'tattoo_gloves'})
		table.insert(elements, {label = 'Inks', value = 'tattoo_inks'})

		ESX.UI.Menu.CloseAll()
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'locker_menu', {
		title    = kitsName,
		align    = 'top',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'tattoo_mx' then
			mx=true
		elseif data.current.value == 'tattoo_gloves' then
			glove=true
		elseif data.current.value == 'tattoo_inks' then
			inks=true
		end

	end, function(data, menu)
		menu.close()
	end)
end