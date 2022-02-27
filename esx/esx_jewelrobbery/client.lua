local ESX, leftdoor, rightdoor= nil, nil, nil
local IsBusy, HasNotified, shockingevent,policeclosed, IsAbleToRob, HasAlreadyEnteredArea = false,false,false,false,false,false
local CopsOnline= 0
local kapikilitli = true

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterCommand('kilitle', function(source, args, rawCommand)
	if Config.AllowPoliceStoreClose then
		ply = PlayerPedId()
		plyloc = GetEntityCoords(ply)
		local ispolice = false
		for i, v in pairs(Config.PoliceJobs) do
			if PlayerData.job.name == v then
				ispolice = true
				break
			end
		end
		if GetDistanceBetweenCoords(plyloc, -631.9449, -237.8447, 38.07262, true) < 2.0 and ispolice then
			TriggerServerEvent('esx_JewelRobbery:closestore')
			leftdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_l"), false, false, false)
			rightdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_r1"), false, false, false)			
			ClearAreaOfPeds(-622.2496, -230.8000, 38.05705, 10.0, 1)
			storeclosed = true
			HasNotified = false
		elseif ispolice then
			ESX.ShowNotification('Mağazayı kapatmak için kapının yanında durmalısınız!')
		end
	end
end)

RegisterNetEvent('esx_jobnumbers:setjobs')
AddEventHandler('esx_jobnumbers:setjobs', function(jobslist)
	JobCount = jobslist
	CopsOnline = 0
	if JobCount['cops'] ~= nil then
		CopsOnline = JobCount['cops']
	else
		for i,v in pairs(Config.PoliceJobs) do
			if JobCount[v] ~= nil then
				CopsOnline = CopsOnline + JobCount[v]
			end
		end
	end
	HasAlreadyEnteredArea = false
end)

RegisterNetEvent('esx_JewelRobbery:policeopenstoree')
AddEventHandler('esx_JewelRobbery:policeopenstoree', function()
	policeclosed = false
	storeclosed = false
	IsAbleToRob = true
	vangelicoDoorOpen()
end)

RegisterNetEvent('esx_JewelRobbery:policeclosure')
AddEventHandler('esx_JewelRobbery:policeclosure', function()
	policeclosed = true
	storeclosed = false
	IsAbleToRob = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('esx_JewelRobbery:loadconfig')
end)

RegisterNetEvent('esx_JewelRobbery:resetcases')
AddEventHandler('esx_JewelRobbery:resetcases', function(list)
	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -622.2496, -230.8000, 38.05705, true)  < 20.0  then
		for i, v in pairs(Config.CaseLocations) do
			if v.Broken then
				RemoveModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
			end
		end
	end
	Config.CaseLocations = list
	HasNotified = false
	policeclosed = false
	storeclosed = false
	IsAbleToRob = false
	HasAlreadyEnteredArea = false
	kapikiliti = true
end)

RegisterNetEvent('esx_JewelRobbery:setcase')
AddEventHandler('esx_JewelRobbery:setcase', function(casenumber, switch)
	Config.CaseLocations[casenumber].Broken = switch
	HasAlreadyEnteredArea = false
end)

RegisterNetEvent('esx_JewelRobbery:policenotify')
AddEventHandler('esx_JewelRobbery:policenotify', function()
	for i, v in pairs(Config.PoliceJobs) do
		if  PlayerData.job.name == v then  
			ESX.ShowAdvancedNotification('911 Emergency', 'Silent Alarm' , 'Vangelico Jewelry Store', 'CHAR_CALL911', 1)
			TriggerEvent('esx_jewel:alarmBlip')
		end
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 617)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Vangelico Mücevher Dükkanı')
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent('esx_JewelRobbery:loadconfig')
AddEventHandler('esx_JewelRobbery:loadconfig', function(casestatus)
	while not DoesEntityExist(PlayerPedId()) do
		Citizen.Wait(100)
	end
	Config.CaseLocations = casestatus
	if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 20.0 then
		for i, v in pairs(Config.CaseLocations) do
			if v.Broken then
				CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
			end
		end
	end
end)

RegisterNetEvent('esx_JewelRobbery:playsound')
AddEventHandler('esx_JewelRobbery:playsound', function(x,y,z, soundtype)
	ply = PlayerPedId()
	plyloc = GetEntityCoords(ply)
	if GetDistanceBetweenCoords(plyloc,x,y,z,true) < 20.0 then
		if soundtype == 'break' then
			PlaySoundFromCoord(-1, "Glass_Smash", x,y,z, 0, 0, 0)
		elseif soundtype == 'nonbreak' then
			PlaySoundFromCoord(-1, "Drill_Pin_Break", x,y,z, "DLC_HEIST_FLEECA_SOUNDSET", 0, 0, 0)
		end
	end
end)

