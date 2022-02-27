--{ Türkçeleştirme ve düzenleme yapılmıştır --www.fivemturk.com }--
ESX = nil
local RegisteredSocieties = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()
end

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getBlackMoneyFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('black_money')
	return account.money

end

local function getBankFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('bank')
	return account.money

end
	
RegisterCommand("meslek", function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.getJob()
    xPlayer.showNotification("Mesleğin: "..job.name.." Meslekteki rütben: "..job.grade_label)
end)

RegisterCommand("parabak", function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local wallet = xPlayer.getQuantity('cash', count)
	xPlayer.showNotification("Üzerinde "..wallet.." dolar var")
end)

RegisterCommand("bankapara", function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local wallet = getBankFromUser(src)
	xPlayer.showNotification("Bankanda "..wallet.." dolar var")
end)

RegisterCommand("karapara", function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local wallet = getBlackMoneyFromUser(src)
	xPlayer.showNotification("Üzerinde "..wallet.." dolar karapara var")
end)



RegisterCommand("depoparasi", function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.job.grade_name == 'boss' then
		local society = GetSociety(xPlayer.job.name)

		if society ~= nil then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
		end
		
                --TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. money .. ' ~s~in the society account~g~ ')
	        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Sirketteki depo Paran: $' .. money })
																	
	else

	        --TriggerClientEvent('esx:showNotification', _source, '~r~Access not granted!')
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Erisim yok!', length = 5000})
																			
	end
end)

TriggerEvent('esx_society:getSocieties', function(societies) 
	RegisteredSocieties = societies
end)

function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end
