local handcuffTimer, dragStatus, blipsForces,currentTask = {}, {}, {}, {}, {}
local isDead, cuffed, hasAlreadyJoined, search, dragged = false, false, false, false, false
dragStatus.isDragged = false
ESX = nil
local cooldown = 0
local open = false
local IsAnimated = false

local plateModel = "prop_fib_badge"
local plateModel2 = "prop_fib_badge"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local plate_net = nil

local ct = Citizen.CreateThread

ct(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	Citizen.Wait(5000)
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	Citizen.Wait(5000)
	TriggerServerEvent('dd_police:forceBlip')
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end
RegisterNetEvent('dd_police:Locker')
AddEventHandler('dd_police:Locker', function()
	OpenPoliceLocker()
end)
function OpenPoliceLocker()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	local elements = {
		{label = 'Loadout', 			value = 'loadout'},
		-- {label = 'Ranked Police Suit', 	uniform = grade},
		{label = 'Civilian Outfit', 	value = 'civ_wear'},
		-- {label = 'Bulletproof Vest', 	bulletwear = 'vest'},
		{label = 'Protected Suit', 		uniform = 'combat'},
		-- {label = 'Ranked Headwear', 	headwear = grade},
		-- {label = 'Protected Headwear', 	headwear = 'helmet'},
		-- {label = 'Police Cap', 			headwear = 'cap'}

	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = 'Locker Room',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)
		if data.current.value == 'loadout' then
			
			TriggerServerEvent('dd_police:LoadOut')
		end
		if data.current.value == 'civ_wear' then
			AnimCivClothes()
			Citizen.Wait(3000)
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
			end)

		end
		if data.current.headwear then
			AnimHeadWear()
				Citizen.Wait(1000)
				------------------------------------------------------------------------
					setHeadwear1(data.current.headwear, playerPed)
    			------------------------------------------------------------------------
		elseif data.current.uniform then
			ShirtsAnim()
				Citizen.Wait(2500)
				------------------------------------------------------------------------
					setUniform1(data.current.uniform, playerPed)
    				------------------------------------------------------------------------				
		elseif data.current.bulletwear then
			ShirtsAnim()
				Citizen.Wait(2500)
				------------------------------------------------------------------------
					setBulletwear1(data.current.bulletwear, playerPed)
    			------------------------------------------------------------------------
		end
	end, function(data, menu)
		menu.close()
	end)
end
function setUniform1(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.PoliceUniforms[uniform].male
		else
			uniformObject = Config.PoliceUniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
			SetPedArmour(playerPed, 500)
		else
			exports['okokNotify']:Alert("POLICE", "There is no uniform that fits you!", 3000, 'info')
		end
	end)
end
function setHeadwear1(headwear, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local headwearObject

		if skin.sex == 0 then
			headwearObject = Config.PoliceHeadwear[headwear].male
		else
			headwearObject = Config.PoliceHeadwear[headwear].female
		end

		if headwearObject then
			TriggerEvent('skinchanger:loadClothes', skin, headwearObject)
		else
			exports['okokNotify']:Alert("POLICE", "There is no headwear that fits you!", 3000, 'info')
		end
	end)
end
function setBulletwear1(bulletwear, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local bulletwearObject

		if skin.sex == 0 then
			bulletwearObject = Config.PoliceVest[bulletwear].male
		else
			bulletwearObject = Config.PoliceVest[bulletwear].female
		end

		if bulletwearObject then
			TriggerEvent('skinchanger:loadClothes', skin, bulletwearObject)

			if bulletwear == 'vest' then
				SetPedArmour(playerPed, 500)
			end
		else
			exports['okokNotify']:Alert("POLICE", "There is no vest that fits you!", 3000, 'info')
		end
	end)
end

--[[WEAPONS]]--
function OpenPoliceWeapons()
	ESX.TriggerServerCallback("dd_police:getPoliceWeaps", function(inventory)
		TriggerEvent("dd_inventory:openPoliceWeaps", inventory)
	end, owner)
end
--[[STASH]]--
function OpenPoliceStash()
	ESX.TriggerServerCallback("dd_police:getPoliceInventory", function(inventory)
		TriggerEvent("dd_inventory:openPoliceInventory", inventory)
	end, owner)
end

