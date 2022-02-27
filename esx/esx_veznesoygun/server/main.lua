ESX = nil
PlayerData = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('lockpick:sil')
AddEventHandler('lockpick:sil', function()
    local _source = source
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceXPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('lockpick', 1)
    sourceXPlayer.showNotification('Maymuncuk kırıldı!', _source)
end)

RegisterServerEvent('kart:sil')
AddEventHandler('kart:sil', function()
    local _source = source
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceXPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('securitycard', 1)
    sourceXPlayer.showNotification('Güvenli kartı kullanılamaz hale geldi!', _source)
end)

RegisterServerEvent('drill:sil')
AddEventHandler('drill:sil', function()
    local _source = source
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceXPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('drillbank', 1)
    sourceXPlayer.showNotification('Drill Parçalandı!', _source)
end)

RegisterServerEvent('raidervezne:parakazan')
AddEventHandler('raidervezne:parakazan', function()
    local _source = source
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceXPlayer = ESX.GetPlayerFromId(playerId)
    local random = math.random(10000,15000)
    xPlayer.addMoney(random)
    sourceXPlayer.showNotification('Kasadan ' .. random .. '$ çaldın.', _source)
end)

RegisterServerEvent('raiderkasa:parakazan')
AddEventHandler('raiderkasa:parakazan', function()
    local _source = source
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceXPlayer = ESX.GetPlayerFromId(playerId)
    local random = math.random(60000,65000)
    xPlayer.addMoney(random)
    sourceXPlayer.showNotification('Kasadan ' .. random .. '$ çaldın.', _source)
end)

RegisterServerEvent('raider:kapiyiac')
AddEventHandler('raider:kapiyiac', function(bankid)
    for _, bank in pairs(Config.Banks) do
        if bank.id == bankid then
            TriggerClientEvent('banking:CloseBank', -1, bank.id)
            bank.cdoor.open = true
            bank.cdoor.opentime = os.time(t)
            bank.cashierlr = os.time(t) + Config.CounterCooldowns.Between
            bank.cashlock = true
        end
    end
    TriggerClientEvent('lsrp-banks:sendBanking', -1, Config.Banks)
end)

RegisterServerEvent('raider:kapiac')
AddEventHandler('raider:kapiac', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
    TriggerClientEvent('raider:kapiac', -1)
end)

RegisterServerEvent('raider:kasaac')
AddEventHandler('raider:kasaac', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
    TriggerClientEvent('raider:kasakapiac', -1)
end)

RegisterServerEvent('raider:kasakapiyiac')
AddEventHandler('raider:kasakapiyiac', function(bankid)
    for y, banka in pairs(Config.Banksa) do
        if banka.id == bankid then
            TriggerClientEvent('banking:CloseBank', -1, banka.id)
            banka.cdoor.open = true
            banka.cdoor.opentime = os.time(t)
            banka.cashieralr = os.time(t) + Config.CounterCooldowns.Between
            banka.cashlock = true
        end
    end
    TriggerClientEvent('lsrp-banks:sendBanking', -1, Config.Banks)
end)



ESX.RegisterServerCallback('raider:policeCount', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			CopsConnected = CopsConnected + 1
		end
	end
  print(CopsConnected)
	cb(CopsConnected)
end)

ESX.RegisterServerCallback('raider:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
    
    cb(quantity)
end)

