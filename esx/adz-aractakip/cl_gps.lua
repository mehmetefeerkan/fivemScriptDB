ESX = nil
local vehiclegps = nil
local utilise = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent("gps:track")
AddEventHandler("gps:track", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    vehiclegps = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
    utilise = true
    while utilise do
      Citizen.Wait(0)
        if utilise ~= nil then
            if IsEntityAVehicle(vehiclegps) then
                local position = GetEntityCoords(vehiclegps)
                 auto = AddBlipForCoord(position.x, position.y, position.z)
          SetBlipSprite(auto, 163)
          SetBlipDisplay(auto, 4)
          SetBlipScale(auto, 0.7)
          SetBlipColour(auto, 1)
          SetBlipAsShortRange(auto, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString("Vehicule")
          EndTextCommandSetBlipName(auto)
         Citizen.Wait(Config.Refresh * 1000)
          RemoveBlip(auto)
          if Config.SelectionGPS then
          SetNewWaypoint(position.x, position.y)
end
            end
        else
            utilise = false
        end
    end
end)

RegisterNetEvent("gps:desactiver")
AddEventHandler("gps:desactiver", function()
    if utilise == true then
        utilise = false
    end
end)

RegisterNetEvent("gps:menu")
AddEventHandler("gps:menu", function()
    Menu()
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(7)
      if utilise then
     drawTxt(0.66, 1.44, 1.0,1.0,0.5, '~h~~g~Sinyali takip et GPS', 255, 255, 255, 255)
      end
    end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 1,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function Menu()
	local elements = {}
		table.insert(elements, {label = 'GPS ekle',  value = 'inserer'})
        table.insert(elements, {label = 'GPS izlemeyi devre dışı bırak',  value = 'desactiver'})
    ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'gps',
	{
		title    = 'GPS',
		align    = 'center',
		elements = elements
	},
	function(data, menu)

    if data.current.value == 'inserer' then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
    vehiclegps = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
    local position = GetEntityCoords(vehiclegps)
    if utilise == true then 
ESX.ShowNotification("~h~~r~Zaten aracı takip ediyorsun!")
else
     if GetDistanceBetweenCoords(pos, position,  true) < 2 then
                utilise = true
                TaskStartScenarioInPlace(ped, "world_human_vehicle_mechanic", 0, true)
                Citizen.Wait(Config.Temps * 1000)
                TriggerEvent("gps:track")
                ESX.ShowNotification("~h~Aracı takip et. Model: ~g~" ..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehiclegps))))
                ClearPedTasksImmediately(ped)
else 
ESX.ShowNotification("~h~~r~Yakında araç yok!")
end
end

elseif data.current.value == 'desactiver' then
if utilise == true then
utilise = false
ESX.ShowNotification("~h~~y~GPS izlemeyi devre dışı bırak!")
TriggerEvent("gps:desactiver")
TriggerServerEvent('gps:supprimer')
else 
ESX.ShowNotification("~h~~r~Hiçbir aracı takip etmiyorsun!")
end

      

end
		menu.close()
	end)
end