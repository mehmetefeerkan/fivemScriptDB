--====================================================================================
-- #XenKnighT
--====================================================================================

function NewsGetPapers (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT tab_newpaper.*,
        tab_newsaccounts.username as author,
        tab_newsaccounts.avatar_url as authorIcon
      FROM tab_newpaper
        LEFT JOIN tab_newsaccounts
        ON tab_newpaper.authorId = tab_newsaccounts.id
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  end
end

function getWriter(username, password, cb)
  MySQL.Async.fetchAll("SELECT id, username as author, avatar_url as authorIcon FROM tab_newsaccounts WHERE tab_newsaccounts.username = @username AND tab_newsaccounts.password = @password", {
    ['@username'] = username,
    ['@password'] = password
  }, function (data)
    cb(data[1])
  end)
end

function NewsPostPapers (username, password, htitle, message, kmessage, umessage, sourcePlayer, realUser, cb)
  getWriter(username, password, function (user)
    if user == nil then
      if sourcePlayer ~= nil then
        NewsShowError(sourcePlayer, 'News Info', 'APP_NEWS_NOTIF_LOGIN_ERROR')
      end
      return
    end
    MySQL.Async.insert("INSERT INTO tab_newpaper (`authorId`, `htitle`, `message`, `kmessage`, `umessage`, `realUser`) VALUES(@authorId, @htitle, @message, @kmessage, @umessage, @realUser);", {
      ['@authorId'] = user.id,
	  ['@htitle'] = htitle,
      ['@message'] = message,
	  ['@kmessage'] = kmessage,
	  ['@umessage'] = umessage,
      ['@realUser'] = realUser
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from tab_newpaper WHERE id = @id', {
        ['@id'] = id
      }, function (newsp)
        news = newsp[1]
        news['author'] = user.author
        news['authorIcon'] = user.authorIcon
        TriggerClientEvent('xentablet:news_newPapers', -1, news)
        TriggerEvent('xentablet:news_newPapers', news)
      end)
    end)
  end)
end

function NewsCreateAccount(username, password, avatarUrl, cb)
  MySQL.Async.insert('INSERT IGNORE INTO tab_newsaccounts (`username`, `password`, `avatar_url`) VALUES(@username, @password, @avatarUrl)', {
    ['username'] = username,
    ['password'] = password,
    ['avatarUrl'] = avatarUrl
  }, cb)
end
-- ALTER TABLE `tab_newsaccounts`	CHANGE COLUMN `username` `username` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_general_ci';

function NewsShowError (sourcePlayer, title, message)
  TriggerClientEvent('xentablet:news_showError', sourcePlayer, message)
end
function NewsShowSuccess (sourcePlayer, title, message)
  TriggerClientEvent('xentablet:news_showSuccess', sourcePlayer, title, message)
end

RegisterServerEvent('xentablet:news_login')
AddEventHandler('xentablet:news_login', function(username, password)
  local sourcePlayer = tonumber(source)
  getWriter(username, password, function (user)
    if user == nil then
      NewsShowError(sourcePlayer, 'News Info', 'APP_NEWS_NOTIF_LOGIN_ERROR')
    else
      NewsShowSuccess(sourcePlayer, 'News Info', 'APP_NEWS_NOTIF_LOGIN_SUCCESS')
      TriggerClientEvent('xentablet:news_setAccount', sourcePlayer, username, password, user.authorIcon)
    end
  end)
end)


RegisterServerEvent('xentablet:news_createAccount')
AddEventHandler('xentablet:news_createAccount', function(username, password, avatarUrl)
  local sourcePlayer = tonumber(source)
  NewsCreateAccount(username, password, avatarUrl, function (id)
    if (id ~= 0) then
      TriggerClientEvent('xentablet:news_setAccount', sourcePlayer, username, password, avatarUrl)
      NewsShowSuccess(sourcePlayer, 'News Info', 'APP_NEWS_NOTIF_ACCOUNT_CREATE_SUCCESS')
    else
      NewsShowError(sourcePlayer, 'News Info', 'APP_NEWS_NOTIF_ACCOUNT_CREATE_ERROR')
    end
  end)
end)

RegisterServerEvent('xentablet:news_getPapers')
AddEventHandler('xentablet:news_getPapers', function(username, password)
  local sourcePlayer = tonumber(source)
  if username ~= nil and username ~= "" and password ~= nil and password ~= "" then
    getWriter(username, password, function (user)
      local accountId = user and user.id
      NewsGetPapers(accountId, function (newsp)
        TriggerClientEvent('xentablet:news_getPapers', sourcePlayer, newsp)
      end)
    end)
  else
    NewsGetPapers(nil, function (newsp)
      TriggerClientEvent('xentablet:news_getPapers', sourcePlayer, newsp)
    end)
  end
end)

RegisterServerEvent('xentablet:news_postPapers')
AddEventHandler('xentablet:news_postPapers', function(username, password, htitle, message, kmessage, umessage)
  local sourcePlayer = tonumber(source)
  local srcIdentifier = getPlayerID(source)
  NewsPostPapers(username, password, htitle, message, kmessage, umessage, sourcePlayer, srcIdentifier)
end)


RegisterServerEvent('xentablet:news_setAvatarUrl')
AddEventHandler('xentablet:news_setAvatarUrl', function(username, password, avatarUrl)
  local sourcePlayer = tonumber(source)
  MySQL.Async.execute("UPDATE `tab_newsaccounts` SET `avatar_url`= @avatarUrl WHERE tab_newsaccounts.username = @username AND tab_newsaccounts.password = @password", {
    ['@username'] = username,
    ['@password'] = password,
    ['@avatarUrl'] = avatarUrl
  }, function (result)
    if (result == 1) then
      TriggerClientEvent('xentablet:news_setAccount', sourcePlayer, username, password, avatarUrl)
      NewsShowSuccess(sourcePlayer, 'News Info', 'APP_NEWS_NOTIF_AVATAR_SUCCESS')
    else
      NewsShowError(sourcePlayer, 'News Info', 'APP_NEWS_NOTIF_LOGIN_ERROR')
    end
  end)
end)


--[[
  Discord WebHook
  set discord_webhook 'https//....' in config.cfg
--]]
AddEventHandler('xentablet:news_newPapers', function (news)
  -- print(json.encode(news))
  local discord_webhook = GetConvar('discord_webhook', '')
  if discord_webhook == '' then
    return
  end
  local headers = {
    ['Content-Type'] = 'application/json'
  }
  local data = {
    ["username"] = news.author,
    ["embeds"] = {{
      ["thumbnail"] = {
        ["url"] = news.authorIcon
      },
      ["color"] = 1942002,
      ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ", news.time / 1000 )
    }}
  }
  local isHttp = string.sub(news.message, 0, 7) == 'http://' or string.sub(news.message, 0, 8) == 'https://'
  local ext = string.sub(news.message, -4)
  local isImg = ext == '.png' or ext == '.pjg' or ext == '.gif' or string.sub(news.message, -5) == '.jpeg'
  if (isHttp and isImg) and true then
    data['embeds'][1]['image'] = { ['url'] = news.message }
  else
    data['embeds'][1]['description'] = news.message
  end
  PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end)