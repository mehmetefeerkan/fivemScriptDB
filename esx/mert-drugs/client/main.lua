ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

candoldur = false
RegisterNetEvent('mertdrug:candoldur')
AddEventHandler('mertdrug:candoldur', function(effects, sure)
    local playerPed = PlayerPedId()
    
    TriggerServerEvent("mertdrug:remove", 1, "maydanoz1g")
    loadAnimDict("move_m@hipster@a")
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(7000)
    ClearPedTasksImmediately(playerPed)
    StartScreenEffect(effects, sure, 0)

	function can()
		local health = GetEntityHealth(playerPed)
		local maxHealth = GetEntityMaxHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 15))
		SetEntityHealth(playerPed, newHealth)
    end
    
    candoldur = false
    Citizen.CreateThread(function()
        while(true) do
            if candoldur == false then 
                Citizen.Wait(3000)
                can()
            else
                Citizen.Wait(100)
            end
        end
    end)

    Citizen.Wait(35000)
    candoldur = true

end)

armordoldur = false
RegisterNetEvent('mertdrug:armordoldur')
AddEventHandler('mertdrug:armordoldur', function(effects, sure)
    local playerPed = PlayerPedId()
    
    TriggerServerEvent("mertdrug:remove", 1, "roka1g")
    loadAnimDict("move_m@hipster@a")
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(7000)
    ClearPedTasksImmediately(playerPed)
    StartScreenEffect(effects, sure, 0)
    armordoldur = false
    Citizen.CreateThread(function()
        while(true) do
            if armordoldur == false then 
                Citizen.Wait(1000)
                AddArmourToPed(playerPed, 3)
            else
                Citizen.Wait(100)
            end
        end
    end)

    Citizen.Wait(35000)
    armordoldur = true

end)


RegisterNetEvent('mertdrug:hizlikosma')
AddEventHandler('mertdrug:hizlikosma', function(effects, sure)
    local playerPed = PlayerPedId()
    
    TriggerServerEvent("mertdrug:remove", 1, "joint")
    loadAnimDict("move_m@hipster@a")
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(7000)
    ClearPedTasksImmediately(playerPed)
    StartScreenEffect(effects, sure, 0)
    
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    Citizen.Wait(20000)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end)


-- Gereksinimler
function DrawText3D(x,y,z,text)
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

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end



-- Ipls
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