ESX = nil

local PlayerData = {}
local tab, temp, PoliceCadIsShowed = nil, false, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	ESX.UI.Menu.RegisterType('cadsystem', OpenCadSystem, CloseCadSystem)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	PlayerData.job = job
end)

RegisterNUICallback('search-plate', function(data)
  ESX.TriggerServerCallback('esx_police_cad:search-plate', function(data2)
    if data2 then
      ESX.TriggerServerCallback('esx_police_cad:search-plate2', function(data3)
        print(data2.modelname)
        SendNUIMessage({
          plate = data2.plate,
          modelname = data2.modelname,
          firstname = data3.firstname,
          lastname = data3.lastname
        })
      end, data2.owner)
		else
			SendNUIMessage({
				plate = 'Plaka Bulunamadı',
				model = '',
				firstname = '',
				lastname = ''
			}) 
		end
	end, data.plate)
end)

function tprint (t, s)
  for k, v in pairs(t) do
      local kfmt = '["' .. tostring(k) ..'"]'
      if type(k) ~= 'string' then
          kfmt = '[' .. k .. ']'
      end
      local vfmt = '"'.. tostring(v) ..'"'
      if type(v) == 'table' then
          tprint(v, (s or '')..kfmt)
      else
          if type(v) ~= 'string' then
              vfmt = tostring(v)
          end
          print(type(t)..(s or '')..kfmt..' = '..vfmt)
      end
  end
end

RegisterNUICallback('refresh_cr', function(crId)
	ESX.TriggerServerCallback('esx_police_cad:refresh_cr', function(data)
		if data then
			SendNUIMessage({cr_deleted = true})
		else
			SendNUIMessage({cr_not_deleted = true})
		end
	end, crId.id)
end)

RegisterNUICallback('add-cr', function(data)
  	TriggerServerEvent('esx_police_cad:add-cr', data)
end)

RegisterNUICallback('refresh_note', function(noteId)

  ESX.TriggerServerCallback('esx_police_cad:refresh_note', function(data)

		if data then
			SendNUIMessage({note_deleted = true})
		else
			SendNUIMessage({note_not_deleted = true})
		end
	end, noteId.id)
end)


RegisterNUICallback('add-note', function(data)
  	TriggerServerEvent('esx_police_cad:add-note', data)
end)

RegisterNUICallback('add-bolo', function(data)
	ESX.TriggerServerCallback('esx_police_cad:add-bolo', function(data)
		SendNUIMessage({showBolos = data})
	end, data)
end)

RegisterNUICallback('get-cr', function(playerid)
	ESX.TriggerServerCallback('esx_police_cad:get-cr', function(data)
		SendNUIMessage({crresults = data})
	end, playerid.playerid)
end)

RegisterNetEvent("police-cad:get-cr")
AddEventHandler("police-cad:get-cr", function(data)
	SendNUIMessage({crresults = data})
end)

RegisterNUICallback('get-bolos', function()
	ESX.TriggerServerCallback('esx_police_cad:get-bolos', function(bolo)
		SendNUIMessage({showBolos = bolo})
	end)
end)

RegisterNUICallback('get-note', function(playerid)
	ESX.TriggerServerCallback('esx_police_cad:get-note', function(data)
		SendNUIMessage({noteResults = data})
	end, playerid.playerid)
end)

RegisterNetEvent("police-cad:get-note")
AddEventHandler("police-cad:get-note", function(data)
	SendNUIMessage({noteResults = data})
end)

RegisterNUICallback('save-photo', function(data)
	TriggerServerEvent("esx_police_cad:save-user-photo", data)
end)

RegisterNUICallback('foto-cek', function(playerid)
	stopAnim()
	DeleteObject(tab)
	ESX.UI.Menu.Close('cadsystem', GetCurrentResourceName(), 'main')

	CreateMobilePhone(1)
	CellCamActivate(true, true)
	takePhoto = true
	if hasFocus == true then
		SetNuiFocus(false, false)
		hasFocus = false
	end
	while takePhoto do
		Citizen.Wait(1)
		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
		elseif IsControlJustPressed(1, 177) then -- CANCEL
			DestroyMobilePhone()
			CellCamActivate(false, false)
			takePhoto = false
			break
		elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload("https://discord.com/api/webhooks/816791933040328704/0agkGEdUPg7TkxyEJg1jc3fsid4IVz3DNwMK3uOZq3k6OArPylolZQ7ZFW3bb6s2phg8", "files[]", function(data)
				local resp = json.decode(data)
				DestroyMobilePhone()
				CellCamActivate(false, false)
				SendNUIMessage({foto = resp.files[1].url})
				takePhoto = false
			end)
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
		HideHudAndRadarThisFrame()
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('cadsystem', GetCurrentResourceName(), 'main')
	startAnim()
end)

