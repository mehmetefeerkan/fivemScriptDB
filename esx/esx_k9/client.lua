ESX = nil
local PlayerData = {}

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


--[[ Variables ]]--
    -- DO NOT CHANGE --
    local just_started = true
    local k9_name = "K9"
    local spawned_ped = nil
    local following = false
    local attacking = false
    local attacked_player = 0
    local searching = false
    local playing_animation = false

    local animations = {
        ['Normal'] = {
            sit = {
                dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
                anim = "idle_c"
            },
			sitstart = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@enter",
				anim = "enter"
			},
			sitstop = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@exit",
				anim = "exit"
			},
            laydown = {
                dict = "creatures@rottweiler@amb@sleep_in_kennel@",
                anim = "sleep_in_kennel"
            },
            searchhit = {
                dict = "creatures@rottweiler@indication@",
                anim = "indicate_high"
            },
			getout = {
				dict = "creatures@rottweiler@incar@",
				anim = "get_out"
			},
			pawsitdown = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@enter",
				anim = "enter"
			},
			pawsit = {
                dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
                anim = "idle_b"
            },
			pawenter = {
				dict = "creatures@rottweiler@tricks@",
				anim = "paw_right_enter"
			},
			pawloop = {
				dict = "creatures@rottweiler@tricks@",
				anim = "paw_right_loop"
			},
			pawend = {
				dict = "creatures@rottweiler@tricks@",
				anim = "paw_right_exit"
			},
			pawstandup = {
				dict = "creatures@rottweiler@amb@world_dog_sitting@exit",
				anim = "exit"
			},
			begenter = {
				dict = "creatures@rottweiler@tricks@",
				anim = "beg_enter"
			},
			begloop = {
				dict = "creatures@rottweiler@tricks@",
				anim = "beg_loop"
			},
			begexit = {
				dict = "creatures@rottweiler@tricks@",
				anim = "beg_exit"
			},
        }
    }
--]]

--[[ Tables ]]--
local language = {}
--]]

--[[ NUI Messages ]]--

    -- Open Menu --
    function EnableMenu()
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "open_k9_menu"
        })
    end

--]]

--[[ NUI Callbacks ]]--

    RegisterNUICallback("closemenu", function(data)
        SetNuiFocus(false, false)
    end)

    RegisterNUICallback("updatename", function(data)
        k9_name = data.name
    end)

    RegisterNUICallback("spawnk9", function(data)
        TriggerEvent("K9:ToggleK9", data.model)
    end)
	
    RegisterNUICallback("spawnk9polis", function(data)
        TriggerEvent("Polis:ToggleK9", data.model)
    end)

    RegisterNUICallback("vehicletoggle", function(data)
        if spawned_ped ~= nil then
            TriggerServerEvent("K9:RequestVehicleToggle")
        end
    end)

    RegisterNUICallback("vehiclesearch", function(data)
        if spawned_ped ~= nil then
            TriggerServerEvent("K9:RequestItems")
        end
    end)

    RegisterNUICallback("sit", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
        end
    end)

    RegisterNUICallback("laydown", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].laydown.dict, animations['Normal'].laydown.anim)
        end
    end)
	
	RegisterNUICallback("pawsitdown", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawsitdown.dict, animations['Normal'].pawsitdown.anim)
        end
    end)
	
	RegisterNUICallback("pawsit", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawsitdown.dict, animations['Normal'].pawsitdown.anim)
        end
    end)
	
	RegisterNUICallback("pawsit", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawsit.dict, animations['Normal'].pawsit.anim)
        end
    end)
	
	RegisterNUICallback("pawenter", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawenter.dict, animations['Normal'].pawenter.anim)
        end
    end)
	
	RegisterNUICallback("pawloop", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawloop.dict, animations['Normal'].pawloop.anim)
        end
    end)
	
	RegisterNUICallback("pawend", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawend.dict, animations['Normal'].pawend.anim)
        end
    end)
	
	RegisterNUICallback("pawstandup", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawstandup.dict, animations['Normal'].pawstandup.anim)
        end
    end)
	
	RegisterNetEvent("K9:animationss")
    AddEventHandler("K9:sit", function()
	if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
    end
	end)
	
	AddEventHandler("K9:laydown", function()
	if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].laydown.dict, animations['Normal'].laydown.anim)
    end
	end)
	
	AddEventHandler("K9:standup", function()
	if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].pawstandup.dict, animations['Normal'].pawstandup.anim)
    end
	end)
	
	AddEventHandler("K9:k9toggle", function()
		TriggerEvent("K9:ToggleK9", data.model)
	end)
	
	AddEventHandler("K9:k9toggle", function()
		TriggerEvent("Polis:ToggleK9", data.model)
	end)
	
	AddEventHandler("K9:vehicletoggle", function()
	if spawned_ped ~= nil then
            TriggerServerEvent("K9:RequestVehicleToggle")
    end
	end)
	
	AddEventHandler("K9:vehiclesearch", function()
	if spawned_ped ~= nil then
            TriggerServerEvent("K9:RequestItems")
        end
	end)

