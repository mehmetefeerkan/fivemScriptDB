local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX 			    			= nil
local showblip = false
local displayedBlips = {}
local AllBlips = {}
local number = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
		  SetNuiFocus(false, false)
	  end
end)
  
RegisterNUICallback('escape', function(data, cb)
	 
	  SetNuiFocus(false, false)
  
	  SendNUIMessage({
		  type = "close",
	  })
end)

RegisterNUICallback('bossactions', function(data, cb)
	 
	SetNuiFocus(false, false)

	SendNUIMessage({
		type = "close",
	})

	OpenBoss(number)
end)

local Cart = {}

RegisterNUICallback('putcart', function(data, cb)
	table.insert(Cart, {item = data.item, label = data.label, count = data.count, id = data.id, price = data.price, src = data.src})
	cb(Cart)
end)

RegisterNUICallback('notify', function(data, cb)
	ESX.ShowNotification(data.msg)
end)

RegisterNUICallback('refresh', function(data, cb)
	 
	Cart = {}

		ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
			ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)
			
					if data ~= nil then
						Owner = true
					end

					if result ~= nil then

								SetNuiFocus(true, true)
				
								SendNUIMessage({
									type = "shop",
									result = result,
									owner = Owner,
								})
					end

				end, number)
			end, number)
end)

RegisterNUICallback('emptycart', function(data, cb)
	Cart = {}
	
end)

RegisterNUICallback('buy', function(data, cb)
	TriggerServerEvent('esx_kr_shops:Buy', number, data.item, data.count)
	Cart = {}
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
   PlayerData = xPlayer
end)

local ShopId           = nil
local Msg        = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil


AddEventHandler('esx_kr_shop:hasEnteredMarker', function(zone)
	if zone == 'center' then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_open_center')
	elseif zone <= 100 then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_open')
	elseif zone >= 100 then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_rob')
	end
end)

AddEventHandler('esx_kr_shop:hasExitedMarker', function(zone)
	ShopId = nil
end)

Citizen.CreateThread(function ()
 	 while true do
		Citizen.Wait(0)

		if ShopId ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(Msg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys['E']) then

					if ShopId == 'center' then
						OpenShopCenter()
					

					elseif ShopId <= 100 then
						ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
						ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)
						
								if data ~= nil then
									Owner = true
								end
	
								if result ~= nil then

									SetNuiFocus(true, true)
						
									SendNUIMessage({
										type = "shop",
										result = result,
										owner = Owner,
									})
								end
			
							end, number)
						end, number)
					elseif ShopId >= 100 then
						Robbery(number - 100)
					end

	 	 		end
		end
	end
 end)



function OpenShopCenter()

	ESX.UI.Menu.CloseAll()

  	local elements = {}

		if showblip then
			table.insert(elements, {label = 'Haritadaki bütün marketleri gizle', value = 'removeblip'})
		else
			table.insert(elements, {label = 'Haritadaki bütün marketleri göster', value = 'showblip'})
		end

			ESX.TriggerServerCallback('esx_kr_shop:getShopList', function(data)

				for i=1, #data, 1 do
					table.insert(elements, {label = _U('buy_shop') .. data[i].ShopNumber .. ' [$' .. data[i].ShopValue .. ']', value = 'kop', price = data[i].ShopValue, shop = data[i].ShopNumber})
				end


					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'shopcenter',
					{
						title    = 'Shop',
						align    = 'left',
						elements = elements
					},
					function(data, menu)

					if data.current.value == 'kop' then
					ESX.UI.Menu.CloseAll()

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name', {
					title = _U('name_shop')
					}, function(data2, menu2)

					local name = data2.value
					TriggerServerEvent('esx_kr_shops:BuyShop', name, data.current.price, data.current.shop, data.current.bought)
					menu2.close()

					end,
					function(data2, menu2)
					menu2.close()
					end)

					elseif data.current.value == 'removeblip' then
						showblip = false
						createForSaleBlips()
						menu.close()
					elseif data.current.value == 'showblip' then
						showblip = true
						createForSaleBlips()
						menu.close()
					end
					end)
				end,
			function(data, menu)
		menu.close()
	end)
