ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drc_opium:Pickup")
AddEventHandler("drc_opium:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
         	if xPlayer.getQuantity('marul') >= Config.maxpickableopium then
				TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
			else
				xPlayer.addInventoryItem('marul', math.random(Config.MinopiumPickUP,Config.MaxopiumPickUP)) 
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupopium'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.opiumPickup, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - opium", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
            end			
end)


RegisterServerEvent('drc_opium:ProcessItems')
AddEventHandler('drc_opium:ProcessItems', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getQuantity('marul') >= 3 then
		xPlayer.removeInventoryItem('marul', 3)
		xPlayer.addInventoryItem('opium_pooch', 1) 	
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocessopium'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
			PerformHttpRequest(Config.opiumProcess, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - opium", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, _U('nomoreopium'))	
		end
	end)
