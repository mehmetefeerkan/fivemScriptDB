--====================================================================================
-- #XenKnighT
--====================================================================================

RegisterNetEvent("xentablet:news_getPapers")
AddEventHandler("xentablet:news_getPapers", function(newsp)
  SendNUIMessage({event = 'news_paperr', newsp = newsp})
end)

RegisterNetEvent("xentablet:news_newPapers")
AddEventHandler("xentablet:news_newPapers", function(news)
  SendNUIMessage({event = 'news_newPaperr', news = news})
end)

RegisterNetEvent("xentablet:news_setAccount")
AddEventHandler("xentablet:news_setAccount", function(username, password, avatarUrl)
  SendNUIMessage({event = 'news_setAccount', username = username, password = password, avatarUrl = avatarUrl})
end)

RegisterNetEvent("xentablet:news_createAccount")
AddEventHandler("xentablet:news_createAccount", function(account)
  SendNUIMessage({event = 'news_createAccount', account = account})
end)

RegisterNetEvent("xentablet:news_showError")
AddEventHandler("xentablet:news_showError", function(title, message)
  SendNUIMessage({event = 'news_showError', message = message, title = title})
end)

RegisterNetEvent("xentablet:news_showSuccess")
AddEventHandler("xentablet:news_showSuccess", function(title, message)
  SendNUIMessage({event = 'news_showSuccess', message = message, title = title})
end)




RegisterNUICallback('news_login', function(data, cb)
  TriggerServerEvent('xentablet:news_login', data.username, data.password)
end)


RegisterNUICallback('news_createAccount', function(data, cb)
  TriggerServerEvent('xentablet:news_createAccount', data.username, data.password, data.avatarUrl)
end)

RegisterNUICallback('news_getPapers', function(data, cb)
  TriggerServerEvent('xentablet:news_getPapers', data.username, data.password)
end)

RegisterNUICallback('news_postPaper', function(data, cb)
  TriggerServerEvent('xentablet:news_postPapers', data.username or '', data.password or '', data.htitle or '', data.message or '', data.kmessage or '', data.umessage)
end)

RegisterNUICallback('news_setAvatarUrl', function(data, cb)
  TriggerServerEvent('xentablet:news_setAvatarUrl', data.username or '', data.password or '', data.avatarUrl)
end)
