ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingKoda    = {}
local PlayersTransformingKoda  = {}
local PlayersSellingKoda       = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

--kodeina
local function HarvestKoda(source)

	SetTimeout(Config.TimeToFarm, function()
		if PlayersHarvestingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local koda = xPlayer.getInventoryItem('bitcoin')
			local lap = xPlayer.getInventoryItem('laptop')
				xPlayer.addInventoryItem('bitcoin', 1)
				HarvestKoda(source)
		end
	end)
end

RegisterServerEvent('esx_bitcoin:startHarvestKoda')
AddEventHandler('esx_bitcoin:startHarvestKoda', function()
	local _source = source

	if not PlayersHarvestingKoda[_source] then
		PlayersHarvestingKoda[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('pegar_frutos'))
		HarvestKoda(_source)
	else
		print(('esx_bitcoin: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_bitcoin:stopHarvestKoda')
AddEventHandler('esx_bitcoin:stopHarvestKoda', function()
	local _source = source

	PlayersHarvestingKoda[_source] = false
end)

local function TransformKoda(source)

	SetTimeout(Config.TimeToProcess, function()
		if PlayersTransformingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local kodaQuantity = xPlayer.getInventoryItem('bitcoin').count
			local pooch = xPlayer.getInventoryItem('bitcoin')

			if kodaQuantity < 2 then
				TriggerClientEvent('esx:showNotification', source, _U('nao_tens_mais_frutos'))
			else
				xPlayer.removeInventoryItem('bitcoin', 2)
				xPlayer.addInventoryItem('bitcoin', 1)

				TransformKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_bitcoin:startTransformKoda')
AddEventHandler('esx_bitcoin:startTransformKoda', function()
	local _source = source

	if not PlayersTransformingKoda[_source] then
		PlayersTransformingKoda[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('colocar_frutos_dentro_dos_sacos'))
		TransformKoda(_source)
	else
		print(('esx_bitcoin: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_bitcoin:stopTransformKoda')
AddEventHandler('esx_bitcoin:stopTransformKoda', function()
	local _source = source

	PlayersTransformingKoda[_source] = false
end)

local function SellKoda(source)

	SetTimeout(Config.TimeToSell, function()
		if PlayersSellingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local poochQuantity = xPlayer.getInventoryItem('bitcoin').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('nao_tens_sacos_com_frutos'))
			else
				xPlayer.removeInventoryItem('bitcoin', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 100)
					TriggerClientEvent('esx:showNotification', source, _U('vendeste_sacos'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 110)
					TriggerClientEvent('esx:showNotification', source, _U('vendeste_sacos'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 120)
					TriggerClientEvent('esx:showNotification', source, _U('vendeste_sacos'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 130)
					TriggerClientEvent('esx:showNotification', source, _U('vendeste_sacos'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 140)
					TriggerClientEvent('esx:showNotification', source, _U('vendeste_sacos'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 150)
					TriggerClientEvent('esx:showNotification', source, _U('vendeste_sacos'))
				end

				SellKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_bitcoin:startSellKoda')
AddEventHandler('esx_bitcoin:startSellKoda', function()
	local _source = source

	if not PlayersSellingKoda[_source] then
		PlayersSellingKoda[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('venda_do_sacos'))
		SellKoda(_source)
	else
		print(('esx_bitcoin: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_bitcoin:stopSellKoda')
AddEventHandler('esx_bitcoin:stopSellKoda', function()
	local _source = source

	PlayersSellingKoda[_source] = false
end)

RegisterServerEvent('esx_bitcoin:GetUserInventory')
AddEventHandler('esx_bitcoin:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_bitcoin:ReturnInventory',
		_source,
		xPlayer.getInventoryItem('bitcoin').count,
		xPlayer.getInventoryItem('bitcoin').count,
		xPlayer.job.name,
		currentZone
	)
end)

ESX.RegisterUsableItem('bitcoin', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('bitcoin', 1)

	TriggerClientEvent('esx_bitcoin:onPot', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_koda'))
end)
