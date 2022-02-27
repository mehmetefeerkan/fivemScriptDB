ESX = nil
local hacked = false
local copied = false
local transfered = false
local insertUSB = false
local gettingFiles = false
local transferredMoney = false
local accessUSB = false
local pcOn = false
local disconnnecting = false
local copiedFile = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local isLoggedin = false
RegisterNetEvent('isLoggedin:me')
AddEventHandler('isLoggedin:me', function(result)
	isLoggedin = result
end)

local hotspots = {
	--pinkcage--
	{ ['x'] = 323.3, ['y'] = -214.47, ['z'] = 54.09},
	--pd--
	{ ['x'] = 439.38, ['y'] = -982.33, ['z'] = 30.69 },
	--hp--
	{ ['x'] = 305.8, ['y'] = -591.53, ['z'] = 43.29 },
	--mech--
	{ ['x'] = -329.29, ['y'] = -119.8, ['z'] = 39.01 },
	--barangay paleto--
	{ ['x'] = -144.18, ['y'] = 6304.69, ['z'] = 35.49 },
	--mayor--
	{ ['x'] = -812.16, ['y'] = 179.79, ['z'] = 72.16 }, 
	--car dealer--
	{ ['x'] = -43.51, ['y'] = -1105.47, ['z'] = 26.20 },
	--bigbank--
	{ ['x'] = 253.58, ['y'] = 221.03, ['z'] = 106.29 },
	--redline
	{ ['x'] = -573.7978,   ['y'] = -926.7297,  ['z'] = 23.29245},
	-- --dacrew--
	-- { ['x'] = 971.51, ['y'] = -1843.24, ['z'] = 31.26 },
	-- --liberty--
	-- { ['x'] = 324.13, ['y'] = -894.26, ['z'] = 29.28 }
}
local spotsIn = false
local spotsOut = false
local pocketOn = false
local pocketOff = false
local closestZone = 1

spot1 = function()
	local playerPed = GetPlayerPed(-1)
	local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
	local minDistance = 100000
	for i = 1, #hotspots, 1 do
		dist = Vdist(hotspots[i].x, hotspots[i].y, hotspots[i].z, x, y, z)
		if dist < minDistance then
			minDistance = dist
			closestZone = i
		end
	end
end
spot2 = function()
	local player = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(player, true))
	local dist = Vdist(hotspots[closestZone].x, hotspots[closestZone].y, hotspots[closestZone].z, x, y, z)

	if dist <= 50.0 then 
		if not spotsIn then		
			ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
				if quantity >= 1 then
					ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
						if quantity <= 0 then
							Citizen.Wait(100)
							exports['okokNotify']:Alert("NETWORK", "Connecting to wifi.", 3000, 'info')
							Citizen.Wait(5100)
							Connects()	
							TriggerServerEvent("dd_cyberheist:StartConnect")
						else
							exports['okokNotify']:Alert("NETWORK", "Cannot connect to another spot", 3000, 'info')
						end			
					end, 'pocket_wifi')
				else
					exports['okokNotify']:Alert("NETWORK", "Wifi zone!", 3000, 'info')		
				end			
			end, 'ddphone')

			spotsIn = true
			spotsOut = false

		end
	else
		if not spotsOut then
			ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
				if quantity <= 0 then
					--do nothing
				else
					ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
				if quantity >= 1 then
					--do nothing
				else
					Citizen.Wait(100)
					exports['okokNotify']:Alert("NETWORK", "Disconnecting to wifi..", 3000, 'info')	
					Citizen.Wait(5100)		
					Disconnects()								
					TriggerServerEvent("dd_cyberheist:StartdisConnect")
				end		
			end, 'pocket_wifi')
		end			
	end, 'ddphone')

			spotsOut = true
			spotsIn = false

		end
	end
	if spotsIn then
	

	end
	if DoesEntityExist(player) then
	end
end

Citizen.CreateThread(function()
	inLoops.CreateLoop(15000, spot1)
	inLoops.CreateLoop(100, spot2)
end )

