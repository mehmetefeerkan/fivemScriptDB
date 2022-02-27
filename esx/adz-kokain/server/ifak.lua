ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--nice song if you want to listen //https://www.youtube.com/watch?v=1KEx9h2hdz8//




ESX.RegisterUsableItem('pantolon', function(source)
  local pl = ESX.GetPlayerFromId(source)
  pl.removeInventoryItem("pantolon",1)
  TriggerClientEvent('hasan:useitemifak', source)
end)

ESX.RegisterUsableItem('gomlek', function(source)
  local pl = ESX.GetPlayerFromId(source)
  pl.removeInventoryItem("gomlek",1)
  TriggerClientEvent('esx_status:remove', source, 'stress', 25000)
  TriggerClientEvent('hasan:useitemmarul', source)
end)

ESX.RegisterUsableItem('tshirt', function(source)
	local player = ESX.GetPlayerFromId(source)
	player.removeInventoryItem('tshirt', 1)
	TriggerClientEvent('hasan:useitemkan', source)
end)

