ESX = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local tasking = false
local drugStorePed = 0
local oxyVehicle = 0

local OxyDropOffs = {
	[1] =  { ['x'] = -140.89,['y'] = -1789.06,['z'] = 29.83,['h'] = 141.8, ['info'] = ' 1' },
	[2] =  { ['x'] = 69.76,['y'] = -1722.28,['z'] = 29.31,['h'] = 47.6, ['info'] = ' 2' },
	[3] =  { ['x'] = 130.24,['y'] = -1579.19,['z'] = 29.52,['h'] = 319.96, ['info'] = ' 3' },
	[4] =  { ['x'] = 20.76,['y'] = -1819.84,['z'] = 25.69,['h'] = 321.35, ['info'] = ' 4' },
	[5] =  { ['x'] = 111.05,['y'] = -1484.79,['z'] = 29.26,['h'] = 311.86, ['info'] = ' 5' },
	[6] =  { ['x'] = -53.17,['y'] = -1384.98,['z'] = 29.31,['h'] = 2.9, ['info'] = ' 6' },
	[7] =  { ['x'] = -326.61,['y'] = -1534.18,['z'] = 27.71,['h'] = 359.3, ['info'] = ' 7' },
	[8] =  { ['x'] = 326.54,['y'] = -1547.85,['z'] = 30.46,['h'] = 314.99, ['info'] = ' 8' },

	[9] =  { ['x'] = 348.68,['y'] = -1568.36,['z'] = 30.3,['h'] = 315.32, ['info'] = ' chewy1' },
	[10] =  { ['x'] = 435.39,['y'] = -1713.19,['z'] = 29.36,['h'] = 144.53, ['info'] = ' biscuts2' },
	[11] =  { ['x'] = 502.56,['y'] = -1532.55,['z'] = 29.28,['h'] = 234.1, ['info'] = ' are3' },
	[12] =  { ['x'] = 180.18,['y'] = -1249.52,['z'] = 29.2,['h'] = 343.24, ['info'] = ' only4' },
	[13] =  { ['x'] = 89.19,['y'] = -1745.32,['z'] = 30.09,['h'] = 317.15, ['info'] = ' nice5' },
	[14] =  { ['x'] = 491.52,['y'] = -1523.04,['z'] = 29.29,['h'] = 50.8, ['info'] = ' ifthey6' },
	[15] =  { ['x'] = -143.54,['y'] = -1300.21,['z'] = 31.01,['h'] = 0.92, ['info'] = ' contain7' },
	[16] =  { ['x'] = 21.84,['y'] = -1115.25,['z'] = 29.22,['h'] = 247.76, ['info'] = ' chocolate' },

}

local carspawns = {
	[1] =  { ['x'] = 79.85,['y'] = -1544.99,['z'] = 29.47,['h'] = 51.55, ['info'] = ' car 8' },
	[2] =  { ['x'] = 66.93,['y'] = -1561.73,['z'] = 29.47,['h'] = 45.73, ['info'] = ' car 1' },
	[3] =  { ['x'] = 68.57,['y'] = -1559.53,['z'] = 29.47,['h'] = 50.6, ['info'] = ' car 2' },
	[4] =  { ['x'] = 70.4,['y'] = -1557.12,['z'] = 29.47,['h'] = 51.18, ['info'] = ' car 3' },
	[5] =  { ['x'] = 72.22,['y'] = -1554.63,['z'] = 29.47,['h'] = 50.32, ['info'] = ' car 4' },
	[6] =  { ['x'] = 73.99,['y'] = -1552.22,['z'] = 29.47,['h'] = 52.47, ['info'] = ' car 5' },
	[7] =  { ['x'] = 76.06,['y'] = -1549.87,['z'] = 29.47,['h'] = 51.53, ['info'] = ' car 6' },
	[8] =  { ['x'] = 77.9,['y'] = -1547.45,['z'] = 29.47,['h'] = 53.24, ['info'] = ' car 7' },
}