end

-- function OpenShop()
--   ESX.UI.Menu.CloseAll()
--   local elements = {}

  
-- 	ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
-- 	ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)

--         if data ~= nil then
--             table.insert(elements, {label = 'Boss Menu', value = 'boss'})
--         end

-- 	    if result ~= nil then
-- 		    for i=1, #result, 1 do
-- 		        if result[i].count > 0 then
-- 					table.insert(elements, {label = result[i].label .. ' | ' .. result[i].count ..' in your stock for [$' .. result[i].price .. ' per item]', value = 'buy', ItemName = result[i].item})
-- 				end
-- 			end
-- 		end


--   ESX.UI.Menu.Open(
--   'default', GetCurrentResourceName(), 'shops',
--   {
-- 	title    = 'Shop',
-- 	align    = 'left',
-- 	elements = elements
--   },
--   function(data, menu)
-- 	if data.current.value == 'boss' then
--         ESX.UI.Menu.CloseAll()
-- 		OpenBoss()
		
-- 	elseif data.current.value == 'buy' then
--         	ESX.UI.Menu.CloseAll()

-- 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mainmeny', {
-- 			title = 'How much whould you like to buy?'
-- 			}, function(data2, menu2)

--        	 	local count = tonumber(data2.value)

-- 				TriggerServerEvent('esx_kr_shops:Buy', number, data.current.ItemName, count)
-- 				menu2.close()
	
--                     	end,
--                     	function(data2, menu2)
--                     	menu2.close()
--                 	end)
--                     end
--                 end,
--                 function(data, menu)
-- 				menu.close()
-- 			end)
-- 		end, number)
-- 	end, number)
-- end

function OpenBoss()


  ESX.TriggerServerCallback('esx_kr_shop:getOwnedShop', function(data)
  
	local elements = {}

		table.insert(elements, {label = 'Şirketinde: $' .. data[1].money .. ' para var',    value = ''})
		table.insert(elements, {label = 'Kargo',    value = 'shipments'})
        table.insert(elements, {label = 'Satılığa Eşya Koy', value = 'putitem'})
        table.insert(elements, {label = 'Eşyayı Satılıktan Çıkar',    value = 'takeitem'})
        table.insert(elements, {label = 'Kasaya Para Koy',    value = 'putmoney'})
        table.insert(elements, {label = 'Kasadan Para Çıkar',    value = 'takemoney'})
        table.insert(elements, {label = 'Şu Kadar Fiyata Şirketinin Adını Değiştir: $' .. Config.ChangeNamePrice,    value = 'changename'})
		table.insert(elements, {label = 'Şu Kadar Paraya Şirketini Sat $' .. math.floor(data[1].ShopValue / Config.SellValue),   value = 'sell'})

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss',
		{
			title    = 'Market',
			align    = 'left',
			elements = elements
		},
		function(data, menu)
        if data.current.value == 'putitem' then
            PutItem(number)
        elseif data.current.value == 'takeitem' then  
            TakeItem(number)
        elseif data.current.value == 'takemoney' then
            

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'takeoutmoney', {
                title = 'Ne kadar para çekmek istiyorsun?'
            }, function(data2, menu2)
  
			local amount = tonumber(data2.value)
			
			TriggerServerEvent('esx_kr_shops:takeOutMoney', amount, number)
			
			menu2.close()
        
		end,
		function(data2, menu2)
		menu2.close()
		end)

	 	elseif data.current.value == 'putmoney' then
			ESX.UI.Menu.CloseAll()

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'putinmoney', {
			title = 'Ne kadar para yatırmak istiyorsun?'
			}, function(data3, menu3)
			local amount = tonumber(data3.value)
			TriggerServerEvent('esx_kr_shops:addMoney', amount, number)
			menu3.close()
				end,
				function(data3, menu3)
			menu3.close()
		end)

		elseif data.current.value == 'sell' then
		  ESX.UI.Menu.CloseAll()    

		  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
			title = 'WRITE: (YES) without parentheses to confim'
          }, function(data4, menu4)
            
            if data4.value == 'YES' then
              TriggerServerEvent('esx_kr_shops:SellShop', number)
              menu4.close()
			end
		    	end,
		    	function(data4, menu4)
		    menu4.close()
		end)

	  elseif data.current.value == 'changename' then
		ESX.UI.Menu.CloseAll()    

		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'changename', {
		  title = 'Marketinin adı ne olsun?'
        }, function(data5, menu5)
            
            TriggerServerEvent('esx_kr_shops:changeName', number, data5.value)
            menu5.close()
               		end,
                	function(data5, menu5)
                	menu5.close()
				end)
				
			elseif data.current.value == 'shipments' then
				OpenShipments(number)

				end
        		end,
        		function(data, menu)
        	menu.close()
	    end)
    end, number)
