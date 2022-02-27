ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('smerfikubrania:koszulka')
AddEventHandler('smerfikubrania:koszulka', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0,
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:spodnie')
AddEventHandler('smerfikubrania:spodnie', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:buty')
AddEventHandler('smerfikubrania:buty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:masky')
AddEventHandler('smerfikubrania:masky', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['mask_1'] = 0, ['mask_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:bagy')
AddEventHandler('smerfikubrania:bagy', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['bags_1'] = -1, ['bags_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:haty')
AddEventHandler('smerfikubrania:haty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['helmet_1'] = -1, ['helmet_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:watchy')
AddEventHandler('smerfikubrania:watchy', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['watches_1'] = -1, ['watches_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:braceletsy')
AddEventHandler('smerfikubrania:braceletsy', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['bracelets_1'] = -1, ['bracelets_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:glassessy')
AddEventHandler('smerfikubrania:glassessy', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['glasses_1'] = -1, ['glasses_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:kapat')
AddEventHandler('smerfikubrania:kapat', function()
	
end)

RegisterNetEvent('smerfikubrania:gerigiy')
AddEventHandler('smerfikubrania:gerigiy', function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		end)
end)


--[[function OpenActionMenuInteraction(target)

	local elements = {}

	table.insert(elements, {label = ('Üstüne Kıyafetleri Giy'), value = 'ubie'})
	table.insert(elements, {label = ('Tişörtünü Çıkart'), value = 'tul'})
	table.insert(elements, {label = ('Pantalonunu Çıkart'), value = 'spo'})
	table.insert(elements, {label = ('Ayakkabılarını Çıkart'), value = 'but'})
	table.insert(elements, {label = ('Maskeni Çıkart'), value = 'mask'})
	table.insert(elements, {label = ('Çantanı Çıkart'), value = 'bag'})
	table.insert(elements, {label = ('Şapka Çıkart'), value = 'hat'})
	table.insert(elements, {label = ('Saati Çıkart'), value = 'watch'})
	table.insert(elements, {label = ('Bilekliği Çıkart'), value = 'bracelets'})
	table.insert(elements, {label = ('Gözlüğü Çıkart'), value = 'glassessy'})
	table.insert(elements, {label = ('Menuyu Kapat'), value = 'kapat'})
  		ESX.UI.Menu.CloseAll()	


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Clothes'),
			align    = 'top-right',
			elements = elements
		},
    function(data, menu)



		
		if data.current.value == 'ubie' then			
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		end)
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'tul' then
		TriggerEvent('smerfikubrania:koszulka')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'spo' then
		TriggerEvent('smerfikubrania:spodnie')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'but' then
		TriggerEvent('smerfikubrania:buty')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'mask' then
		TriggerEvent('smerfikubrania:masky')
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'bag' then
		TriggerEvent('smerfikubrania:bagy')
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'hat' then
		TriggerEvent('smerfikubrania:haty')
		ESX.UI.Menu.CloseAll()		
		elseif data.current.value == 'watch' then
		TriggerEvent('smerfikubrania:watchy')
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'bracelets' then
		TriggerEvent('smerfikubrania:braceletsy')			
		elseif data.current.value == 'glassessy' then
		TriggerEvent('smerfikubrania:glassessy')		
		elseif data.current.value == 'kapat' then
		TriggerEvent('smerfikubrania:kapat')
		ESX.UI.Menu.CloseAll()
	  end
	end)


end]]
			
--[[Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustReleased(0, 57) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
		OpenActionMenuInteraction()
    end
  end
end)]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- RegisterCommand('giy', function()
-- 	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
-- 		TriggerEvent('skinchanger:loadSkin', skin)
-- 		end)
-- end)


-- RegisterCommand('tişört', function()
-- 	TriggerEvent('smerfikubrania:koszulka')
-- end)

-- RegisterCommand('pantolon', function()
-- 	TriggerEvent('smerfikubrania:spodnie')
-- end)

-- RegisterCommand('maske', function()
-- 	TriggerEvent('smerfikubrania:masky')
-- end)

-- RegisterCommand('ayakkabı', function()
-- 	TriggerEvent('smerfikubrania:buty')
-- end)

-- RegisterCommand('gözlük', function()
-- 	TriggerEvent('smerfikubrania:glassessy')
-- end)

-- RegisterCommand('şapka', function()
-- 	TriggerEvent('smerfikubrania:haty')
-- end)

-- RegisterCommand('çanta', function()
-- 	TriggerEvent('smerfikubrania:bagy')
-- end)

-- RegisterCommand('bileklik', function()
-- 	TriggerEvent('smerfikubrania:braceletsy')
-- end)

-- RegisterCommand('saat', function()
-- 	TriggerEvent('smerfikubrania:watchy')
-- end)