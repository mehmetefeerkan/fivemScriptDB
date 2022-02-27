local PlayerData = {}
ESX = nil
 
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
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local wait = 1000
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(wait)
        if coords(1004.541, -1572.90, 30.815, 1) or coords(1088.694, -3187.70, -38.99, 1) or coords(1090.331, -3195.70, -38.99, 1) or coords(1093.127, -3195.70, -38.99, 1) or coords(809.89, -490.92, 30.63, 1) or coords(996.85, -3200.67, -36.39, 1) or coords(1005.747, -3201.20, -38.51, 1) or coords(1012.144, -3194.20, -38.99, 1) or coords(2642.902, 4740.702, 35.118, 13) then
            wait = 1
            


            -- Maydanoz  
            if coords(1004.541, -1572.90, 30.815, 1) then -- giriş
                DrawText3D(1004.541, -1572.90, 30.815, '[E]')
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetEntityCoords(PlayerPedId(), 1088.694, -3187.90, -39.89, 0.0, 0.0, 0.0)
                    Citizen.Wait(5000)
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            end

            if coords(1088.694, -3187.70, -38.99, 1) then -- Çıkış
                DrawText3D(1088.694, -3187.70, -38.99, '[E]')
                if IsControlJustPressed(0, 38) then
                    SetEntityCoords(PlayerPedId(), 1004.541, -1572.90, 30.815, 0.0, 0.0, 0.0)
                end
            end

            if coords(1090.331, -3195.70, -38.99, 1) then
                DrawText3D(1090.331, -3195.70, -38.99, '~g~E~w~ - Maydanoz Isleme')
                if IsControlJustPressed(0, 119) then
                    TriggerEvent("mythic_progbar:client:progress", {duration = 10000, label = "İşliyorsun", useWhileDead = true, canCancel = true, controlDisables = { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, }, animation = { animfreeze = true, animDict = "mini@repair", anim = "fixing_a_player", } }, function(status)
                        if not status then
                            ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                if quantity >= 1 then 
                                    ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                        if quantity >= 5 then 
                                            TriggerServerEvent('emrdrug:add', "maydanoz5g", 5)
                                            TriggerServerEvent('emrdrug:remove', "maydanoz25g", 1)
                                            TriggerServerEvent('emrdrug:remove', "drugbag", 5)
                                        else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                                    end, "drugbag")
                                else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                            end, "maydanoz25g")
                        end
                    end)
                end
            end

            if coords(1093.127, -3195.70, -38.99, 1) then
                DrawText3D(1093.127, -3195.70, -38.99, '~g~E~w~ - Maydanoz Paketleme')
                if IsControlJustPressed(0, 119) then
                    TriggerEvent("mythic_progbar:client:progress", {duration = 10000, label = "Paketliyorsun", useWhileDead = true, canCancel = true, controlDisables = { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, }, animation = { animfreeze = true, animDict = "mini@repair", anim = "fixing_a_player", } }, function(status)
                        if not status then
                            ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                if quantity >= 1 then 
                                    ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                        if quantity >= 5 then 
                                            TriggerServerEvent('emrdrug:add', "maydanoz1g", 5)
                                            TriggerServerEvent('emrdrug:remove', "maydanoz5g", 1)
                                            TriggerServerEvent('emrdrug:remove', "drugbag", 5)
                                        else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                                    end, "drugbag")
                                else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                            end, "maydanoz5g")
                        end
                    end)
                end
            end

            -- Roka
            if coords(809.89, -490.92, 30.63, 1) then
                DrawText3D(809.89, -490.92, 30.63, '[E]')
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetEntityCoords(PlayerPedId(), 996.85, -3200.67, -36.39, 0.0, 0.0, 0.0)
                    Citizen.Wait(5000)
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            end

            if coords(996.85, -3200.67, -36.39, 1) then
                DrawText3D( 996.85, -3200.67, -36.39, '[E]')
                if IsControlJustPressed(0, 38) then
                    SetEntityCoords(PlayerPedId(), 809.89, -490.92, 30.63, 0.0, 0.0, 0.0)
                end
            end

            if coords(1005.747, -3201.20, -38.51, 1) then
                DrawText3D(1005.747, -3201.20, -38.51, '~g~E~w~ - Roka Isleme')
                if IsControlJustPressed(0, 119) then
                    TriggerEvent("mythic_progbar:client:progress", {duration = 10000, label = "İşliyorsun", useWhileDead = true, canCancel = true, controlDisables = { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, }, animation = { animfreeze = true, animDict = "mini@repair", anim = "fixing_a_player", } }, function(status)
                        if not status then
                            ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                if quantity >= 1 then 
                                    ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                        if quantity >= 5 then 
                                            TriggerServerEvent('emrdrug:add', "roka5g", 5)
                                            TriggerServerEvent('emrdrug:remove', "roka25g", 1)
                                            TriggerServerEvent('emrdrug:remove', "drugbag", 5)
                                        else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                                    end, "drugbag")
                                else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                            end, "roka25g")
                        end
                    end)
                end
            end

            if coords(1012.144, -3194.20, -38.99, 1) then
                DrawText3D(1012.144, -3194.20, -38.99, '~g~E~w~ - Isleme [5G]')
                if IsControlJustPressed(0, 119) then
                    TriggerEvent("mythic_progbar:client:progress", {duration = 10000, label = "İşliyorsun", useWhileDead = true, canCancel = true, controlDisables = { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, }, animation = { animfreeze = true, animDict = "mini@repair", anim = "fixing_a_player", } }, function(status)
                        if not status then
                            ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                if quantity >= 1 then 
                                    ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
                                        if quantity >= 5 then 
                                            TriggerServerEvent('emrdrug:add', "roka1g", 5)
                                            TriggerServerEvent('emrdrug:remove', "roka5g", 1)
                                            TriggerServerEvent('emrdrug:remove', "drugbag", 5)
                                        else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                                    end, "drugbag")
                                else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
                            end, "roka5g")
                        end
                    end)
                end
            end

            if coords(2642.902, 4740.702, 35.118, 13) then
                if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
                    TriggerEvent('mythic_progbar:client:progress', { duration = 7000, label = 'Topluyorsun', useWhileDead = false, canCancel = true, controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, animation = { animfreeze = false, task = 'world_human_gardener_plant' }, }, function(status) 
                        if not status then
                            TriggerServerEvent("emrdrug:add", "islaktohum", 1)
                        end
                    end)
                end
            end

        else
            wait = 1000
        end
    end
