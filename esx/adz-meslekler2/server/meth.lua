ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drc_meth:Pickup")
AddEventHandler("drc_meth:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
         	if xPlayer.getQuantity('domates') >= Config.maxpickablemeth then
				TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
			else
				xPlayer.addInventoryItem('domates', math.random(Config.MinmethPickUP,Config.MaxmethPickUP)) 
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupmeth'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.methPickup, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - meth", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
            end			
end)


RegisterServerEvent('drc_meth:ProcessItems')
AddEventHandler('drc_meth:ProcessItems', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getQuantity('domates') >= 3 then
		xPlayer.removeInventoryItem('domates', 3)
		xPlayer.addInventoryItem('meth_pooch', 1) 	
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocessmeth'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
			PerformHttpRequest(Config.methProcess, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - meth", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, _U('nomoremeth'))	
		end
	end)
