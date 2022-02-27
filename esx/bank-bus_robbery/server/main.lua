---======================---
---Written by Tościk#9715---
---======================---
local potrzebniPolicjanci = 0  		--<< görevi etkinleştirmek için polislere ihtiyaç duyuldu
local czastimer = 7200 * 1000	    --<< timer co ile mozna robic misje, domyslnie 600 sekund
local gotowkaA = 75000 				--<< ile minimum mozesz dostac z rabunku
local gotowkaB = 100000 				--<< ile maximum mozesz dostac z rabunku
local KosztAktywacji = 5000 		--<< ile kosztuje aktywacja misji (czystej z banku)
-----------------------------------
local MisjaAktywna = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('napadtransport:akceptujto')
AddEventHandler('napadtransport:akceptujto', function()
	local copsOnDuty = 0
	local Players = ESX.GetPlayers()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local accountMoney = 0
	accountMoney = xPlayer.getAccount('bank').money
if MisjaAktywna == 0 then
	if accountMoney < KosztAktywacji then
	TriggerClientEvent('esx:showNotification', source, 'Bankanda en az 5000$ para olmalı!')
	else
	for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer["job"]["name"] == "police" then
            copsOnDuty = copsOnDuty + 1
        end
    end
	if copsOnDuty >= potrzebniPolicjanci then
		TriggerClientEvent("napadtransport:Pozwolwykonac", _source)
		xPlayer.removeAccountMoney('bank', KosztAktywacji)
		OdpalTimer()
    end
	end
else
TriggerClientEvent('esx:showNotification', source, 'Şimdilik soyabileceğin bir banka aracı yok!')
end
end)

function OdpalTimer()
MisjaAktywna = 1
Wait(czastimer)
MisjaAktywna = 0
end

RegisterServerEvent('napadtransport:zawiadompsy')
AddEventHandler('napadtransport:zawiadompsy', function(x, y, z) 
    TriggerClientEvent('napadtransport:infodlalspd', -1, x, y, z)
end)

ESX.RegisterServerCallback("bankakamyonn:c4sil", function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem("lockpick")
		xPlayer.removeInventoryItem("c4_bank",1)
end)

RegisterServerEvent('napadtransport:graczZrobilnapad')
AddEventHandler('napadtransport:graczZrobilnapad', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local LosujSiano = math.random(gotowkaA,gotowkaB)
xPlayer.addMoney(LosujSiano)
TriggerClientEvent('esx:showNotification', source, LosujSiano..'$ çaldın!')
Wait(2500)
end)


