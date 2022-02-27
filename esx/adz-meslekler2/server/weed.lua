ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drc_weed:Pickup")
AddEventHandler("drc_weed:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
         	if xPlayer.getQuantity('file_patates') >= Config.maxpickableweed then
				TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
			else
				xPlayer.addInventoryItem('file_patates', math.random(Config.MinweedPickUP,Config.MaxweedPickUP)) 
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupweed'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.weedPickup, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - weed", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
            end			
end)


