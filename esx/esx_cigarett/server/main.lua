ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarett', 1)
			TriggerClientEvent('esx_cigarett:startSmoke', source)
			TriggerClientEvent('esx_status:remove', source, 'stress', 350000)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Stresin bir miktar azaldı.', length = 4000, style = { ['background-color'] = '#2f5c73', ['color'] = '#ffffff' } })
		else
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Çakmaksız sigaranı yakamazsın.' } )
		end
end)