--]]		

--[[ Main Event Handlers ]]--

    -- Updates Language Settings
    RegisterNetEvent("K9:UpdateLanguage")
    AddEventHandler("K9:UpdateLanguage", function(commands)
        language = commands
        Citizen.Trace(tostring(json.encode(language)))
    end)

    -- Opens K9 Menu
    RegisterNetEvent("K9:OpenMenu")
    AddEventHandler("K9:OpenMenu", function(pedRestriction, pedList)
        if pedRestriction then
            if CheckPedRestriction(GetLocalPed(), pedList) then
                EnableMenu()
            else
                TriggerEvent("pNotify:SendNotification", {text = "Zmie?? model postaci, aby u??ywa?? K9."})
            end
        else
            EnableMenu()
        end
    end)

    -- Error for Identifier Whitelist
    RegisterNetEvent("K9:IdentifierRestricted")
    AddEventHandler("K9:IdentifierRestricted", function()
        --TriggerEvent("pNotify:SendNotification", {text = "~r~Nie masz uprawnie??!"})
    end)
	
	-- Beg Trick
	RegisterNetEvent("K9:Beg")
    AddEventHandler("K9:Beg", function()
        if spawned_ped ~= nil then
            if not following then
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
					TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
                    SetPedKeepTask(spawned_ped, true)
                    following = true
                    attacking = false
                    TriggerEvent("pNotify:SendNotification", {text = k9_name .. " " .. language.good})
                end
            else
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    SetPedKeepTask(spawned_ped, false)
                    ClearPedTasks(spawned_ped)
                    following = false
                    attacking = false
					TriggerEvent("pNotify:SendNotification", {text = k9_name .. " " .. language.beg})
					PlayAnimation(animations['Normal'].begenter.dict, animations['Normal'].begenter.anim)
					Citizen.Wait(650)
					PlayAnimation(animations['Normal'].begloop.dict, animations['Normal'].begloop.anim)
					Citizen.Wait(450)
					PlayAnimation(animations['Normal'].begloop.dict, animations['Normal'].begloop.anim)
					Citizen.Wait(450)
					PlayAnimation(animations['Normal'].begexit.dict, animations['Normal'].begexit.anim)
                end
            end
        end
    end)
	
	-- Paw Trick
	RegisterNetEvent("K9:Paw")
    AddEventHandler("K9:Paw", function()
        if spawned_ped ~= nil then
            if not following then
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    PlayAnimation(animations['Normal'].pawstandup.dict, animations['Normal'].pawstandup.anim)
					TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
                    SetPedKeepTask(spawned_ped, true)
                    following = true
                    attacking = false
                    TriggerEvent("pNotify:SendNotification", {text = k9_name .. " " .. language.good})
                end
            else
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    SetPedKeepTask(spawned_ped, false)
                    ClearPedTasks(spawned_ped)
                    following = false
                    attacking = false
					TriggerEvent("pNotify:SendNotification", {text = k9_name .. " " .. language.paw})
					PlayAnimation(animations['Normal'].pawsitdown.dict, animations['Normal'].pawsitdown.anim)
					Citizen.Wait(1200)
					PlayAnimation(animations['Normal'].pawsit.dict, animations['Normal'].pawsit.anim)
					Citizen.Wait(150)
					PlayAnimation(animations['Normal'].pawenter.dict, animations['Normal'].pawenter.anim)
					Citizen.Wait(600)
					PlayAnimation(animations['Normal'].pawloop.dict, animations['Normal'].pawloop.anim)
					Citizen.Wait(3000)
					PlayAnimation(animations['Normal'].pawend.dict, animations['Normal'].pawend.anim)
					Citizen.Wait(450)
					PlayAnimation(animations['Normal'].pawsit.dict, animations['Normal'].pawsit.anim)
                end
            end
        end
    end)

    -- Spawns and Deletes K9
    RegisterNetEvent("K9:ToggleK9")
    AddEventHandler("K9:ToggleK9", function(model)
	if PlayerData.job and PlayerData.job.name == 'police' then
	TriggerEvent('notification', 'Sadece K9 ??a????rabilirsin!', 2)
	else
        if spawned_ped == nil then
		TriggerEvent('notification', 'Pet ??a????r??ld??!', 1)
            local ped = GetHashKey(model)
            RequestModel(ped)
            while not HasModelLoaded(ped) do
                Citizen.Wait(1)
                RequestModel(ped)
            end
            local plyCoords = GetOffsetFromEntityInWorldCoords(GetLocalPed(), 0.0, 2.0, 0.0)
            local dog = CreatePed(28, ped, plyCoords.x, plyCoords.y, plyCoords.z, GetEntityHeading(GetLocalPed()), 0, 1)
            spawned_ped = dog
			PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
            SetBlockingOfNonTemporaryEvents(spawned_ped, true)
            SetPedFleeAttributes(spawned_ped, 0, 0)
            SetPedRelationshipGroupHash(spawned_ped, GetHashKey("k9"))
            local blip = AddBlipForEntity(spawned_ped)
            SetBlipAsFriendly(blip, true)
            SetBlipSprite(blip, 442)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(tostring("K9: ".. k9_name))
            EndTextCommandSetBlipName(blip)
            NetworkRegisterEntityAsNetworked(spawned_ped)
            while not NetworkGetEntityIsNetworked(spawned_ped) do
                NetworkRegisterEntityAsNetworked(spawned_ped)
                Citizen.Wait(1)
            end
        else
		TriggerEvent('notification', 'Pet G??nderildi!', 1)
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                SetEntityAsMissionEntity(spawned_ped, true, true)
                DeleteEntity(spawned_ped)
                spawned_ped = nil
                if attacking then
                    SetPedRelationshipGroupDefaultHash(target_ped, GetHashKey("CIVMALE"))
                    target_ped = nil
                    attacking = false
                end
                following = false
                searching = false
                playing_animation = false
            end
        end
		end
    end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
end)

    -- Polis Spawn K9
    RegisterNetEvent("Polis:ToggleK9")
    AddEventHandler("Polis:ToggleK9", function(model)
	if PlayerData.job and PlayerData.job.name == 'police' then
        if spawned_ped == nil then
		TriggerEvent('notification', 'K9 ??a????r??ld??', 1)
            local ped = GetHashKey(model)
            RequestModel(ped)
            while not HasModelLoaded(ped) do
                Citizen.Wait(1)
                RequestModel(ped)
            end
            local plyCoords = GetOffsetFromEntityInWorldCoords(GetLocalPed(), 0.0, 2.0, 0.0)
            local dog = CreatePed(28, ped, plyCoords.x, plyCoords.y, plyCoords.z, GetEntityHeading(GetLocalPed()), 0, 1)
            spawned_ped = dog
			PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
            SetBlockingOfNonTemporaryEvents(spawned_ped, true)
            SetPedFleeAttributes(spawned_ped, 0, 0)
            SetPedRelationshipGroupHash(spawned_ped, GetHashKey("k9"))
            local blip = AddBlipForEntity(spawned_ped)
            SetBlipAsFriendly(blip, true)
            SetBlipSprite(blip, 442)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(tostring(k9_name))
            EndTextCommandSetBlipName(blip)
            NetworkRegisterEntityAsNetworked(spawned_ped)
            while not NetworkGetEntityIsNetworked(spawned_ped) do
                NetworkRegisterEntityAsNetworked(spawned_ped)
                Citizen.Wait(1)
            end
        else
		TriggerEvent('notification', 'K9 G??nderildi', 1)
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                SetEntityAsMissionEntity(spawned_ped, true, true)
                DeleteEntity(spawned_ped)
                spawned_ped = nil
                if attacking then
                    SetPedRelationshipGroupDefaultHash(target_ped, GetHashKey("CIVMALE"))
                    target_ped = nil
                    attacking = false
                end
                following = false
                searching = false
                playing_animation = false
            end
        end
		else
		TriggerEvent('notification', 'Polis De??ilsin!', 2)
		end
    end)

    -- Toggles K9 to Follow / Heel
    RegisterNetEvent("K9:ToggleFollow")
    AddEventHandler("K9:ToggleFollow", function()
        if spawned_ped ~= nil then
            if not following then
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
				if PlayerData.job and PlayerData.job.name == 'police' then
                    PlayAnimation(animations['Normal'].sitstop.dict, animations['Normal'].sitstop.anim)
					ExecuteCommand('e parmaka??a????')
					exports["t0sic_loadingbar"]:StartDelayedFunction("K9 takip ediyor", 1500, function()
					TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
					SetPedKeepTask(spawned_ped, true)
					following = true
					attacking = false
					TriggerEvent('notification', 'K9 takip ediyor', 1)
					end)					
				else
					PlayAnimation(animations['Normal'].sitstop.dict, animations['Normal'].sitstop.anim)
					TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
					SetPedKeepTask(spawned_ped, true)
					following = true
					attacking = false
				end
                end
            else
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
				if PlayerData.job and PlayerData.job.name == 'police' then
					ExecuteCommand('e parmaka??a????')
					exports["t0sic_loadingbar"]:StartDelayedFunction("K9 oturuyor", 1500, function()
					PlayAnimation(animations['Normal'].sitstart.dict, animations['Normal'].sitstart.anim)
                    SetPedKeepTask(spawned_ped, false)
                    ClearPedTasks(spawned_ped)
                    following = false
                    attacking = false
					TriggerEvent('notification', 'K9 oturdu', 1)
					PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
					end)
				else
					PlayAnimation(animations['Normal'].sitstart.dict, animations['Normal'].sitstart.anim)
                    SetPedKeepTask(spawned_ped, false)
                    ClearPedTasks(spawned_ped)
                    following = false
                    attacking = false
					PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
				end
                end
            end
        end
    end)

    -- Toggles K9 In and Out of Vehicles
    RegisterNetEvent("K9:ToggleVehicle")
    AddEventHandler("K9:ToggleVehicle", function(isRestricted, vehList)
        if not searching then
            if IsPedInAnyVehicle(spawned_ped, false) then
				if PlayerData.job and PlayerData.job.name == 'police' then
				local ped = PlayerPedId()
				local currentPos = GetEntityCoords(ped)
				ExecuteCommand('e parmaka??a????')
								exports["t0sic_loadingbar"]:StartDelayedFunction("K9 ara??tan iniyor", 1500, function()
								SetEntityCoords(spawned_ped, currentPos.x, currentPos.y, currentPos.z, false, false, false, true)
								TriggerEvent('notification', 'K9 ara??tan indi.', 1)
								end)
				Citizen.Wait(18)
				PlayAnimation(animations['Normal'].getout.dict, animations['Normal'].getout.anim)
				else
				local ped = PlayerPedId()
				local currentPos = GetEntityCoords(ped)
								SetEntityCoords(spawned_ped, currentPos.x, currentPos.y, currentPos.z, false, false, false, true)
				Citizen.Wait(18)
				PlayAnimation(animations['Normal'].getout.dict, animations['Normal'].getout.anim)
				end
            else
                if not IsPedInAnyVehicle(GetLocalPed(), false) then
                    local plyCoords = GetEntityCoords(GetLocalPed(), false)
                    local vehicle = GetVehicleAheadOfPlayer()
                    local door = GetClosestVehicleDoor(vehicle)
                    if door ~= false then
                        if isRestricted then
                            if CheckVehicleRestriction(vehicle, vehList) then
							if PlayerData.job and PlayerData.job.name == 'police' then
								ExecuteCommand('e parmaka??a????')
								TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
								exports["t0sic_loadingbar"]:StartDelayedFunction("K9 araca biniyor", 1500, function()
								TaskWarpPedIntoVehicle(spawned_ped, vehicle, 1)
								TriggerEvent('notification', 'K9 araca bindi', 1)
								end)
							else
								TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
								Citizen.Wait(500)
								TaskWarpPedIntoVehicle(spawned_ped, vehicle, 1)
							end
                            end
                        else
							if PlayerData.job and PlayerData.job.name == 'police' then
							ExecuteCommand('e parmaka??a????')
							TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
								exports["t0sic_loadingbar"]:StartDelayedFunction("K9 araca biniyor", 1500, function()
								TaskWarpPedIntoVehicle(spawned_ped, vehicle, 1)
								TriggerEvent('notification', 'K9 araca bindi', 1)
								end)
							else
								TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
								Citizen.Wait(500)
								TaskWarpPedIntoVehicle(spawned_ped, vehicle, 1)
							end
                        end
                    end
                else
                    local vehicle = GetVehiclePedIsIn(GetLocalPed(), false)
                    local door = 1
                    if isRestricted then
                        if CheckVehicleRestriction(vehicle, vehList) then
                            TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                            TriggerEvent("pNotify:SendNotification", {text = k9_name .. " " .. language.enter})
                        end
                    else
                        TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                        TriggerEvent("pNotify:SendNotification", {text = k9_name .. " " .. language.enter})
                    end
                end
            end
        end
    end)

    -- Triggers K9 to Attack
    RegisterNetEvent("K9:ToggleAttack")
    AddEventHandler("K9:ToggleAttack", function(target)
        if not attacking and not searching then
            if IsPedAPlayer(target) then
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    local player = GetPlayerFromServerId(GetPlayerId(target))
                    SetCanAttackFriendly(spawned_ped, true, true)
                    TaskPutPedDirectlyIntoMelee(spawned_ped, GetPlayerPed(player), 0.0, -1.0, 0.0, 0)
                    attacked_player = player
                end
            else
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    SetCanAttackFriendly(spawned_ped, true, true)
                    TaskPutPedDirectlyIntoMelee(spawned_ped, target, 0.0, -1.0, 0.0, 0)
                    attacked_player = 0
                end
            end
            attacking = true
            following = false
            TriggerEvent("pNotify:SendNotification", {text = k9_name .. " " .. language.attack})
        end
    end)

    -- Triggers K9 to Search Vehicle
    RegisterNetEvent("K9:SearchVehicle")
    AddEventHandler("K9:SearchVehicle", function(items, openDoors)
        local vehicle = GetVehicleAheadOfPlayer()
        Citizen.Trace(tostring(vehicle))
        Citizen.Trace(tostring(json.encode(items)))
        if vehicle ~= 0 and not searching then
            searching = true
            local found_table = {}

            TriggerEvent("pNotify:SendNotification", {text = k9_name .. " zacz???? szuka??..."})
            
            if openDoors then
                SetVehicleDoorOpen(vehicle, 0, 0, 0)
                SetVehicleDoorOpen(vehicle, 1, 0, 0)
                SetVehicleDoorOpen(vehicle, 2, 0, 0)
                SetVehicleDoorOpen(vehicle, 3, 0, 0)
                SetVehicleDoorOpen(vehicle, 4, 0, 0)
                SetVehicleDoorOpen(vehicle, 5, 0, 0)
                SetVehicleDoorOpen(vehicle, 6, 0, 0)
                SetVehicleDoorOpen(vehicle, 7, 0, 0)
            end

            -- Back Right
            local offsetOne = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, -2.0, 0.0)
            TaskGoToCoordAnyMeans(spawned_ped, offsetOne.x, offsetOne.y, offsetOne.z, 5.0, 0, 0, 1, 10.0)
            local oneItem = ChooseItem(items)
            if oneItem ~= false then
                table.insert(found_table, oneItem)
            end

            Citizen.Wait(7000)

            -- Front Right
            local offsetTwo = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, 2.0, 0.0)
            TaskGoToCoordAnyMeans(spawned_ped, offsetTwo.x, offsetTwo.y, offsetTwo.z, 5.0, 0, 0, 1, 10.0)
            local twoItem = ChooseItem(items)
            if twoItem ~= false then
                table.insert(found_table, twoItem)
            end

            Citizen.Wait(7000)

            -- Front Left
            local offsetThree = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, 2.0, 0.0)
            TaskGoToCoordAnyMeans(spawned_ped, offsetThree.x, offsetThree.y, offsetThree.z, 5.0, 0, 0, 1, 10.0)
            local threeItem = ChooseItem(items)
            if threeItem ~= false then
                table.insert(found_table, threeItem)
            end

            Citizen.Wait(7000)

            -- Front Right
            local offsetFour = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, -2.0, 0.0)
            TaskGoToCoordAnyMeans(spawned_ped, offsetFour.x, offsetFour.y, offsetFour.z, 5.0, 0, 0, 1, 10.0)
            local fourItem = ChooseItem(items)
            if fourItem ~= false then
                table.insert(found_table, fourItem)
            end

            Citizen.Wait(7000)

            if openDoors then
                SetVehicleDoorsShut(vehicle, 0)
            end

            local stringified_table = {}
            local found_illegal_item = false
            for a = 1, #found_table do
                table.insert(stringified_table, found_table[a].item)
                if found_table[a].illegal then
                    found_illegal_item = true
                end
            end

            if found_illegal_item then
                PlayAnimation(animations['Normal'].searchhit.dict, animations['Normal'].searchhit.anim)
                Citizen.Wait(3000)
                PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
            end

            TriggerEvent("pNotify:SendNotification", {text = k9_name .. " znalaz?? [ " .. tostring(table.concat(stringified_table, ", ")) .. " ]."})
            searching = false
        end
    end)
	
