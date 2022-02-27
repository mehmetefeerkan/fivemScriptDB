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

ESX = nil

local handcuffed                = false
local IsDragged                 = false
local CopPed                    = 0
local IsAbleToSearch            = false
local kelepcegitti = false


Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)


function IsAbleToSteal(targetSID, err)
    ESX.TriggerServerCallback('esx_thief:getValue', function(result)
        local result = result
    	if result.value then
    		err(false)
    	else
    		err(_U('no_hands_up'))
    	end
    end, targetSID)
end

---- MENU

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function OpenCuffMenu()

  local elements = {
        {label = _U('cuff'), value = 'cuff'},
        {label = _U('uncuff'), value = 'uncuff'}, 
		{label = _U('search'), value = 'search'}, 
      }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cuffing',
    {
      title    = _U('cuffs'),
      align    = 'top-left',
      elements = elements
      },
          function(data2, menu2)
            local player, distance = ESX.Game.GetClosestPlayer()
            if distance ~= -1 and distance <= 3.0 then
              if data2.current.value == 'cuffs' then
                if Config.EnableItems then

                    local target_id = GetPlayerServerId(player)
                
                    IsAbleToSteal(target_id, function(err)

                        if not err then
                            ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                                if quantity > 0 then
									if kelepcegitti == false then
										TriggerServerEvent("esx_thief:removecuffs")
										kelepcegitti = true
										IsAbleToSearch = true
										TriggerServerEvent('cuffServer', GetPlayerServerId(player))
										TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 2, "handcuff", 0.3)
										TriggerEvent('notification', 'Birini kelepçeledin', 1)
									end
								else
                                    --ESX.ShowNotification(_U('no_cuffs'))
									-- exports['mythic_notify']:SendAlert('error', 'Kelepçen yok')
									TriggerEvent('notification', 'Kelepçen yok', 2)
                                end
                            end, 'cuffs')
                        else
							-- exports['mythic_notify']:SendAlert('inform', 'Kelepçeliyorsun')
							TriggerEvent('notification', 'Kelepçeliyorsun', 1)
                        end
                    end)
                else
                    IsAbleToSearch = true
                    TriggerServerEvent('cuffServer', GetPlayerServerId(player))
                end
              end
              if data2.current.value == 'cuffs' then
                if Config.EnableItems then
				if kelepcegitti == true then
					TriggerServerEvent("esx_thief:addcuffs")
				end
                    ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                        if quantity > 0 then
                            IsAbleToSearch = false
                            TriggerServerEvent('unCuffServer', GetPlayerServerId(player))
							kelepcegitti = false
                        else
                            --ESX.ShowNotification(_U('no_cuffs'))
							-- exports['mythic_notify']:SendAlert('error', 'Kelepçen yok')
							TriggerEvent('notification', 'Kelepçen yok', 2)
						end
                    end, 'cuffs')
                else
                    IsAbleToSearch = false
                    TriggerServerEvent('cuffServer', GetPlayerServerId(player))
                end
              end
              if data2.current.value == 'drag' then
                if Config.EnableItems then
                    ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                        if quantity > 0 then
                            IsAbleToSearch = false
                            TriggerServerEvent('dragServer', GetPlayerServerId(player))
                        else
                            --ESX.ShowNotification(_U('no_rope'))
							-- exports['mythic_notify']:SendAlert('error', 'Halatın yok')
							TriggerEvent('notification', 'Halatın yok', 2)
						end
                    end, 'rope')
                else
                    TriggerServerEvent('dragServer', GetPlayerServerId(player))
                end
              end  
			  
			 if data2.current.value == 'rehinal' then
				takeHostage()
              end  
			  
              if data2.current.value == 'search' then

                local ped = PlayerPedId()

                if IsPedArmed(ped, 7) then
						local target, distance = ESX.Game.GetClosestPlayer()
                        	if target ~= -1 and distance ~= -1 and distance <= 2.0 then
									local target_id = GetPlayerServerId(target)
									ExecuteCommand('e mekanik')
									ExecuteCommand('me kişinin üstünü arar')
									exports["t0sic_loadingbar"]:StartDelayedFunction("Soyuyorsun", 2000, function()
									ClearPedTasks(ped)
									OpenStealMenu(target, target_id)
									end)
                        	elseif distance < 20 and distance > 2.0 then
                            --ESX.ShowNotification(_U('too_far'))
							--exports['mythic_notify']:SendAlert('error', 'Hedef çok uzakta')
							end
                else
					-- exports['mythic_notify']:SendAlert('error', 'Silah çekmedin')
					TriggerEvent('notification', 'Silah çekmedin', 2)
					--ESX.ShowNotification(_U('not_armed'))
                end
              end
			end
          end,
    function(data2, menu2)
      menu2.close()
    end
  )

