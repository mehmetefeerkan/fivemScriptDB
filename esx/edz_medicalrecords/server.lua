ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('emstablet', function(source)

	local _source = source
  TriggerClientEvent("edz:medicalrecords:client", _source)

end)

ESX.RegisterServerCallback('edz:checkrecords', function(source, cb)

  MySQL.Async.fetchAll("SELECT identity, records, reg_date FROM `edz_medrecords`", {} , function(result)

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

RegisterServerEvent('edz:addrecord')
AddEventHandler('edz:addrecord', function(identity, records)

      local date = os.date("%Y-%m-%d %H:%M:%S")

      MySQL.Async.execute('INSERT INTO edz_medrecords (identity, records, reg_date) VALUES (@identity, @records, @reg_date)',
        {
          ['@identity']   = identity,
          ['@records']    = records,
          ['@reg_date']   = date,
        }
      )

end)
