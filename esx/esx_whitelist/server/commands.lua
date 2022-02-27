function displayPermissionIssue ()
  TriggerClientEvent('chatMessage', source, 'SYSTEM', { 255, 0, 0 }, 'Insufficienct permissions!')
end

TriggerEvent('es:addGroupCommand', 'wlyenile', 'admin', function (source, args, user)
  loadWhiteList()
end, function (source, args, user)
  displayPermissionIssue(source)
end, { help = _U('help_whitelist_load') })

TriggerEvent('es:addGroupCommand', 'wlekle', 'admin', function (source, args, user)
  local steamID = 'steam:' .. args[2]

  MySQL.Async.execute(
    'INSERT INTO whitelist (identifier) VALUES (@identifier)',
    { ['@identifier'] = tostring(steamID) },
    function ()
      loadWhiteList()
    end
  )
end, function (source, args, user)
  displayPermissionIssue(source)
end, { help = _U('help_whitelist_add'), params = { steam = 'SteamID', help = 'SteamID formated to hex' }})