-- Citizen.CreateThread(function()
-- 	for k,v in pairs(DD.Satelite) do
-- 		local blip = AddBlipForCoord(v.Blip.Coords)
-- 		SetBlipSprite (blip, v.Blip.Sprite)
-- 		SetBlipDisplay(blip, v.Blip.Display)
-- 		SetBlipScale  (blip, v.Blip.Scale)
-- 		SetBlipColour (blip, v.Blip.Colour)
-- 		SetBlipAsShortRange(blip, true)
-- 		BeginTextCommandSetBlipName('STRING')
-- 		AddTextComponentString('Cyber Heist')
-- 		EndTextCommandSetBlipName(blip)
-- 	end
-- end)

RegisterNetEvent('dd_cyberheist:hacked')
AddEventHandler('dd_cyberheist:hacked', function()
	hacked = true
end)
RegisterNetEvent('dd_cyberheist:unhacked')
AddEventHandler('dd_cyberheist:unhacked', function()
	hacked = false
end)
RegisterNetEvent('dd_cyberheist:copied')
AddEventHandler('dd_cyberheist:copied', function()
	copied = true
end)
RegisterNetEvent('dd_cyberheist:uncopied')
AddEventHandler('dd_cyberheist:uncopied', function()
	copied = false
end)
RegisterNetEvent('dd_cyberheist:transfered')
AddEventHandler('dd_cyberheist:transfered', function()
	transfered = true
end)
RegisterNetEvent('dd_cyberheist:nottransfered')
AddEventHandler('dd_cyberheist:nottransfered', function()
	transfered = false
end)

function Connects()
	SendNUIMessage({
		action = 'connect'
	})
end

function Disconnects()
	SendNUIMessage({
		action = 'disconnect'
	})
end

RegisterNetEvent('dd_cyberheist:sms')
AddEventHandler('dd_cyberheist:sms', function()
	SendNUIMessage({
		action = 'sms'
	})
	Citizen.Wait(12000)
	Xsms()
end)

RegisterNetEvent('dd_cyberheist:twt')
AddEventHandler('dd_cyberheist:twt', function()
	SendNUIMessage({
		action = 'twt'
	})
	Citizen.Wait(12000)
	Xtwt()
end)
function Xsms()
	SendNUIMessage({
		action = 'Xsms'
	})
end
function Xtwt()
	SendNUIMessage({
		action = 'Xtwt'
	})
end
------------------[[HACK INTERNET]]--------------------------
local isShow = true
local blipHacking = nil
RegisterNetEvent('dd_cyberheist:setBlip')
AddEventHandler('dd_cyberheist:setBlip', function()
	blipHacking = AddBlipForCoord(-1052.37, -232.59, 44.02)

	SetBlipSprite(blipHacking, 161)
	SetBlipScale(blipHacking, 2.0)
	SetBlipColour(blipHacking, 1)

	PulseBlip(blipHacking)
	PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1)