end

function OpenShipments(id)

	local elements = {}

	table.insert(elements, {label = 'Mal Sipariş Et', value = 'buy'})
	table.insert(elements, {label = 'Gönderiler', value = 'shipments'})

	ESX.UI.Menu.Open(
  	'default', GetCurrentResourceName(), 'shipments',
	{
		title    = 'Market',
		align    = 'left',
		elements = elements
	},
	  function(data, menu)
		
		if data.current.value == 'buy' then
			ESX.UI.Menu.CloseAll()
			OpenShipmentDelivery(id)
		elseif data.current.value == 'shipments' then
			ESX.UI.Menu.CloseAll()
			GetAllShipments(id)
		end
		end,
	function(data, menu)
	menu.close()
	end)
end

function GetAllShipments(id)

	local elements = {}

	ESX.TriggerServerCallback('esx_kr_shop:getTime', function(time)
	ESX.TriggerServerCallback('esx_kr_shop:getAllShipments', function(items)

	local once = true
	local once2 = true

		for i=1, #items, 1 do

			if time - items[i].time >= Config.DeliveryTime and once2 then
			table.insert(elements, {label = '--Gönderiye Hazır--'})
			table.insert(elements, {label = 'Bütün mallarını Al', value = 'pickup'})
			once2 = false
			end

			if time - items[i].time >= Config.DeliveryTime then
			table.insert(elements, {label = items[i].label,	value = items[i].item, price = items[i].price})
			end

			if time - items[i].time <= Config.DeliveryTime and once then
				table.insert(elements, {label = '--Beklenen Mallar--'})
				once = false
			end

			if time - items[i].time <= Config.DeliveryTime then
				times = time - items[i].time
				table.insert(elements, {label = items[i].label .. ' Kalan süre: ' .. math.floor((Config.DeliveryTime - times) / 60) .. ' dakika' })
			end

		end

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'allshipments',
	{
	  title    = 'Market',
	  align    = 'left',
	  elements = elements
	},
	  function(data, menu)
		
		if data.current.value == 'pickup' then
			TriggerServerEvent('esx_kr_shops:GetAllItems', id)
		end
	
		end,
		function(data, menu)
		menu.close()
		end)

	end, id)
	end)
end