end


RegisterNetEvent('cuffClient')
AddEventHandler('cuffClient', function()
	local pP = PlayerPedId()
	RequestAnimDict('mp_arresting')
	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(100)
	end
	TaskPlayAnim(pP, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
	SetEnablecuffs(pP, true)
	SetCurrentPedWeapon(pP, GetHashKey('WEAPON_UNARMED'), true)
	DisablePlayerFiring(pP, true)
	-- exports['mythic_notify']:SendAlert('error', 'Birisi tarafından kelepçelendin')
	TriggerEvent('notification', 'Birisi tarafından kelepçelendin', 2)
	TriggerEvent('inventoryhud:searching')
	--FreezeEntityPosition(pP, true)
	handcuffed = true
end)

RegisterNetEvent('unCuffClient')
AddEventHandler('unCuffClient', function()
	local pP = PlayerPedId()
	ClearPedSecondaryTask(pP)
	SetEnablecuffs(pP, false)
	SetCurrentPedWeapon(pP, GetHashKey('WEAPON_UNARMED'), true)
  --ESX.ShowNotification(_U('uncuffed'))
	-- exports['mythic_notify']:SendAlert('inform', 'Birisi kelepçeni çözdü')
	TriggerEvent('inventoryhud:searching-end')
	TriggerEvent('notification', 'Birisi kelepçeni çözdü', 1)
	--FreezeEntityPosition(pP, false)
	handcuffed = false
end)

RegisterNetEvent('cuffs:OpenMenu')
AddEventHandler('cuffs:OpenMenu', function()
	OpenCuffMenu()
end)

RegisterNetEvent('cuffscript:drag')
AddEventHandler('cuffscript:drag', function(cop)
  --TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if handcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = PlayerPedId()
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(PlayerPedId(), true, false)
      end
    end
  end
end)

-- Handcuff
Citizen.CreateThread(function()
while true do
	Citizen.Wait(0)
    if handcuffed then
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 157, true) -- Inventory
			DisableControlAction(0, 158, true) -- Inventory
			DisableControlAction(0, 160, true) -- Inventory
			DisableControlAction(0, 164, true) -- Inventory
			DisableControlAction(0, 165, true) -- Inventory
			DisableControlAction(0, 19, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
    else
      Citizen.Wait(500)
    end
  end
end)


---- END MENU


function OpenStealMenu(target, target_id)
    TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(target), GetPlayerName(target))
end


-- Citizen.CreateThread(function()
    -- while true do
        -- Citizen.Wait(0)
        -- local ped = PlayerPedId()
		-- if IsControlJustPressed(1, Keys['E']) and IsPedArmed(ped, 7) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
			-- local target, distance = ESX.Game.GetClosestPlayer()

            -- if target ~= -1 and distance ~= -1 and distance <= 2.0 then

                -- local target_id = GetPlayerServerId(target)
                
                -- IsAbleToSteal(target_id, function(err)
                    -- if(not err)then
                        -- OpenCuffMenu(closestPlayer)
					-- end
                -- end)
                
            -- elseif distance < 20 and distance > 2.0 then

                -- ESX.ShowNotification(_U('too_far'))
                -- exports['mythic_notify']:SendAlert('error', 'Hedef çok uzakta')   
			-- end

		-- end
	-- end
-- end)

