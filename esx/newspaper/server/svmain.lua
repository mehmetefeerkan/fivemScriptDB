---------------------------NewsPaper----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------
while Config == nil do Citizen.Wait(10); end; 
local debugprint, arrester1, arrester2, arrester3 = false, true, false, false
if Config.usingESX then
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if Config.Whitelist then
--Put steam or license here if using a Whitelist
Whitelist = {
    'steam:11000011b7c7b7c',
    --'steam:11000510b72352',
    --'license:1234975143578921327',
}

function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(Whitelist) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('[^1NewsPaper-Debug^7] Whitelist id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end
end

RegisterCommand(Config.TitleCommand1, function(source, args)
	local usource = source
   	local article = table.concat(args, " ")
	if Config.Whitelist then
	    if isAllowedToChange(usource) then
			if article then
				TriggerClientEvent("newspaper:headlineTitle1", -1, article)
				exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleTitle1=@articleTitle1", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleTitle1"] = table.concat(args, " ")})
			else
				TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
			end
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
		end
	elseif Config.usingESX and Config.JobRequired then
		local xPlayer = ESX.GetPlayerFromId(usource)
		if xPlayer.job.name == Config.JobName then
			TriggerClientEvent("newspaper:headlineTitle1", -1, article)
			exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleTitle1=@articleTitle1", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleTitle1"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You do not have the reporter job.')
		end
	else
		if article then
			TriggerClientEvent("newspaper:headlineTitle1", -1, article)
			exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleTitle1=@articleTitle1", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleTitle1"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
		end
	end
end)

RegisterCommand(Config.TitleCommand2, function(source, args)
	local usource = source
   	local article = table.concat(args, " ")
	if Config.Whitelist then
	    if isAllowedToChange(usource) then
			if article then
				TriggerClientEvent("newspaper:headlineTitle2", -1, article)
				exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleTitle2=@articleTitle2", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleTitle2"] = table.concat(args, " ")})
			else
				TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
			end
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
		end
	elseif Config.usingESX and Config.JobRequired then
		local xPlayer = ESX.GetPlayerFromId(usource)
		if xPlayer.job.name == Config.JobName then
			TriggerClientEvent("newspaper:headlineTitle2", -1, article)
			exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleTitle2=@articleTitle2", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleTitle2"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You do not have the reporter job.')
		end
	else
		if article then
			TriggerClientEvent("newspaper:headlineTitle2", -1, article)
			exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleTitle2=@articleTitle2", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleTitle2"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
		end
	end
end)

RegisterCommand(Config.ArticleCommand1, function(source, args)
	local usource = source
   	local article = table.concat(args, " ")
	if Config.Whitelist then
	    if isAllowedToChange(usource) then
			if article then
				TriggerClientEvent("newspaper:headline1", -1, article)
				exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleDesc1=@articleDesc1", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleDesc1"] = table.concat(args, " ")})
			else
				TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
			end
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
		end
	elseif Config.usingESX and Config.JobRequired then
		local xPlayer = ESX.GetPlayerFromId(usource)
		if xPlayer.job.name == Config.JobName then
			TriggerClientEvent("newspaper:headline1", -1, article)
			exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleDesc1=@articleDesc1", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleDesc1"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You do not have the reporter job.')
		end
	else
		if article then
			TriggerClientEvent("newspaper:headline1", -1, article)
			exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleDesc1=@articleDesc1", {["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleDesc1"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
		end
	end
end)

RegisterCommand(Config.ArticleCommand2, function(source, args)
	local usource = source
   	local article = table.concat(args, " ")
	if Config.Whitelist then
	    if isAllowedToChange(usource) then
			if article then
				TriggerClientEvent("newspaper:headline2", -1, article)
	 			exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleDesc2=@articleDesc2",{["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleDesc2"] = table.concat(args, " ")})
			else
				TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
			end
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
		end
	elseif Config.usingESX and Config.JobRequired then
		local xPlayer = ESX.GetPlayerFromId(usource)
		if xPlayer.job.name == Config.JobName then
			TriggerClientEvent("newspaper:headline2", -1, article)
	 		exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleDesc2=@articleDesc2",{["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleDesc2"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You do not have the reporter job.')
		end
	else
		if article then
			TriggerClientEvent("newspaper:headline2", -1, article)
	 		exports.ghmattimysql:execute("UPDATE newspaper SET reporter=@reporter, articleDesc2=@articleDesc2",{["@reporter"] = GetPlayerIdentifiers(usource)[1], ["@articleDesc2"] = table.concat(args, " ")})
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You did not put in a title.')
		end
	end
end)

RegisterNetEvent("newspaper:jail")
AddEventHandler("newspaper:jail", function(firstname,lastname,jailTime)
local bigbootybitches = firstname.." "..lastname
local args = bigbootybitches .. " was sent to prison for " .. jailTime .. " months."
if arrester1 and not arrester2 and not arrester3 then
    TriggerClientEvent("newspaper:arrest1", -1, args)
    arrester1 = false
    arrester2 = true
  exports.ghmattimysql:executeSync("UPDATE newspaper SET arrest1=@arrest1",{["@arrest1"] = args})
elseif not arrester1 and arrester2 and not arrester3 then
    TriggerClientEvent("newspaper:arrest2", -1, args)
    arrester2 = false
    arrester3 = true
  exports.ghmattimysql:executeSync("UPDATE newspaper SET arrest2=@arrest2",{["@arrest2"] = args})
elseif not arrester1 and not arrester2 and arrester3 then
    TriggerClientEvent("newspaper:arrest3", -1, args)
    arrester3 = false
    arrester1 = true
  exports.ghmattimysql:executeSync("UPDATE newspaper SET arrest3=@arrest3",{["@arrest3"] = args})
  end
end)

RegisterNetEvent("newspaper:update")
AddEventHandler("newspaper:update", function(source)
exports.ghmattimysql:execute("SELECT * FROM newspaper", {}, function(result)
    TriggerClientEvent('newspaper:headlineTitle1', -1, result[1].articleTitle1)
    TriggerClientEvent('newspaper:headlineTitle2', -1, result[1].articleTitle2)
    TriggerClientEvent('newspaper:headline1', -1, result[1].articleDesc1)
    TriggerClientEvent('newspaper:headline2', -1, result[1].articleDesc2)
    TriggerClientEvent('newspaper:arrest1', -1, result[1].arrest1)
    TriggerClientEvent('newspaper:arrest2', -1, result[1].arrest2)
    TriggerClientEvent('newspaper:arrest3', -1, result[1].arrest3)
end)
end)

---------------------------NewsPaper----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------