RegisterNetEvent("dd_police:ToggleJobAction")
AddEventHandler("dd_police:ToggleJobAction", function()
	if Config.UiMenu then
		openLSPDXnMenu1()
	else
		OpenJobMenu()
	end
end)
function OpenJobMenu()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = 'Job Menu',
		align    = 'bottom-right',
		elements = {
			
			{label = 'Quick Actions', 				value = 'quick_actions'},	
			{label = 'Citizen Interactions', 		value = 'citizen_interaction'},	
			{label = 'Vehicle Interactions', 		value = 'vehicle_interaction'},	
			{label = 'Deploy Spikestrips',			value = 'stinger'},		
			{label = 'News Announcement', 			value = 'news_alert'},
			{label = 'Police MDT', 					value = 'mdt'},	
			

	}}, function(data, menu)
		local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
		if data.current.value == 'badge_menu' then
			local elements = {
				{label = 'Check myBadge', 				value = 'checkBadge'},
				{label = 'Show myBadge', 				value = 'showBadge'}		
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_badge', {
				title    = 'MyBadge',
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value

				if action == 'checkBadge' then
					if not IsPedInAnyVehicle(playerPed) then
						TriggerServerEvent('c5ms_police:openBadge', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
					end
				elseif action == 'showBadge' then
					if not IsPedInAnyVehicle(playerPed) then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance <= 3.0 then
							TriggerServerEvent('c5ms_police:openBadge', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
							startAnimShowBadge()
						end
					end
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end
		if data.current.value == 'mdt' then
			TriggerEvent('police.togglemdt')
		end
		if data.current.value == 'stinger' then
			TriggerEvent('deploy.stinger')
		end
		if data.current.value == 'news_alert' then
			OpenNewsStation()
		end
		if data.current.value == 'quick_actions' then
			local elements = {
				{label = 'Cuff', 						value = 'cuff'},
				{label = 'Uncuff', 						value = 'xcuff'},
				{label = 'Drag', 						value = 'drag'},
				{label = 'Put in to Vehicle',  			value = 'putveh'},
				{label = 'Drag-out from vehicle',		value = 'dragout'}			
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'quick_actions', {
				title    = 'Quick Actions',
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)

					local action = data2.current.value

					if action == 'cuff' then
						if not IsPedInAnyVehicle(playerPed) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								if not IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "mp_arresting", "idle", 3) then
									ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
										if quantity >= 1 then 
										--------------------------------
										CuffAnim()
										Citizen.Wait(1100)
										TriggerServerEvent('inv_inUse:removeItem', 'pol_cuff')
										--------------------------------
										else
											exports['okokNotify']:Alert("POLICE", "No Handcuffs", 3000, 'info')
										end			
									end, 'pol_cuff')
								else
									exports['okokNotify']:Alert("POLICE", "Target is already cuffed!", 3000, 'info')	
								end
							end
						end
					elseif action == 'xcuff' then
						if not IsPedInAnyVehicle(playerPed) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
		
								if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "mp_arresting", "idle", 3) then
									ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
										if quantity >= 1 then 
										--------------------------------
											UncuffAnim()
											Citizen.Wait(3100)
											TriggerServerEvent('inv_inUse:addItem', 'pol_cuff')
										--------------------------------
										else
											exports['okokNotify']:Alert("POLICE", "You don't have key", 3000, 'info')									
										end			
									end, 'cuff_key')
								else
									exports['okokNotify']:Alert("POLICE", "Target is not cuffed!", 3000, 'info')
								end
							end
						end
					elseif action == 'drag' then
						if not IsPedInAnyVehicle(playerPed) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then						
								TriggerServerEvent('dd_police:drag', GetPlayerServerId(closestPlayer))
							else
								exports['dd_core']:notify('inform', 'No one to drag')
							end
						end
					elseif action == 'putveh' then
						if not IsPedInAnyVehicle(playerPed) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('dd_police:putInVehicle', GetPlayerServerId(closestPlayer))
							end
						end
					elseif action == 'dragout' then
						if not IsPedInAnyVehicle(playerPed) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('dd_police:OutVehicle', GetPlayerServerId(closestPlayer))
							end
						end
					end

			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'citizen_interaction' then
			local elements = {
				{label = 'Check IDs', 			value = 'identity_card'},
				{label = 'Conduct a search', 	value = 'search'},
				{label = 'Fines Menu', 			value = 'fine'},
				{label = 'Jail Menu',       	value = 'jail_menu'},
				{label = 'ComServ Menu',		value = 'communityservice'},
				
				-- {label = 'Conduct a GSR-test', 	value = 'gsr'},
				{label = 'Check Billings', 		value = 'unpaid_bills'}				
			}

			if Config.EnableLicenses then
				table.insert(elements, {label = 'Check Licences', value = 'license'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = 'Citizen Interactions',
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'jail_menu' then
						local dialog = exports['zf_dialog']:DialogInput({
							header = 'Jail Menu',
							  rows = {
								{
								  id = 0,
								  txt = 'Jail Time (minutes)'
								},
								{
								  id = 1,
								  txt = 'Jail Reason'
								},
							  }
							})
						
						if dialog ~= nil then
							if dialog[1].input == nil or dialog[2].input == nil then
								exports['okokNotify']:Alert("POLICE", "Invalid inputs", 3000, 'error')
							else
								jailTime = dialog[1].input
								reason = dialog[2].input
								TriggerServerEvent("dd_jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
							end          
						end
					elseif action == 'communityservice' then
						local dialog = exports['zf_dialog']:DialogInput({
							header = 'Community Service',
							  rows = {
								{
								  id = 0,
								  txt = 'Jail Time (minutes)'
								},

							  }
							})
						
						if dialog ~= nil then
							if dialog[1].input == nil then
								exports['okokNotify']:Alert("POLICE", "Invalid input", 3000, 'error')
							else
								prison_services_count = dialog[1].input
								TriggerServerEvent("dd_prisonwork:sendToCommunityService", GetPlayerServerId(closestPlayer), prison_services_count)
							end          
						end
					elseif action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'search' then
						if not IsAnimated then
							local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
							IsAnimated = true
							ct(function()
								local playerPed = PlayerPedId()											
								ESX.Streaming.RequestAnimDict(dict, function()
									TaskPlayAnim(playerPed, dict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
									Citizen.Wait(1800)
									OpenBodySearchMenu(closestPlayer)
									IsAnimated = false
									ClearPedSecondaryTask(playerPed)										
								end)
							end)
						end
					elseif action == 'gsr' then
						--TriggerEvent('esx_guntest:checkGun', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					end				
				end
			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = 'Vehicle Information',	value = 'vehicle_infos'})
				table.insert(elements, {label = 'Force open vehicle', 	value = 'hijack_vehicle'})
				table.insert(elements, {label = 'Impound Vehicle', 		value = 'impound'})
			end

			table.insert(elements, {label = 'Search on database', value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = 'Vehicle Interactions',
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value

				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					if action == 'vehicle_infos' then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							exports['okokNotify']:Alert("POLICE", "Successfully unlocked vehicle", 3000, 'success')					
						end
					elseif action == 'impound' then
						if not IsPedInAnyVehicle(playerPed, false) then
							local id = '1'
							TriggerEvent('dropoff:vehshop', id)
						end
					end
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end
openLSPDXnMenu1 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'openLSPDXn1'
	})
end
RegisterNUICallback('closexn1', function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({
		action = 'closeLSPDXn1'
	})	
end)
closeLSPDXnn1 = function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		action = 'closeLSPDXn1'
	})	
end
RegisterNUICallback('ci', function(data, cb)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 1.7 then
			
	else
		closeLSPDXnn1()
		CitizenInteraction()
	end
end)
RegisterNUICallback('vi', function(data, cb)
	local vehicle = ESX.Game.GetVehicleInDirection()
	local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
	if DoesEntityExist(vehicle) then
		OpenVehicleInfosMenu(vehicleData)
		closeLSPDXnn1()
	end
end)
RegisterNUICallback('fm', function(data, cb)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 1.7 then
			
	else
		closeLSPDXnn1()
		-- OpenFineMenu()
		OpenFineMenu(closestPlayer)
	end
end)
function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = 'Fines',
		align    = 'bottom-right',
		elements = {
			{label = 'Traffic Offense', value = 0},
			{label = 'Minor Offense',   value = 1},
			{label = 'Average Offense', value = 2},
			{label = 'Major Offencse',   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('dd_police:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, 'P'..ESX.Math.GroupDigits(fine.amount)),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = 'Fines',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('billing:sendBill', GetPlayerServerId(player), 'society_police', 'Fine: ' ..data.current.fineLabel, data.current.amount)
			else
				TriggerServerEvent('billing:sendBill', GetPlayerServerId(player), '', 'Fine: ' ..data.current.fineLabel, data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end
RegisterNUICallback('dr', function(data, cb)
	local playerPed = PlayerPedId()
	if not IsPedInAnyVehicle(playerPed) then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then						
			TriggerServerEvent('dd_police:drag', GetPlayerServerId(closestPlayer))
			closeLSPDXnn1()
		end
	end
end)
RegisterNUICallback('piv', function(data, cb)
	local playerPed = PlayerPedId()
	if not IsPedInAnyVehicle(playerPed) then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent('dd_police:putInVehicle', GetPlayerServerId(closestPlayer))
		end
	end
end)
RegisterNUICallback('pov', function(data, cb)
	local playerPed = PlayerPedId()
	if not IsPedInAnyVehicle(playerPed) then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent('dd_police:OutVehicle', GetPlayerServerId(closestPlayer))
		end
	end
end)
CitizenInteraction = function()
	exports['dd_context']:SetTitle("Citizen Interaction")

	exports['dd_context']:AddButton("Search a person" , "" ,'ci:search' ,'b1' , 'm1')
	exports['dd_context']:AddButton("GSR Tst" , "" ,'ci:gsr' ,'b1' , 'm1')

	exports['dd_context']:AddButton("Jail closest person" , "" ,'ci:jail1' ,'b1' , 'm2')
	exports['dd_context']:AddButton("Unjail person" , "" ,'ci:jail2' ,'b1' , 'm2')
	exports['dd_context']:AddButton("Send closest person to prison work" , "" ,'ci:prisonwork' ,'b1' , 'm2')
	exports['dd_context']:AddButton("Send closest person to community service" , "" ,'ci:comserve' ,'b1' , 'm2')

	exports['dd_context']:SubMenu("Search/Test" , "Search and GSR Test" , "m1" )
    exports['dd_context']:SubMenu("Jail/Prison/Comserve Menu" , "Nemesis interaction" , "m2" )
    exports['dd_context']:SubMenu("Check Billings" , "Open billing menu" , "m3" )
end

RegisterNetEvent("ci:search")
AddEventHandler("ci:search", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 1.7 then
			
	else
		if not IsAnimated then
			local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
			IsAnimated = true
			ct(function()
				local playerPed = PlayerPedId()											
				ESX.Streaming.RequestAnimDict(dict, function()
					TaskPlayAnim(playerPed, dict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
					Citizen.Wait(1800)
					OpenBodySearchMenu(closestPlayer)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)										
				end)
			end)
		end
	end
end)
RegisterNetEvent("ci:gsr")
AddEventHandler("ci:gsr", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 1.7 then
		
	else
		TriggerEvent('guntest:checkGun', GetPlayerServerId(closestPlayer))
	end
end)
RegisterNetEvent("ci:jail1")
AddEventHandler("ci:jail1", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 3.0 then
	
	else
		local dialog = exports['zf_dialog']:DialogInput({
			header = 'Jail Menu',
				rows = {
				{
					id = 0,
					txt = 'Jail Time (minutes)'
				},
				{
					id = 1,
					txt = 'Jail Reason'
				},
				}
			})
		
		if dialog ~= nil then
			if dialog[1].input == nil or dialog[2].input == nil then
				exports['okokNotify']:Alert("POLICE", "Invalid inputs", 3000, 'error')
			else
				jailTime = dialog[1].input
				reason = dialog[2].input
				TriggerServerEvent("dd_jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
			end          
		end
	end
end)
RegisterNetEvent("ci:jail2")
AddEventHandler("ci:jail2", function()
	local elements = {}
	ESX.TriggerServerCallback("dd_jail:retrieveJailedPlayers", function(playerArray)
		if #playerArray == 0 then
			exports['dd_core']:notify('error', 'Your jail is empty!')	
			return
		end
		for i = 1, #playerArray, 1 do
			table.insert(elements, {label = "Prisoner: " .. playerArray[i].name .. " | Jail Time: " .. playerArray[i].jailTime .. " minutes", value = playerArray[i].identifier })
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'jail_unjail_menu',
			{
				title = "Unjail Player",
				align = "right",
				elements = elements
			},
		function(data2, menu2)
			local action = data2.current.value
			TriggerServerEvent("dd_jail:unJailPlayer", action)
			menu2.close()
		end, function(data2, menu2)
			menu2.close()
		end)
	end)
end)
RegisterNetEvent("ci:prisonwork")
AddEventHandler("ci:prisonwork", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 3.0 then
		
	else
		local dialog = exports['zf_dialog']:DialogInput({
			header = 'Prison Work',
				rows = {
				{
					id = 0,
					txt = 'Work load(s)'
				},
				}
			})
		
		if dialog ~= nil then
			if dialog[1].input == nil then
				exports['okokNotify']:Alert("POLICE", "Invalid inputs", 3000, 'error')
			else
				prison_services_count = dialog[1].input
				TriggerServerEvent("dd_prisonwork:sendToPrisonService", GetPlayerServerId(closestPlayer), prison_services_count)
			end          
		end
	end
end)
RegisterNetEvent("ci:comserve")
AddEventHandler("ci:comserve", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 3.0 then
		
	else
		local dialog = exports['zf_dialog']:DialogInput({
			header = 'Community Service',
			  rows = {
				{
				  id = 0,
				  txt = 'Service load(s)'
				},

			  }
			})
		
		if dialog ~= nil then
			if dialog[1].input == nil then
				exports['okokNotify']:Alert("POLICE", "Invalid input", 3000, 'error')
			else
				prison_services_count = dialog[1].input
				TriggerServerEvent("dd_prisonwork:sendToCommunityService", GetPlayerServerId(closestPlayer), prison_services_count)
			end          
		end
	end
end)

--[[REUSABLE ITEMS TARGET]]--
RegisterCommand('badge', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		TriggerEvent('badge:openPD')
	end
end)
RegisterNetEvent('dd_police:showbadge')
AddEventHandler('dd_police:showbadge', function()
	local player, distance = ESX.Game.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then
		local playerPed = PlayerPedId()
		local prop_name = 'prop_fib_badge'
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 28422)
		AttachEntityToEntity(prop, playerPed, boneIndex, 0.065, 0.029, -0.035, 80.0, -1.90, 75.0, true, true, false, true, 1, true)
		RequestAnimDict('paper_1_rcm_alt1-9')
		TaskPlayAnim(playerPed, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, 10.0, 49, 0, 0, 0, 0)
		Citizen.Wait(5000)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		TriggerServerEvent('dd_police:openBadge', GetPlayerServerId(player))
        TriggerServerEvent('dd_police:openBadge')
	else 
		local playerPed = PlayerPedId()
		local prop_name = 'prop_fib_badge'
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 28422)
		AttachEntityToEntity(prop, playerPed, boneIndex, 0.065, 0.029, -0.035, 80.0, -1.90, 75.0, true, true, false, true, 1, true)
		while (not HasAnimDictLoaded("paper_1_rcm_alt1-9")) do
			RequestAnimDict("paper_1_rcm_alt1-9")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "paper_1_rcm_alt1-9", "machinic_loop_mechandplayer", 2.0, 1.0, -1, 18, 0, 0, 0, 0)

		RequestAnimDict('paper_1_rcm_alt1-9')
		TaskPlayAnim(playerPed, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, 10.0, 49, 0, 0, 0, 0)
		Citizen.Wait(5000)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		TriggerServerEvent('dd_police:openBadge')
	end
end)

RegisterNetEvent('badge:openPD')
AddEventHandler('badge:openPD', function()
	TriggerEvent('dd_police:showbadge')
	-- startAnim()
end)
function startAnim()
    RequestModel(GetHashKey(plateModel))
    while not HasModelLoaded(GetHashKey(plateModel)) do
        Citizen.Wait(100)
    end
	ClearPedSecondaryTask(PlayerPedId())
	RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    local playerPed = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -5.0)
    local platespawned = CreateObject(GetHashKey(plateModel), plyCoords.x, plyCoords.y, plyCoords.z, 0, 0, 0)
    Citizen.Wait(1000)
    local netid = ObjToNet(platespawned)
    SetNetworkIdExistsOnAllMachines(netid, true)
    SetNetworkIdCanMigrate(netid, false)
    TaskPlayAnim(playerPed, 1.0, -1, -1, 50, 0, 0, 0, 0)
    TaskPlayAnim(playerPed, animDict, animName, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
    Citizen.Wait(800)
    AttachEntityToEntity(platespawned, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    plate_net = netid
    Citizen.Wait(3000)
    ClearPedSecondaryTask(playerPed)
    DetachEntity(NetToObj(plate_net), 1, 1)
    DeleteEntity(NetToObj(plate_net))
    plate_net = nil
end

RegisterNetEvent('dd_police:cuff')
AddEventHandler('dd_police:cuff', function(item)
	local playerPed = PlayerPedId()
	if not IsPedInAnyVehicle(playerPed) then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			if not IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "mp_arresting", "idle", 3) then
				CuffAnim()
				Citizen.Wait(1100)
				TriggerServerEvent('inv_inUse:removeItem', item)
			else
				exports['okokNotify']:Alert("POLICE", "Target is already cuffed!", 3000, 'error')
			end
		end
	end
end)
RegisterNetEvent('dd_police:xcuff')
AddEventHandler('dd_police:xcuff', function(item,xitem)
	local playerPed = PlayerPedId()
	if not IsPedInAnyVehicle(playerPed) then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "mp_arresting", "idle", 3) then
				if item == 'bobbypin' then
					local rdm = math.random(0,math.random(0,1))
					if rdm == 1 then
						UncuffAnim()
						Citizen.Wait(3100)
						TriggerServerEvent('inv_inUse:addItem', item)
					else
						local rdm2 = math.random(0,math.random(0,2))
						if rdm2 >=1 then
							exports['okokNotify']:Alert("", "Bobbypin was deformed, uncuffing unsuccesful", 3000, 'error')
						elseif rdm2 == 0 then
							exports['okokNotify']:Alert("", "Bobbypin was damaged, uncuffing unsuccesful", 3000, 'error')
							TriggerServerEvent('inv_inUse:removeItem', xitem)
						end
					end
				end
				if item == 'cutter' then
					UncuffAnim()
				end
				if item == 'cuff_key' then
					UncuffAnim()
					Citizen.Wait(3100)
					TriggerServerEvent('inv_inUse:addItem', xitem)
				end
			else
				exports['okokNotify']:Alert("", "Target is not cuffed!", 3000, 'error')
			end
		end
	end
end)
RegisterNetEvent('dd_police:booklet')
AddEventHandler('_rc_polcie:booklet', function()
	OpenJobMenu()
end)

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('dd_police:getOtherPlayerData', function(data)
		local elements = {
			{label = 'Name: '..data.name},
			{label = 'Job: '..data.job},
			{label = 'Rank: '..data.grade}
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = 'Sex: '..data.sex})
			table.insert(elements, {label = 'DoB: '..data.dob})
			table.insert(elements, {label = 'Height: '..data.height})
		end

		if data.drunk then
			table.insert(elements, {label = 'Bac: '..data.drunk})
		end

		if data.licenses then
			table.insert(elements, {label = '--- Licenses ---'})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = 'Citizen Interactions',
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu(player)
	TriggerEvent("dd_inventory:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end

function LookupVehicle()
	local dialog = exports['zf_dialog']:DialogInput({
		header = 'Jail Menu',
		  rows = {
			{
			  id = 0,
			  txt = 'Enter Plate Number'
			},
		  }
		})
	
	if dialog ~= nil then
		local length = string.len(dialog[1].input)
		if dialog[1].input == nil or length < 2 or length > 13 then
			exports['okokNotify']:Alert("POLICE", "Invalid inputs", 3000, 'error')
		else
			answer = dialog[1].input
			ESX.TriggerServerCallback('dd_police:getVehicleFromPlate', function(owner, found)
				if found then
					exports['okokNotify']:Alert("POLICE", 'The vehicle is registered to: '..owner, 3000, 'success')				
				else
					exports['okokNotify']:Alert("POLICE", "That registration number is not registered to an vehicle!", 3000, 'error')				
				end
			end, answer)
		end          
	end
end

function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('dd_police:getOtherPlayerData', function(PlayerData)
		if PlayerData.licenses then
			for i=1, #PlayerData.licenses, 1 do
				if PlayerData.licenses[i].label and PlayerData.licenses[i].type then
					table.insert(elements, {
						label = PlayerData.licenses[i].label,
						type = PlayerData.licenses[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = 'Revoke Licenses',
			align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)
			exports['okokNotify']:Alert("POLICE", 'You revoked a '..data.current.label..' which belonged to '..PlayerData.name, 3000, 'success')	

			TriggerServerEvent('dd_police:message', GetPlayerServerId(player), 'Your license '..data.current.label..' has been revoked!')

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, '$ '..ESX.Math.GroupDigits(bill.amount)),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = 'Check unpaid bills',
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('dd_police:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = 'Plate: '..retrivedInfo.plate}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = 'Owner: Unknown'})
		else
			table.insert(elements, {label = 'Owner: '..retrivedInfo.owner})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = 'Vehicle Info',
			align    = 'center',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

RegisterNetEvent('dd_police:ShowMyBadge')
AddEventHandler('dd_police:ShowMyBadge', function()
	SendNUIMessage({
		action = 'openMir'
	})
	Citizen.Wait(5000)
	closeBadge()
end)
closeBadge = function()
	SendNUIMessage({
		action = 'closeMir'
	})
end
RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Police',
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
	}
	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)
--[[JOB BLIPS]]--
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true)
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
		SetBlipNameToPlayerName(blip, id)
		SetBlipScale(blip, 0.85)
		SetBlipAsShortRange(blip, true)
		if ESX.PlayerData.job.name == 'police' then
			SetBlipColour (blip, 1)
		end

		table.insert(blipsForces, blip)
	end
end

RegisterNetEvent('dd_police:updateBlip')
AddEventHandler('dd_police:updateBlip', function()

	for k, existingBlip in pairs(blipsForces) do
		RemoveBlip(existingBlip)
	end

	blipsForces = {}

	if not Config.EnableJobBlip then
		return
	end

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	-- TriggerEvent('dd_police:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('dd_police:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		-- TriggerEvent('dd_police:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')
		-- if Config.EnableHandcuffTimer and handcuffTimer.active then
		-- 	ESX.ClearTimeout(handcuffTimer.task)
		-- end
	end
end)

function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		exports['okokNotify']:Alert("", 'You feel your handcuffs slowly losing grip and fading away.', 3000, 'info')
		-- TriggerEvent('dd_police:unrestrain')
		handcuffTimer.active = false
	end)
end

function ImpoundVehicle(vehicle)
	ESX.Game.DeleteVehicle(vehicle)
	exports['okokNotify']:Alert("POLICE", 'Successfully impounded vehicle.', 3000, 'info')
	currentTask.busy = false
end
-------------------------------------------CUFF-UNCUFF-----------------------------------------------------
RegisterNetEvent('dd_police:getarrested')
AddEventHandler('dd_police:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 30.0, 'Cuff', 0.2)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	local count = 1
	local speed = 1.5
	exports["mf-inventory"]:startMinigame(count,speed,function(res)
		if res == true then
			cuffed = true
			loadanimdict('mp_arresting')
			TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
			SetPedCanPlayGestureAnims(PlayerPedId(), false)
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end)
end)

RegisterNetEvent('dd_police:doarrested')
AddEventHandler('dd_police:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
end) 

RegisterNetEvent('dd_police:douncuffing')
AddEventHandler('dd_police:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(PlayerPedId())
	SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
end)

RegisterNetEvent('dd_police:getuncuffed')
AddEventHandler('dd_police:getuncuffed', function(playerheading, playercoords, playerlocation)
	SetPedCanPlayGestureAnims(PlayerPedId(), true)
	FreezeEntityPosition(PlayerPedId(), false)
	TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 30.0, 'Uncuff', 0.2)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	cuffed = false
	ClearPedTasks(PlayerPedId())
end)

function CuffAnim()
	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(PlayerPedId())
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(PlayerPedId())
	local target_id = GetPlayerServerId(target)
	if distance <= 2.0 then
		TriggerServerEvent('dd_police:requestarrest', target_id, playerheading, playerCoords, playerlocation)
	else
		exports['okokNotify']:Alert("POLICE", 'Not Close Enough', 3000, 'info')
	end
end

function UncuffAnim()
	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(PlayerPedId())
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playerCoords = GetEntityCoords(PlayerPedId())
	local target_id = GetPlayerServerId(target)
	TriggerServerEvent('dd_police:requestrelease', target_id, playerheading, playerCoords, playerlocation)
end
-----------------------------------------------------DRAGGING-----------------------------------------------------------------
RegisterNetEvent('dd_police:dodragging')
AddEventHandler('dd_police:dodragging', function()
	if not IsEntityPlayingAnim(PlayerPedId(), "switch@trevor@escorted_out", "001215_02_trvs_12_escorted_out_idle_guard2", 3) then
		Citizen.Wait(250)
		loadanimdict('switch@trevor@escorted_out')
		TaskPlayAnim(PlayerPedId(), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(3760)
	else
		Citizen.Wait(0)
		ClearPedTasksImmediately(PlayerPedId())
	end

end) 
function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

RegisterNetEvent('dd_police:drag')
AddEventHandler('dd_police:drag', function(copId)
	if cuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

ct(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if cuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0, 0.70, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(500)
		end
	end
end)

-----------------------------------------------------------------------------------------------------
RegisterNetEvent('dd_police:putInVehicle')
AddEventHandler('dd_police:putInVehicle', function()
	if cuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('dd_police:OutVehicle')
AddEventHandler('dd_police:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 16)
		FreezeEntityPosition(PlayerPedId(), false)
	end
end)

--Handcuff
ct(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		
		if cuffed then		
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)

			if IsAnyVehicleNearPoint(coords, 5.0) and IsControlJustReleased(0, 23) then
				local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

				if DoesEntityExist(vehicle) then
					local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

					for i=maxSeats - 1, 0, -1 do
						if IsVehicleSeatFree(vehicle, i) then
							FreezeEntityPosition(PlayerPedId(), true)
							DisableControlAction(0, 24, true) -- F
							freeSeat = i
							break
						end
					end

					if freeSeat then
						TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
						
						dragStatus.isDragged = false
					end
				end
			end
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 23, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 92,  true)
			DisableControlAction(0, 243, true)
			-- DisableControlAction(0, 32, true) -- W
			-- DisableControlAction(0, 34, true) -- A
			-- DisableControlAction(0, 31, true) -- S
			-- DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 245, true) -- T

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 21, true) -- Run
			-- DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 24, true)
			-- DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 166, true) -- Player Interaction

			DisableControlAction(0, 157,  true) -- 1
			DisableControlAction(0, 158, true) -- 2
			DisableControlAction(0, 160, true) -- 3

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