AddEventHandler('esx_JewelRobbery:EnteredArea', function()
	for i, v in pairs(Config.CaseLocations) do
		if v.Broken then
			CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
		end
	end
end)

AddEventHandler('esx_JewelRobbery:LeftArea', function()
	for i, v in pairs(Config.CaseLocations) do
		if v.Broken then
			RemoveModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
		end
	end
end)

function UnAuthJob()
	while ESX == nil do
		Citizen.Wait(0)
	end
	local UnAuthjob = false
	for i,v in pairs(Config.UnAuthJobs) do
		if PlayerData.job.name == v then
			UnAuthjob = true
			break
		end
	end

	return UnAuthjob
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread( function()
	while true do 
		ply = PlayerPedId()
		plyloc = GetEntityCoords(ply)
		IsInArea = false
		
		if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 20.0 then
			IsInArea = true
		end
		
		if IsInArea and not HasAlreadyEnteredArea then
			TriggerEvent('esx_JewelRobbery:EnteredArea')
			shockingevent = false
			if kapikilitli then
				leftdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_l"), false, false, false)
				rightdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_r1"), false, false, false)			
				ClearAreaOfPeds(-622.2496, -230.8000, 38.05705, 10.0, 1)
				storeclosed = true
				HasNotified = false
			end
			HasAlreadyEnteredArea = true
		end

		if not IsInArea and HasAlreadyEnteredArea then
			TriggerEvent('esx_JewelRobbery:LeftArea')
			HasAlreadyEnteredArea = false
			shockingevent = false
			IsAbleToRob = false
			storeclosed = false
			HasNotified = false
		end
		
		if Config.Closed and not (CopsOnline >= Config.MinPolice) and not storeclosed and not policeclosed then
			Citizen.Wait(1250)
		else
			Citizen.Wait(3250)
		end
	end
end)

function vangelicoDoorOpen()
	TriggerEvent('esx_JewelRobbery:EnteredArea')
	shockingevent = false
	
	leftdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_l"), false, false, false)
	rightdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_r1"), false, false, false)			
	storeclosed = false
	Citizen.Wait(100)
	freezedoors(false)
	IsAbleToRob = true
	HasNotified = false
	kapikilitli = false
end
	

function hasgun()
	hasweapon = false
	local _, weaponname = GetCurrentPedWeapon(ply)
	for index, weapon in pairs (Config.AllowedWeapons) do
		if GetHashKey(weapon.name) == weaponname then
			hasweapon = weapon
			break 
		end
	end
	return hasweapon
end

Citizen.CreateThread(function()
	while true do
	  sleep = 2000
	  if kapikilitli then
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local dstCheck = GetDistanceBetweenCoords(pedCoords, -595.98, -283.7, 50.72, true)
		if dstCheck <= 3.0 then
			sleep = 5
				DrawText3Ds(-595.98, -283.7, 50.72, '[E] Kuyumcu kapısını aç')
				if IsControlJustPressed(0,38) then
				ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
					if quantity > 0 then
						TriggerEvent("dooranims")
						exports["t0sic_loadingbar"]:StartDelayedFunction("Kuyumcu kapısı açılıyor", 5000, function()
						-- exports['mythic_notify']:SendAlert('inform', 'Kuyumcu kapılarını başarıyla açtın')
						TriggerEvent('notification', 'Kuyumcu kapılarını başarıyla açtın.', 1)
						TriggerServerEvent('esx_JewelRobbery:openstore')
						end)
						TriggerServerEvent('GuvenlikKartiniAl')
					else
					-- exports['mythic_notify']:SendAlert('error', 'Güvenlik kartın yok!')
					TriggerEvent('notification', 'Güvenlik kartın yok!', 2)
					end
					end, 'securitycard')
				end
			end
			end
			Citizen.Wait(sleep)
	end
end)

