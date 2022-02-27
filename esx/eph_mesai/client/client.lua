local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}



ESX                           = nil
local PlayerData              = {}
local Keys                      = {}
local xPlayer                   = {}


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LogIn()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()	
		RequestAnimDict("gestures@f@standing@casual")
		Citizen.Wait(100)
		TaskPlayAnim((ped), 'gestures@f@standing@casual', 'gesture_hand_down', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
		Citizen.Wait(1200)
		ClearPedTasks(ped)
	end)
end

function Typing()
	Citizen.CreateThread(function()
		local ped = PlayerPedId()	
		RequestAnimDict("mp_fbi_heist")
		Citizen.Wait(100)
		TaskPlayAnim((ped), 'mp_fbi_heist', 'loop', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
		Citizen.Wait(5000)
		ClearPedTasks(ped)
	end)
end

function DrawText3D(x,y,z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		  SetTextScale(0.35, 0.35)
		  SetTextFont(4)
		  SetTextProportional(1)
		  SetTextColour(255, 255, 255, 215)
		  SetTextEntry("STRING")
		  SetTextCentre(1)
		  AddTextComponentString(text)
		  DrawText(_x,_y)
		  local factor = (string.len(text)) / 370
		  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 255, 11, 41, 1000)
	  end
end

function OpenDutyMenu()
ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'on_duty',
            {
                title = _U('duty_menu'),
                align = 'right',
                elements = {
                    {label = _U('duty'), value = 'duty'},
		            --{label = _U('leave'), value = 'unemployed'},
                },
            },
        function(data,menu)
menu.close()
        if data.current.value == 'duty' then
            OpenDuty()
        elseif data.current.value == 'unemployed' then
            OpenUnemployed()
        end
    end,
    function(data,menu)
        menu.close()
      end
    )
end   

function OpenUnemployed()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'unemployed',
        {
       title = _U('leave_menu'),
       align = 'right',     
       elements = {
           {label = _U('yes'), value = 'true'},
           {label = _U('no'), value = 'false'}
         }
    },

    function(data,menu)
        if data.current.value == 'true' then
		Typing()
		exports['progressBars']:startUI(5000, _U('leave_true'))
            TriggerServerEvent('russell-duty:unemployed')
	ESX.UI.Menu.CloseAll()
	elseif data.current.value == 'false' then
		ESX.UI.Menu.CloseAll()
           end
    end,
    function(data,menu)
        menu.close()
    end
    )
end

function OpenDuty()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'duty',
        {
       title = _U('duty_select'),
       align = 'right',     
       elements = {
           {label = _U('onduty'), value = 'onduty'},
           {label = _U('offduty'), value = 'offduty'}
         }
    },

    function(data,menu)
        if data.current.value == 'onduty' then
            exports['progressBars']:startUI(1000, _U('log_in'))
		LogIn()
            TriggerServerEvent('russell-duty:onduty')
        ESX.ShowNotification(_U('on_success'))
	ESX.UI.Menu.CloseAll()
        elseif data.current.value == 'offduty' then
            exports['progressBars']:startUI(1000, _U('log_off'))
		LogIn()
            TriggerServerEvent('russell-duty:offduty')
        ESX.ShowNotification(_U('off_success'))
	ESX.UI.Menu.CloseAll()
           end
    end,
    function(data,menu)
        menu.close()
    end
    )
end


Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)
        local sleep = true
        for k,v in pairs(Config.Duty) do

            for b, c in pairs(Config.Jobs) do
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == c then
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Duty[k].x, Config.Duty[k].y, Config.Duty[k].z)
                sleep = false
				if dist <= Config.DrawDistance then
                DrawMarker(21, Config.Duty[k].x, Config.Duty[k].y, Config.Duty[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.1, 1.1, 0.8, 255, 128, 0, 100, false, true, 2, false, false, false, false)
                --DrawMarker(27, Config.Duty[k].x, Config.Duty[k].y, Config.Duty[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				--DrawText3D(Config.Duty[k].x, Config.Duty[k].y, Config.Duty[k].z + 0.9, _U('press_open'))

                        end
                    end
                if sleep then
                    Citizen.Wait(1000)
                end
            end
	    end
    end
end)

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)
        
        for k,v in pairs(Config.Duty) do

            for b, c in pairs(Config.Jobs) do
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == c then
            
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Duty[k].x, Config.Duty[k].y, Config.Duty[k].z)

            if dist <= 0.5 then
                hintToDisplay(_U('press_open'))
            for k,v in pairs(Config.Jobs) do
            if IsControlJustPressed(0, 38) and ESX.PlayerData.job and v ==  ESX.PlayerData.job.name then
                OpenDutyMenu()
      	 		    		end
 				        end
			        end
                end
            end
		end
	end
end)
