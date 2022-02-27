local PlayerData, CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('st:openmdt')
AddEventHandler('st:openmdt', function()
    TriggerServerEvent('lexia:malikontrol', GetPlayerServerId(closestPlayer))
end)

RegisterNetEvent('sheriff:eup')
AddEventHandler('sheriff:eup', function()
	TriggerEvent('eup')
end)

RegisterNetEvent('st:escort')
AddEventHandler('st:escort', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('esx_sheriffjob:drag', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('sheriff:billing')
AddEventHandler('sheriff:billing', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing',
		{ title = 'Polis cezası kes'
	  	},
	  	function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		 	menu.close()
		  	if amount == nil then
				-- ESX.ShowNotification(_U('amount_invalid'))
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = _U('amount_invalid')})
		  	else
			  	TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_sheriff', 'LSPD', amount)
		  	end
  
		else
			-- ESX.ShowNotification(_U('no_players_nearby'))
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = _U('no_players_nearby')})
		end
  
	  	end,
	function(data, menu)
		menu.close()
	end)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = 'Faturalar',
		align    = 'top-right',
		elements = {
			{label = _'Trafik Cezaları', value = 0},
			{label = - 'Küçük Cezalar',   value = 1},
			{label = 'Orta Cezalar', value = 2},
			{label = 'Büyük Cezalar',   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_sheriffjob:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label.. 'armory_item' ..ESX.Math.GroupDigits(fine.amount)),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = 'Fatura',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_sheriff', 'fine_total' ..data.current.fineLabel, data.current.amount)
			else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', 'fine_total ' ..data.current.fineLabel, data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function SendToCommunityService(player)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
        title = "Community Service Menu",
    }, function (data2, menu)
        local community_services_count = tonumber(data2.value)

        if community_services_count == nil then
            ESX.ShowNotification('Invalid services count.')
        else
            TriggerServerEvent("esx_communityservice:sendToCommunityService", player, community_services_count)
            menu.close()
        end
    end, function (data2, menu)
        menu.close()
    end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('esx_sheriffjob:getOtherPlayerData', function(data)
		if data.licenses then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label and data.licenses[i].type then
					table.insert(elements, {
						label = data.licenses[i].label,
						type = data.licenses[i].type
					})
				end
			end
		end

		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		{
			title    = 'Lisans İptal',
			align    = 'top-right',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_sheriffjob:message', GetPlayerServerId(player), 'license_revoked' ..data.current.label)

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function JailPlayer(player)
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'jail_menu',
		{
			title = 'Hapishane Menüsü',
		},
	function (data2, menu)
		local jailTime = tonumber(data2.value)
		if jailTime == nil then
			exports['mythic_notify']:SendAlert('inform', 'Hapise gönderildiniz!')
			
		else
			TriggerServerEvent("esx_jail:sendToJail2", player, jailTime * 60)
			menu.close()
		end
	end,
	function (data2, menu)
		menu.close()
	end
	)
end

RegisterNetEvent('sheriff:checkLicenses')
AddEventHandler('sheriff:checkLicenses', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		ShowPlayerLicense(closestPlayer)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('sheriff:communityservice')
AddEventHandler('sheriff:communityservice', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		SendToCommunityService(GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('sheriff:jailmenu')
AddEventHandler('sheriff:jailmenu', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		JailPlayer(GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('sheriff:object')
AddEventHandler('sheriff:object', function()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
        title    = _U('traffic_interaction'),
        align    = 'top-right',
        elements = {
            --{label = _U('cone'), model = 'prop_roadcone02a'},
            {label = _U('barrier'), model = 'prop_barrier_work05'},
            {label = _U('spikestrips'), model = 'p_ld_stinger_s'}
            --{label = _U('box'), model = 'prop_boxpile_07d'},
            --{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
    }}, function(data2, menu2)
        local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)
        local forward   = GetEntityForwardVector(playerPed)
        local x, y, z   = table.unpack(coords + forward * 1.0)

        if data2.current.model == 'prop_roadcone02a' then
            z = z - 2.0
        end

        ESX.Game.SpawnObject(data2.current.model, {x = x, y = y, z = z}, function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end)
    end, function(data2, menu2)
        menu2.close()
    end)
end)

RegisterNetEvent('sheriff:checkBank')
AddEventHandler('sheriff:checkBank', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		OpenUnpaidBillsMenu(closestPlayer)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('st:handcuff')
AddEventHandler('st:handcuff', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'handcuffhard', 0.9)
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
		if distance <= 2.0 then
			TriggerServerEvent('esx_sheriffjob:requestarrest', target_id, playerheading, playerCoords, playerlocation)
		else
			ESX.ShowNotification('Kelepçelemek için yeterince yakın değil')
		end
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('st:uncuff')
AddEventHandler('st:uncuff', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'handcuffunhard', 0.9)
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
		TriggerServerEvent('esx_sheriffjob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
		if distance <= 2.0 then
		else
			ESX.ShowNotification('Kelepçeyi çözmek için yeterince yakın değil')
		end		
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

function OpenBodySearchMenu(player)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end

RegisterNetEvent('st:search')
AddEventHandler('st:search', function()
	ExecuteCommand('ara')
end)

RegisterNetEvent('st:checkGSR')
AddEventHandler('st:checkGSR', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('GSR:Status2', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('st:getid')
AddEventHandler('st:getid', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('jsfour-idcard:open',  GetPlayerServerId(player), GetPlayerServerId(PlayerId()))
    else
    exports['mythic_notify']:SendAlert('inform', 'Yakında birisi yok', 2500)
    end
    --     exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    -- end
end)

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for i=1, #bills, 1 do
			table.insert(elements, {
				label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>',
				value = bills[i].id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = 'Ödenmemiş Faturalar',
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

RegisterNetEvent('st:putinvehicle')
AddEventHandler('st:putinvehicle', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_sheriffjob:putInVehicle', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)

RegisterNetEvent('st:takeoutvehicle')
AddEventHandler('st:takeoutvehicle', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_sheriffjob:OutVehicle', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok!')
    end
end)