function OpenShipmentDelivery(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.Items, 1 do
			table.insert(elements, {labels =  Config.Items[i].label, label =  Config.Items[i].label .. ' fiyata ' .. Config.Items[i].price .. ' adet ',	value = Config.Items[i].item, price = Config.Items[i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Market',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'krille', {
				title = 'Kaç Tane Satın Almak İstiyorsun?'
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('esx_kr_shop:MakeShipment', id, data.current.value, data.current.price, tonumber(data2.value), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)

		end,
		function(data, menu)
		menu.close()
	end)
end


function TakeItem(number)

  local elements = {}

  ESX.TriggerServerCallback('esx_kr_shop:getShopItems', function(result)

	for i=1, #result, 1 do
	    if result[i].count > 0 then
	    	table.insert(elements, {label = result[i].label .. ' | ' .. result[i].count ..' pieces in storage [' .. result[i].price .. ' $ per piece', value = 'removeitem', ItemName = result[i].item})
	    end
    end


  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'takeitem',
  {
	title    = 'Market',
	align    = 'left',
	elements = elements
  },
  function(data, menu)
local name = data.current.ItemName

    if data.current.value == 'removeitem' then
        menu.close()
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'howmuch', {
        title = 'Kaç tane eşya almak istiyorsun?'
        }, function(data2, menu2)

        local count = tonumber(data2.value)
		menu2.close()
    	TriggerServerEvent('esx_kr_shops:RemoveItemFromShop', number, count, name)
    
			end, function(data2, menu2)
				menu2.close()
			end)
			end
		end,
		function(data, menu)
		menu.close()
		end)
  	end, number)
end


function PutItem(number)

  local elements = {}

  ESX.TriggerServerCallback('esx_kr_shop:getInventory', function(result)

    for i=1, #result.items, 1 do
        
      local invitem = result.items[i]
      
	    if invitem.count > 0 then
			table.insert(elements, { label = invitem.label .. ' | ' .. invitem.count .. ' çantanda', count = invitem.count, name = invitem.name})
	    end
	end

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'putitem',
  {
	title    = 'Market',
	align    = 'left',
	elements = elements
  },
  function(data, menu)

        local itemName = data.current.name
        local invcount = data.current.count

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
			title = _U('how_much')
			}, function(data2, menu2)

			local count = tonumber(data2.value)
		
			if count > invcount then
				--TriggerEvent("pNotify:SendNotification", {text ="Sahip olduğundan fazla satamazsın",type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })
				-- exports['mythic_notify']:SendAlert('error', 'Sahip olduğundan fazla satamazsın')
				TriggerEvent('notification', 'Sahip olduğundan fazla satamazsın', 2)
				menu2.close()
				menu.close()
			else
				menu2.close()
				menu.close()

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sellprice', {
				title = _U('set_price')
				}, function(data3, menu3)

				local price = tonumber(data3.value)
				menu3.close()
				TriggerServerEvent('esx_kr_shops:setToSell', number, itemName, count, price)
		
						end)
					end
				end,
				function(data3, menu3)
				menu3.close()
				end)
			end, 
			function(data2, menu2)
			menu2.close()
			end)
        end, function(data, menu)
        menu.close()
    end)
end


Citizen.CreateThread(function ()
  while true do
	sleep = 2000
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

		for k,v in pairs(Config.Zones) do
			if(27 ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 20.0 ) then
				sleep = 5
				if v.Pos.red then
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 180, 0, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 180, 0, 0, 200, false, true, 2, false, false, false, false)		
				else
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 0, 180, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 180, 0, 200, false, true, 2, false, false, false, false)
				end
	        end
		end
		
		for k,v in pairs(Config.Zonesx) do
			if(27 ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 20.0 ) then
				sleep = 5
				if v.Pos.red then
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 180, 0, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 180, 0, 0, 200, false, true, 2, false, false, false, false)		
				else
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 180, 0, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 180, 0, 0, 200, false, true, 2, false, false, false, false)
				end
	        end
		end
		Citizen.Wait(sleep)
    end
end)


Citizen.CreateThread(function ()
  while true do
	sleep = 2000

	local coords      = GetEntityCoords(PlayerPedId())
	local isInMarker  = false
	local currentZone = nil

	for k,v in pairs(Config.Zones) do
	  if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.2) then
		sleep = 5
		isInMarker  = true
		currentZone = v.Pos.number
	  end
	end
	
	for k,v in pairs(Config.Zonesx) do
	  if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.2) then
		sleep = 5
		isInMarker  = true
		currentZone = v.Pos.number
	  end
	end

	if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
	  HasAlreadyEnteredMarker = true
	  LastZone                = currentZone
	  TriggerEvent('esx_kr_shop:hasEnteredMarker', currentZone)
	end

	if not isInMarker and HasAlreadyEnteredMarker then
	  HasAlreadyEnteredMarker = false
	  TriggerEvent('esx_kr_shop:hasExitedMarker', LastZone)
	end
	Citizen.Wait(sleep)
  end
end)

