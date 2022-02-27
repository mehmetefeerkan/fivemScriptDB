ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('wallet', function(source) -- Super
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_wallet:ToggleMenu', source);
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Cüzdanı kullandın', length = 2500 })
end)