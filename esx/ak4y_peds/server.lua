ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('ped', 'admin', function(xPlayer, args, showError)
    if args.playerId and args.ped ~= nil then
		if ESX.GetPlayerFromId(args.playerId) ~= nil then
			local xPlayer = ESX.GetPlayerFromId(args.playerId)
			if args.ped == "sil" then
				local Identifier = ESX.GetPlayerFromId(args.playerId).identifier
				MySQL.Async.execute("UPDATE users SET ped = @ped WHERE identifier = @identifier",{['@identifier'] = Identifier,	['@ped'] = nil})
				Citizen.Wait(100)
				TriggerClientEvent("ak4y:loadDefault", xPlayer.source)
			else
				TriggerClientEvent("ak4y:setNewPed", xPlayer.source, args.ped)
			end
		end
	end
end, true, {help = "Oyuncuya ped ver", validate = true, arguments = {
	{name = 'playerId', help = "Oyuncunun id'si", type = 'number'},
	{name = 'ped', help = "'Ped Adı' ya da 'sil' (kisinin pedini siler)", type = 'string'}
}})

RegisterServerEvent('ak4y:savePed')
AddEventHandler('ak4y:savePed', function(model)
	local Identifier = ESX.GetPlayerFromId(source).identifier
    MySQL.Async.execute("UPDATE users SET ped = @ped WHERE identifier = @identifier",{['@identifier'] = Identifier,['@ped'] = tostring(model)})
end)

RegisterServerEvent('ak4y:checkPed')
AddEventHandler('ak4y:checkPed', function()
	local Identifier = ESX.GetPlayerFromId(source).identifier
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll("SELECT ped FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
		if result[1].ped == "" or result[1].ped == nil then
			TriggerClientEvent("ak4y:loadDefault", xPlayer.source)
		else
			TriggerClientEvent("ak4y:loadPed", xPlayer.source, result[1].ped)
		end
    end)
end)