RegisterNUICallback('delete_note', function(noteId)

  ESX.TriggerServerCallback('esx_police_cad:delete_note', function(data)

		if data then
			SendNUIMessage({note_deleted = true})
		else
			SendNUIMessage({note_not_deleted = true})
		end
	end, noteId.id)
end)

RegisterNUICallback('delete_cr', function(crId)
	ESX.TriggerServerCallback('esx_police_cad:delete_cr', function(data)
		if data then
			SendNUIMessage({cr_deleted = true})
		else
			SendNUIMessage({cr_not_deleted = true})
		end
	end, crId.id)
end)

RegisterNUICallback('delete-bolo', function(boloId)
	ESX.TriggerServerCallback('esx_police_cad:delete-bolo', function(data)
		if data then
			SendNUIMessage({bolo_deleted = true})
		end
	end, boloId.id)
end)

RegisterNUICallback('get-license', function(playerid)
	ESX.TriggerServerCallback('esx_police_cad:get-license', function(data)
		SendNUIMessage({licenseResults = data})
	end, playerid.playerid)
end)

RegisterNUICallback('search-players', function(player)
  print(player.search)
	ESX.TriggerServerCallback('esx_police_cad:search-players', function(data)
		if data then
			SendNUIMessage({civilianresults = data})
		end
	end, player.search)
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 2000
		if PoliceCadIsShowed then -- codes here: https://pastebin.com/guYd0ht4
			DisableControlAction(0, 1,    true) -- LookLeftRight
			DisableControlAction(0, 2,    true) -- LookUpDown
			DisableControlAction(0, 25,   true) -- Input Aim
			DisableControlAction(0, 106,  true) -- Vehicle Mouse Control Override

			DisableControlAction(0, 24,   true) -- Input Attack
			DisableControlAction(0, 140,  true) -- Melee Attack Alternate
			DisableControlAction(0, 141,  true) -- Melee Attack Alternate
			DisableControlAction(0, 142,  true) -- Melee Attack Alternate
			DisableControlAction(0, 257,  true) -- Input Attack 2
			DisableControlAction(0, 263,  true) -- Input Melee Attack
			DisableControlAction(0, 264,  true) -- Input Melee Attack 2

			DisableControlAction(0, 12,   true) -- Weapon Wheel Up Down
			DisableControlAction(0, 14,   true) -- Weapon Wheel Next
			DisableControlAction(0, 15,   true) -- Weapon Wheel Prev
			DisableControlAction(0, 16,   true) -- Select Next Weapon
			DisableControlAction(0, 17,   true) -- Select Prev Weapon
			if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
				SendNUIMessage({type = "click"})
			end
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNUICallback('escape', function()
	ESX.UI.Menu.Close('cadsystem', GetCurrentResourceName(), 'main')
	DeleteObject(tab)
	stopAnim()
end)



RegisterNetEvent('back:tablet')
AddEventHandler('back:tablet', function()
	if PlayerData.job and (PlayerData.job.name == "police" or PlayerData.job.name == "sheriff") then
		if not ESX.UI.Menu.IsOpen('cadsystem', GetCurrentResourceName(), 'main') then
		TriggerEvent('notification', 'Tablet açıldı.', 1)
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('cadsystem', GetCurrentResourceName(), 'main')
			startAnim()
		else
			stopAnim()
			DeleteObject(tab)
			ESX.UI.Menu.Close('cadsystem', GetCurrentResourceName(), 'main')
		end
	else
		TriggerEvent('notification', 'Bu tableti sadece polis/sheriff kullanabilir!', 2)
	end
end)

function OpenCadSystem()
	local playerPed = PlayerPedId()
	PoliceCadIsShowed = true
	SendNUIMessage({showCadSystem = true})
	ESX.SetTimeout(250, function()
		SetNuiFocus(true, true)
	end)
end

function CloseCadSystem()
	local playerPed = PlayerPedId()
	SendNUIMessage({showCadSystem = false})
	SetNuiFocus(false)
	PoliceCadIsShowed = false
	ClearPedTasks(playerPed)
	end

function attachObject()
	tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end

function stopAnim()
	temp = false
	StopAnimTask(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteObject(tab)
end

function startAnim()
	if not temp then
		RequestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
		while not HasAnimDictLoaded("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a") do
			Citizen.Wait(7)
		end
		attachObject()
		TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
		temp = true
	end
end