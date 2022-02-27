ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('russell-duty:onduty')
AddEventHandler('russell-duty:onduty', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
	
    for k,v in pairs(Config.Jobs) do
		local offjob = 'off'..v
		local onjob = string.gsub(job, "off", "")
		local name = GetName(_source)
		local xPlayer = ESX.GetPlayerFromId(_source)
		if job == offjob then
			xPlayer.setJob(onjob, grade)
			 DiscordWebhook(xPlayer, Config.Bot["Name"], Config.Bot["Image"],name.." **Mesaiye girdi.**")
		else
		end
	end

end)

RegisterServerEvent('russell-duty:offduty')
AddEventHandler('russell-duty:offduty', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
	
    for k,v in pairs(Config.Jobs) do
		local offjob = 'off'..v
		local onjob = string.gsub(job, "off", "")
		local name = GetName(_source)
		local xPlayer = ESX.GetPlayerFromId(_source)
		if job == v then
			xPlayer.setJob('off' ..job, grade)
		 DiscordWebhook(xPlayer, Config.Bot["Name"], Config.Bot["Image"],name.." **Mesaiden çıktı.**")
		else
		end
	end

end)

RegisterServerEvent('russell-duty:unemployed')
AddEventHandler('russell-duty:unemployed', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = GetName(_source)
			xPlayer.setJob('unemployed', 0)
		 DiscordWebhook(xPlayer, Config.Bot["Name"], Config.Bot["Image"],name.." **İmzalı istifa.**")
	end)

function DiscordWebhook(xPlayer, botname, botimage, message)
	PerformHttpRequest(Config.JobWH[xPlayer.job.name], function(Error, Content, Head) end, 'POST', json.encode({username = botname, content = "> ".. message, avatar_url = botimage}), { ['Content-Type'] = 'application/json' })
end	


function GetName(_source)
    local identifier = GetPlayerIdentifiers(_source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})

    if result[1] ~= nil then
        return result[1].firstname .. " " .. result[1].lastname
    else
        return nil
    end
end