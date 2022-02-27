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

scanId = 0
cityRobbery = false
local myspawns = {}
CCTVCamLocations = {
	[1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ['info'] = ' Store Camera 1', ["recent"] = false },
	[2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ['info'] = ' Store Camera 2', ["recent"] = false },
	[3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ['info'] = ' Store Camera 3', ["recent"] = false },
	[4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ['info'] = ' Store Camera 4', ["recent"] = false },
	[5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ['info'] = ' Store Camera 5', ["recent"] = false },
	[6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9, ['info'] = ' Store Camera 6', ["recent"] = false },
	[7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ['info'] = ' Store Camera 7', ["recent"] = false },
	[8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ['info'] = ' Store Camera 8', ["recent"] = false },
	[9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43, ['info'] = ' Store Camera 9', ["recent"] = false },
	[10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35, ['info'] = ' Store Camera 10', ["recent"] = false },
	[11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01, ['info'] = ' Store Camera 11', ["recent"] = false },
	[12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ['info'] = ' Store Camera 12', ["recent"] = false },
	[13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ['info'] = ' Store Camera 13', ["recent"] = false }, --
	[14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ['info'] = ' Store Camera 14', ["recent"] = false },
	[15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ['info'] = ' Store Camera 15', ["recent"] = false },
	[16] =  { ['x'] = 1392.88,['y'] = 3606.7,['z'] = 34.99,['h'] = 201.69, ['info'] = ' Store Camera 16', ["recent"] = false },
	[17] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ['info'] = ' Store Camera 17', ["recent"] = false },
	[18] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ['info'] = ' Store Camera 18', ["recent"] = false },
	[19] =  { ['x'] = 733.45,['y'] = 127.58,['z'] = 80.69,['h'] = 285.51, ['info'] = ' Cam Power' },
	[20] =  { ['x'] = 1846.32,['y'] = 2597.93,['z'] = 45.64,['h'] = 311.88, ['info'] = ' Cam Jail Front' },
	[21] =  { ['x'] = 1807.71,['y'] = 2590.62,['z'] = 45.64,['h'] = 143.41, ['info'] = ' Cam Jail Prisoner Drop Off' },
	[22] =  { ['x'] = -627.46,['y'] = -229.45,['z'] = 38.8,['h'] = 163.15, ['info'] = ' Cam Jewelry Store' },
	[23] =  { ['x'] = -108.11,['y'] = 6463.04,['z'] = 32.05,['h'] = 3.57, ['info'] = ' Cam Paleto Bank Outside' },
	[24] =  { ['x'] = 232.78,['y'] = 221.84,['z'] = 107.23,['h'] = 221.8, ['info'] = ' Cam Main Bank 1' },
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	  PlayerData = ESX.GetPlayerData()
	end
  end)


-- Citizen.CreateThread(function()
-- while true do
	-- sleep = 2000
	-- local ped = PlayerPedId()
	-- local kordinat = GetEntityCoords(ped)
	-- local dist = GetDistanceBetweenCoords(kordinat, 440.35, -975.73, 30.69, true) 
	-- if dist < 3.0 then
		-- sleep = 5
	-- end
	-- if dist < 2.0 then
		-- DrawText3D(440.35, -975.73, 30.69, ('~g~[E]~s~ Kameralara Bak'))
		-- if IsControlJustReleased(0, 46) then
			-- cctvmenu()
		-- end
	-- end
	-- Citizen.Wait(sleep)
-- end
-- end)