end)
RegisterNetEvent('dd_cyberheist:killBlip')
AddEventHandler('dd_cyberheist:killBlip', function()
	RemoveBlip(blipHacking)
end)
RegisterNetEvent('net:hackTelecom')
AddEventHandler('net:hackTelecom', function()
	if not hacked then
		if isShow then
			ESX.TriggerServerCallback('dd_core:Check_Police', function(police)
				if police >= DD.CopsReq then
					ESX.TriggerServerCallback('dd_news:CanStartRobbery', function(CanRob)
						if CanRob then	
							ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(hackable)
								if hackable then
									ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
										if quantity >= 1 then 
											exports['dd_utils']:HideXn()
											isShow = false
											if DD.UseUiHacking then
												local rdm = math.random(0,math.random(0,1))	
												SetEntityCoords(PlayerPedId(), -1056.82, -233.08, 44.02-0.95) --x = -1056.82, y = -233.08, z = 44.02, heading = 339.2
												SetEntityHeading(PlayerPedId(), 339.2)
												while (not HasAnimDictLoaded("anim@heists@ornate_bank@hack")) do
													RequestAnimDict("anim@heists@ornate_bank@hack")
													Citizen.Wait(5)
												end
												TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 1.0, 1.0, -1, 18, 0, 0, 0, 0)
												hackingUI()
												local finished = exports["taskbar"]:taskBar(15000,"Hacking Computer")
												if (finished == 100) then
													if rdm == 0 then
														ClearPedTasks(PlayerPedId())
														
														Citizen.Wait(1000)
														XhackingUI()
														Citizen.Wait(1000)
														failedUI()
														isShow = true
													else
														TriggerServerEvent("dd_cyberheist:StartHack")
														ClearPedTasks(PlayerPedId())
														Citizen.Wait(1000)
														XhackingUI()
														Citizen.Wait(1000)
														successUI()
														isShow = true
														insertUSB = true
														TriggerEvent('net:insertUSB', true)
														TriggerServerEvent('inv_inUse:removeItem', 'black_chip')
													end
												end
											else
												SetEntityCoords(PlayerPedId(), -1056.82, -233.08, 44.02-0.95) --x = -1056.82, y = -233.08, z = 44.02, heading = 339.2
												SetEntityHeading(PlayerPedId(), 339.2)
												while (not HasAnimDictLoaded("anim@heists@ornate_bank@hack")) do
													RequestAnimDict("anim@heists@ornate_bank@hack")
													Citizen.Wait(5)
												end
												TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 1.0, 1.0, -1, 18, 0, 0, 0, 0)
												local finished = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
												if finished ~= 100 then																	
													Citizen.Wait(2000)
													ClearPedTasks(PlayerPedId())
													isShow = true	
												else
													local finished2 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
													if finished2 ~= 100 then
														ClearPedTasks(PlayerPedId())	
														isShow = true
													else 
														local finished3 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
														if finished3 ~= 100 then
															Citizen.Wait(2000)
															ClearPedTasks(PlayerPedId())	
															isShow = true
														else 
															local finished4 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
															if finished4 ~= 100 then
																Citizen.Wait(2000)
																ClearPedTasks(PlayerPedId())	
																isShow = true
															else 
																TriggerServerEvent("dd_cyberheist:StartHack")
																ClearPedTasks(PlayerPedId())
																isShow = true
																insertUSB = true	
																TriggerEvent('net:insertUSB', true)
																TriggerServerEvent('inv_inUse:removeItem', 'black_chip')
															end
														end
													end
												end
											end
										else
											exports['okokNotify']:Alert("", "You need an Intergrated chip!", 3000, 'info')	
										end
									end, 'black_chip')
								end
							end)
						else
							exports['okokNotify']:Alert("NEWS", "A Global Cooldown has been implemented", 3000, 'info')	
						end
					end)
				else
					exports['okokNotify']:Alert("", "Not enough Police to start a Heist", 3000, 'info')	
				end
			end)
		end
	end
