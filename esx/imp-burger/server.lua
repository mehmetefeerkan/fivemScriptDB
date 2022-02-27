ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kvl-burger:Product')
AddEventHandler('kvl-burger:Product', function(item, reqItem)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)
     if type(item) == "table" then
      if reqItem ~= nil then
         for i,z in pairs(reqItem) do -- Req ıtemsdan silicek
            if xPlayer.getInventoryItem(z.name).count >= z.count then
               xPlayer.removeInventoryItem(z.name, z.count)
            else
               xPlayer.showNotification("Lan üstünde gerekli eşyalar mı var")
               return false
            end
         end
      end
      TriggerEvent('kvl-burger:additem', src, item)
    end
end) 

RegisterServerEvent('kvl-burger:additem')
AddEventHandler('kvl-burger:additem', function(source, item)
   local src = source 
   local xPlayer = ESX.GetPlayerFromId(src)
   for k,v in pairs(item) do
      xPlayer.addInventoryItem(v.name, v.count)
   end
end)


RegisterNetEvent("kvl-burger:Sell")
AddEventHandler("kvl-burger:Sell", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('khamburger').count > 0 then
                local money = Config.Price
                local count = xPlayer.getInventoryItem('khamburger').count
                xPlayer.removeInventoryItem('khamburger', count)
                xPlayer.addMoney(money*count)
            elseif xPlayer.getInventoryItem('khamburger').count < 1 then
                xPlayer.showNotification("Lan üstünde gerekli eşyalar mı var")
            end
        end
    end)


