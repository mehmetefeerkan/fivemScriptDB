ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('redux:userpeds:pedCheck', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM redux_user_peds WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
		}, function(result)
			if result[1] ~= nil then
				cb(result[1])
			else
				cb(nil)
			end
		end)
	else
		cb(nil)
	end
end)

RegisterServerEvent('redux:userpeds:saveRandomized')
AddEventHandler('redux:userpeds:saveRandomized', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT * FROM redux_user_peds WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier}, function(result2)
		if result2[1] ~= nil then
			MySQL.Async.execute('UPDATE redux_user_peds SET randomized = @randomized WHERE identifier = @identifier',{['@randomized'] = true, ['@identifier'] = xPlayer.identifier})
		end
	end)
end)
			

TriggerEvent('es:addGroupCommand', 'pedver', 'admin', function(source, args, user)
	local _source = source
	local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
	local pedModel   = args[2]

	if xTarget ~= nil then
		if pedModel ~= nil then
			MySQL.Async.fetchAll('SELECT * FROM redux_user_peds WHERE pedmodel = @pedmodel', {
				['@pedmodel'] = pedModel,
			}, function(result)
				if result[1] == nil then
					MySQL.Async.fetchAll('SELECT * FROM redux_user_peds WHERE identifier = @identifier', {
						['@identifier'] = xTarget.identifier,
					}, function(result2)
						if result2[1] == nil then
							MySQL.Async.execute('INSERT INTO redux_user_peds (identifier, pedmodel) VALUES (@identifier, @pedmodel)',{
								['@identifier'] = xTarget.identifier, ['@pedmodel'] = pedModel})
							TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'inform', text = 'Your ped have confirmed. Please re-enter!'})
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'This people already have a pedmodel!'})
						end
					end)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'This model is already in use!'})
				end
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'empty_pedmodel'})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'empty_id'})
	end
end,  function(source, args, user)
	TriggerClientEvent('chat:addMessage', _source, { args = { '^1SISTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addGroupCommand', 'pedsil', 'admin', function(source, args, user)
	local _source = source
	local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))

	if xTarget ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM redux_user_peds WHERE identifier = @identifier', {
			['@identifier'] = xTarget.identifier,
		}, function(result)
			if result[1] ~= nil then
				MySQL.Async.fetchAll('DELETE FROM redux_user_peds WHERE identifier = @identifier',{['@identifier'] = xTarget.identifier})
				TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'error', text = 'Your peds been removed. Please re-enter!'})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'This people don\'t already have a model!'})
			end
		end)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'empty_id'})
	end
end,  function(source, args, user)
	TriggerClientEvent('chat:addMessage', _source, { args = { '^1SISTEM', 'Insufficient Permissions.' } })
end)


