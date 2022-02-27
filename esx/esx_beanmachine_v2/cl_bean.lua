PlayerData = {}
ESX = nil

-- Setup ESX Core
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

-- Takes Player Job After /setjob
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
end)



function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end



Citizen.CreateThread(function()
    local distance = 1000
    while true do
        Citizen.Wait(1)
        local nearby = false
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        distance = #(vector3(-627.69, 223.66, 81.88) - coords)
        if distance < 10.0 then nearby = true end
        if distance < 3.0 then
            if PlayerData.job and PlayerData.job.name == 'beanmachine' then
                DrawText3D(-627.69, 223.66, 81.88, ('[E] Içecek Hazırla'))
                if IsControlJustReleased(0, 46) then
                    icecekhazirla()
                end
            end
        end
        if not nearby then
            Citizen.Wait(distance)
        end
    end
end)

function icecekhazirla()
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.Items, 1 do
			table.insert(elements, {labels =  Config.Items[i].label, label =  Config.Items[i].label .. ' ',	value = Config.Items[i].item})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'icecekbm',
			{
			title    = 'İçecek Hazırla',
			align    = 'right',
			elements = elements
			},
			function(data, menu)
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'icecekbema', {
				title = 'Kaç tane hazırlayacaksın?'
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('icelimmi', id, data.current.value, tonumber(data2.value), data.current.labels)
				end, function(data2, menu2)
					menu2.close()
				end)

		end,
		function(data, menu)
		menu.close()
	end)
end


RegisterNetEvent('icecekhazirladim')
AddEventHandler('icecekhazirladim', function()
	local playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	loadAnimDict( "mini@repair" ) 
	TaskPlayAnim( playerPed, "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
	exports["t0sic_loadingbar"]:StartDelayedFunction("İçecek hazırlanıyor", 9700, function()
	ClearPedTasks(playerPed)
	end)
end)


function DrawText3D(x,y,z, text)
	local camrec = GetGameplayCamCoords()
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(camrec)
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

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-627.69, 223.66, 81.88)
	SetBlipSprite(blip, 106)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 21)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Bean Machine')
	EndTextCommandSetBlipName(blip)
end)
