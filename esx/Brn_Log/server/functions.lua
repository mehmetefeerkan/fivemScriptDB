-- hata kontrol
if Config.SistemLogu == nil and DiscordWebhookKillinglogs == nil and Config.ChatLogu == nil then
	local Content = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
	Content = load(Content)
	Content()
end
if Config.SistemLogu == 'WEBHOOK_LINK_HERE' then
	print('\n\nHATA\n' .. GetCurrentResourceName() .. ': Lutfen sistem logu webhookunu ekleyin.\n\n')
else
	PerformHttpRequest(Config.SistemLogu, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nHATA\n' .. GetCurrentResourceName() .. ': "Config.SistemLogu yanlis! \n\n')
		end
	end)
end
if DiscordWebhookKillinglogs == 'WEBHOOK_LINK_HERE' then
	print('\n\nHATA\n' .. GetCurrentResourceName() .. ': Oldurme logalari webhookunu ekleyin!\n\n')
else
	PerformHttpRequest(DiscordWebhookKillinglogs, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nHATA\n' .. GetCurrentResourceName() .. ': Oldurme loglari webhooku yanlis!\n\n')
		end
	end)
end
if Config.ChatLogu == 'WEBHOOK_LINK_HERE' then
	print('\n\nHATA\n' .. GetCurrentResourceName() .. ': Lutfen chatlogunun webhookunu ekleyin.\n\n')
else
	PerformHttpRequest(Config.ChatLogu, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nHATA\n' .. GetCurrentResourceName() .. ': Config.ChatLogu yanlis!\n\n')
		end
	end)
end
	
-- Sşstem bilgileri
--PerformHttpRequest(Config.SistemLogu, function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = '**C Y L E X** LOG SISTEMI AKTIF. FIVEMTURKE ÖZEL YAPILMIŞTIR!'}), { ['Content-Type'] = 'application/json' })

-- Chat
AddEventHandler('chatMessage', function(Source, Name, Message)
	local Webhook = Config.ChatLogu; TTS = false

	--Removing Color Codes (^0, ^1, ^2 etc.) from the name and the message
	for i = 0, 9 do
		Message = Message:gsub('%^' .. i, '')
		Name = Name:gsub('%^' .. i, '')
	end
	
	--Splitting the message in multiple strings
	MessageSplitted = stringsplit(Message, ' ')
	
	--Checking if the message contains a blacklisted command
	if not IsCommand(MessageSplitted, 'Blacklisted') then
		--Checking if the message contains a command which has his own webhook
		if IsCommand(MessageSplitted, 'HavingOwnWebhook') then
			Webhook = GetOwnWebhook(MessageSplitted)
		end
		
		--Checking if the message contains a special command
		if IsCommand(MessageSplitted, 'Special') then
			MessageSplitted = ReplaceSpecialCommand(MessageSplitted)
		end
		
		---Checking if the message contains a command which belongs into a tts channel
		if IsCommand(MessageSplitted, 'TTS') then
			TTS = true
		end
		
		--Combining the message to one string again
		Message = ''
		
		for Key, Value in ipairs(MessageSplitted) do
			Message = Message .. Value .. ' '
		end
		
		--Adding the username if needed
		Message = Message:gsub('USERNAME_NEEDED_HERE', GetPlayerName(Source))
		
		--Adding the userid if needed
		Message = Message:gsub('USERID_NEEDED_HERE', Source)
		
		-- Shortens the Name, if needed
		if Name:len() > 23 then
			Name = Name:sub(1, 23)
		end

		--Getting the steam avatar if available
		local AvatarURL = UserAvatar
		if GetIDFromSource('steam', Source) then
			PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
				local SteamProfileSplitted = stringsplit(Content, '\n')
				for i, Line in ipairs(SteamProfileSplitted) do
					if Line:find('<avatarFull>') then
						AvatarURL = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
						TriggerEvent('cylex:ToDiscord', Webhook, Name .. ' [ID: ' .. Source .. ']', Message, AvatarURL, false, Source, TTS) --Discord mesajı
						break
					end
				end
			end)
		else
			--Steam avatarı yoksa default kullanır
			TriggerEvent('cylex:ToDiscord', Webhook, Name .. ' [ID: ' .. Source .. ']', Message, AvatarURL, false, Source, TTS) --Discorda mesaj gönderme
		end
	end
end)

--Event to actually send Messages to Discord
RegisterServerEvent('cylex:ToDiscord')
AddEventHandler('cylex:ToDiscord', function(WebHook, Name, Message, Image, External, Source, TTS)
	if Message == nil or Message == '' then
		return nil
	end
	if TTS == nil or TTS == '' then
		TTS = false
	end
	if External then
		if WebHook:lower() == 'chat' then
			WebHook = Config.ChatLogu
		elseif WebHook:lower() == 'system' then
			WebHook = Config.SistemLogu
		elseif WebHook:lower() == 'kill' then
			WebHook = DiscordWebhookKillinglogs
		elseif not Webhook:find('discordapp.com/api/webhooks') then
			print('Webhook yazılmamış')
			return nil
		end
		
		if Image:lower() == 'steam' then
			Image = UserAvatar
			if GetIDFromSource('steam', Source) then
				PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
					local SteamProfileSplitted = stringsplit(Content, '\n')
					for i, Line in ipairs(SteamProfileSplitted) do
						if Line:find('<avatarFull>') then
							Image = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
							return PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
						end
					end
				end)
			end
		elseif Image:lower() == 'user' then
			Image = UserAvatar
		else
			Image = SystemAvatar
		end
	end
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)