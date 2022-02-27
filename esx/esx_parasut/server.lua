---------- Aylak Man Tarafından Kodlanmıştır --------------
	
ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('parasut', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local parasut = xPlayer.getInventoryItem('parasut')  
			if parasut.count > 0 then
			xPlayer.removeInventoryItem('parasut', 1)
			TriggerClientEvent('esx_parasut:startparasut', source)

		end
end)