-- RegisterNetEvent('esx_kr_shops:setBlip')
-- AddEventHandler('esx_kr_shops:setBlip', function()

  	-- ESX.TriggerServerCallback('esx_kr_shop:getOwnedBlips', function(blips)

		-- if blips ~= nil then
			-- createBlip(blips)
	  	-- end
   	-- end)
-- end)

RegisterNetEvent('esx_kr_shops:removeBlip')
AddEventHandler('esx_kr_shops:removeBlip', function()

	for i=1, #displayedBlips do
    	RemoveBlip(displayedBlips[i])
	end

end)

-- AddEventHandler('playerSpawned', function(spawn)
	-- Citizen.Wait(500)

	-- ESX.TriggerServerCallback('esx_kr_shop:getOwnedBlips', function(blips)

		-- if blips ~= nil then
			-- createBlip(blips)
		-- end
	-- end)
-- end)



-- Citizen.CreateThread(function()
	-- Citizen.Wait(1000)

	-- ESX.TriggerServerCallback('esx_kr_shop:getOwnedBlips', function(blips)

		-- if blips ~= nil then
			-- createBlip(blips)
		-- end
	-- end)
-- end)

--[[Citizen.CreateThread(function()
	Citizen.Wait(500)
		local blip = AddBlipForCoord(-244.51, -958.1, 31.22)

		SetBlipSprite (blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 26)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Market Satın Al')
		EndTextCommandSetBlipName(blip)
end)]]