end)

RegisterNetEvent('emrdrug:ufala')
AddEventHandler('emrdrug:ufala', function()
	TriggerEvent('mythic_progbar:client:progress', {duration = 7500, label = 'Ufalıyorsun', useWhileDead = false, canCancel = true, controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, animation = { animfreeze = false, animDict = 'amb@prop_human_parking_meter@male@base', anim = 'base', } }, function(status)
		if not status then
			ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
				if quantity >= 1 then 
					TriggerServerEvent("emrdrug:remove", "islaktohum", 1)
					TriggerServerEvent("emrdrug:add", "ufalanmisot", 1)
                else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
			end, 'islaktohum')
		end
	end)
end)

RegisterNetEvent('emrdrug:kurut')
AddEventHandler('emrdrug:kurut', function()
	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1978.878, 5171.579, 47.639, true) <= 15 then					
		TriggerEvent('mythic_progbar:client:progress', { duration = 7500, label = 'Kurutuyorsun', useWhileDead = false, canCancel = true, controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, animation = { animfreeze = false, animDict = 'amb@world_human_cop_idles@female@idle_b', anim = 'idle_d', } }, function(status)
			if not status then
				ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
					if quantity >= 1 then 
						TriggerServerEvent("emrdrug:remove", "ufalanmisot", 1)
						TriggerServerEvent("emrdrug:add", "kucukot", 1)
                    else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
				end, 'ufalanmisot')
			end
		end)
	end
end)

RegisterNetEvent('emrdrug:sar')
AddEventHandler('emrdrug:sar', function()
	TriggerEvent('mythic_progbar:client:progress', { duration = 7500, label = 'Sarıyorsun', useWhileDead = false, canCancel = true, controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, animation = { animfreeze = false, animDict = 'amb@prop_human_parking_meter@male@base', anim = 'base', } }, function(status)
		if not status then
			ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
				if quantity >= 3 then 
					ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
						if quantity >= 1 then 
							TriggerServerEvent("emrdrug:remove", "kucukot", 3)
							TriggerServerEvent("emrdrug:remove", "sarmakagit", 1)
							TriggerServerEvent("emrdrug:add", "joint", 1)
                        else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
					end, 'sarmakagit')
                else TriggerEvent('notification', 'Bir şeyler eksik', 2) end
			end, 'kucukot')
		end
	end)