function stopAnim()
	temp = false
	StopAnimTask(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteObject(tab)
end

function attachObject()
	tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end

function startAnim()
	if not temp then
		RequestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
		while not HasAnimDictLoaded("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a") do
			Citizen.Wait(0)
		end
		attachObject()
		TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
		temp = true
	end
end

function cctvmenu()
startAnim()
local elements = {}
ESX.UI.Menu.CloseAll()

ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'cctvm',
  {
    title    = ('Güvenlik Kameraları'),
    align = 'top-left',
    elements = { 
      {label = ('Marketler'),     value = 'marketler'},
	  {label = ('Federal Hapishane'),     value = 'camenu20'},
	  {label = ('Federal Hapishane(2)'),     value = 'camenu21'},
	  {label = ('Mücevher Dükkanı'),     value = 'camenu22'},
	  {label = ('Blaine County Saving Banks'),     value = 'camenu23'},
	  {label = ('Merkez Bankası'),     value = 'camenu24'}
    }
  },
  function(data, menu)
    if data.current.value == 'marketler' then
      menu.close()
	  cctvShops()
	elseif data.current.value == 'camenu20' then
	  TriggerEvent('cam20')
	elseif data.current.value == 'camenu21' then
	  TriggerEvent('cam21')
	elseif data.current.value == 'camenu22' then
	  TriggerEvent('cam22')
	elseif data.current.value == 'camenu23' then
	  TriggerEvent('cam23')
	elseif data.current.value == 'camenu24' then
	  TriggerEvent('cam24')
	  end
  end,
  function(data, menu)
      menu.close() 
	  inCam = false
	  ClearPedTasks(PlayerPedId())
	  stopAnim()
  end
)
end

function cctvShops()
	ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'cctvShops',
  {
    title    = ('Market Kameraları'),
    align = 'center',
    elements = { 
      {label = ('Market (Şehir-1)'),     value = 'camenu1'},
      {label = ('Market (Şehir-2)'),     value = 'camenu2'},
	  {label = ('Market (Şehir-3)'),     value = 'camenu3'},
	  {label = ('Market (Şehir-4)'),     value = 'camenu4'},
	  {label = ('Market (Şehir-5)'),     value = 'camenu5'},
	  {label = ('Market (Şehir-6)'),     value = 'camenu6'},
	  {label = ('Market (Şehir-7)'),     value = 'camenu7'},
	  {label = ('Market (Otoyol-1)'),     value = 'camenu8'},
	  {label = ('Market (Otoyol-2)'),     value = 'camenu9'},
	  {label = ('Market (Otoyol-3)'),     value = 'camenu10'},
      {label = ('Market (Otoyol-4)'),     value = 'camenu11'},
      {label = ('Market (Kasaba-1)'),     value = 'camenu12'},
	  {label = ('Market (Kasaba-2)'),     value = 'camenu13'},
	  {label = ('Market (Kasaba-3)'),     value = 'camenu14'},
	  {label = ('Market (Kasaba-4)'),     value = 'camenu15'},
	  {label = ('Market (Kasaba-5)'),     value = 'camenu16'},
	  {label = ('Market (Kasaba-6)'),     value = 'camenu17'},
	  {label = ('Market (Kasaba-7)'),     value = 'camenu18'}
    }
  },
  function(data2, menu2)
	if data2.current.value == 'camenu1' then
	  TriggerEvent('cam1')
	elseif data2.current.value == 'camenu2' then
	  TriggerEvent('cam2')
	elseif data2.current.value == 'camenu3' then
	  TriggerEvent('cam3')
	elseif data2.current.value == 'camenu4' then
	  TriggerEvent('cam4')
	elseif data2.current.value == 'camenu5' then
	  TriggerEvent('cam5')
	elseif data2.current.value == 'camenu6' then
	  TriggerEvent('cam6')
	elseif data2.current.value == 'camenu7' then
	  TriggerEvent('cam7')
	elseif data2.current.value == 'camenu8' then
	  TriggerEvent('cam8')
	elseif data2.current.value == 'camenu9' then
	  TriggerEvent('cam9')
	elseif data2.current.value == 'camenu10' then
	  TriggerEvent('cam10')
	elseif data2.current.value == 'camenu11' then
	  TriggerEvent('cam11')
	elseif data2.current.value == 'camenu12' then
	  TriggerEvent('cam12')
	elseif data2.current.value == 'camenu13' then
	  TriggerEvent('cam13')
	elseif data2.current.value == 'camenu14' then
	  TriggerEvent('cam14')
	elseif data2.current.value == 'camenu15' then
	  TriggerEvent('cam15')
	elseif data2.current.value == 'camenu16' then
	  TriggerEvent('cam16')
	elseif data2.current.value == 'camenu17' then
	  TriggerEvent('cam17')
	elseif data2.current.value == 'camenu18' then
	  TriggerEvent('cam18')
	elseif data2.current.value == 'camenu19' then
	  TriggerEvent('cam19')
	end
	end,
	 function(data2, menu2)
      menu2.close()
	  cctvmenu()
	  inCam = false
	 end
)
end


