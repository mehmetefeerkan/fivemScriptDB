ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('ptab', function(source)

	local _source = source
  TriggerClientEvent("mxs:pd:client", _source)

end)

ESX.RegisterServerCallback('mxs:checkrecords2', function(source, cb)

  MySQL.Async.fetchAll("SELECT identity, records, reg_date FROM `mxs_pd2`", {} , function(result)

      local crime = {}
      for i=1, #result, 1 do
        table.insert(crime, {
          identity = result[i].identity,
          records = result[i].records,
          date = result[i].reg_date,
        })
      end

      cb(crime)

  end)
end)
ESX.RegisterServerCallback('mxs:checkrecords3', function(source, cb)

  MySQL.Async.fetchAll("SELECT identity, records, reg_date FROM `mxs_pd3`", {} , function(result)

      local crime = {}
      for i=1, #result, 1 do
        table.insert(crime, {
          identity = result[i].identity,
          records = result[i].records,
          date = result[i].reg_date,
        })
      end

      cb(crime)

  end)
end)
ESX.RegisterServerCallback('mxs:checkrecords4', function(source, cb)

  MySQL.Async.fetchAll("SELECT identity, records, reg_date FROM `mxs_pd4`", {} , function(result)

      local crime = {}
      for i=1, #result, 1 do
        table.insert(crime, {
          identity = result[i].identity,
          records = result[i].records,
          date = result[i].reg_date,
        })
      end

      cb(crime)

  end)
end)
ESX.RegisterServerCallback('mxs:checkrecords5', function(source, cb)

  MySQL.Async.fetchAll("SELECT identity, records, reg_date FROM `mxs_pd5`", {} , function(result)

      local crime = {}
      for i=1, #result, 1 do
        table.insert(crime, {
          identity = result[i].identity,
          records = result[i].records,
          date = result[i].reg_date,
        })
      end

      cb(crime)

  end)
end)

ESX.RegisterServerCallback('mxs:checkrecords', function(source, cb)

  MySQL.Async.fetchAll("SELECT identity, records, reg_date FROM `mxs_pd`", {} , function(result)

      local crime = {}
      for i=1, #result, 1 do
        table.insert(crime, {
          identity = result[i].identity,
          records = result[i].records,
          date = result[i].reg_date,
        })
      end

      cb(crime)

  end)
end)

RegisterServerEvent('mxs:addrecord')
AddEventHandler('mxs:addrecord', function(identity, records)

      local date = os.date("%Y-%m-%d %H:%M:%S")

      MySQL.Async.execute('INSERT INTO mxs_pd (identity, records, reg_date) VALUES (@identity, @records, @reg_date)',
        {
          ['@identity']   = identity,
          ['@records']    = records,
          ['@reg_date']   = date,
        }
      )

end)
---
RegisterServerEvent('mxs:addrecord2')
AddEventHandler('mxs:addrecord2', function(identity, records)

      local date = os.date("%Y-%m-%d %H:%M:%S")

      MySQL.Async.execute('INSERT INTO mxs_pd2 (identity, records, reg_date) VALUES (@identity, @records, @reg_date)',
        {
          ['@identity']   = identity,
          ['@records']    = records,
          ['@reg_date']   = date,
        }
      )

end)
RegisterServerEvent('mxs:addrecord3')
AddEventHandler('mxs:addrecord3', function(identity, records)

      local date = os.date("%Y-%m-%d %H:%M:%S")

      MySQL.Async.execute('INSERT INTO mxs_pd3 (identity, records, reg_date) VALUES (@identity, @records, @reg_date)',
        {
          ['@identity']   = identity,
          ['@records']    = records,
          ['@reg_date']   = date,
        }
      )
end)
RegisterServerEvent('mxs:addrecord4')
AddEventHandler('mxs:addrecord4', function(identity, records)

      local date = os.date("%Y-%m-%d %H:%M:%S")

      MySQL.Async.execute('INSERT INTO mxs_pd4 (identity, records, reg_date) VALUES (@identity, @records, @reg_date)',
        {
          ['@identity']   = identity,
          ['@records']    = records,
          ['@reg_date']   = date,
        }
      )
end)
RegisterServerEvent('mxs:addrecord5')
AddEventHandler('mxs:addrecord5', function(identity, records)

      local date = os.date("%Y-%m-%d %H:%M:%S")

      MySQL.Async.execute('INSERT INTO mxs_pd5 (identity, records, reg_date) VALUES (@identity, @records, @reg_date)',
        {
          ['@identity']   = identity,
          ['@records']    = records,
          ['@reg_date']   = date,
        }
      )
end)
--logger
RegisterServerEvent("mxs:aramakarari")
AddEventHandler("mxs:aramakarari", function(reason)
local xPlayer = ESX.GetPlayerFromId(source)
  local connect = {
        {
            ["color"] = 1913503,
            ["title"] = "Arama kararı yayınlandı!",
            ["description"] = reason,
            ["footer"] = {
            ["text"] = "Made by MIXAS#1234",
            },
            ["author"] = {
            ["name"] = "Los Santos Police Department",
            ["icon_url"] = "https://i.imgur.com/uC0WGig.jpg",
            },
        }
    }
  PerformHttpRequest(Config.AramaWebhook, function(err, text, headers) end, 'POST', json.encode({username = "PD LOGGER", embeds = connect, avatar_url = "https://i.imgur.com/uC0WGig.jpg"}), { ['Content-Type'] = 'application/json' })
end)
---
RegisterServerEvent("mxs:sabikaekle")
AddEventHandler("mxs:sabikaekle", function(reason)
local xPlayer = ESX.GetPlayerFromId(source)
  local connect = {
        {
            ["color"] = 16203601,
            ["title"] = "Sabıka eklendi!",
            ["description"] = reason,
            ["footer"] = {
            ["text"] = "Made by MIXAS#1234",
            },
            ["author"] = {
            ["name"] = "Los Santos Police Department",
            ["icon_url"] = "https://i.imgur.com/uC0WGig.jpg",
            },
        }
    }
  PerformHttpRequest(Config.SabikaWebhook, function(err, text, headers) end, 'POST', json.encode({username = "PD LOGGER", embeds = connect, avatar_url = "https://i.imgur.com/uC0WGig.jpg"}), { ['Content-Type'] = 'application/json' })
end)
--
RegisterServerEvent("mxs:ruhsatekle")
AddEventHandler("mxs:ruhsatekle", function(reason)
local xPlayer = ESX.GetPlayerFromId(source)
  local connect = {
        {
            ["color"] = 16107977,
            ["title"] = "Ruhsat eklendi!",
            ["description"] = reason,
            ["footer"] = {
            ["text"] = "Made by MIXAS#1234",
            },
            ["author"] = {
            ["name"] = "Los Santos Police Department",
            ["icon_url"] = "https://i.imgur.com/uC0WGig.jpg",
            },
        }
    }
  PerformHttpRequest(Config.RuhsatWebhook, function(err, text, headers) end, 'POST', json.encode({username = "PD LOGGER", embeds = connect, avatar_url = "https://i.imgur.com/uC0WGig.jpg"}), { ['Content-Type'] = 'application/json' })
end)
---