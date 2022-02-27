-------------[[JEWELRY]]-----------------
ESX = nil
local ct = Citizen.CreateThread
ct(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	-- if GetClockHours() >= Jewel.TimeToStartTrigger and GetClockHours() <= Jewel.TimeToEndTrigger - 1 then
	-- 	TriggerEvent('jewel:onTime', true)
	-- end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
local jewelRobsBlip = nil
-- ct(function()
-- 	for k,v in pairs(Jewel.Zones) do
-- 	local blip = AddBlipForCoord(v.Blip.Coords)
  
--  		SetBlipSprite (blip, v.Blip.Sprite)
--  		SetBlipDisplay(blip, v.Blip.Display)
--  		SetBlipScale  (blip, v.Blip.Scale)
--  		SetBlipColour (blip, v.Blip.Colour)
--  		SetBlipAsShortRange(blip, true)
	
-- 	BeginTextCommandSetBlipName("STRING")
--   	AddTextComponentString("Jewelry Shop")
--   	EndTextCommandSetBlipName(blip)
-- 	end
-- end)
local jewel1,jewel2,jewel3,jewel4,jewel5,jewel6,jewel7,jewel8,jewel9,jewel10,jewel11,jewel12,jewel13,jewel14,jewel15 = false,false,false,false,false,false,false,false,false,false,false,false,false,false,false

RegisterNetEvent('jewel:hackPC')
AddEventHandler('jewel:hackPC', function()
	if GetClockHours() >= Jewel.TimeToStartTrigger and GetClockHours() <= Jewel.TimeToEndTrigger - 1 then
		ESX.TriggerServerCallback('dd_core:Check_Police', function(police)
			if police >= Jewel.JewelCop then
				ESX.TriggerServerCallback('dd_news:CanStartRobbery', function(CanRob)
					if CanRob then
						ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
							if quantity >= 1 then	
								SetEntityCoords(PlayerPedId(), -631.32, -230.07, 38.06-0.95)--x=-631.32, y=-230.07, z=38.06, heading=209.47
								SetEntityHeading(PlayerPedId(), 209.47)
								local rdm = math.random(0,math.random(0,1))	
								while (not HasAnimDictLoaded("anim@heists@ornate_bank@hack")) do
									RequestAnimDict("anim@heists@ornate_bank@hack")
									Citizen.Wait(5)
								end
								TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
								local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
								if finished ~= 100 then
									Citizen.Wait(2000)
									ClearPedTasks(PlayerPedId())		   
								else
									jewel1 = true	
									TriggerEvent('jewel:enable', 1)
									exports['okokNotify']:Alert("", "Successfully hacked PC!!!", 5000, 'warning')
									ClearPedTasks(PlayerPedId())
									jewelHeistSetBlip(-631.32, -230.07, 38.06)
									TriggerEvent('jewel:onRob', true)
									TriggerServerEvent("dd_news:PostNews", 'Jewelry')
									isShow = true
								end	
							else
								SetEntityCoords(PlayerPedId(), -631.32, -230.07, 38.06-0.95)--x=-631.32, y=-230.07, z=38.06, heading=209.47
								SetEntityHeading(PlayerPedId(), 209.47)
								local rdm = math.random(0,math.random(0,1))	
								while (not HasAnimDictLoaded("anim@heists@ornate_bank@hack")) do
									RequestAnimDict("anim@heists@ornate_bank@hack")
									Citizen.Wait(5)
								end
								TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@hack", "hack_loop", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
								local finished = exports["taskbar"]:taskBar(15000,"Hacking Computer")
								if (finished == 100) then
									if rdm == 0 then
										exports['okokNotify']:Alert("", "Failed to hack PC!!! Try again.", 5000, 'warning')
										ClearPedTasks(PlayerPedId())
										isShow = true
									else
										jewel1 = true	
										TriggerEvent('jewel:enable', 1)
										exports['okokNotify']:Alert("", "Successfully hacked PC!!!", 5000, 'warning')
										ClearPedTasks(PlayerPedId())
										jewelHeistSetBlip(-631.32, -230.07, 38.06)
										TriggerEvent('jewel:onRob', true)
										TriggerServerEvent("dd_news:StartTimer")
										TriggerServerEvent("dd_news:PostNews", 'Jewelry')
										isShow = true
									end
								end								
							end
						end,'hackerDevice')

					end
				end)
			else
				exports['okokNotify']:Alert("", "Not enough Cop to start a heist!", 5000, 'warning')
			end
		end)
	else
		exports['okokNotify']:Alert("", "Too early to start a robbery", 5000, 'warning')
	end
end)
RegisterNetEvent('jewel:robjewel1')
AddEventHandler('jewel:robjewel1', function(x,y,z,h,i)
	if jewel1 then
		jewel1 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel2 = true	
		TriggerEvent('jewel:enable', 2)
	end
end)
RegisterNetEvent('jewel:robjewel2')
AddEventHandler('jewel:robjewel2', function(x,y,z,h,i)
	if jewel2 then
		jewel2 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel3 = true	
		TriggerEvent('jewel:enable', 3)
	end
end)
RegisterNetEvent('jewel:robjewel3')
AddEventHandler('jewel:robjewel3', function(x,y,z,h,i)
	if jewel3 then
		jewel3 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel4 = true	
		TriggerEvent('jewel:enable', 4)
	end
end)
RegisterNetEvent('jewel:robjewel4')
AddEventHandler('jewel:robjewel4', function(x,y,z,h,i)
	if jewel4 then
		jewel4 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel5 = true	
		TriggerEvent('jewel:enable', 5)
	end
end)
RegisterNetEvent('jewel:robjewel5')
AddEventHandler('jewel:robjewel5', function(x,y,z,h,i)
	if jewel5 then
		jewel5 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel6 = true	
		TriggerEvent('jewel:enable', 6)
	end
end)
RegisterNetEvent('jewel:robjewel6')
AddEventHandler('jewel:robjewel6', function(x,y,z,h,i)
	if jewel6 then
		jewel6 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel7 = true	
		TriggerEvent('jewel:enable', 7)
	end
end)
RegisterNetEvent('jewel:robjewel7')
AddEventHandler('jewel:robjewel7', function(x,y,z,h,i)
	if jewel7 then
		jewel7 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel8 = true	
		TriggerEvent('jewel:enable', 8)
	end
end)
RegisterNetEvent('jewel:robjewel8')
AddEventHandler('jewel:robjewel8', function(x,y,z,h,i)
	if jewel8 then
		jewel8 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel9 = true	
		TriggerEvent('jewel:enable', 9)
	end
end)
RegisterNetEvent('jewel:robjewel9')
AddEventHandler('jewel:robjewel9', function(x,y,z,h,i)
	if jewel9 then
		jewel9 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel10 = true	
		TriggerEvent('jewel:enable', 10)
	end
end)
RegisterNetEvent('jewel:robjewel10')
AddEventHandler('jewel:robjewel10', function(x,y,z,h,i)
	if jewel10 then
		jewel10 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel11 = true	
		TriggerEvent('jewel:enable', 11)
	end
end)
RegisterNetEvent('jewel:robjewel11')
AddEventHandler('jewel:robjewel11', function(x,y,z,h,i)
	if jewel11 then
		jewel11 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel12 = true
		TriggerEvent('jewel:enable', 12)	
	end
end)
RegisterNetEvent('jewel:robjewel12')
AddEventHandler('jewel:robjewel12', function(x,y,z,h,i)
	if jewel12 then
		jewel12 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel13 = true	
		TriggerEvent('jewel:enable', 13)
	end
end)
RegisterNetEvent('jewel:robjewel13')
AddEventHandler('jewel:robjewel13', function(x,y,z,h,i)
	if jewel13 then
		jewel13 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel14 = true	
		TriggerEvent('jewel:enable', 14)
	end
end)
RegisterNetEvent('jewel:robjewel14')
AddEventHandler('jewel:robjewel14', function(x,y,z,h,i)
	if jewel14 then
		jewel14 = false	
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
		jewel15 = true	
		TriggerEvent('jewel:enable', 15)
	end
end)
RegisterNetEvent('jewel:robjewel15')
AddEventHandler('jewel:robjewel15', function(x,y,z,h,i)
	if jewel15 then
		jewel15 = false		
		SetEntityCoords(PlayerPedId(), x, y, z-0.95)
		SetEntityHeading(PlayerPedId(), h)
		PlaySoundFromCoord(-1, "Glass_Smash", x, y, z, "", 0, 0, 0)
		if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
		end
		while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Citizen.Wait(0)
		end
		SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimDict( "missheist_jewel" ) 
		TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('jewel:StartLooting')
		TriggerServerEvent('jewel:endoHeist')
		TriggerEvent('jewel:enable', 0)
		jewelHeistKillBlip()
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)		
	end
end)

jewelHeistSetBlip = function(x,y,z)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'ambulance') then
		jewelRobsBlip = AddBlipForCoord(x,y,z)
		SetBlipSprite(jewelRobsBlip, 161)
		SetBlipScale(jewelRobsBlip, 2.0)
		SetBlipColour(jewelRobsBlip, 1)
		PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1)
		return jewelRobsBlip
		
	end
end
jewelHeistKillBlip = function()
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'ambulance')  then
		RemoveBlip(jewelRobsBlip)
	end
end
function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 