end)

--
kullaniliyor, candoldur, armordoldur = false, false, false
RegisterNetEvent('emrdrug:drugeffect')
AddEventHandler('emrdrug:drugeffect', function(type, effects, sure, item)
    if not kullaniliyor then
        if IsPedInAnyVehicle(PlayerPedId()) then
            TriggerEvent('mythic_progbar:client:progress', { duration = 6000, label = 'Kullanıyorsun', useWhileDead = false, canCancel = true, controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },}, function(status)
                if not status then
                    ozelguc(type, effects, sure, item)
                end
            end)
        else
            TriggerEvent('mythic_progbar:client:progress', { duration = 6000, label = 'Kullanıyorsun', useWhileDead = false, canCancel = true, controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, animation = { animfreeze = false, task = 'WORLD_HUMAN_SMOKING_POT', }, }, function(status)
                if not status then
                    ozelguc(type, effects, sure, item)
                end
            end)
        end
    end
end)

function ozelguc(type, effects, sure, item)
    ESX.TriggerServerCallback('emrdrug:getItemAmount', function(quantity)
        if quantity >= 1 then 
            if not kullaniliyor then
                kullaniliyor = true
                local playerPed = PlayerPedId()
                TriggerServerEvent("emrdrug:remove", item, 1)
                StartScreenEffect(effects, sure, 0)
                if type == 'candoldur' then       
                    candoldur = false
                    Citizen.CreateThread(function()
                        while true do
                            Citizen.Wait(1)
                            if not candoldur then 
                                Citizen.Wait(5000)
                                local health = GetEntityHealth(playerPed)
                                health = health + 7
                                SetEntityHealth(playerPed, health)
                            end
                        end
                    end)
                    Citizen.Wait(sure)
                    candoldur = true
                elseif type == 'armordoldur' then
                    armordoldur = false
                    Citizen.CreateThread(function()
                        while true do
                            Citizen.Wait(1)
                            if not armordoldur then 
                                Citizen.Wait(3000)
                                AddArmourToPed(playerPed, 3)
                            end
                        end
                    end)
                    Citizen.Wait(sure)
                    armordoldur = true
                elseif type == 'hızlıkoş' then
                    SetPedMoveRateOverride(PlayerId(), 40.0)
                    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
                    SetSwimMultiplierForPlayer(player, 1.3)
                    Citizen.Wait(sure)
                    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                    SetSwimMultiplierForPlayer(PlayerId(), 1.0)
                end
                kullaniliyor = false
            end
        end
    end, item)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
end