end)
RegisterNetEvent('net:insertUSB1')
AddEventHandler('net:insertUSB1', function()
	if not copied then
		if insertUSB then
			ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
				if quantity >= 1 then
					exports['dd_utils']:HideXn()
					insertUSB = false
					if DD.UseUiHacking then
						local rdm = math.random(0,math.random(0,1))	
						SetEntityCoords(PlayerPedId(), -1051.73, -231.46, 44.02-0.95)--x = -1051.73, y = -231.46, z = 44.02, heading = 3.64
						SetEntityHeading(PlayerPedId(), 3.64)
						while (not HasAnimDictLoaded("anim@amb@prop_human_atm@interior@male@enter")) do
							RequestAnimDict("anim@amb@prop_human_atm@interior@male@enter")
							Citizen.Wait(5)
						end
						TaskPlayAnim(PlayerPedId(), "anim@amb@prop_human_atm@interior@male@enter", "enter", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
						local finished = exports["taskbar"]:taskBar(15000,"Booting Flashdrive")
						if (finished == 100) then
							if rdm == 0 then
								exports['okokNotify']:Alert("", "Failed to read Flash Drive, try re-inserting", 3000, 'info')	
								ClearPedTasks(PlayerPedId())
								insertUSB = true
								TriggerEvent('net:insertUSB', true)
							else
								exports['okokNotify']:Alert("", "Flash Drive booted", 3000, 'success')	
								ClearPedTasks(PlayerPedId())
								gettingFiles = true
								TriggerEvent('net:gettingFiles', true)
								insertUSB = false
								TriggerEvent('net:insertUSB', false)
								TriggerServerEvent('inv_inUse:removeItem', 'black_chip')
							end
						end
					else
						SetEntityCoords(PlayerPedId(), -1051.73, -231.46, 44.02-0.95)--x = -1051.73, y = -231.46, z = 44.02, heading = 3.64
						SetEntityHeading(PlayerPedId(), 3.64)
						while (not HasAnimDictLoaded("anim@amb@prop_human_atm@interior@male@enter")) do
							RequestAnimDict("anim@amb@prop_human_atm@interior@male@enter")
							Citizen.Wait(5)
						end
						TaskPlayAnim(PlayerPedId(), "anim@amb@prop_human_atm@interior@male@enter", "enter", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
						local finished = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
						if finished ~= 100 then																	
							Citizen.Wait(2000)
							ClearPedTasks(PlayerPedId())
							insertUSB = true	
							TriggerEvent('net:insertUSB', true)
						else
							local finished2 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
							if finished2 ~= 100 then
								ClearPedTasks(PlayerPedId())	
								insertUSB = true
								TriggerEvent('net:insertUSB', true)
							else 
								local finished3 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
								if finished3 ~= 100 then
									Citizen.Wait(2000)
									ClearPedTasks(PlayerPedId())	
									insertUSB = true
									TriggerEvent('net:insertUSB', true)
								else 
									local finished4 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
									if finished4 ~= 100 then
										Citizen.Wait(2000)
										ClearPedTasks(PlayerPedId())
										insertUSB = true	
										TriggerEvent('net:insertUSB', true)
									else 
										exports['okokNotify']:Alert("", "Flash Drive booted", 3000, 'success')	
									
										ClearPedTasks(PlayerPedId())
										gettingFiles = true
										TriggerEvent('net:gettingFiles', true)
										insertUSB = false
										TriggerEvent('net:insertUSB', false)
										TriggerServerEvent('inv_inUse:removeItem', 'black_chip')
									end
								end
							end
						end
					end
				end
			end,'flashDrive')
		end
	end
end)
RegisterNetEvent('net:transferringMoney')
AddEventHandler('net:transferringMoney', function()
	if not transferredMoney then
		if gettingFiles then
			local rdm = DD.Reward
			gettingFiles = false
			TriggerEvent('net:gettingFiles', false)
			exports['dd_utils']:HideXn()
			-- copiedFile = math.random(1,12)	
			-- if DD.UseUiHacking then
			-- 	SetEntityCoords(PlayerPedId(), -1053.61, -230.57, 44.02-0.95)--x = -1053.61, y = -230.57, z = 44.02, heading = 245.22
			-- 	SetEntityHeading(PlayerPedId(), 245.22)
			-- 	while (not HasAnimDictLoaded("anim@heists@ornate_bank@hack")) do
			-- 		RequestAnimDict("anim@heists@ornate_bank@hack")
			-- 		Citizen.Wait(5)
			-- 	end
			-- 	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
			-- 	copyUI()
			-- 	local finished = exports["taskbar"]:taskBar(15000,"Fetching bank accounts")
			-- 	if (finished == 100) then
			-- 		TriggerServerEvent("dd_cyberheist:StartTransferring", rdm)
			-- 		transferredMoney = true
			-- 		XcopyUI()
			-- 	end
			-- else
				SetEntityCoords(PlayerPedId(), -1053.61, -230.57, 44.02-0.95)--x = -1053.61, y = -230.57, z = 44.02, heading = 245.22
				SetEntityHeading(PlayerPedId(), 245.22)
				while (not HasAnimDictLoaded("anim@heists@ornate_bank@hack")) do
					RequestAnimDict("anim@heists@ornate_bank@hack")
					Citizen.Wait(5)
				end
				TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
				local finished = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
				if finished ~= 100 then																	
					Citizen.Wait(2000)
					ClearPedTasks(PlayerPedId())
					gettingFiles = true	
					TriggerEvent('net:gettingFiles', true)
				else
					local finished2 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
					if finished2 ~= 100 then
						ClearPedTasks(PlayerPedId())
						gettingFiles = true	
						TriggerEvent('net:gettingFiles', true)
					else 
						local finished3 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
						if finished3 ~= 100 then
							Citizen.Wait(2000)
							ClearPedTasks(PlayerPedId())	
							gettingFiles = true
							TriggerEvent('net:gettingFiles', true)
						else 
							local finished4 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
							if finished4 ~= 100 then
								Citizen.Wait(2000)
								ClearPedTasks(PlayerPedId())	
								gettingFiles = true
								TriggerEvent('net:gettingFiles', true)
							else
								local finished5 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
								if finished5 ~= 100 then																	
									Citizen.Wait(2000)
									ClearPedTasks(PlayerPedId())
									gettingFiles = true
									TriggerEvent('net:gettingFiles', true)
								else
									local finished6 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
									if finished6 ~= 100 then
										ClearPedTasks(PlayerPedId())
										gettingFiles = true	
										TriggerEvent('net:gettingFiles', true)
									else 
										local finished7 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
										if finished7 ~= 100 then
											Citizen.Wait(2000)
											ClearPedTasks(PlayerPedId())	
											gettingFiles = true
											TriggerEvent('net:gettingFiles', true)
										else 
											local finished8 = exports["skillbar"]:taskBar(math.random(8000, 10000),math.random(5,15))
											if finished8 ~= 100 then
												Citizen.Wait(2000)
												ClearPedTasks(PlayerPedId())	
												gettingFiles = true
												TriggerEvent('net:gettingFiles', true)
											else 
												TriggerServerEvent("dd_cyberheist:StartTransferring", rdm)
												transferredMoney = true
												gettingFiles = false
												TriggerEvent('net:gettingFiles', false)
												ClearPedTasks(PlayerPedId())
												exports['okokNotify']:Alert("", "Flash Drive burned", 3000, 'success')	
											end
										end
									end
								end
							end
						end
					end
				end
			-- end
		end
	end
end)
hackingUI = function()
	TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'myhack', 0.3) 
	SendNUIMessage({
		action = 'imHacking'
	})