RegisterNetEvent('soyguncu')
AddEventHandler('soyguncu', function()
	local ped = PlayerPedId()
	if	IsPedArmed(ped, 7) then
		if not IsEntityDead(ped) then
			if not IsPedInAnyVehicle(ped, true) then
				local target, distance = ESX.Game.GetClosestPlayer()
				if target ~= -1 and distance ~= -1 and distance <= 2.0 then
					local target_id = GetPlayerServerId(target)
					
					IsAbleToSteal(target_id, function(err)
						if(not err)then
							OpenCuffMenu(closestPlayer)
						else
							TriggerEvent('notification', 'Karşıdaki kişi ellerini kaldırmıyor!', 2)
						end
					end)
				elseif distance < 20 and distance > 2.0 then
					TriggerEvent('notification', 'Soymak istediğin kişi çok uzakta!', 2)
				end
			else
				TriggerEvent('notification', 'Araçtayken adam soyamazsın!', 2)
			end
		end
	else
		TriggerEvent('notification', 'Eline silah almalısın!', 2)
	end
end)
	

--[[Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		if IsControlJustReleased(0, Keys['U']) then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if IsPlayerDead(closestPlayer) then 
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    OpenStealMenu(closestPlayer)
                end
            end
		end
	end
end) --]]



--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
		if IsControlJustPressed(1, Keys['G']) and IsPedArmed(ped, 7) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
			local target, distance = ESX.Game.GetClosestPlayer()

            if target ~= -1 and distance ~= -1 and distance <= 2.0 then

                local target_id = GetPlayerServerId(target)
                
                IsAbleToSteal(target_id, function(err)
                    if(not err)then
                        OpenStealMenu(target, target_id)
                        TriggerEvent('animation')
					else
						ESX.ShowNotification(err)
					end
                end)
                
            elseif distance < 20 and distance > 2.0 then

                ESX.ShowNotification(_U('too_far'))
                    
            else
                
                ESX.ShowNotification(_U('no_players_nearby'))
                    
			end

		end
	end
end)
]]--


---- REHİN ALMA ---

-----------------------------------------------------------------
--TakeHostage by Robbster, do not redistrbute without permission--
------------------------------------------------------------------

local hostageAllowedWeapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_VINTAGEPISTOL",
	--etc add guns you want
}

local holdingHostageInProgress = false

--[[RegisterCommand("rehinal",function()
	takeHostage()
end)

RegisterCommand("th",function()
	takeHostage()
end) --]]

function takeHostage()
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
	for i=1, #hostageAllowedWeapons do
		if HasPedGotWeapon(PlayerPedId(), GetHashKey(hostageAllowedWeapons[i]), false) then
			if GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(hostageAllowedWeapons[i])) > 0 then
				canTakeHostage = true 
				foundWeapon = GetHashKey(hostageAllowedWeapons[i])
				break
			end 					
		end
	end

	if not canTakeHostage then 
		--drawNativeNotification("Birini rehin almak için silaha ihtiyacın var!")
		-- exports['mythic_notify']:SendAlert('error', 'Birini rehin almak için silaha ihtiyacın var!')
		TriggerEvent('notification', 'Birini rehin almak için silaha ihtiyacın var!', 2)
	end

	if not holdingHostageInProgress and canTakeHostage then		
		local player = PlayerPedId()	
		--lib = 'misssagrab_inoffice'
		--anim1 = 'hostage_loop'
		--lib2 = 'misssagrab_inoffice'
		--anim2 = 'hostage_loop_mrk'
		lib = 'anim@gangops@hostage@'
		anim1 = 'perp_idle'
		lib2 = 'anim@gangops@hostage@'
		anim2 = 'victim_idle'
		distans = 0.11 --Higher = closer to camera
		distans2 = -0.24 --higher = left
		height = 0.0
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 49
		animFlagTarget = 50
		attachFlag = true 
		local closestPlayer = GetClosestPlayer(2)
		target = GetPlayerServerId(closestPlayer)
		if closestPlayer ~= nil then
			SetCurrentPedWeapon(PlayerPedId(), foundWeapon, true)
			holdingHostageInProgress = true
			holdingHostage = true 
			--print("triggering cmg3_animations:sync")
			TriggerServerEvent('cmg3_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
		else
			--print("[CMG Anim] No player nearby")
			--drawNativeNotification("No one nearby to take as hostage!")
			-- exports['mythic_notify']:SendAlert('error', 'Yakınında rehin alacak kimse yok')
			TriggerEvent('notification', 'Yakınında rehin alacak kimse yok', 2)
		end 
	end
	canTakeHostage = false 
end 

RegisterNetEvent('cmg3_animations:syncTarget')
AddEventHandler('cmg3_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	if holdingHostageInProgress then 
		holdingHostageInProgress = false 
	else 
		holdingHostageInProgress = true
	end
	beingHeldHostage = true 
	--print("triggered cmg3_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	if attach then 
		--print("attaching entity")
		AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	else 
		--print("not attaching entity")
	end
	
	if controlFlag == nil then controlFlag = 0 end
	
	if animation2 == "victim_fail" then 
		SetEntityHealth(PlayerPedId(),0)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false 
		holdingHostageInProgress = false 
	elseif animation2 == "shoved_back" then 
		holdingHostageInProgress = false 
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false 
	else
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)	
	end
end)

RegisterNetEvent('cmg3_animations:syncMe')
AddEventHandler('cmg3_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	--print("triggered cmg3_animations:syncMe")
	ClearPedSecondaryTask(PlayerPedId())
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	if animation == "perp_fail" then 
		SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, 0)
		holdingHostageInProgress = false 
	end
	if animation == "shove_var_a" then 
		Wait(900)
		ClearPedSecondaryTask(PlayerPedId())
		holdingHostageInProgress = false 
	end
end)

