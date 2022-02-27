local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)
RegisterServerEvent("utku_realdopes:üretim")
AddEventHandler("utku_realdopes:üretim", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local currentOpium = xPlayer.getInventoryItem("opium")["count"]
    local currentAcetone = xPlayer.getInventoryItem("acetone")["count"]
    local currentLithium = xPlayer.getInventoryItem("lithium")["count"]

    if currentOpium >= 40 then
         if currentAcetone >= 5 then
            if currentLithium >= 5 then
                xPlayer.removeInventoryItem("opium", 40)
                xPlayer.removeInventoryItem("acetone", 5)
                xPlayer.removeInventoryItem("lithium", 5)

                TriggerClientEvent("esx:showNotification", _source, (_U("prod_start")))
                TriggerClientEvent("utku_realdopes:üretimBaşla", _source)
            else
                TriggerClientEvent("esx:showNotification", _source, _U("no_item"))
            end
        else
            TriggerClientEvent("esx:showNotification", _source, _U("no_item"))
        end
    else
        TriggerClientEvent("esx:showNotification", _source, _U("no_item"))
    end
end)
RegisterServerEvent('utku_realdopes:finish')
AddEventHandler('utku_realdopes:finish', function(qualtiy)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local rnd = math.random(-5, 2)
	xPlayer.addInventoryItem('epinephrine', math.floor(qualtiy * 3 / 2) + rnd)
end)
RegisterServerEvent('utku_realdopes:patla')
AddEventHandler('utku_realdopes:patla', function(posx, posy, posz)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('utku_realdopes:patlamaBaşla', xPlayers[i],posx, posy, posz)
	end
end)
RegisterServerEvent("utku_realdopes:itemSil")
AddEventHandler("utku_realdopes:itemSil", function(itemismi, miktar)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem(itemismi, miktar)
end)

RegisterServerEvent('utku_realdopes:itemKontrol')
AddEventHandler('utku_realdopes:itemKontrol', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local currentItem = xPlayer.getInventoryItem(item)["count"]
    if item == "gas_mask" then
        if currentItem >= 1 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "fluor_stick" then
        if currentItem >= 1 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "phone" then
        if currentItem >= 1 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "spare_parts" then
        if currentItem >= 1 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "gas_pump" then
        if currentItem >= 1 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "syringe" then
        if currentItem >= 1 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "lithium" then
        if currentItem >= 5 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "water" then
        if currentItem >= 5 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
    if item == "acetone" then
        if currentItem >= 5 then
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, true, item)
        else
            TriggerClientEvent("utku_realdopes:itemKontrolSonuç",_source, false, item)
        end
    end
end)