local oUsing = false
local InAction = false
local oLastPos = nil
local oAnim = "sırt üstü"
local oAnimscroll = 0
local oPlayer = false
local oPlayerFrontCoords = false
local oPlayerCoords = false
local oCanSleep = true
local oCooldown = 0
ESX = nil 
Config = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(1000)
        
		oPlayer = PlayerPedId()
        if IsPedInAnyVehicle(PlayerPedId()) then 
        else
		oPlayerFrontCoords = GetOffsetFromEntityInWorldCoords(oPlayer,0.0,0.5,0.0) 
		oPlayerCoords = GetEntityCoords(oPlayer)
		if oCooldown > 0 then
			oCooldown = oCooldown-1
		end
		if oUsing == false and oCanSleep == true then
                local oSelectedObject = ESX.Game.GetClosestObject()
                local oEntityCoords = GetEntityCoords(oSelectedObject)
				local objectexits = DoesEntityExist(oSelectedObject)
                
				if objectexits then
                    local hash = GetEntityModel(oSelectedObject)
                    local dist = #(oPlayerFrontCoords - oEntityCoords)
					if dist < 5.0 then
						if oSelectedObject ~= 0 then
							local objects = Config.objects
							if oSelectedObject ~= objects.Object then
                                
								
                                if Config.objects.Locations[hash] ~= nil then 
                                    objects.Object = oSelectedObject
                                    objects.ObjectVertX = Config.objects.Locations[hash].verticalOffsetX
                                    objects.ObjectVertY = Config.objects.Locations[hash].verticalOffsetY
                                    objects.ObjectVertZ = Config.objects.Locations[hash].verticalOffsetZ
                                    objects.ObjectDir = Config.objects.Locations[hash].direction
                                    objects.isBed = Config.objects.Locations[hash].bed
                                else 
                                    objects.Object = nil
                                    objects.ObjectVertX = nil
                                    objects.ObjectVertY = nil
                                    objects.ObjectVertZ = nil
                                    objects.ObjectDir = nil
                                    objects.isBed = nil
                                end
							end
                            
						end
					end
			end
		end
        end
	end
end)


CreateThread(function()
	while true do
		local sleep = 2000
        if IsPedInAnyVehicle(PlayerPedId()) then 
        else
		oCanSleep = true
		local objects = Config.objects
		if objects.Object ~= nil and objects.ObjectVertX ~= nil and objects.ObjectVertY ~= nil and objects.ObjectVertZ ~= nil and objects.ObjectDir ~= nil and objects.isBed ~= nil then
			local player = oPlayer
			local getPlayerFrontCoords = oPlayerCoords
			local objectcoords = GetEntityCoords(objects.Object)
            local dist = #(objectcoords - getPlayerFrontCoords)
			if dist < 5.0 then
			sleep = 5
			end
			if dist < 1.8 and not oUsing then
				if objects.isBed == true then
					if oAnim == "sit" then
						DrawText3D(objectcoords.x, objectcoords.y, objectcoords.z+0.30, Config.Text.SitOnBed)
					else
						DrawText3D(objectcoords.x, objectcoords.y, objectcoords.z+0.30, "~g~E~w~ ile " ..oAnim.. " " ..Config.Text.LieOnBed)
					end
					DrawText3D(objectcoords.x, objectcoords.y, objectcoords.z+0.20, Config.Text.SwitchBetween)
					if IsControlJustPressed(0, 175) then -- right
						oAnimscroll = oAnimscroll+1
						if oAnimscroll == 0 then
							oAnim = "sırt üstü"
						elseif oAnimscroll == 1 then
							oAnim = "karın üstü"
						elseif oAnimscroll == 2 then
							oAnim = "sit"
						elseif oAnimscroll == 3 then
							oAnimscroll = 1
						end
					end

					if IsControlJustPressed(0, 174) then -- left
						oAnimscroll = oAnimscroll-1
						if oAnimscroll == -1 then
							oAnimscroll = 0
						elseif oAnimscroll == 0 then
							oAnim = "sırt üstü"
						elseif oAnimscroll == 1 then
							oAnim = "karın üstü"
						elseif oAnimscroll == 2 then
							oAnim = "sit"
						elseif oAnimscroll == 3 then
							oAnimscroll = 0
							oAnim = "sırt üstü"
						end
					end
					if IsControlJustPressed(0, objects.ButtonToLayOnBed) then
						if Config.Cooldown ~= 0 and oCooldown == 0 then
							oCooldown = Config.Cooldown
							TriggerServerEvent('ChairBedSystem:Server:Enter', objects, objectcoords)
						end
					end
				else
					DrawText3D(objectcoords.x, objectcoords.y, objectcoords.z+0.30, Config.Text.SitOnChair)
					if IsControlJustPressed(0, objects.ButtonToSitOnChair) then
						if Config.Cooldown ~= 0 and oCooldown == 0 then
							oCooldown = Config.Cooldown
							TriggerServerEvent('ChairBedSystem:Server:Enter', objects, objectcoords)
						end
					end
				end
			end
			if oUsing == true then
				DrawText2D(Config.Text.Standup,0,1,0.086,0.77,0.6,255,255,255,255)

				if IsControlJustPressed(0, objects.ButtonToStandUp) then
					TriggerServerEvent('ChairBedSystem:Server:Leave', GetEntityCoords(objects.Object))
					ClearPedTasksImmediately(player)
					oUsing = false
					
                    local dist = #(oLastPos - getPlayerFrontCoords)
					if dist < 10 then
						SetEntityCoords(player, oLastPos)
					end
					FreezeEntityPosition(player, false)
				end
			end
		end

		if oCanSleep then
			Citizen.Wait(1000)
		end
        end
		Citizen.Wait(sleep)
	end
end)

