ESX = nil

local Categories = {}
local Vehicles   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('zar:shareDisplay')
AddEventHandler('zar:shareDisplay', function(text)
	TriggerClientEvent('zar:triggerDisplay', -1, text, source)
	if logEnabled then
		setLog(text, source)
	end
end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end

AddEventHandler('esx:playerLoaded', function(source)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addAccountMoney('bank', 1)
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(message)
	MySQL.Async.execute('INSERT INTO bz_olumlog (OlumNedeni)VALUES (@OlumNedeni) ', {
					['@OlumNedeni']   = message})
end)

--[[

AddEventHandler('playerConnecting', function()
	local Join = GetPlayerName(source) .. " Servera Bağlandı"
	MySQL.Async.execute('INSERT INTO bz_joinlog (GirisCikis)VALUES (@GirisCikis) ', {
					['@GirisCikis']   = Join})
end)

AddEventHandler('playerDropped', function()
	local Join = GetPlayerName(source) .. " Serverdan Çıkış Yaptı"
	MySQL.Async.execute('INSERT INTO bz_joinlog (GirisCikis)VALUES (@GirisCikis) ', {
					['@GirisCikis']   = Join})
end)
--]]