function coords(x, y, z, uzaklik)
    return Vdist2(GetEntityCoords(PlayerPedId(), true), x, y, z) < uzaklik
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        RequestIpl("bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo")
        RequestIpl("bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo")
        RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo")
        RequestIpl("bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo")
        RequestIpl("bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo")
        RequestIpl("bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo")
        RequestIpl("bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo")
        RequestIpl("ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo")
        RequestIpl("ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo")
        RequestIpl("ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo")
        
        EnableInteriorProp(247297, "weed_upgrade_equip")
        EnableInteriorProp(247297, "weed_drying")
        EnableInteriorProp(247297, "weed_security_upgrade")
        
        EnableInteriorProp(247297, "weed_production")
        EnableInteriorProp(247297, "weed_set_up")
        EnableInteriorProp(247297, "weed_chairs")
        
        EnableInteriorProp(247297, "weed_growtha_stage3")
        EnableInteriorProp(247297, "weed_growthb_stage3")
        EnableInteriorProp(247297, "weed_growthc_stage3")
        
        EnableInteriorProp(247297, "weed_growthd_stage3")
        EnableInteriorProp(247297, "weed_growthe_stage3")
        EnableInteriorProp(247297, "weed_growthf_stage3")
        
        EnableInteriorProp(247297, "weed_growthg_stage3")
        EnableInteriorProp(247297, "weed_growthh_stage3")
        EnableInteriorProp(247297, "weed_growthi_stage3")
        
        EnableInteriorProp(247297, "weed_hosea")
        EnableInteriorProp(247297, "weed_hoseb")
        EnableInteriorProp(247297, "weed_hosec")
        
        EnableInteriorProp(247297, "weed_hosed")
        EnableInteriorProp(247297, "weed_hosee")
        EnableInteriorProp(247297, "weed_hosef")
        
        EnableInteriorProp(247297, "weed_hoseg")
        EnableInteriorProp(247297, "weed_hoseh")
        EnableInteriorProp(247297, "weed_hosei")
        
        EnableInteriorProp(247297, "light_growtha_stage23_upgrade")
        EnableInteriorProp(247297, "light_growthb_stage23_upgrade")
        EnableInteriorProp(247297, "light_growthc_stage23_upgrade")
        
        EnableInteriorProp(247297, "light_growthd_stage23_upgrade")
        EnableInteriorProp(247297, "light_growthe_stage23_upgrade")
        EnableInteriorProp(247297, "light_growthf_stage23_upgrade")
        
        EnableInteriorProp(247297, "light_growthg_stage23_upgrade")
        EnableInteriorProp(247297, "light_growthh_stage23_upgrade")
        EnableInteriorProp(247297, "light_growthi_stage23_upgrade")
        
        EnableInteriorProp(247553, "coke_cut_01")
        EnableInteriorProp(247553, "coke_cut_02")
        EnableInteriorProp(247553, "coke_cut_03")
        
        EnableInteriorProp(247553, "security_high")
        EnableInteriorProp(247553, "production_upgrade")
        EnableInteriorProp(247553, "equipment_upgrade")
        
        EnableInteriorProp(247553, "coke_cut_04")
        EnableInteriorProp(247553, "coke_cut_05")
        EnableInteriorProp(247553, "set_up")
        
        EnableInteriorProp(247553, "table_equipment_upgrade")
        EnableInteriorProp(247553, "coke_press_upgrade")
        
        EnableInteriorProp(247041, "meth_lab_upgrade")
        EnableInteriorProp(247041, "meth_lab_production")
        EnableInteriorProp(247041, "meth_lab_security_high")
        
        EnableInteriorProp(247041, "meth_lab_setup")
        
        EnableInteriorProp(247809, "counterfeit_security")
        EnableInteriorProp(247809, "counterfeit_cashpile100a")
        EnableInteriorProp(247809, "counterfeit_cashpile20a")
        
        EnableInteriorProp(247809, "counterfeit_cashpile10a")
        EnableInteriorProp(247809, "counterfeit_cashpile100b")
        EnableInteriorProp(247809, "counterfeit_cashpile100c")
        
        EnableInteriorProp(247809, "counterfeit_cashpile100d")
        EnableInteriorProp(247809, "counterfeit_cashpile20b")
        EnableInteriorProp(247809, "counterfeit_cashpile20c")
        
        EnableInteriorProp(247809, "counterfeit_cashpile20d")
        EnableInteriorProp(247809, "counterfeit_cashpile10b")
        EnableInteriorProp(247809, "counterfeit_cashpile10c")
        
        EnableInteriorProp(247809, "counterfeit_cashpile10d")
        EnableInteriorProp(247809, "counterfeit_setup")
        EnableInteriorProp(247809, "counterfeit_upgrade_equip")
        
        EnableInteriorProp(247809, "dryera_on")
        EnableInteriorProp(247809, "dryerb_on")
        EnableInteriorProp(247809, "dryerc_on")
        
        EnableInteriorProp(247809, "dryerd_on")
        EnableInteriorProp(247809, "money_cutter")
        EnableInteriorProp(247809, "special_chairs")
        
        EnableInteriorProp(246785, "equipment_upgrade")
        EnableInteriorProp(246785, "production")
        EnableInteriorProp(246785, "security_high")
        
        EnableInteriorProp(246785, "set_up")
        EnableInteriorProp(246785, "clutter")
        EnableInteriorProp(246785, "interior_upgrade")
        
        EnableInteriorProp(246785, "chair01")
        EnableInteriorProp(246785, "chair02")
        EnableInteriorProp(246785, "chair03")
        
        EnableInteriorProp(246785, "chair04")
        EnableInteriorProp(246785, "chair05")
        EnableInteriorProp(246785, "chair06")
        EnableInteriorProp(246785, "chair07")
    
        EnableInteriorProp(246529, "lower_walls_default")
        EnableInteriorProp(246529, "Mural_02")
        EnableInteriorProp(246529, "Walls_01")
        EnableInteriorProp(246529, "Furnishings_01")
        EnableInteriorProp(246529, "Decorative_01")
    end
end)