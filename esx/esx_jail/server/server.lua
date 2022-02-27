ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)

RegisterCommand("hapis", function(source, args, raw)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == "police" then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if args[1] ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = GetPlayerName(jailPlayer) .. "  " .. jailTime .. " dakika hapise girdi!"})
				--TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text =  GetPlayerName(jailPlayer) .. "  " .. jailTime .. " dakika hapise girdi!")
				
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
						TriggerClientEvent('chat:addMessage', -1, {
							template = '<div class="chat-message server"> [HAPISHANE]: {0}</div>',
							args = {Firstname .. " " .. Lastname .. " hapise girdi! Sebep: " .. args[3]}
						})
						--TriggerClientEvent('chat:addMessage', -1, { args = { "HAPISHANE",  Firstname .. " " .. Lastname .. " hapise girdi! Sebep: " .. args[3] }, color = { 249, 166, 0 } })
					end)
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Geçersiz zaman girdin!"})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Geçersiz ID girdin!"})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Polis olmadan bu komutu kullanmazsın!"})
	end
end)

RegisterCommand("hapistencikart", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local jailPlayer = args[1]

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text =  "Geçersiz ID"})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text =  "Polis değilsin."})
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)

	JailPlayer(targetSrc, jailTime)

	GetRPName(targetSrc, function(Firstname, Lastname)
		TriggerClientEvent('chat:addMessageOOC', -1, {
			template = '<div class="chat-message server"> [HAPISHANE]: {0}</div>',
			args = {Firstname .. " " .. Lastname .. " hapise girdi! Sebep: " .. jailReason}
		})
		--TriggerClientEvent('chat:addMessage', -1, { args = { "JUDGE",  Firstname .. " " .. Lastname .. " hapiste! Sebep: " .. jailReason }, color = { 249, 166, 0 } })
	end)
	--TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Firstname(targetSrc) .. "  " .. jailTime .. " dakika hapise mahkum edildin!"})
	--TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text =  GetPlayerName(targetSrc) .. "  " .. jailTime .. " dakika hapise mahkum edildin!")
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text =  xPlayer.name .. " hapisten çıktı!"})
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(10, 25))

	TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text =  "Biraz para kazandın."})
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)