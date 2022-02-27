
---------------------------


AddEventHandler('playerConnecting', function()
	TriggerEvent('cylex:ToDiscord', Config.SistemLogu, SystemName, '```fix\n' .. GetPlayerName(source) .. ' bağlanıyor\n```', SystemAvatar, false)
end)

AddEventHandler('playerDropped', function(Reason)
	TriggerEvent('cylex:ToDiscord', Config.SistemLogu, SystemName, '```fix\n' .. GetPlayerName(source) .. ' çıktı (' .. Reason .. ')\n```', SystemAvatar, false)
end)

	-- Killing Log
RegisterServerEvent('cylex:playerDied')
AddEventHandler('cylex:playerDied', function(Message, Weapon)
	local date = os.date('*t')

	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	if Weapon then
		Message = Message .. ' [' .. Weapon .. ']'
	end
	TriggerEvent('cylex:ToDiscord', Config.OldurmeLoglari, SystemName, Message .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`', SystemAvatar, false)
end)

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for i, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for i, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for i, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	end
	return false
end
	
function ReplaceSpecialCommand(String)
	for i, SpecialCommand in ipairs(SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'WEBHOOK_LINK_HERE' then
				print('Bu komut için web hook gir: ' .. String[1])
				return Config.ChatLogu
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end

	local t={} ; i=1

	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	return t
end

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
	local IDs = GetPlayerIdentifiers(ID)
	for k, CurrentID in pairs(IDs) do
		local ID = stringsplit(CurrentID, ':')
		if (ID[1]:lower() == string.lower(Type)) then
			return ID[2]:lower()
		end
	end
	return nil
end

--  TriggerEvent("cylex:giveitemalert", sourceXPlayer.name, targetXPlayer.name, itemCount, ESX.Items[itemName].label)
RegisterServerEvent("cylex:giveitemalert")
AddEventHandler("cylex:giveitemalert", function(name, nametarget, amount, itemname)
  	if(Config.ItemVerme)then
  		if Config.Discord then 
    		sendToDiscord(Config.ItemVermeLogu, "Eşya transfer edildi.", name.. "oyuncusu " ..nametarget.. " oyuncusuna " ..amount .. " adet " ..itemname .. " eşyasını verdi.", Config.orange)
    	else
			MySQL.Async.execute('INSERT INTO cylex_item (Veren, Tip, Sayi, Item, Alici)VALUES (@Veren, @Tip, @Sayi, @Item, @Alici) ',
            {
                    ['@Veren']   = name,
                    ['@Tip']   = 'Esya verdi',
                    ['@Sayi']    = amount,
					['@Item']    = itemname,
                    ['@Alici']    = nametarget

       	}
            )
    	end
  	end
end)

--TriggerEvent("cylex:dropitemalert", xPlayer.name, itemCount, ESX.Items[itemName].label)
RegisterServerEvent("cylex:dropitemalert")
AddEventHandler("cylex:dropitemalert", function(name, amount, itemname)
  	if(Config.EsyaAtma)then
  		if Config.Discord then
    	 	sendToDiscord(Config.ItemAtmaLogu, "Yere eşya atıldı.", name.. " oyuncusu yere " ..amount .. " adet " ..itemname.. " eşyasını attı", Config.orange)
    	else
    		MySQL.Async.execute('INSERT INTO cylex_drop (Atan, Tip, Item, Sayi)VALUES (@Atan, @Tip, @Item, @Sayi) ',
            {
                    ['@Atan']   = name,
                    ['@Tip']   = 'Yere atti',
					['@Item']   = itemname,
					['@Sayi']    = amount

        }
            )
        end
  	end
end)

--TriggerEvent("cylex:dropmoneyalert", xPlayer.name, itemCount)
RegisterServerEvent("cylex:dropmoneyalert")
AddEventHandler("cylex:dropmoneyalert", function(name, amount)
  	if(Config.ParaAtma)then
  		if Config.Discord then
    		sendToDiscord(Config.ParaAtmaLogu, "Yere para atıldı.", name.. " oyuncusu yere $" ..amount .. " para attı", Config.orange)
    	else
			MySQL.Async.execute('INSERT INTO cylex_drop (Atan, Tip, Item, Sayi)VALUES (@Atan, @Tip, @Item, @Sayi) ',
            {
                    ['@Atan']   = name,
                    ['@Tip']   = 'Esya atti',
                    ['@Item']   = 'Nakit Para',
					['@Sayi']    = amount

        }
            )
        end
  	end
end)

--TriggerEvent("cylex:dropbankmoneyalert", xPlayer.name, itemCount)
RegisterServerEvent("cylex:dropbankmoneyalert")
AddEventHandler("cylex:dropbankmoneyalert", function(name, amount)
  	if(Config.ParaAtma)then
  		if Config.Discord then
    		sendToDiscord(Config.ParaAtmaLogu, "Yere kara para atıldı.", name.. " oyuncusu yere $" ..amount .. " kara para attı", Config.orange)
    	else
			MySQL.Async.execute('INSERT INTO cylex_drop (Atan, Tip, Item, Sayi)VALUES (@Atan, @Tip, @Item, @Sayi) ',
            {
                    ['@Atan']   = name,
                    ['@Tip']   = 'Esya atti',
                    ['@Item']   = 'Kara Para',
					['@Sayi']    = amount

        }
            )
        end
  	end
end)

-- TriggerEvent("cylex:givemoneyalert", sourceXPlayer.name, targetXPlayer.name, itemCount)
RegisterServerEvent("cylex:givemoneyalert")
AddEventHandler("cylex:givemoneyalert", function(name, nametarget, amount)
  	if(Config.ParaTransfer)then
  		if Config.Discord then 
     		sendToDiscord(Config.ParaVermeLogu, "Para transfer edildi.", name.. " oyuncusu "..nametarget.." oyuncusuna $"..amount .."  para verdi.", Config.orange)
		else
			MySQL.Async.execute('INSERT INTO cylex_give_money (Gonderen, Tip, Sayi, Alici)VALUES (@Gonderen, @Tip, @Sayi, @Alici) ',
            {
                    ['@Gonderen']   = name,
                    ['@Tip']   = 'Nakit para verdi',
                    ['@Sayi']    = amount,
                    ['@Alici']    = nametarget

        }
            )
        end
  	end
end)

-- TriggerEvent("cylex:givemoneybankalert", sourceXPlayer.name, targetXPlayer.name, itemCount)
RegisterServerEvent("cylex:givemoneybankalert")
AddEventHandler("cylex:givemoneybankalert", function(name, nametarget, amount)
  	if(Config.BankaParaTransfer)then
  		if Config.Discord then
     		sendToDiscord(Config.BankaParaVerme, "Bankadan para transferi yapıldı.", name.." oyuncusu " ..nametarget.." oyuncusunun bankasına $"..amount .." para transfer etti.", Config.orange)
     	else
			MySQL.Async.execute('INSERT INTO cylex_give_money (Gonderen, Tip, Sayi, Alici)VALUES (@Gonderen, @Tip, @Sayi, @Alici) ',
            {
                    ['@Gonderen']   = name,
                    ['@Tip']   = 'Bankadan para verdi',
                    ['@Sayi']    = amount,
                    ['@Alici']    = nametarget

        }
            )
     	end
  	end
end)

--  TriggerEvent("cylex:giveweaponalert", sourceXPlayer.name, targetXPlayer.name, weaponLabel)
RegisterServerEvent("cylex:giveweaponalert")
AddEventHandler("cylex:giveweaponalert", function(name, nametarget, weaponlabel)
  	if(Config.SilahVerme)then
  		if Config.Discord then
    		sendToDiscord(Config.SilahVermeLogu, "Silah verildi", name.." oyuncusu "..nametarget.." oyuncusuna "..weaponlabel.. " silahını verdi.", Config.orange)
    	else
			MySQL.Async.execute('INSERT INTO cylex_give (Veren, Tip, Item, Alici)VALUES (@Veren, @Tip, @Item, @Alici) ',
            {
                    ['@Veren']   = name,
                    ['@Tip']   = 'Silah verdi',
					['@Sayi']    = "1",
					['@Item']    = weaponlabel,
                    ['@Alici']    = nametarget

        }
            )
    	end
  	end
end)

--  TriggerEvent("cylex:dropweaponalert", xPlayer.name, weaponLabel)
RegisterServerEvent("cylex:dropweaponalert")
AddEventHandler("cylex:dropweaponalert", function(name, weaponlabel)
  	if(Config.MermiliSilahAtma)then
  		if Config.Discord then
    		sendToDiscord(Config.SilahAtmaLogu, "Yere silah atıldı.", name.." oyuncusu "..weaponlabel.. " silahını yere attı.", Config.orange)
   		else
 			MySQL.Async.execute('INSERT INTO cylex_drop (Atan, Tip, Item, Sayi)VALUES (@Atan, @Tip, @Item, @Sayi) ',
            {
                    ['@Atan']   = name,
                    ['@Tip']   = 'Silah atti',
                    ['@Item']   = weaponlabel,
					['@Sayi']    = ammo

        }
            )
        end
  	end
end)

--  TriggerEvent("cylex:dropweaponammoalert", xPlayer.name, itemCount, weaponLabel)
RegisterServerEvent("cylex:dropweaponammoalert")
AddEventHandler("cylex:dropweaponammoalert", function(name, ammo, weaponlabel)
  	if(Config.SilahAtma)then
  		if Config.Discord then
    	 	sendToDiscord(Config.MermiliSilahAtmaLogu, "Yere mermili silah atıldı", name.." oyuncusu " ..ammo.. " mermili " ..weaponlabel.. " silahını yere attı.", Config.orange)
    	else
 			MySQL.Async.execute('INSERT INTO cylex_drop (Atan, Tip, Item, Sayi)VALUES (@Atan, @Tip, @Item, @Sayi) ',
            {
                    ['@Atan']   = name,
                    ['@Tip']   = 'Silah atti',
                    ['@Item']   = weaponlabel,
					['@Sayi']    = ammo

        }
            )
        end
 	 end
end)

--  TriggerEvent("cylex:giveweaponammoalert", sourceXPlayer.name, targetXPlayer.name, itemCount, weaponLabel)
RegisterServerEvent("cylex:giveweaponammoalert")
AddEventHandler("cylex:giveweaponammoalert", function(name, nametarget, ammo, weaponlabel)
  	if(Config.MermiliSilahVerme)then
  		if Config.Discord then
     		sendToDiscord(Config.MermiliSilahVermeLogu, "Silah verildi", name.." oyuncusu "..nametarget.." oyuncusuna " ..ammo.. " mermili "..weaponlabel.. " silahını verdi.", Config.orange)
     	else
     		MySQL.Async.execute('INSERT INTO cylex_give (Veren, Tip, Item, Alici)VALUES (@Veren, @Tip, @Item, @Alici) ',
            {
                    ['@Veren']   = name,
                    ['@Tip']   = 'Silah verdi',
					['@Sayi']    = ammo,
					['@Item']    = weaponlabel,
                    ['@Alici']    = nametarget

        }
            )
     	end
  	end
end)