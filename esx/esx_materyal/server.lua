ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('materyaluretserver')
AddEventHandler('materyaluretserver', function(id, item, count, label)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local yeterli = count * 100
  local currentAluminum = xPlayer.getInventoryItem("mt-aluminum")["count"]
  local currentChurro = xPlayer.getInventoryItem("mt-churro")["count"]
  local currentCopper = xPlayer.getInventoryItem("mt-copper")["count"]
  local currentGlass = xPlayer.getInventoryItem("mt-glass")["count"]
  local currentPlastic = xPlayer.getInventoryItem("mt-plastic")["count"]
  local currentSteel = xPlayer.getInventoryItem("mt-steel")["count"]
            if item ==  'armourhalf' then
                if (currentSteel >= yeterli) and (currentAluminum >= yeterli) then
                    TriggerClientEvent('uretimanimasyon', _source)
                    xPlayer.removeInventoryItem('mt-steel', yeterli)
                    xPlayer.removeInventoryItem('mt-aluminum', yeterli)
                    Citizen.Wait(60000)
                    xPlayer.addInventoryItem('armourhalf', count)
                else
                    TriggerClientEvent('notification', _source, 'Üzerinde yeterli materyal yok!', 2)
                end
            elseif item ==  'sarjorpistol' then
                if (currentCopper >= yeterli) and (currentAluminum >= yeterli) then
                    TriggerClientEvent('uretimanimasyon', _source)
                    xPlayer.removeInventoryItem('mt-copper', yeterli)
                    xPlayer.removeInventoryItem('mt-aluminum', yeterli)
                    Citizen.Wait(60000)
                    xPlayer.addInventoryItem('sarjorpistol', count)
                else
                    TriggerClientEvent('notification', _source, 'Üzerinde yeterli materyal yok!', 2)
                end
            elseif item ==  'sarjortaramali' then
                if (currentCopper >= yeterli) and (currentAluminum >= yeterli) and (currentSteel >= yeterli) then
                    TriggerClientEvent('uretimanimasyon', _source)
                    xPlayer.removeInventoryItem('mt-copper', yeterli)
                    xPlayer.removeInventoryItem('mt-aluminum', yeterli)
                    xPlayer.removeInventoryItem('mt-steel', yeterli)
                    Citizen.Wait(60000)
                    xPlayer.addInventoryItem('sarjortaramali', count)
                else
                    TriggerClientEvent('notification', _source, 'Üzerinde yeterli materyal yok!', 2)
                end
            elseif item ==  'WEAPON_KNUCKLE' then
                if (currentAluminum >= yeterli) and (currentSteel >= yeterli) then
                    TriggerClientEvent('uretimanimasyon', _source)
                    xPlayer.removeInventoryItem('mt-aluminum', yeterli)
                    xPlayer.removeInventoryItem('mt-steel', yeterli)
                    Citizen.Wait(60000)
                    xPlayer.addWeapon('WEAPON_KNUCKLE', 1)
                else
                    TriggerClientEvent('notification', _source, 'Üzerinde yeterli materyal yok!', 2)
                end
            elseif item ==  'WEAPON_BAT' then
                if (currentAluminum >= yeterli) and (currentSteel >= yeterli) then
                    TriggerClientEvent('uretimanimasyon', _source)
                    xPlayer.removeInventoryItem('mt-aluminum', yeterli)
                    xPlayer.removeInventoryItem('mt-steel', yeterli)
                    Citizen.Wait(60000)
                    xPlayer.addWeapon('WEAPON_BAT', 1)
                else
                    TriggerClientEvent('notification', _source, 'Üzerinde yeterli materyal yok!', 2)
                end
            elseif item ==  'WEAPON_POOLCUE' then
                if (currentChurro >= yeterli) and (currentSteel >= yeterli) then
                    TriggerClientEvent('uretimanimasyon', _source)
                    xPlayer.removeInventoryItem('mt-churro', yeterli)
                    xPlayer.removeInventoryItem('mt-steel', yeterli)
                    Citizen.Wait(60000)
                    xPlayer.addWeapon('WEAPON_POOLCUE', 1)
                else
                    TriggerClientEvent('notification', _source, 'Üzerinde yeterli materyal yok!', 2)
                end
            elseif item ==  'WEAPON_MOLOTOV' then
                if (currentChurro >= yeterli * 3) and (currentPlastic >= yeterli * 3) and (currentGlass >= yeterli * 3) then
                    TriggerClientEvent('uretimanimasyon', _source)
                    xPlayer.removeInventoryItem('mt-churro', yeterli * 2)
                    xPlayer.removeInventoryItem('mt-plastic', yeterli * 2)
                    xPlayer.removeInventoryItem('mt-glass', yeterli * 2)
                    Citizen.Wait(60000)
                    xPlayer.addWeapon('WEAPON_MOLOTOV', 1)
                else
                    TriggerClientEvent('notification', _source, 'Üzerinde yeterli materyal yok!', 2)
                end
            end 	
end)
