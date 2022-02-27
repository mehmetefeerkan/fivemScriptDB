ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("comserv", function(src, args, raw)
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.job.name == 'police' then
		if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
			TriggerEvent('dd_prisonwork:sendToCommunityService', tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent('okokNotify:Alert', src, "", "Invalid player ID or actions count.", 5000, 'error')
		end
	end
	
end)
RegisterCommand("jailwork", function(src, args, raw)
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.job.name == 'police' then
		if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
			TriggerEvent('dd_prisonwork:sendToPrisonService', tonumber(args[1]), tonumber(args[2]))
		else
			TriggerClientEvent('okokNotify:Alert', src, "", "Invalid player ID or actions count.", 5000, 'error')
		end
	end
	
end)

RegisterCommand("endcomserv", function(src, args, raw)
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.job.name == 'police' then
		if args[1] then 
			if GetPlayerName(args[1]) ~= nil then
				TriggerEvent('dd_prisonwork:endCommunityServiceCommand', tonumber(args[1]))
			else
				TriggerClientEvent('okokNotify:Alert', src, "", "Invalid player ID or actions count.", 5000, 'error')
			end
		else
			TriggerEvent('dd_prisonwork:endCommunityServiceCommand', src)
		end
	end
end)

RegisterCommand("endjail", function(src, args, raw)
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.job.name == 'police' then
		if args[1] then 
			if GetPlayerName(args[1]) ~= nil then
				TriggerEvent('dd_prisonwork:endPrisonServiceCommand', tonumber(args[1]))
			else
				TriggerClientEvent('okokNotify:Alert', src, "", "Invalid player ID or actions count.", 5000, 'error')
			end
		else
			TriggerEvent('dd_prisonwork:endPrisonServiceCommand', src)
		end
	end
end)

RegisterServerEvent('dd_prisonwork:endCommunityServiceCommand')
AddEventHandler('dd_prisonwork:endCommunityServiceCommand', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)
RegisterServerEvent('dd_prisonwork:endPrisonServiceCommand')
AddEventHandler('dd_prisonwork:endPrisonServiceCommand', function(source)
	if source ~= nil then
		releaseFromPrisonService(source)
	end
end)

RegisterServerEvent('dd_prisonwork:finishCommunityService')
AddEventHandler('dd_prisonwork:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('dd_prisonwork:finishPrisonService')
AddEventHandler('dd_prisonwork:finishPrisonService', function()
	releaseFromPrisonService(source)
end)

-------------//community service//-------------------------------
RegisterServerEvent('dd_prisonwork:completeService')
AddEventHandler('dd_prisonwork:completeService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE users SET comserv = comserv - 1 WHERE identifier = @identifier', {
				['@identifier'] = identifier
			})
		else
			print ("dd_prisonwork :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('dd_prisonwork:extendService')
AddEventHandler('dd_prisonwork:extendService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE users SET comserv = comserv + @extension_value WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@extension_value'] = Config.ServiceExtensionOnEscape
			})
		else
			print ("dd_prisonwork :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('dd_prisonwork:sendToCommunityService')
AddEventHandler('dd_prisonwork:sendToCommunityService', function(target, actions_count)

	local identifier = GetPlayerIdentifiers(target)[1]

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@comserv'] = actions_count
			})
		end
	end)
	TriggerClientEvent('dd_prisonwork:inCommunityService', target, actions_count)
end)
RegisterServerEvent('dd_prisonwork:checkIfSentenced')
AddEventHandler('dd_prisonwork:checkIfSentenced', function()
	local _source = source -- cannot parse source to client trigger for some weird reason
	local identifier = GetPlayerIdentifiers(_source)[1] -- get steam identifier

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] ~= nil and result[1].comserv > 0 then			
			TriggerClientEvent('dd_prisonwork:inCommunityService', _source, tonumber(result[1].comserv))
		end
	end)
end)
function releaseFromCommunityService(target)
	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@comserv'] = 0
			})
		end
	end)

	TriggerClientEvent('dd_prisonwork:finishCommunityService', target)
end
-------------//prison works//-------------------------------
RegisterServerEvent('dd_prisonwork:completePrisonService')
AddEventHandler('dd_prisonwork:completePrisonService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE users SET prisonwork = prisonwork - 1 WHERE identifier = @identifier', {
				['@identifier'] = identifier
			})
		else
			print ("dd_prisonwork :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('dd_prisonwork:extendPrisonService')
AddEventHandler('dd_prisonwork:extendPrisonService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE users SET prisonwork = prisonwork + @extension_value WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@extension_value'] = Config.ServiceExtensionOnEscape
			})
		else
			print ("dd_prisonwork :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('dd_prisonwork:sendToPrisonService')
AddEventHandler('dd_prisonwork:sendToPrisonService', function(target, actions_count)

	local identifier = GetPlayerIdentifiers(target)[1]

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE users SET prisonwork = @prisonwork WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@prisonwork'] = actions_count
			})
		end
	end)
	TriggerClientEvent('dd_prisonwork:inPrisonService', target, actions_count)
end)

RegisterServerEvent('dd_prisonwork:checkIfJailed')
AddEventHandler('dd_prisonwork:checkIfJailed', function()
	local _source = source -- cannot parse source to client trigger for some weird reason
	local identifier = GetPlayerIdentifiers(_source)[1] -- get steam identifier

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] ~= nil and result[1].prisonwork > 0 then
			
			TriggerClientEvent('dd_prisonwork:inPrisonService', _source, tonumber(result[1].prisonwork))
		end
	end)
end)

function releaseFromPrisonService(target)
	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE users SET prisonwork = @prisonwork WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@prisonwork'] = 0
			})
		end
	end)

	TriggerClientEvent('dd_prisonwork:finishPrisonService', target)
end