ESX = nil
toggleState = false


Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
      Citizen.Wait(10)
    end
end)




--nui

RegisterCommand("atm", function()
    if nearATM() then
        if toggleState == false then
            playAnim('mp_common', 'givetake1_a', Config.AnimationTime)
            toggle(true)
            getPlayerData()
            sendHistory()
        else
            toggle(false)
        end
    end
end)

RegisterNUICallback("notif", function(data, cb)
    sendNotif(data.text, data.type)
end)


function toggle(open)
    SetNuiFocus(open, open)
    SendNUIMessage({
        type = "toggleMenu",
        toggle = open
    })
    toggleState = open
end

function getPlayerData()
    ESX.TriggerServerCallback("kocadede-banking:GetPlayerData", function(PlayerData)
        SendNUIMessage({
            type = "getPlayerData",
            data = PlayerData
        })
    end)
end

RegisterNUICallback('exit', function()
    toggle(false)
end)


RegisterNUICallback('withdraw', function(data)
    TriggerServerEvent("vlast-banking:withdraw", data)
end)


RegisterNUICallback('deposit', function(data)
    TriggerServerEvent("vlast-banking:deposit", data)
end)


RegisterNUICallback('addHistory', function(data)
    TriggerServerEvent("vlast-banking-addBankHistory", data)
end)

RegisterNUICallback('transfer', function(data)
    TriggerServerEvent("vlast-banking-transfer", data)
end)



function sendHistory()
    ESX.TriggerServerCallback("kocadede-getPlayerAccountHistory", function(history)
        SendNUIMessage({
            type = "sendHistory",
            history = history
        })
    end)
end




-- lua

function nearATM()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.ATM) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 2 then
			return true
		end
	end
end

function nearBank()
    local player = PlayerPedId()
    local playerloc = GetEntityCoords(player, 0)

    for _, search in pairs(Config.Bank) do
        local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), search.x, search.y, search.z) < 2.5 then
            DrawText3D(search.x, search.y, search.z, Config.Text["banktext"])
        end


        if distance <= 3 then
            return true
        end
    end
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

--BANK
Citizen.CreateThread(function()
	if Config.ShowBlips then
	  for k,v in ipairs(Config.Bank)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.1)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Text["bank_blip"])
		EndTextCommandSetBlipName(blip)
	  end
	end
end)


--ATM
Citizen.CreateThread(function()
	if Config.ShowBlips and Config.OnlyBank == false then
	  for k,v in ipairs(Config.ATM)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U("atm_blip"))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

function DrawText3D(x,y,z,text,size)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35,0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	--DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)
	DrawRect(_x,_y + 0.03, 41, 11, 41, 100)
end

Citizen.CreateThread(function()
    local performans = 1000
    while true do
        Citizen.Wait(performans)
        if nearBank() then
            performans = 1
        else
            performans = 1000
        end
    end
end)