--KAMERALAR
RegisterNetEvent('cam1')
AddEventHandler('cam1', function()
ExecuteCommand("scam 1")
end)
RegisterNetEvent('cam2')
AddEventHandler('cam2', function()
ExecuteCommand("scam 2")
end)
RegisterNetEvent('cam3')
AddEventHandler('cam3', function()
ExecuteCommand("scam 3")
end)
RegisterNetEvent('cam4')
AddEventHandler('cam4', function()
ExecuteCommand("scam 4")
end)
RegisterNetEvent('cam5')
AddEventHandler('cam5', function()
ExecuteCommand("scam 5")
end)
RegisterNetEvent('cam6')
AddEventHandler('cam6', function()
ExecuteCommand("scam 6")
end)
RegisterNetEvent('cam7')
AddEventHandler('cam7', function()
ExecuteCommand("scam 7")
end)
RegisterNetEvent('cam8')
AddEventHandler('cam8', function()
ExecuteCommand("scam 8")
end)
RegisterNetEvent('cam9')
AddEventHandler('cam9', function()
ExecuteCommand("scam 9")
end)
RegisterNetEvent('cam10')
AddEventHandler('cam10', function()
ExecuteCommand("scam 10")
end)
RegisterNetEvent('cam11')
AddEventHandler('cam11', function()
ExecuteCommand("scam 11")
end)
RegisterNetEvent('cam12')
AddEventHandler('cam12', function()
ExecuteCommand("scam 12")
end)
RegisterNetEvent('cam13')
AddEventHandler('cam13', function()
ExecuteCommand("scam 13")
end)
RegisterNetEvent('cam14')
AddEventHandler('cam14', function()
ExecuteCommand("scam 14")
end)
RegisterNetEvent('cam15')
AddEventHandler('cam15', function()
ExecuteCommand("scam 15")
end)
RegisterNetEvent('cam16')
AddEventHandler('cam16', function()
ExecuteCommand("scam 16")
end)
RegisterNetEvent('cam17')
AddEventHandler('cam17', function()
ExecuteCommand("scam 17")
end)
RegisterNetEvent('cam18')
AddEventHandler('cam18', function()
ExecuteCommand("scam 18")
end)
RegisterNetEvent('cam19')
AddEventHandler('cam19', function()
ExecuteCommand("scam 19")
end)
RegisterNetEvent('cam20')
AddEventHandler('cam20', function()
ExecuteCommand("scam 20")
end)
RegisterNetEvent('cam21')
AddEventHandler('cam21', function()
ExecuteCommand("scam 21")
end)
RegisterNetEvent('cam22')
AddEventHandler('cam22', function()
ExecuteCommand("scam 22")
end)
RegisterNetEvent('cam23')
AddEventHandler('cam23', function()
ExecuteCommand("scam 23")
end)
RegisterNetEvent('cam24')
AddEventHandler('cam24', function()
ExecuteCommand("scam 24")
end)
--KAMERA SON

RegisterCommand("scam", function (source, args, rawCommand)

	local cam = args[1]

	local xPlayer = ESX.GetPlayerData()
	local job = xPlayer.job
	local jobname = xPlayer.job.name
	if job and (jobname == 'police' or jobname == 'sheriff') then
		ESX.TriggerServerCallback('esx_policejob:getItem', function(quantity)
			if quantity > 0 then
			if cam == nil then
			cctvmenu()
			else
			TriggerEvent('cctv:camera', cam)
			end
			else
			-- exports['mythic_notify']:SendAlert('error', "Üzerinde polis tableti yok")
			TriggerEvent('notification', 'Üzerinde polis tableti yok', 2)
			end
		end, 'ptab')
	else
		-- exports['mythic_notify']:SendAlert('error', "Polis/Sheriff değilsin")
		TriggerEvent('notification', 'Polis/Sheriff değilsin', 2)
	end

end)

