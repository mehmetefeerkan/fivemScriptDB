CFG = { 
  CitizenTax = {1500, 7500}, --Tax amount
  JobDiff = true, --Taxes on individual jobs
  jobTax = {
    [1] = {
      job = "police",
      tax = math.random(1500, 5000)
    },
    [2] = {
      job = "unemployed",
      tax = math.random(1000, 7000)
    }
  }
}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Vehicles = {}

MySQL.ready(function ()
  local result = MySQL.Sync.fetchAll('SELECT model, price FROM vehicles')
  Vehicles = result
  for k,v in ipairs(result) do
    Vehicles[k].model = v.model
    Vehicles[k].price = v.price
  end
end)

function Tax()
  local result = MySQL.Sync.fetchAll('SELECT vehicle, plate, tax FROM owned_vehicles')
  if result[1] ~= nil then
    for k,v in pairs(Vehicles) do
      for i = 1, #result do
        local vh = json.decode(result[i].vehicle)
        if GetHashKey(v.model) == vh.model then
            MySQL.Async.execute('UPDATE owned_vehicles SET `tax` = @tax WHERE plate = @plate',{['@tax']=result[i].tax+math.floor(v.price/2),['@plate']=result[i].plate
            })
        end
      end
    end
  end
  local res = MySQL.Sync.fetchAll('SELECT tax, identifier FROM users')
    for k,v in pairs(res) do
        if CFG.JobDiff == true then
          for d,x in pairs(CFG.jobTax) do
            MySQL.Async.execute('UPDATE users SET `tax` = @tax WHERE identifier = @identifier', {
              ['@identifier'] = v.identifier,
              ['@tax'] = v.job == x.job and x.tax + v.tax or v.tax + math.random(CFG.CitizenTax[1], CFG.CitizenTax[2])
            })
          end
        else
          MySQL.Async.execute('UPDATE users SET `tax` = @tax WHERE identifier = @identifier', {
            ['@identifier'] = v.identifier,
            ['@tax'] = v.tax + math.random(CFG.CitizenTax[1], CFG.CitizenTax[2])
          })
        end
    end
end

RegisterCommand("test", function()
    Tax()
end)

ESX.RegisterServerCallback('mx-tax:GetVehicleTax', function(source, cb)
  local garbage = {}
  local xPlayer = ESX.GetPlayerFromId(source)
    local rr = MySQL.Sync.fetchAll('SELECT vehicle, tax FROM owned_vehicles WHERE owner = @owner', {['@owner'] = xPlayer.identifier})
        for k,v in pairs(rr) do
            if v.tax ~= 0 and v.tax ~= nil then
                garbage[k] = v
            end
        end
    cb(garbage)
end)

ESX.RegisterServerCallback('mx-tax:GetCitizenTax', function(source, cb)
    local garbage = {}
    local xPlayer = ESX.GetPlayerFromId(source)
    --local rr = MySQL.Sync.fetchAll('SELECT tax FROM users WHERE citizenid = @citizenid', {['@citizenid'] = xPlayer.citizenid}) -- FOR ME...
    local rr = MySQL.Sync.fetchAll('SELECT tax FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
    for k,v in pairs(rr) do
        if v.tax ~= 0 and v.tax ~= nil then
            garbage[k] = v
        end
    end
    cb(garbage)
end)

ESX.RegisterServerCallback('mx-tax:PayCitizenTax', function(source, cb, tax)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('bank').money >= tonumber(tax) then
      xPlayer.removeAccountMoney('bank', tonumber(tax))
        MySQL.Async.execute('UPDATE users SET `tax` = @tax WHERE identifier = @identifier', {['@tax'] = 0, ['@identifier'] = xPlayer.identifier})
        -- MySQL.Async.execute('UPDATE owned_vehicles SET `tax` = @tax WHERE identifier = @identifier', {['@tax'] = 0, ['@identifier'] = xPlayer.identifier})
        cb(true)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Kişisel vergini ödedin teşekkür ederiz!'})
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Yeterli paran yok!'})
        cb(false)
    end
end)

ESX.RegisterServerCallback('mx-tax:PayVehicleTax', function(source, cb, plate, tax)
     local xPlayer = ESX.GetPlayerFromId(source)
     if xPlayer.getAccount('bank').money >= tonumber(tax) then
       xPlayer.removeAccountMoney('bank', tonumber(tax)) 
         MySQL.Async.execute('UPDATE owned_vehicles SET `tax` = @tax WHERE plate = @plate', {['@tax'] = 0, ['@plate'] = plate})
         cb(true)
         TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Araç vergini ödedin teşekkür ederiz!'})
       else
         TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Yeterli paran yok!'})
         cb(false)
     end
end)

TriggerEvent('cron:runAt', 13, 00, Tax)
TriggerEvent('cron:runAt', 15, 10, Tax)
TriggerEvent('cron:runAt', 15, 00, Tax)
TriggerEvent('cron:runAt', 18, 00, Tax)
TriggerEvent('cron:runAt', 23, 00, Tax)
