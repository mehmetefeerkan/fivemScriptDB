ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local Ped = PlayerPedId()

        for k,v in pairs(Config.Zones) do
            if Vdist2(GetEntityCoords(Ped, false), v.x, v.y, v.z) < 20  then
                DrawMarker(2, v.x, v.y, v.z-0.10, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if Vdist2(GetEntityCoords(Ped, false), v.x, v.y, v.z) < 0.5 then
                    DrawText3D(v.x, v.y, v.z, v.DravText)
                    if IsControlJustPressed(0, 311) then
                        if v.ItemGerek then

                            ESX.TriggerServerCallback('keke31:getItemAmount', function(quantity)
                                if quantity >= v.GerekItemAdet then
                                    loadAnimDict(v.Dict)
                                    TaskPlayAnim(Ped, v.Dict, v.Anim, 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
                                    FreezeEntityPosition(Ped, true)
                                    exports["t0sic_loadingbar"]:StartDelayedFunction(v.BarText, 10000, function()
                                        ClearPedTasks(Ped)
                                        FreezeEntityPosition(Ped, false)
                                        TriggerServerEvent('keke31job:add', v.ItemIsim, v.ItemAdet)
                                        TriggerServerEvent('keke31job:remove', v.GerekItemIsim, v.GerekItemAdet)
                                    end)
                                else
                                    TriggerEvent("notification", "Üzerinde gerekli eşyalar yok",  2)
                                end
                            end, v.GerekItemIsim)

                        else

                            loadAnimDict(v.Dict)
                            TaskPlayAnim(Ped, v.Dict, v.Anim, 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
                            FreezeEntityPosition(Ped, true)
                            exports["t0sic_loadingbar"]:StartDelayedFunction(v.BarText, 10000, function()
                                ClearPedTasks(Ped)
                                FreezeEntityPosition(Ped, false)
                                TriggerServerEvent('keke31job:add', v.ItemIsim, v.ItemAdet)
                            end)

                        end
                    Citizen.Wait(10300)
                    end
                end
            end
        end

    end
end)


if Config.ShowBlips then
	Citizen.CreateThread(function()
		for k,v in pairs(Config.Zones) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite (blip, v.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.6)
			SetBlipColour (blip, v.color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.BlipName)
			EndTextCommandSetBlipName(blip)
		end
	end)
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end

function DrawText3D(x,y,z,text,size)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35,0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)
end