local pillWorker = { ['x'] = 70.85,['y'] = -1567.81,['z'] = 29.6,['h'] = 59.54, ['info'] = 'boop bap' }

local rnd = 0
local blip = 0
local deliveryPed = 0

local oxyPeds = {
	'a_m_y_stwhi_02',
	'a_m_y_stwhi_01'
}


local drugLocs = {
	[1] =  { ['x'] = 131.94,['y'] = -1937.95,['z'] = 20.61,['h'] = 118.59, ['info'] = ' Grove Stash' },
	[2] =  { ['x'] = 1390.84,['y'] = -1507.94,['z'] = 58.44,['h'] = 29.6, ['info'] = ' East Side' },
	[3] =  { ['x'] = -676.81,['y'] = -877.94,['z'] = 24.48,['h'] = 324.9, ['info'] = ' Wei Cheng' },
}

local carpick = {
    [1] = "chino2",
    [2] = "paradise",
    [3] = "voodoo2",
    [4] = "youga2",
    [5] = "burrito3",
}

function CreateOxyVehicle()

	if DoesEntityExist(oxyVehicle) then

	    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
		SetEntityAsNoLongerNeeded(oxyVehicle)
		DeleteEntity(oxyVehicle)
	end

    local car = GetHashKey(carpick[math.random(#carpick)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    local spawnpoint = 1
    for i = 1, #carspawns do
	    local caisseo = GetClosestVehicle(carspawns[i]["x"], carspawns[i]["y"], carspawns[i]["z"], 3.500, 0, 70)
		if not DoesEntityExist(caisseo) then
			spawnpoint = i
		end
    end

    oxyVehicle = CreateVehicle(car, carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], carspawns[spawnpoint]["h"], true, false)
    local plt = GetVehicleNumberPlateText(oxyVehicle)
	SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)
	-- local plateS = GetVehicleNumberPlateText(oxyVehicle)
	-- TriggerEvent("ARPF:spawn:recivekeys", oxyVehicle,plateS)

    while true do
    	Citizen.Wait(1)
    	 DrawText3Ds(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"])
    	 if #(GetEntityCoords(PlayerPedId()) - vector3(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"])) < 8.0 then
    	 	return
    	 end
    end

end

function CreateOxyPed()

    local hashKey = `a_m_y_stwhi_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"], OxyDropOffs[rnd]["h"], 0, 0)
	
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)

end

RegisterCommand('rolexbitir', function(source, args)
	if OxyRun or tasking then
		OxyRun = false
		tasking = false
		-- exports['mythic_notify']:SendAlert('inform', 'Rolex satış işini bitirdin.')
		TriggerEvent('notification', 'Rolex satış işini bitirdin.', 1)
	else
		-- exports['mythic_notify']:SendAlert('error', 'Rolex satış işinde zaten değilsin')
		TriggerEvent('notification', 'Rolex satış işinde zaten değilsin', 2)
	end
end)

function DeleteCreatedPed()
	print("Deleting Ped?")
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)
		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if OxyRun then
		blip = AddBlipForCoord(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])
	end
    
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Müşteri")
    EndTextCommandSetBlipName(blip)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function DoDropOff()
	local success = true
	local OxyChance = math.random(1,1000)

	Citizen.Wait(1000)
	playerAnim()
	Citizen.Wait(800)

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

		local counter = math.random(50,200)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Citizen.Wait(1)
		end
	
		if success then
			local counter = math.random(100,300)
			while counter > 0 do
				local crds = GetEntityCoords(deliveryPed)
				counter = counter - 1
				Citizen.Wait(1)
			end
			giveAnim()
		end
	
		local crds = GetEntityCoords(deliveryPed)
		local crds2 = GetEntityCoords(PlayerPedId())
	
		if #(crds - crds2) > 3.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
			success = false
		end
		
		DeleteBlip()
		if success then
			ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
				if quantity > 0 then

					if OxyChance <= Config.OxyChance then
						TriggerServerEvent("oxydelivery:receiveoxy")
					elseif OxyChance <= Config.BigRewarditemChance then
						TriggerServerEvent("oxydelivery:receiveBigRewarditem")
						-- exports['mythic_notify']:SendAlert('inform', 'Alıcı ürünü çok beğendi, sana hem para hem de ' .. Config.BigRewarditem .. ' verdi')
						TriggerEvent('notification', 'Alıcı ürünü çok beğendi, sana hem para hem de ' .. Config.BigRewarditem .. ' verdi', 1)
					else
						TriggerServerEvent("oxydelivery:receivemoneyyy")
					end
					
					Citizen.Wait(2000)
					-- TriggerEvent("notification", "")
					-- exports['mythic_notify']:SendAlert('inform', 'Satış başarılı, bir sonraki müşteriyi bekle.')
					TriggerEvent('notification', 'Satış başarılı, bir sonraki müşteriyi bekle.', 1)
				else
					-- exports['mythic_notify']:SendAlert('error', 'Satacak rolex kalmadı, satış bitti!')
					TriggerEvent('notification', 'Satacak rolex kalmadı, satış bitti!', 2)
					OxyRun = false
					tasking = false
				end
			end, 'rolex')
		else
			-- TriggerEvent("notification","",2)
			-- exports['mythic_notify']:SendAlert('error', 'Satış başarısız, yeni müşteriyi bekle!')
			TriggerEvent('notification', 'Satış başarısız, yeni müşteriyi bekle!', 2)
		end
	
		DeleteCreatedPed()
	end
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

RegisterNetEvent("oxydelivery:client")
AddEventHandler("oxydelivery:client", function()

	if tasking then
		return
	end
	
	rnd = math.random(1,#OxyDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true
	local toolong = 600000
	while tasking do

		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])) 
		local oxyVehCoords = GetEntityCoords(oxyVehicle)
		local dstcheck2 = #(plycoords - oxyVehCoords) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated and (oxyVehicle == veh or dstcheck2 < 15.0) then
			pedCreated = true
			DeleteCreatedPed()
			CreateOxyPed()
			-- TriggerEvent("notification","Müşteriye yakınsın")
			-- exports['mythic_notify']:SendAlert('inform', 'Müşteriye yakınsın')
			TriggerEvent('notification', 'Müşteriye yakınsın', 1)
		end
		toolong = toolong - 1
		if toolong < 0 then

		    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
			SetEntityAsNoLongerNeeded(oxyVehicle)
			tasking = false
			OxyRun = false
			--TriggerEvent("notification","You are no longer selling Oxy due to taking too long to drop off", 2)
			-- exports['mythic_notify']:SendAlert('error', 'Dağıtmak çok uzun sürdüğü için Kan Durdurucu satmayı bıraktın.')
			TriggerEvent('notification', 'Dağıtmak çok uzun sürdüğü için Kan Durdurucu satmayı bıraktın.', 2)
		end
		if dstcheck < 2.0 and pedCreated then

			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")  

			if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Citizen.Wait(1500)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()
				tasking = false
			end

		end

	end
	

	DeleteCreatedPed()
	DeleteBlip()

end)

Citizen.CreateThread(function()

    while true do

	    sleep = 2000
		local dropOff6 = #(GetEntityCoords(PlayerPedId()) - vector3(pillWorker["x"],pillWorker["y"],pillWorker["z"]))
		if dropOff6 < 3.0 then
			sleep = 5
		end

		if dropOff6 < 1.6 and not OxyRun then

			DrawText3Ds(pillWorker["x"],pillWorker["y"],pillWorker["z"], "[E] 500$ Rolex satmaya basla") 
			if IsControlJustReleased(0,38) then
				TriggerServerEvent("oxydelivery:server")
				Citizen.Wait(1000)
			end
		end
		Citizen.Wait(sleep)

    end

end)

local firstdeal = false
Citizen.CreateThread(function()


    while true do

        if drugdealer then

	        Citizen.Wait(1000)

	        if firstdeal then
	        	Citizen.Wait(10000)
	        end

	        TriggerEvent("drugdelivery:client")  

		    salecount = salecount + 1
		    if salecount == 12 then
		    	Citizen.Wait(600000)
		    	drugdealer = false
		    end

		    Citizen.Wait(150000)
		    firstdeal = false

		elseif OxyRun then

			if not DoesEntityExist(oxyVehicle) or GetVehicleEngineHealth(oxyVehicle) < 200.0 or GetVehicleBodyHealth(oxyVehicle) < 200.0 then
				OxyRun = false
				tasking = false
				-- TriggerEvent("notification", "The dealer isn't giving you anymore locations due to the state of his car", 2)
				-- exports['mythic_notify']:SendAlert('error', 'Bayi, arabasının durumu nedeniyle artık konum vermiyor')
				TriggerEvent('notification', 'Bayi, arabasının durumu nedeniyle artık konum vermiyor', 2)
				
			else
				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("oxydelivery:client")  
				    salecount = salecount + 1
				    if salecount == Config.RunAmount then
				    	Citizen.Wait(300000)
				    	OxyRun = false
				    end
				end
			end

	    else

	    	local close = false

	    	for i = 1, #drugLocs do

				local plycoords = GetEntityCoords(PlayerPedId())

				local dstcheck = #(plycoords - vector3(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"])) 

			

				if dstcheck < 5.0 then

					close = true

					local job = exports["isPed"]:isPed("job")

					if job ~= "police" then

						local price = 100

			    		DrawText3Ds(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"], "[E] $" .. price .. " offer to sell stolen goods (12).") 
				    	
				    	if IsControlJustReleased(0,38) then

				    		local countpolice = exports["isPed"]:isPed("countpolice")
				    		local daytime = exports["isPed"]:isPed("daytime")

							if not daytime then
		            			-- TriggerEvent("notification","Its too late - noones buying shit!",2)
								-- exports['mythic_notify']:SendAlert('error', 'Çok geç, artık kimse bir şey almak istemiyor!')
								TriggerEvent('notification', 'Çok geç, artık kimse bir şey almak istemiyor!', 2)
		            		else
		            			mygang = drugLocs[i]["gang"]
					    		TriggerServerEvent("drugdelivery:server",price,"robbery",50)
					    		Citizen.Wait(1500)
					    	end

				    	end

			    	else

			    		Citizen.Wait(60000)

			    	end

			    	Citizen.Wait(1)

			    end

			end

			if not close then
				Citizen.Wait(2000)
			end

	    end

    end

end)

RegisterNetEvent("oxydelivery:startDealing")
AddEventHandler("oxydelivery:startDealing", function()
    local NearNPC = GetClosestPed()
	ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
		if quantity > 0 then
			PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
			salecount = 0
			OxyRun = true
			firstdeal = true
			-- TriggerEvent("notification","Senin için araba çıkartıldı. Birazdan lokasyon bilgileri gelecek.")
			-- exports['mythic_notify']:SendAlert('inform', 'Aracın hazır, lokasyon bilgileri birazdan gelecek.')
			TriggerEvent('notification', 'Aracın hazır, lokasyon bilgileri birazdan gelecek.', 1)
			CreateOxyVehicle()
		else
			-- exports['mythic_notify']:SendAlert('error', 'Üzerinde satacak rolex yok, olduğu zaman tekrar gel!')
			TriggerEvent('notification', 'Üzerinde satacak rolex yok, olduğu zaman tekrar gel!', 2)
			TriggerServerEvent('oxydelivery:paraiade')
		end
	end, 'rolex')
end)