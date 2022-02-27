ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingMelon   = {}
local PlayersTransformingMelon = {}
local PlayersSellingMelon      = {}
local PlayersHarvestingSarap   = {}
local PlayersTransformingSarap = {}
local PlayersSellingSarap      = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('antihack:policeCountUpdate')
AddEventHandler('antihack:policeCountUpdate', function(count)
	CopsConnected = count
end)

-------------------------------------------------------
-----------------------Sarap----------------------------
-------------------------------------------------------
local function HarvestSarap(source)
	
	SetTimeout(Config.TimeToFarmSarap, function()

		if PlayersHarvestingSarap[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local sarap = xPlayer.getInventoryItem('sarap')

			if xPlayer.canCarryItem('sarap', 1) then
				xPlayer.addInventoryItem('sarap', 1)
				HarvestSarap(source)
			else 
				xPlayer.showNotification('Envanterin Dolu')
			end
		end
	end)
end

RegisterServerEvent('antihack:startHarvestSarap')
AddEventHandler('antihack:startHarvestSarap', function()

	local _source = source

	PlayersHarvestingSarap[_source] = true

	-- TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('pickup_in_prog')})

	HarvestSarap(_source)

end)

RegisterServerEvent('antihack:stopHarvestSarap')
AddEventHandler('antihack:stopHarvestSarap', function()

	local _source = source

	PlayersHarvestingSarap[_source] = false

end)

local function TransformSarap(source)

	

	SetTimeout(Config.TimeToProcessSarap, function()

		if PlayersTransformingSarap[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)
			
			local SarapQuantity = xPlayer.getInventoryItem('sarap').count
			local poochQuantity = xPlayer.getInventoryItem('choped_sarap').count

			if SarapQuantity >= 5 then
				if xPlayer.canCarryItem('choped_melon', 1) then
					xPlayer.removeInventoryItem('sarap', 5)
					xPlayer.addInventoryItem('choped_sarap', 1)
					TransformSarap(source)
				else
					xPlayer.showNotification('Envanterin Dolu')
				end
			else	
				xPlayer.showNotification('Yeteri Kadar Esyan Yok')
			end

		end
	end)
end

RegisterServerEvent('antihack:startTransformSarap')
AddEventHandler('antihack:startTransformSarap', function()

	local _source = source

	PlayersTransformingSarap[_source] = true

	
	-- TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('packing_in_prog')})

	TransformSarap(_source)

end)

RegisterServerEvent('antihack:stopTransformSarap')
AddEventHandler('antihack:stopTransformSarap', function()

	local _source = source

	PlayersTransformingSarap[_source] = false

end)

local function SellSarap(source)

	if CopsConnected < Config.RequiredCopsSarap then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsSarap))
	
		return
	end

	SetTimeout(Config.TimeToSellSarap, function()

		if PlayersSellingSarap[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('choped_sarap').count

			if poochQuantity == 0 then
			
				-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_pouches_Sarap_sale')})
		    
			else
				xPlayer.removeInventoryItem('choped_sarap', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
				elseif CopsConnected >= 4 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
                elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
                elseif CopsConnected >= 7 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
                elseif CopsConnected >= 8 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
                elseif CopsConnected >= 9 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))
                elseif CopsConnected >= 10 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_sarap'))					
				end
				
				SellSarap(source)
			end

		end
	end)
end

RegisterServerEvent('antihack:startSellSarap')
AddEventHandler('antihack:startSellSarap', function()

	local _source = source

	PlayersSellingSarap[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellSarap(_source)

end)

RegisterServerEvent('antihack:stopSellSarap')
AddEventHandler('antihack:stopSellSarap', function()

	local _source = source

	PlayersSellingSarap[_source] = false

end)

------------- KARPUZ -------------------
local function HarvestMelon(source)

	if PlayersHarvestingMelon[source] == true then
	
	SetTimeout(Config.TimeToFarmMelon, function()

		local xPlayer  = ESX.GetPlayerFromId(source)
		local _source = source
			
		local melon = xPlayer.getInventoryItem('melon')

		if xPlayer.canCarryItem('melon', 1) then
			xPlayer.addInventoryItem('melon', 1)
			HarvestMelon(source)
		else
			xPlayer.showNotification('Envanterin Dolu')
		end		
		end)
	end
end

RegisterServerEvent('antihack:startHarvestMelon')
AddEventHandler('antihack:startHarvestMelon', function()

	local _source = source

	PlayersHarvestingMelon[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestMelon(_source)

end)

RegisterServerEvent('antihack:stopHarvestMelon')
AddEventHandler('antihack:stopHarvestMelon', function()

	local _source = source

	PlayersHarvestingMelon[_source] = false

end)

local function TransformMelon(source)
	
	SetTimeout(Config.TimeToProcessMelon, function()

		if PlayersTransformingMelon[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local melonQuantity = xPlayer.getInventoryItem('melon').count
			local poochQuantity = xPlayer.getInventoryItem('choped_melon').count

			if melonQuantity >= 5 then
				if xPlayer.canCarryItem('choped_melon', 1) then
					xPlayer.removeInventoryItem('melon', 5)
					xPlayer.addInventoryItem('choped_melon', 1)
					TransformMelon(source)
				else
					xPlayer.showNotification('Yeteri Kadar Esyan Yok')
				end	
			end
		end
	end)
end

RegisterServerEvent('antihack:startTransformMelon')
AddEventHandler('antihack:startTransformMelon', function()

	local _source = source

	PlayersTransformingMelon[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformMelon(_source)

end)

RegisterServerEvent('antihack:stopTransformMelon')
AddEventHandler('antihack:stopTransformMelon', function()

	local _source = source

	PlayersTransformingMelon[_source] = false

end)

local function SellMelon(source)

	
	SetTimeout(Config.TimeToSellMelon, function()

		if PlayersSellingMelon[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('choped_melon').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_melon_sale'))
			else
				xPlayer.removeInventoryItem('choped_melon', 1)
				xPlayer.addMoney(200)
				TriggerClientEvent('esx:showNotification', source, _U('sold_one_melon'))
				SellMelon(source)
			end

		end
	end)
end

RegisterServerEvent('antihack:startSellMelon')
AddEventHandler('antihack:startSellMelon', function()

	local _source = source

	PlayersSellingMelon[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellMelon(_source)

end)

RegisterServerEvent('antihack:stopSellMelon')
AddEventHandler('antihack:stopSellMelon', function()

	local _source = source

	PlayersSellingMelon[_source] = false

end)

RegisterServerEvent('antihack:GetUserInventory')
AddEventHandler('antihack:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		
	TriggerClientEvent('antihack:ReturnInventory', _source, xPlayer.getInventoryItem('melon').count, xPlayer.getInventoryItem('choped_melon').count, xPlayer.getInventoryItem('sarap').count, xPlayer.getInventoryItem('choped_sarap').count,xPlayer.job.name, currentZone)
end)

ESX.RegisterUsableItem('sarap', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('sarap', 1)

	TriggerClientEvent('antihack:onPot', _source)
	-- TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('used_one_sarap')})
end)