RegisterNetEvent("K9:Attack")
AddEventHandler("K9:Attack", function()
	if PlayerData.job and PlayerData.job.name == 'police' then
	if DoesEntityExist(spawned_ped) then
        if not IsPedDeadOrDying(spawned_ped) then
            if GetDistanceBetweenCoords(GetEntityCoords(spawned_ped), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                local player, distance = ESX.Game.GetClosestPlayer()
                if distance ~= -1 then
                    if distance <= 3.0 then
                        local playerPed = GetPlayerPed(player)
                        if not IsPedInCombat(spawned_ped, playerPed) then
                            if not IsPedInAnyVehicle(playerPed, true) then
							exports["t0sic_loadingbar"]:StartDelayedFunction("K9 sald??r??yor", 3000, function()
                                TaskCombatPed(spawned_ped, playerPed, 0, 16)
								end)
                            end
                        else
                            ClearPedTasksImmediately(spawned_ped)
                        end
                    end
                end
            end
        end
    end
	end
end)


--]]

RegisterCommand('petmenu', function()
 TriggerServerEvent("K9:RequestOpenMenu")
end)

--[[ Threads ]]

    -- Controls Menu
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            -- Trigger Opens Menu
           --  if IsControlJustPressed(1, 314) and GetLastInputMethod( 0 ) then
           --      TriggerServerEvent("K9:RequestOpenMenu")
          --   end

            -- Trigger Attack
          --   if IsControlJustPressed(1, 47) and GetLastInputMethod( 0 ) and IsPlayerFreeAiming(PlayerId()) then
          --       local target = nil
           --      local bool, target = GetEntityPlayerIsFreeAimingAt(PlayerId(), target)

           --      if bool then
            --        if IsEntityAPed(target) then
             --            TriggerEvent("K9:ToggleAttack", target)
            --         end
            --     end
           --  end

            -- Trigger Follow
            if IsControlJustPressed(1, 108) and not IsPlayerFreeAiming(PlayerId()) and GetLastInputMethod( 0 ) then
                TriggerEvent("K9:ToggleFollow")
            end
			
			-- Trigger Vehicle In/Out
			if IsControlJustPressed(1, 111) and GetLastInputMethod( 0 ) then
				TriggerEvent("K9:ToggleVehicle")
			end
			
			-- Paw Trick
			if IsControlJustPressed(1, 109) and GetLastInputMethod( 0 ) then
				TriggerEvent("K9:Paw")
			end
			
			-- Beg Trick
			if IsControlJustPressed(1, 110) and GetLastInputMethod( 0 ) then
				TriggerEvent("K9:Beg")
			end
			
			if IsControlJustPressed(1, 118) and GetLastInputMethod( 0 ) then
				TriggerEvent("K9:Attack")
			end
			
			if IsControlJustPressed(1, 117) and GetLastInputMethod( 0 ) then
				TriggerEvent("K9:laydown")
			end
        end
    end)

    -- DO NOT TOUCH (CLEANER)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            -- Setting K9 Settings
            if just_started then
                Citizen.Wait(1000)
                local resource = GetCurrentResourceName()
                SendNUIMessage({
                    type = "update_resource_name",
                    name = resource
                })
                just_started = false
                SetNuiFocus(false, false)
                TriggerServerEvent("K9:SendLanguage")
            end

            -- Deletes K9 when you die
            if spawned_ped ~= nil and IsEntityDead(GetLocalPed()) then
                TriggerEvent("K9:ToggleK9")
				TriggerEvent("Polis:ToggleK9")
            end
        end
    end)