end
XhackingUI = function()
	SendNUIMessage({
		action = 'imNotHacking'
	})
end

successUI = function()
	SendNUIMessage({
		action = 'onSuccess'
	})
	Citizen.Wait(3000)
	XsuccessUI()
end
XsuccessUI = function()
	SendNUIMessage({
		action = 'offSuccess'
	})
end

failedUI = function()
	SendNUIMessage({
		action = 'onFailed'
	})
	Citizen.Wait(3000)
	XfailedUI()
end
XfailedUI = function()
	SendNUIMessage({
		action = 'offFailed'
	})
end

copyUI = function()
	TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'myhack', 0.3) 
	SendNUIMessage({
		action = 'onCopy'
	})
end
XcopyUI = function()
	SendNUIMessage({
		action = 'offCopy'
	})
end

loadingUI = function()
	TriggerServerEvent('dd_sound_sv:PlayWithinDistance', 3, 'activate', 0.3) 
	SendNUIMessage({
		action = 'onLoading'
	})
end
XloadingUI = function()
	SendNUIMessage({
		action = 'offLoading'
	})
end

file1 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '1file'
	})
end
file2 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '2file'
	})
end
file3 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '3file'
	})
end
file4 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '4file'
	})
end
file5 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '5file'
	})
end
file6 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '6file'
	})
end
file7 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '7file'
	})
end
file8 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '8file'
	})
end
file9 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '9file'
	})
end
file10 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '10file'
	})
end
file11 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '11file'
	})
end
file12 = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = '12file'
	})
end
XactivateUI = function()
	SendNUIMessage({
		action = 'offActivate'
	})
end

RegisterNUICallback('escape', function(data, cb)
	ClearPedTasks(PlayerPedId())
	pcOn = false
	SendNUIMessage({action = 'offActivate'})
	SetNuiFocus(false, false)
	PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end)
