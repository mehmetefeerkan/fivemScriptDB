-- SELL DRUGS TO NPC --

ESX                 = nil
selling       = false
local has       = false

Citizen.CreateThread(function()
  	while ESX == nil do
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(250)
  	end

  	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(250)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	Citizen.Wait(5000)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ped ~= 0 then 
			if not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then
                        local pedType = GetPedType(ped)
				if ped ~= oldped and not selling and (IsPedAPlayer(ped) == false and pedType ~= 28) then
					TriggerServerEvent('checkD')
					if has then
						local pos = GetEntityCoords(ped)
						DrawText3Ds(pos.x, pos.y, pos.z, 'Bir seyler satmak icin  bas')
						if IsControlJustPressed(1, 86) then
							selling = true
							itemsecme = false
							ebasma()
						end
					end
				end
			else
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)	
		end
	end
end)

RegisterNetEvent('checkR')
AddEventHandler('checkR', function(test)
  has = test
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local playerPed = GetPlayerPed(-1)

		if not IsPedInAnyVehicle(playerPed) or not IsPedDeadOrDying(playerPed) then
			ped = GetPedInFront()
		else
			Citizen.Wait(500)
		end
    end
end)

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end

local itemsecme = false
function ebasma()
    oldped = ped
	SetEntityAsMissionEntity(ped)
	TaskStandStill(ped, 9.0)

	exports['progressBars']:startUI(3500, "Konusuyorsun...")
	Citizen.Wait(3500)
	
	if ESX.PlayerData.job.name == 'police' then
		exports['mythic_notify']:SendAlert('error', 'The buyer has seen you before, they know you\'re a cop!', 4000)
		SetPedAsNoLongerNeeded(oldped)
		selling = false
		return
	end

    if ped ~= oldped then
		exports['mythic_notify']:SendAlert('error', 'You acted sketchy (moved far away) and the buyer was no longer interested.', 5000)
		SetPedAsNoLongerNeeded(oldped)
		selling = false
		return
	end

    local sanscik = math.random(1, 11)
    
    if sanscik <= 4 then
        exports['mythic_notify']:SendAlert('error', 'Müşteri kabul etmedi.', 4000)
    else
        itemsecme = true
    end
    if sanscik > 9 then
        local playerCoords = GetEntityCoords(PlayerPedId())
        itemsecme = false
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)

		exports['mythic_notify']:SendAlert('inform', 'Polise bildirim gönderildi!', 4000)
		TriggerServerEvent('np_selltonpc:saleInProgress', streetName)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        if itemsecme then
            DrawText3Ds(pos.x, pos.y, pos.z + 0.1, 'Esrar [E]')
			DrawText3Ds(pos.x, pos.y, pos.z + 0.2, 'Meth [G]')
			DrawText3Ds(pos.x, pos.y, pos.z + 0.3, 'item2 satmak için m')
			DrawText3Ds(pos.x, pos.y, pos.z, 'Iptal [C]')
        else
            Citizen.Wait(2000)
        end
        if itemsecme and IsControlJustPressed(0, 38) then --E
            TriggerEvent("animation", source)
		    Citizen.Wait(1500)
		    TriggerServerEvent('np_selltonpc:dodeal', 'weed', 80, 90)
			itemsecme = false
			selling = false
        end
        if itemsecme and IsControlJustPressed(0, 244) then --G
            TriggerEvent("animation", source)
		    Citizen.Wait(1500)
		    TriggerServerEvent('np_selltonpc:dodeal', 'balikekmek', 100, 130)
			itemsecme = false
			selling = false
        end
        if itemsecme and IsControlJustPressed(0, 113) then --M
            TriggerEvent("animation", source)
		    Citizen.Wait(1500)
		    TriggerServerEvent('np_selltonpc:dodeal', 'bread', 1, 3)
			itemsecme = false
			selling = false
        end
        if itemsecme and IsControlJustPressed(0, 253) then  --C
            itemsecme = false
			selling = false
        end
    end
end)

AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)

RegisterNetEvent('animation')
AddEventHandler('animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
	TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
	TaskPlayAnim(ped,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
	StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
	StopAnimTask(ped, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)

RegisterNetEvent('np_selltonpc:policeNotify')
AddEventHandler('np_selltonpc:policeNotify', function(alert)
	if ESX.PlayerData.job.name == 'police' then

		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(48, 145, 255, 0.616); border-radius: 10px;">{0}</div>',
			args = { alert }
		})
	end
end)
