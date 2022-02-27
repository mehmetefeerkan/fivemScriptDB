--================================================================================================--
--==                                DEGISKENLER - ELLEMEYIN                                     ==--
--================================================================================================--
ESX                         = nil
inMenu                      = true

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

Bank = {
    {x = 150.2, y = -1040.2, z = 29.3},
    {x = -1212.9, y = -330.8, z = 37.7},
    {x = -2962.5, y = 482.6, z = 15.7},
    {x = -112.2, y = 6469.2, z = 31.6},
    {x = 314.1, y = -278.6, z = 54.1},
    {x = -351.5, y = -49.5, z = 49.0},
    {x = 241.7, y = 220.7, z = 106.2},
    {x = 1175.0, y = 2706.6, z = 38.0}
}
--================================================================================================
--==                                THREADLER - ELLEMEYIN                              	        ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--===============================================
--==             KOMUTLAR FALAN                ==
--===============================================

RegisterNetEvent('open:atm')
AddEventHandler('open:atm', function()
	if nearATM() then
		playAnim('mp_common', 'givetake1_a', 2500)
		Citizen.Wait(2500)


		inMenu = true
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'openGeneral'})
		TriggerServerEvent('bank:balance')
		local ped = GetPlayerPed(-1)

		Citizen.CreateThread(function()
			while inMenu do
				Citizen.Wait(2500)
				if IsControlJustPressed(1, 322) then
					inMenu = false
					SetNuiFocus(false, false)
					SendNUIMessage({type ='close'})
				else
					Citizen.Wait(5)
				end
			end
		end)
	end
end)

--===============================================
--==           PARA YATIRMA                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	ESX.TriggerServerCallback('new_banking:getCharacterName', function(data)
		local name = data.firstname.. ' ' ..data.lastname
		SendNUIMessage({
			type = "balanceHUD",
			balance = balance,
			player = name
			})
	end)
end)
--===============================================
--==           PARA YATIRMA                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

RegisterNUICallback('kapanma', function(data)
	SetNuiFocus(false, false)
end)

--===============================================
--==          PARA CEKME	                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==            MIKTAR EVENTI                  ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==           TRANSFER EVENTI                 ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==           SONUC EVENTI                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               EKRAN FOCUS                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
			playAnim('mp_common', 'givetake1_a', 2500)
			Citizen.Wait(2500)
	SendNUIMessage({type = 'closeAll'})
end)


function nearATM()
	local entity, entityDst = ESX.Game.GetClosestObject({
		'prop_atm_01',
		'prop_atm_02',
		'prop_atm_03',
		'prop_fleeca_atm',
	})
	if DoesEntityExist(entity) and entityDst <= 3 then
		return true
	else
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)

		for _, search in pairs(Bank) do
			local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

			if distance <= 3 then
				return true
			end
		end
	end
end