RegisterNetEvent( 'dooranims' )
AddEventHandler( 'dooranims', function()
    
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(50)
    ClearPedTasks(PlayerPedId())

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function freezedoors(status)
	FreezeEntityPosition(leftdoor, status)
	FreezeEntityPosition(rightdoor, status)
end

Citizen.CreateThread( function()
	while true do 
		sleep = 1500
		while storeclosed do
			ply = PlayerPedId()
			plyloc = GetEntityCoords(ply)
			if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 10.0 then
				DoScreenFadeOut(1250)
				Citizen.Wait(1500)
				SetEntityCoords(PlayerPedId(), -673.1831, -227.6621, 36.11,0,0,0,true)
				DoScreenFadeIn(1250)
				ESX.ShowNotification('Vangelico Mücevher Dükkanı şuanda tadilatta!')
			end
			Citizen.Wait(0)
			sleep = 0
			freezedoors(true)	
			 if GetDistanceBetweenCoords(plyloc, -632.81, -237.9, 38.08, false) < 2.0 then
                DrawText3Ds(- 631.4819, -237.6632, 39.07612, 'Kilitli')
            end
				
		end

		while policeclosed do
			ply = PlayerPedId()
			plyloc = GetEntityCoords(ply)
			if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 10.0 then
				DoScreenFadeOut(1250)
				Citizen.Wait(1500)
				SetEntityCoords(PlayerPedId(), -673.1831, -227.6621, 36.11,0,0,0,true)
				DoScreenFadeIn(1250)
				ESX.ShowNotification('Vangelico Mücevher Dükkanı tadilatta!')
			end
			Citizen.Wait(0)
			sleep = 0
			freezedoors(true)	
			 if GetDistanceBetweenCoords(plyloc, -632.81, -237.9, 38.08, false) < 2.0 then
                DrawText3Ds(-631.4819, -237.6632, 39.07612, 'Mücevher dükkanı tadilatta!')
            end
				
		end
		while IsAbleToRob and not UnAuthJob() and (CopsOnline >= Config.MinPolice) and hasgun() do
			sleep = 1500
			ply = PlayerPedId()
			plyloc = GetEntityCoords(ply)
			for i, v in pairs(Config.CaseLocations) do
				if GetDistanceBetweenCoords(plyloc, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0  and not v.Broken and not IsBusy then
					sleep = 5
					DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.5, '~g~E~w~ Camı kır')
					if IsControlJustPressed(0, 38) and not IsBusy and not IsPedWalking(ply) and not IsPedRunning(ply) and not IsPedSprinting(ply) then
						local policenotify = math.random(1,100)
						if not shockingevent  then
							AddShockingEventAtPosition(99, v.Pos.x, v.Pos.y, v.Pos.z,25.0)
							shockingevent = true
						end
						IsBusy = true				
						TaskTurnPedToFaceCoord(ply, v.Pos.x, v.Pos.y, v.Pos.z, 1250)
						Citizen.Wait(1250)
						if not HasAnimDictLoaded("missheist_jewel") then
							RequestAnimDict("missheist_jewel") 
						end
						while not HasAnimDictLoaded("missheist_jewel") do 
						Citizen.Wait(0)
						end
						TaskPlayAnim(ply, 'missheist_jewel', 'smash_case', 1.0, -1.0,-1,1,0,0, 0,0)
						local breakchance = math.random(1, 100)
						if breakchance <= hasweapon.chance then
							if policenotify <= Config.PoliceNotifyBroken and not HasNotified then
								TriggerEvent('police:vangelicorobbery')
								HasNotified = true
							end
							Citizen.Wait(2100)
							TriggerServerEvent('esx_JewelRobbery:playsound', v.Pos.x, v.Pos.y, v.Pos.z, 'break')
							CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z,  0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
							ClearPedTasksImmediately(ply)
							TriggerServerEvent("esx_JewelRobbery:setcase", i, true)	
						else
							Citizen.Wait(2100)
							TriggerServerEvent('esx_JewelRobbery:playsound', v.Pos.x, v.Pos.y, v.Pos.z, 'nonbreak')
							ClearPedTasksImmediately(ply)
							if policenotify <= Config.PoliceNotifyNonBroken and not HasNotified then
								TriggerEvent('police:vangelicorobbery')
								HasNotified = true
							end
						end	
						Citizen.Wait(1250)
						IsBusy = false			
					end
				end
			end
			Citizen.Wait(sleep)
		end
		Citizen.Wait(sleep)
	end
end)

AddEventHandler('esx_jewel:alarmBlip', function()
	local transT = 250
	local Blip = AddBlipForCoord(-634.02, -239.49, 38)
	SetBlipSprite(Blip,  10)
	SetBlipColour(Blip,  1)
	SetBlipAlpha(Blip,  transT)
	SetBlipAsShortRange(Blip,  false)
	while transT ~= 0 do
		Wait(100)
		transT = transT - 1
		SetBlipAlpha(Blip,  transT)
		if transT == 0 then
			SetBlipSprite(Blip,  2)
			return
		end
	end
end)
