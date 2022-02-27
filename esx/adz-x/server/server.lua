ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local maddeAktifMi = false
local maddeAlindiMi = false
local esyaAlinmaSuresi = 900000 -- 15 Dakika !!! Süreyi değiştirirseniz client tarafındakini de değiştirin yoksa script düzgün çalışmaz!!!

RegisterServerEvent("ak4y_maddeX:baslat")
AddEventHandler("ak4y_maddeX:baslat",function()
    while esyaAlinmaSuresi > 1 do
        esyaAlinmaSuresi = esyaAlinmaSuresi - 5000
        Citizen.Wait(5000)
    end
end)

RegisterServerEvent("ak4y_maddeX:maddeAl")
AddEventHandler("ak4y_maddeX:maddeAl",function()
    local xPlayer = ESX.GetPlayerFromId(source)
    maddeAlindiMi = true
    xPlayer.addInventoryItem("madde_x", 25)
    Citizen.Wait(60*60000) -- 1 Saat sonra ev içindeki markeri kapatmak için bekleme süresi. (Marker açık olsa bile eşyayı alamayacaklar, eşyanın alındığı yazacak)
    maddeAktifMi = false
    TriggerClientEvent("ak4y_maddeX:durum", -1, false)
end)

ESX.RegisterUsableItem('madde_x', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('madde_x', 1)
	TriggerClientEvent('ak4y_maddeX:maddeIcme', source)
end)

ESX.RegisterServerCallback('ak4y_maddeX:bilgi', function(source, cb)
    cb(maddeAlindiMi, esyaAlinmaSuresi, maddeAktifMi)
end)

evBaslat = function()
	maddeAktifMi = true
    TriggerClientEvent("ak4y_maddeX:durum", -1, true)
end

TriggerEvent("cron:runAt", 22, 0, evBaslat) -- 22yi istediğiniz gibi değiştirebilirsiniz. Örnek olarak 13 yaparsanız öğlen 1'de madde x aktif olur