RegisterNetEvent('cmg3_animations:cl_stop')
AddEventHandler('cmg3_animations:cl_stop', function()
	holdingHostageInProgress = false
	beingHeldHostage = false 
	holdingHostage = false 
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

function GetPlayers()
    local players = {}

	for _, i in ipairs(GetActivePlayers()) do
        table.insert(players, i)
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

Citizen.CreateThread(function()
	while true do 
		if holdingHostage then
			if IsEntityDead(PlayerPedId()) then
				--print("release this mofo")			
				holdingHostage = false
				holdingHostageInProgress = false 
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations:stop",target)
				Wait(100)
				releaseHostage()
			end 
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisablePlayerFiring(PlayerPedId(),true)
			local playerCoords = GetEntityCoords(PlayerPedId())
			DrawText3D(playerCoords.x,playerCoords.y,playerCoords.z,"Serbest bırakmak için [G] - öldürmek için [H] tusuna bas")
			if IsDisabledControlJustPressed(0,47) then --release
				--print("release this mofo")			
				holdingHostage = false
				holdingHostageInProgress = false 
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations:stop",target)
				Wait(100)
				releaseHostage()
			elseif IsDisabledControlJustPressed(0,74) then --kill 
				--print("kill this mofo")				
				holdingHostage = false
				holdingHostageInProgress = false 		
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations:stop",target)				
				killHostage()
			end
		end
		if beingHeldHostage then 
			DisableControlAction(0,21,true) -- disable sprint
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,263,true) -- disable melee
			DisableControlAction(0,264,true) -- disable melee
			DisableControlAction(0,257,true) -- disable melee
			DisableControlAction(0,140,true) -- disable melee
			DisableControlAction(0,141,true) -- disable melee
			DisableControlAction(0,142,true) -- disable melee
			DisableControlAction(0,143,true) -- disable melee
			DisableControlAction(0,75,true) -- disable exit vehicle
			DisableControlAction(27,75,true) -- disable exit vehicle  
			DisableControlAction(0,22,true) -- disable jump
			DisableControlAction(0,32,true) -- disable move up
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true) -- disable move down
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true) -- disable move left
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true) -- disable move right
			DisableControlAction(0,271,true)
		end
		Wait(0)
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.19, 0.19)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function releaseHostage()
	local player = PlayerPedId()	
	lib = 'reaction@shove'
	anim1 = 'shove_var_a'
	lib2 = 'reaction@shove'
	anim2 = 'shoved_back'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 100000
	controlFlagMe = 120
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(2)
	target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		print("triggering cmg3_animations:sync")
		TriggerServerEvent('cmg3_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	else
		print("[CMG Anim] No player nearby")
	end
end 

function killHostage()
	local player = PlayerPedId()	
	lib = 'anim@gangops@hostage@'
	anim1 = 'perp_fail'
	lib2 = 'anim@gangops@hostage@'
	anim2 = 'victim_fail'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 0.2
	controlFlagMe = 168
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(2)
	target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		print("triggering cmg3_animations:sync")
		TriggerServerEvent('cmg3_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	else
		print("[CMG Anim] No player nearby")
	end	
end 

function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