----------------------ANIMATIONS-----------------------
function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end
function PantsAnims() 
  local ped = PlayerPedId()
  ct(function()
    RequestAnimDict("re@construction")
    Citizen.Wait(100)
    TaskPlayAnim((ped), 're@construction', 'out_of_breath', 1.0, -1, -1, 50, 0, 0, 0, 0)
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(2000)
    ClearPedTasks(ped)
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end
function ShirtsAnim() 
  local ped = PlayerPedId()
  ct(function()
    RequestAnimDict("clothingshirt")
    Citizen.Wait(100)
    TaskPlayAnim((ped), 'clothingshirt', 'try_shirt_positive_d', 1.0, -1, -1, 50, 0, 0, 0, 0)
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(2000)
    ClearPedTasks(ped)
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end
function ShoesAnims() 
  local ped = PlayerPedId()
  ct(function()
    RequestAnimDict("random@domestic")
    Citizen.Wait(100)
    TaskPlayAnim((ped), 'random@domestic', 'pickup_low', 1.0, -1, -1, 50, 0, 0, 0, 0)
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(2000)
    ClearPedTasks(ped)
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end
function AnimCivClothes() 
	local ped = PlayerPedId()
	ct(function()
	  RequestAnimDict("re@construction")
	  Citizen.Wait(100)
	  TaskPlayAnim((ped), 're@construction', 'out_of_breath', 1.0, -1, -1, 50, 0, 0, 0, 0)
	  FreezeEntityPosition(PlayerPedId(), true)
	  Citizen.Wait(5000)
	  ClearPedTasks(ped)
	  FreezeEntityPosition(PlayerPedId(), false)
	end)
  end
function AnimHeadWear() 
	local ped = PlayerPedId()
	ct(function()
	  RequestAnimDict("missheist_agency2ahelmet")
	  Citizen.Wait(100)
	  TaskPlayAnim((ped), 'missheist_agency2ahelmet', 'take_off_helmet_stand', 1.0, -1, -1, 50, 0, 0, 0, 0)
	  FreezeEntityPosition(PlayerPedId(), true)
	  Citizen.Wait(3000)
	  ClearPedTasks(ped)
	  FreezeEntityPosition(PlayerPedId(), false)
	end)
  end
---//FACEPALM//---
function AnimFailed()
  local ped = PlayerPedId()
  ct(function()
    RequestAnimDict("anim@mp_player_intupperface_palm")
    Citizen.Wait(100)
    TaskPlayAnim((ped), 'anim@mp_player_intupperface_palm', 'idle_a', 2.0, 2.0, -1, 81, 0, 0, 0, 0)
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(2000)
    ClearPedTasks(ped)
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end

--[[GENERAL ANNOUNCEMENT]]--
function OpenNewsStation()
	playAnim('mp_common', 'anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_MOBILE', 0, true)

	local elements = {
		{label = 'Implement Priority Cooldown', value = 'start_cool'},
		{label = 'Reset Priority Cooldown', 	value = 'onhold'}
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'newsstation', {
		title    = 'News Announcement',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'start_cool' then
			TriggerServerEvent("dd_news:PostNewsPolice", 'City Cooldown')
		elseif data.current.value == 'onhold' then
			TriggerServerEvent("dd_news:ResetTimer")
		end

	end, function(data, menu)
		menu.close()
		ClearPedTasks(PlayerPedId())
	end)
end

RegisterNetEvent('dd_police:UpdateCooldown')
AddEventHandler('dd_police:UpdateCooldown', function(newCooldown)
    cooldown = newCooldown
end)

RegisterCommand('escort', function(source,args)
	local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then					
		TriggerServerEvent('dd_police:drag', GetPlayerServerId(closestPlayer))
	end
end)
RegisterCommand('piv', function(source,args)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent('dd_police:putInVehicle', GetPlayerServerId(closestPlayer))
		end
	end
end)
RegisterCommand('pov', function(source,args)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 5.0 then
			TriggerServerEvent('dd_police:OutVehicle', GetPlayerServerId(closestPlayer))
		end
	end
end)

RegisterNetEvent("dd_police:ToggleCivAction")
AddEventHandler("dd_police:ToggleCivAction", function()
	CivAction()
end)
function CivAction()
	local elements = {
		{label = 'Carry', 				value = 'carry'},
		{label = 'Tie', 				value = 'tie'},
		{label = 'Untie', 				value = 'untie'},
		{label = 'Headbag', 			value = 'putheadbag'},
		{label = 'Take Hostage', 		value = 'th'},
		{label = 'Search', 				value = 'search'},
		{label = 'Drag', 				value = 'drag'},
		{label = 'Put into car', 		value = 'piv'},
		{label = 'Drag out from car', 	value = 'pov'},
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'interaction', {
		title    = 'Citizen XN',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'carry' then
			TriggerEvent('criminal.carry')
		elseif data.current.value == 'putheadbag' then
			local player, distance = ESX.Game.GetClosestPlayer()
			if distance ~= -1 and distance <= 3.0 then
				ESX.TriggerServerCallback('dd_headbag:itemCheck', function( hasItem )
					TriggerServerEvent('dd_headbag_sv', GetPlayerServerId(player), hasItem)
				end)
			end
		elseif data.current.value == 'tie' then
			ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
				if quantity > 0 then
					TriggerEvent('dd_police:cuff','ziptie')
				else
					exports['okokNotify']:Alert("", 'You need a zip tie!', 3000, 'info')
				end
			end, 'ziptie')
		elseif data.current.value == 'untie' then
			ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
				if quantity > 0 then
					SetCurrentPedWeapon(PlayerPedId(), "WEAPON_SWITCHBLADE",true)
					local item = 'cutter'
					TriggerEvent('dd_police:xcuff', item)
				else
					exports['okokNotify']:Alert("", 'You need a slide cutter!', 3000, 'info')
				end
			end, 'cutter')
		elseif data.current.value == 'th' then
			local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			if closestPlayer ~= -1 and closestDistance <= 3.0 and IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "random@mugging3", "handsup_standing_base", 3) then
				Citizen.Wait(1000)
				TriggerEvent('takehostage')						
			end
		elseif data.current.value == 'search' then
			local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			if closestPlayer ~= -1 and closestDistance <= 3.0 and IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "random@mugging3", "handsup_standing_base", 3) then
				RequestAnimDict("random@shop_robbery")
				while not HasAnimDictLoaded("random@shop_robbery") do
					Citizen.Wait(0)
				end
				TaskPlayAnim(PlayerPedId(), "random@shop_robbery" , "robbery_action_b", 3.0, -8, 2500, 16, 0, 0, 0, 0)	
				Citizen.Wait(1000)
				OpenBodySearchMenu(closestPlayer)						
			end
		elseif data.current.value == 'drag' then
			local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then					
				TriggerServerEvent('dd_police:drag', GetPlayerServerId(closestPlayer))
			end
		elseif data.current.value == 'piv' then
			if not IsPedInAnyVehicle(PlayerPedId()) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('dd_police:putInVehicle', GetPlayerServerId(closestPlayer))
				end
			end
		elseif data.current.value == 'pov' then
			if not IsPedInAnyVehicle(PlayerPedId()) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 5.0 then
					TriggerServerEvent('dd_police:OutVehicle', GetPlayerServerId(closestPlayer))
				end
			end
		end

	end, function(data, menu)
		menu.close()
	end)
end
RegisterNetEvent('dd_police:putInVehicle')
AddEventHandler('dd_police:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('dd_police:OutVehicle')
AddEventHandler('dd_police:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 16)
	end
end)