Citizen.CreateThread(function()
  		for k,v in pairs(Config.Zones) do
				local blip = AddBlipForCoord(vector3(v.Pos.x, v.Pos.y, v.Pos.z))
					SetBlipSprite (blip, 52)
					SetBlipDisplay(blip, 4)
					SetBlipScale  (blip, 0.7)
					SetBlipColour (blip, 2)
					SetBlipAsShortRange(blip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Market')
                    EndTextCommandSetBlipName(blip)
					table.insert(displayedBlips, blip)
 		end
end)


function createForSaleBlips()
	if showblip then

		IDBLIPS = {
			[1] = {x = 1392.562,  y = 3604.684,  z = 33.980, n = 1},
			[2] = {x = 2678.916,  y = 3280.671, z = 54.241, n = 2},
			[3] = {x = 1698.388,  y = 4924.404,  z = 41.063, n = 3},
			[4] = {x = 1961.464,  y = 3740.672, z = 31.343, n = 4},
			[5] = {x = 547.431,   y = 2671.710, z = 41.156, n = 5},
			[6] = {x = 1166.024,  y = 2708.930,  z = 37.157, n = 6},
			[7] = {x = 1729.216,  y = 6414.131, z = 34.037, n = 7},
			[8] = {x = -306.9,    y = 6266.22,   z = 31.9, n = 8},
		}

		for i=1, #IDBLIPS, 1 do

			local blip2 = AddBlipForCoord(vector3(IDBLIPS[i].x, IDBLIPS[i].y, IDBLIPS[i].z))
				
				SetBlipSprite (blip2, 52)
				SetBlipDisplay(blip2, 4)
				SetBlipScale  (blip2, 0.8)
				SetBlipColour (blip2, 1)
				SetBlipAsShortRange(blip2, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('ID: ' .. IDBLIPS[i].n)
				EndTextCommandSetBlipName(blip2)
				table.insert(AllBlips, blip2)
		end

		else
			for i=1, #AllBlips, 1 do
				RemoveBlip(AllBlips[i])
			end
		ESX.UI.Menu.CloseAll()
	end
end

--ROBBERY

local Var = nil
local Coordss = nil
local OnRobbery = false
local Id = nil
local Name = nil

function Robbery(id)

	local coords1 = {
		[1] = {x = 1395.49, y = 3612.94, z = 33.98, heading = 22.18},
		[2] = {x = 2674.36, y = 3288.0, z = 54.24, heading = 339.44},
		[3] = {x = 1706.87, y = 4919.76, z = 41.06, heading = 237.41},
		[4] = {x = 1960.75, y = 3748.67, z = 31.34, heading = 304.34},
		[5] = {x = 545.07, y = 2663.47, z = 41.16, heading = 96.45},
		[6] = {x = 1168.51, y = 2718.37, z = 36.16, heading = 271.45},
		[7] = {x = 1736.66, y = 6419.02, z = 34.04, heading = 247.6},
    }

    -- TriggerServerEvent('esx_kr_shops:UpdateCurrentShop', id)

        ESX.TriggerServerCallback('esx_kr_shop-robbery:getUpdates', function(result)
		ESX.TriggerServerCallback('esx_kr_shop-robbery:getOnlinePolices', function(results)

			if result.cb ~= nil then
				if results >= Config.RequiredPolices then
                TriggerServerEvent('esx_kr_shops-robbery:UpdateCanRob', id)
                
                    local coords = {
                        x = coords1[id].x,
                        y = coords1[id].y,
                        z = coords1[id].z - 1,
					}
						TriggerServerEvent('esx_phone:send', "police", "Shop robbery at the " .. result.name .. '\'s shop', true, coords)
						TriggerServerEvent('esx_kr_shops-robbery:NotifyOwner', "~r~Marketin ~b~(" .. result.name .. ')~r~ soyuluyor', id)
						
						ESX.Game.SpawnObject(1089807209, coords, function(safe)
						SetEntityHeading(safe, coords1[id].heading)
						FreezeEntityPosition(safe, true)

                        SetEntityHealth(safe, 10000)
                        OnRobbery = true
						Var = safe
						Id = id
						Coordss = coords
						Name = result.name
						end)
                else
				end
			else
				--TriggerEvent("pNotify:SendNotification", {text ="~r~Bu market zaten soyuldu, lütfen bekleyin " ..  math.floor((Config.TimeBetweenRobberies - result.time)  / 60) .. ' dakika',type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })
				-- exports['mythic_notify']:SendAlert('error', 'Bu market zaten soyuldu, lütfen bekleyin'..  math.floor((Config.TimeBetweenRobberies - result.time)  / 60) .. ' dakika')
				TriggerEvent('notification', 'Bu market zaten soyuldu, lütfen bekleyin'..  math.floor((Config.TimeBetweenRobberies - result.time)  / 60) .. ' dakika', 2)
			end
		end)
	end, id)
end




Citizen.CreateThread(function()
	while true do
		sleep = 2000
			local playerPed = PlayerPedId()
			local playerpos = GetEntityCoords(playerPed)
				if OnRobbery and GetDistanceBetweenCoords(playerpos.x, playerpos.y, playerpos.z, Coordss.x, Coordss.y, Coordss.z, true) <= 15 then
					sleep = 5
					
					local hp = GetEntityHealth(Var)
					TriggerEvent("mt:missiontext", "Kasayı kır:~r~ " .. hp/100 .. "%", 1000)

				if hp == 0 then
					OnRobbery = false
					TriggerServerEvent('esx_kr_shops-robbery:GetReward', Id)
					TriggerServerEvent("esx_kr_shops-robbery:NotifyOwner", '~r~Marketindeki soygun ~b~(' .. Name ..')~r~ başarıyla tamamlandı!', Id)
					DeleteEntity(Var)
				end

				elseif OnRobbery and GetDistanceBetweenCoords(playerpos.x, playerpos.y, playerpos.z, Coordss.x, Coordss.y, Coordss.z, true) >= 15 then
					OnRobbery = false
					DeleteEntity(Var)
					TriggerServerEvent('esx_kr_shops-robbery:NotifyOwner', "~g~Marketindeki soygun ~b~(" .. Name .. ')~g~ başarısız oldu!', Id)
					ESX.ShowNotification(_U("robbery_cancel"))	
				end
				Citizen.Wait(sleep)
	end
end)

RegisterNetEvent("mt:missiontext") -- credits: https://github.com/schneehaze/fivem_missiontext/blob/master/MissionText/missiontext.lua
AddEventHandler("mt:missiontext", function(text, time)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString(text)
		DrawSubtitleTimed(time, 1)
end)
