local holdingPackage          = false
local dropkey 	= 246 -- Key to drop/get the props
local closestEntity = 0


-- Proplist, you can add as much as you want
attachPropList = {
	{["model"] = 'prop_roadcone02a',				["name"] = "cone", 		["bone"] = 28422, ["x"] = 0.6,	["y"] = -0.15,	["z"] = -0.1,	["xR"] = 315.0,	["yR"] = 288.0, ["zR"] = 0.0, 	["anim"] = 'pick' }, -- Done
    	{["model"] = 'prop_cs_trolley_01',				["name"] = "trolley", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.6,	["z"] = -0.8,	["xR"] = -180.0,["yR"] = -165.0,["zR"] = 90.0, 	["anim"] = 'hold' }, -- Done
	{["model"] = 'prop_table_03',					["name"] = "mesa", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.8,	["z"] = -0.7,	["xR"] = -180.0,["yR"] = -165.0,["zR"] = 90.0, 	["anim"] = 'hold' }, -- Done
	{["model"] = 'prop_tool_box_04',				["name"] = "ferramentas", 	["bone"] = 28422, ["x"] = 0.4,	["y"] = -0.1,	["z"] = -0.1,	["xR"] = 315.0,	["yR"] = 288.0, ["zR"] = 0.0, 	["anim"] = 'pick' }, -- Done
	{["model"] = "xm_prop_smug_crate_s_medical",			["name"] = "MedBox", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.1,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0, 	["anim"] = 'hold' }, -- Done
	{["model"] = 'xm_prop_x17_bag_med_01a',				["name"] = "MedBag", 		["bone"] = 28422, ["x"] = 0.4,	["y"] = -0.1,	["z"] = -0.1,	["xR"] = 315.0,	["yR"] = 298.0, ["zR"] = 0.0, 	["anim"] = 'pick' }, -- Done
	{["model"] = "imp_prop_impexp_car_door_04a",			["name"] = "porta", 		["bone"] = 28422, ["x"] = -0.5,	["y"] = -0.15,	["z"] = 0.4,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 90.0 , ["anim"] = 'hold' }, -- Done
	{["model"] = "imp_prop_impexp_front_bars_01a",			["name"] = "barra", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.25,	["z"] = -0.1,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' }, -- Done
	{["model"] = "imp_prop_impexp_bonnet_03a",			["name"] = "bonnet", 		["bone"] = 28422, ["x"] = 0.2,	["y"] = 0.2,	["z"] = -0.1,	["xR"] = -0.0,	["yR"] = 0.0, 	["zR"] = 180.0 ,["anim"] = 'hold' }, -- Done
	{["model"] = "imp_prop_impexp_front_bumper_02a",		["name"] = "parachoques", 	["bone"] = 28422, ["x"] = 0.0,	["y"] = 0.1,	["z"] = 0.05,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' }, -- Done
	{["model"] = "prop_car_battery_01",				["name"] = "bateria", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.05,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' }, -- Done
	{["model"] = "prop_wheel_tyre",					["name"] = "pneu", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.05,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' }, -- Done
	{["model"] = 'prop_engine_hoist',				["name"] = "hoist", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.5,	["z"] = -1.3,	["xR"] = -195.0,["yR"] = -180.0,["zR"] = 180.0, ["anim"] = 'hold' }, -- Done
	{["model"] = "ex_office_swag_guns03",				["name"] = "armas", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = 0.0,	["z"] = -0.05,	["xR"] = 90.0,	["yR"] = 180.0, ["zR"] = 90.0 , ["anim"] = 'hold' }, -- Done
	{["model"] = 'prop_cs_cardbox_01',				["name"] = "caixa", 		["bone"] = 28422, ["x"] = 0.01,	["y"] = 0.01,	["z"] = 0.0,	["xR"] = -255.0,["yR"] = -120.0,["zR"] = 40.0, 	["anim"] = 'hold' }, -- Done
	{["model"] = 'xm_prop_x17_bag_01a',				["name"] = "saco", 		["bone"] = 28422, ["x"] = 0.4,	["y"] = -0.1,	["z"] = -0.1,	["xR"] = 315.0,	["yR"] = 298.0, ["zR"] = 0.0, 	["anim"] = 'pick' }, -- Done
	{["model"] = "p_gcase_s",					["name"] = "malaarma", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.25,	["z"] = -0.1,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' }, -- Done
	{["model"] = 'prop_cleaning_trolly',				["name"] = "CarroLimpezas",	["bone"] = 28422, ["x"] = -0.2,	["y"] = -0.4,	["z"] = -1.2,	["xR"] = -188.0,["yR"] = -178.0,["zR"] = 180.0, ["anim"] = 'hold' }, -- Done
	{["model"] = "prop_mp_drug_package",				["name"] = "droga", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.25,	["z"] = -0.05,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' },
	{["model"] = 'hei_prop_hei_drug_pack_01b',				["name"] = "drugp", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.1,	["xR"] = -180.0,["yR"] = -180.0,["zR"] = 0.0, 	["anim"] = 'hold' }, -- Done hei_prop_heist_cash_pile
}

RegisterNetEvent('inrp_propsystem:attachProp')
AddEventHandler('inrp_propsystem:attachProp', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    closestEntity = 0
    holdingPackage = true
    local attachModel = GetHashKey(attachModelSent)
    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
    local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumberSent)
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(0)
    end
    closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	for i=1 ,#attachPropList , 1 do
		if (attachPropList[i].model == attachModelSent) and (attachPropList[i].anim == 'hold') then
			holdAnim()
		end
	end
	Citizen.Wait(200)
    AttachEntityToEntity(closestEntity, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, true, 2, 1)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function randPickupAnim()
  local randAnim = math.random(7)
    loadAnimDict('random@domestic')
    TaskPlayAnim(GetPlayerPed(-1),'random@domestic', 'pickup_low',5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
end

function holdAnim()
    loadAnimDict( "anim@heists@box_carry@" )
	TaskPlayAnim((GetPlayerPed(-1)),"anim@heists@box_carry@","idle",4.0, 1.0, -1,49,0, 0, 0, 0)
end

Citizen.CreateThread( function()
    while true do 
		Citizen.Wait(10)		
		if IsPedOnFoot(GetPlayerPed(-1)) and not IsPedDeadOrDying(GetPlayerPed(-1)) then
			if IsControlJustReleased(0, dropkey) then
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local closestDistance = -1
				closestEntity   = 0
				for i=1, #attachPropList, 1 do
					local object = GetClosestObjectOfType(coords, 1.5, GetHashKey(attachPropList[i].model), false, false, false)
					if DoesEntityExist(object) then
						local objCoords = GetEntityCoords(object)
						local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
						if closestDistance == -1 or closestDistance > distance then
							closestDistance = distance
							closestEntity   = object
							if not holdingPackage then
								local dst = GetDistanceBetweenCoords(GetEntityCoords(closestEntity) ,GetEntityCoords(GetPlayerPed(-1)),true)                 
								if dst < 2 then
									holdingPackage = true
									if attachPropList[i].anim == 'pick' then
										randPickupAnim()
									elseif attachPropList[i].anim == 'hold' then
										holdAnim()
									end
									Citizen.Wait(550)
									NetworkRequestControlOfEntity(closestEntity)
									while not NetworkHasControlOfEntity(closestEntity) do
										Wait(0)
									end
									SetEntityAsMissionEntity(closestEntity, true, true)
									while not IsEntityAMissionEntity(closestEntity) do
										Wait(0)
									end
									SetEntityHasGravity(closestEntity, true)
									AttachEntityToEntity(closestEntity, GetPlayerPed(-1),GetPedBoneIndex(GetPlayerPed(-1), attachPropList[i].bone), attachPropList[i].x, attachPropList[i].y, attachPropList[i].z, attachPropList[i].xR, attachPropList[i].yR, attachPropList[i].zR, 1, 1, 0, true, 2, 1)
								end
							else
								holdingPackage = false
								if attachPropList[i].anim == 'pick' then
									randPickupAnim()
								end
								Citizen.Wait(350)
								DetachEntity(closestEntity)
								ClearPedTasks(GetPlayerPed(-1))
								ClearPedSecondaryTask(GetPlayerPed(-1))
							end
						end
						break
					end
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function removeAttachedProp()
    if DoesEntityExist(closestEntity) then
        DeleteEntity(closestEntity)
    end
end

function attach(prop)
    TriggerEvent("inrp_propsystem:attachItem",prop)
end

function removeall()
    TriggerEvent("RemoveItems",false)
	ClearPedTasks(GetPlayerPed(-1))
	ClearPedSecondaryTask(GetPlayerPed(-1))
end

RegisterNetEvent('inrp_propsystem:attachItem')
AddEventHandler('inrp_propsystem:attachItem', function(item)
	for i=1 ,#attachPropList , 1 do
		if (attachPropList[i].model == item) then
			TriggerEvent("inrp_propsystem:attachProp",attachPropList[i].model, attachPropList[i].bone, attachPropList[i].x, attachPropList[i].y, attachPropList[i].z, attachPropList[i].xR, attachPropList[i].yR, attachPropList[i].zR)
		end
	end
end)

RegisterNetEvent('attach:ex_office_swag_guns03')
AddEventHandler('attach:ex_office_swag_guns03', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","ex_office_swag_guns03")
end)

RegisterNetEvent('attach:prop_roadcone02a') --p_gcase_s
AddEventHandler('attach:prop_roadcone02a', function()
    TriggerEvent("inrp_propsystem:attachItem","prop_roadcone02a")
end)

RegisterNetEvent('attach:xm_prop_x17_bag_01a') --xm_prop_x17_bag_01a
AddEventHandler('attach:xm_prop_x17_bag_01a', function()
    TriggerEvent("inrp_propsystem:attachItem","xm_prop_x17_bag_01a")
end)

RegisterNetEvent('attach:p_gcase_s') --prop_cs_cardbox_01
AddEventHandler('attach:p_gcase_s', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","p_gcase_s")
end)

RegisterNetEvent('attach:prop_cs_cardbox_01') --hei_prop_hei_drug_pack_01b
AddEventHandler('attach:prop_cs_cardbox_01', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","prop_cs_cardbox_01")
end)

RegisterNetEvent('attach:hei_prop_hei_drug_pack_01b') --xm_prop_x17_bag_med_01a
AddEventHandler('attach:hei_prop_hei_drug_pack_01b', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","hei_prop_hei_drug_pack_01b")
end)

RegisterNetEvent('attach:xm_prop_x17_bag_med_01a') --xm_prop_smug_crate_s_medical
AddEventHandler('attach:xm_prop_x17_bag_med_01a', function()
    TriggerEvent("inrp_propsystem:attachItem","xm_prop_x17_bag_med_01a")
end)

RegisterNetEvent('attach:xm_prop_smug_crate_s_medical') --xm_prop_smug_crate_s_medical
AddEventHandler('attach:xm_prop_smug_crate_s_medical', function()
    TriggerEvent("inrp_propsystem:attachItem","xm_prop_smug_crate_s_medical")
end)

RegisterNetEvent('attach:prop_table_03') 
AddEventHandler('attach:prop_table_03', function()
	holdAnim()
    TriggerEvent("inrp_propsystem:attachItem","prop_table_03")
end)

RegisterNetEvent("RemoveItems")
AddEventHandler("RemoveItems", function(sentinfo)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("weapon_unarmed"), 1)
	removeAttachedProp()
	holdingPackage = false
end)


Citizen.CreateThread( function()
	RegisterCommand("r", function()
		removeall()
	end, false)
			
	for i=1, #attachPropList, 1 do
		RegisterCommand(attachPropList[i].name, function(source, args, raw)
			local arg = args[1]

			if arg == nil then
				attach(attachPropList[i].model)
			end
			
		end, false)
	end
	
end)


Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Prevents RAM LEAKS :)
