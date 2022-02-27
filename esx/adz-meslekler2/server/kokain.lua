ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drc_coke:Pickup")
AddEventHandler("drc_coke:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
         	if xPlayer.getQuantity('mercan') >= Config.maxpickablecoke then
				TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
			else
				xPlayer.addInventoryItem('mercan', math.random(Config.MinCokePickUP,Config.MaxCokePickUP)) 
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupcoke'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.CokePickup, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - COKE", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
            end			
end)


RegisterServerEvent('drc_coke:ProcessItems')
AddEventHandler('drc_coke:ProcessItems', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getQuantity('mercan') >= 3 then
		xPlayer.removeInventoryItem('mercan', 3)
		xPlayer.addInventoryItem('coke_pooch', 1) 	
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocesscoke'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
			PerformHttpRequest(Config.CokeProcess, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - COKE", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, _U('nomorecoke'))	
		end
	end)