--]]

--[[ EXTRA FUNCTIONS ]]--

-- Gets Local Ped
function GetLocalPed()
    return GetPlayerPed(PlayerId())
end

-- Gets Control Of Ped
function RequestNetworkControl(callback)
    local netId = NetworkGetNetworkIdFromEntity(spawned_ped)
    local timer = 0
    NetworkRequestControlOfNetworkId(netId)
    while not NetworkHasControlOfNetworkId(netId) do
        Citizen.Wait(1)
        NetworkRequestControlOfNetworkId(netId)
        timer = timer + 1
        if timer == 5000 then
            Citizen.Trace("Control failed")
            callback(false)
            break
        end
    end
    callback(true)
end

-- Gets Players
function GetPlayers()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

-- Get Searching item
function ChooseItem(items)
    local number = math.random(1, 100)

    if number > 70 and number < 95 then -- 70 | 95
        local randomItem = math.random(1, #items)
        return items[randomItem]
    else
        return false
    end
end

-- Set K9 Animation (Sit / Laydown)
function PlayAnimation(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(spawned_ped, dict, anim, 8.0, -8.0, -1, 2, 0.0, 0, 0, 0)
end

-- Gets Player ID
function GetPlayerId(target_ped)
    local players = GetPlayers()
    for a = 1, #players do
        local ped = GetPlayerPed(players[a])
        local server_id = GetPlayerServerId(players[a])
        if target_ped == ped then
            return server_id
        end
    end
    return 0
end

-- Checks Ped Restriction
function CheckPedRestriction(ped, PedList)
	for i = 1, #PedList do
		if GetHashKey(PedList[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

-- Checks Vehicle Restriction
function CheckVehicleRestriction(vehicle, VehicleList)
	for i = 1, #VehicleList do
		if GetHashKey(VehicleList[i]) == GetEntityModel(vehicle) then
			return true
		end
	end
	return false
end

-- Gets Vehicle Ahead Of Player
function GetVehicleAheadOfPlayer()
    local lPed = GetLocalPed()
    local lPedCoords = GetEntityCoords(lPed, alive)
    local lPedOffset = GetOffsetFromEntityInWorldCoords(lPed, 0.0, 3.0, 0.0)
    local rayHandle = StartShapeTestCapsule(lPedCoords.x, lPedCoords.y, lPedCoords.z, lPedOffset.x, lPedOffset.y, lPedOffset.z, 1.2, 10, lPed, 7)
    local returnValue, hit, endcoords, surface, vehicle = GetShapeTestResult(rayHandle)

    if hit then
        return vehicle
    else
        return false
    end
end

-- Gets Closest Door To Player
function GetClosestVehicleDoor(vehicle)
    local plyCoords = GetEntityCoords(GetLocalPed(), false)
	local backleft = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_r"))
	local backright = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_pside_r"))
	local frontright = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_pside_f"))
	local bldistance = GetDistanceBetweenCoords(backleft['x'], backleft['y'], backleft['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)
    local brdistance = GetDistanceBetweenCoords(backright['x'], backright['y'], backright['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)
	local frdistance = GetDistanceBetweenCoords(frontright['x'], frontright['y'], frontright['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)

    local found_door = false

    if (bldistance < brdistance) then
        found_door = 1
    elseif(brdistance < bldistance) then
        found_door = 2
	elseif(frdistance < brdistance) then
        found_door = 3
	elseif(frdistance < bldistance) then
        found_door = 3
    end

    return found_door
end

-- Displays Notification
function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end
--]]