CreateThread(function()
	while Config.Healing ~= 0 do
		local objects = Config.objects
		Citizen.Wait(Config.Healing*1000)
		if oUsing == true then
			if objects.isBed == true then
				local health = GetEntityHealth(oPlayer)
				if health <= 199 then
					SetEntityHealth(oPlayer,health+1)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        sleep = 2000
        for i=1, #Config.BedList do
            local bedID   = Config.BedList[i]
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z, true)
			if distance < 3.0 then 
				sleep = 5
			end
            if distance < Config.MaxDistance and InAction == false then
                --ESX.Game.Utils.DrawText3D({ x = bedID.objCoords.x, y = bedID.objCoords.y, z = bedID.objCoords.z + 1 }, bedID.text, 0.6)
				DrawText3D(bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z+0.10, bedID.text)
                if IsControlJustReleased(0, 38) then
                    bedActive(bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z, bedID.heading, bedID)
                end
            end
		end
		Citizen.Wait(sleep)
    end
end)

function bedActive(x, y, z, heading)

    SetEntityCoords(PlayerPedId(), x, y, z + 0.3)
    RequestAnimDict('anim@gangops@morgue@table@')
    while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), 'anim@gangops@morgue@table@' , 'ko_front' ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), heading + 180.0)
    InAction = true


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            if InAction == true then
                DrawText2D(Config.Text.Standup,0,1,0.086,0.77,0.6,255,255,255,255)
                if IsControlJustReleased(0, 23) then
                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(PlayerPedId(), false)
                    SetEntityCoords(PlayerPedId(), x + 1.0, y, z)
                    InAction = false
                end
            end
        end
    end)
end


RegisterNetEvent("ChairBedSystem:Client:Animation")
AddEventHandler("ChairBedSystem:Client:Animation", function(objects,objectcoords)
	local object = objects.Object
	local vertx = objects.ObjectVertX
	local verty = objects.ObjectVertY
	local vertz = objects.ObjectVertZ
	local dir = objects.ObjectDir
	local isBed = objects.isBed

	local ped = oPlayer
	oLastPos = oPlayerCoords
	FreezeEntityPosition(object, true)
	FreezeEntityPosition(ped, true)
	oUsing = true
	if isBed == false then
		if Config.objects.SitAnimation.dict ~= nil then
			SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z+0.5)
			SetEntityHeading(ped,  GetEntityHeading(object)-180.0)
			local dict = Config.objects.SitAnimation.dict
			local anim = Config.objects.SitAnimation.anim

			AnimLoadDict(dict, anim, ped)
		else
			TaskStartScenarioAtPosition(ped, Config.objects.SitAnimation.anim, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
		end
	else
		if oAnim == "sırt üstü" then
			if Config.objects.BedBackAnimation.dict ~= nil then
				SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z+0.5)
				SetEntityHeading(ped,  GetEntityHeading(object)-180.0)
				local dict = Config.objects.BedBackAnimation.dict
				local anim = Config.objects.BedBackAnimation.anim

				Animation(dict, anim, ped)
			else
				TaskStartScenarioAtPosition(ped, Config.objects.BedBackAnimation.anim, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
			end
		elseif oAnim == "karın üstü" then
			if Config.objects.BedStomachAnimation.dict ~= nil then
				SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z+0.5)
				SetEntityHeading(ped,  GetEntityHeading(object)-180.0)
				local dict = Config.objects.BedStomachAnimation.dict
				local anim = Config.objects.BedStomachAnimation.anim

				Animation(dict, anim, ped)
			else
				TaskStartScenarioAtPosition(ped, Config.objects.BedStomachAnimation.anim, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
			end
		elseif oAnim == "sit" then
			if Config.objects.BedSitAnimation.dict ~= nil then
				SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z+0.5)
				SetEntityHeading(ped,  GetEntityHeading(object)-180.0)
				local dict = Config.objects.BedSitAnimation.dict
				local anim = Config.objects.BedSitAnimation.anim

				Animation(dict, anim, ped)
			else
				TaskStartScenarioAtPosition(ped, Config.objects.BedSitAnimation.anim, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+180.0, 0, true, true)
			end

		end
	end
end)

function Animation(dict, anim, ped)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end


	TaskPlayAnim(ped, dict , anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
end




function DrawText3D(x,y,z, text)
	oCanSleep = false
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    -- --
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 350
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	end
end

function DrawText2D(text,font,centre,x,y,scale,r,g,b,a)
	oCanSleep = false

	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.40, 0.40)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
	local factor = (string.len(text)) / 350
	DrawRect(x,y+0.0150, 0.080+ factor, 0.03, 41, 11, 41, 68)
end