inCam = false
cctvCam = 0
RegisterNetEvent("cctv:camera")
AddEventHandler("cctv:camera", function(camNumber)
	local ped = GetEntityCoords(PlayerPedId())
	local distance = GetDistanceBetweenCoords(ped, 440.35, -975.73, 30.69, true)
	
	if distance < 10000 then
		letSleep = 5
	end
	
	if distance < 10000 then
	camNumber = tonumber(camNumber)
	if inCam then
		inCam = false
		PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
		-- TriggerEvent('animation:tablet',false)
		Wait(250)
		-- ClearPedTasks(PlayerPedId())
	else
		if camNumber > 0 and camNumber < #CCTVCamLocations+1 then
			PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
			TriggerEvent("cctv:startcamera",camNumber)
		end
		Citizen.Wait(letSleep)
		end
		else
		TriggerEvent('notification', 'Kamerayı buradan çalıştıramazsın!', 2)
	end
end)

RegisterNetEvent("cctv:startcamera")
AddEventHandler("cctv:startcamera", function(camNumber)

	-- TriggerEvent('animation:tablet',true)
	local camNumber = tonumber(camNumber)
	local x = CCTVCamLocations[camNumber]["x"]
	local y = CCTVCamLocations[camNumber]["y"]
	local z = CCTVCamLocations[camNumber]["z"]
	local h = CCTVCamLocations[camNumber]["h"]
	local ped = GetEntityCoords(PlayerPedId())
	local distance = GetDistanceBetweenCoords(ped, 440.35, -975.73, 30.69, true)


	if distance < 10000 then
		letSleep = 5
	end
	
	if distance < 10000 then
	inCam = true

	SetTimecycleModifier("heliGunCam")
	SetTimecycleModifierStrength(1.0)
	-- local scaleform = RequestScaleformMovie("TRAFFIC_CAM")
	-- while not HasScaleformMovieLoaded(scaleform) do
		-- Citizen.Wait(0)
	-- end

	local Ped = PlayerPedId()
	cctvCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(cctvCam,x,y,z+1.2)						
	SetCamRot(cctvCam, -15.0,0.0,h)
	SetCamFov(cctvCam, 110.0)
	RenderScriptCams(true, false, 0, 1, 0)
	--PushScaleformMovieFunction(scaleform, "PLAY_CAM_MOVIE")
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	PopScaleformMovieFunctionVoid()

	while inCam do
		SetCamCoord(cctvCam,x,y,z+1.2)						
		-- SetCamRot(cctvCam, -15.0,0.0,h)
		PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
		PushScaleformMovieFunctionParameterFloat(GetEntityCoords(h).z)
		PushScaleformMovieFunctionParameterFloat(1.0)
		PushScaleformMovieFunctionParameterFloat(GetCamRot(cctvCam, 2).z)
		PopScaleformMovieFunctionVoid()
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		Citizen.Wait(1)
	end
	end
	ClearFocus()
	ClearTimecycleModifier()
	RenderScriptCams(false, false, 0, 1, 0)
	SetScaleformMovieAsNoLongerNeeded(scaleform)
	DestroyCam(cctvCam, false)
	SetNightvision(false)
	SetSeethrough(false)	
	Citizen.Wait(letSleep)
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if inCam then

			local rota = GetCamRot(cctvCam, 2)

			if IsControlPressed(1, Keys['N4']) then
				SetCamRot(cctvCam, rota.x, 0.0, rota.z + 0.7, 2)
			end

			if IsControlPressed(1, Keys['N6']) then
				SetCamRot(cctvCam, rota.x, 0.0, rota.z - 0.7, 2)
			end

			if IsControlPressed(1, Keys['N8']) then
				SetCamRot(cctvCam, rota.x + 0.7, 0.0, rota.z, 2)
			end

			if IsControlPressed(1, Keys['N5']) then
				SetCamRot(cctvCam, rota.x - 0.7, 0.0, rota.z, 2)
			end
		end
	end
end)

function DrawText3D(x,y,z, text)
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