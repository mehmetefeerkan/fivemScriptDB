ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('dlrms_hud:getAccounts', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local job = xPlayer.getJob()
  local mySociety = nil
  local society = 0

  TriggerEvent('esx_society:getSociety', xPlayer.job.name, function(_society)
      mySociety = _society
  end)

  if mySociety ~= nil then
      TriggerEvent('esx_addonaccount:getSharedAccount', mySociety.account, function(account)
            society = account.money
      end)
  end


  cb(job.label, job.grade_label, xPlayer.getMoney(), xPlayer.getAccount("bank").money, xPlayer.getAccount("black_money").money, society)
end)
