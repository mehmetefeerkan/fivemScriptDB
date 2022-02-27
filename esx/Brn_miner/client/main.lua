ESX = nil
local PlayerData = {}
local isMenuOn = false

local shopCostMenu = 0
local goldOresCount = 0
local ironOresCount = 0
local copperOresCount = 0
local diamondOresCount = 0
local totalOresCount = 0
local impacts = 0

local done = false
local event_destination = nil
local isMining = false
local newSpawnReady = true
local canpress = true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
	done = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local display = false

-- very important cb 
RegisterNUICallback("exit", function(data)

    SetDisplay(false)
    Citizen.Wait(3000)
    isMenuOn = false
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        goldOres = goldOresCount,
        ironOres = ironOresCount,
        copperOres = copperOresCount,
        diamondOres = diamondOresCount,
        totalOres = totalOresCount
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent("refreshItems:minerJob")
    end
end)

RegisterNetEvent("refreshGold:minerJob")
AddEventHandler("refreshGold:minerJob", function(goldCount)
    goldOresCount = goldCount
end)

RegisterNetEvent("refreshIron:minerJob")
AddEventHandler("refreshIron:minerJob", function(ironCount)
    ironOresCount = ironCount
end)

RegisterNetEvent("refreshCopper:minerJob")
AddEventHandler("refreshCopper:minerJob", function(copperCount)
    copperOresCount = copperCount
end)

RegisterNetEvent("refreshDiamond:minerJob")
AddEventHandler("refreshDiamond:minerJob", function(diamondCount)
    diamondOresCount = diamondCount
end)

RegisterNetEvent("refreshTotal:minerJob")
AddEventHandler("refreshTotal:minerJob", function(totalCount)
    totalOresCount = totalCount
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

--[[Citizen.CreateThread(function()
	--createAllBlip()
end)

function createAllBlip()
	--if PlayerData.job.name == 'miner' then
		local blip2 = AddBlipForCoord(2947.458, 2783.615, 39.902)
      	SetBlipSprite(blip2, 237)
      	SetBlipDisplay(blip2, 4)
      	SetBlipScale(blip2, 1.1)
     	SetBlipColour(blip2, 33)
      	SetBlipAsShortRange(blip2, true)
	    BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('1. Adım: Kazma Yeri')
		EndTextCommandSetBlipName(blip2)

		local blip = AddBlipForCoord(1084.781, -2002.84, 31.380)
      	SetBlipSprite(blip, 365)
      	SetBlipDisplay(blip, 4)
      	SetBlipScale(blip, 1.1)
     	SetBlipColour(blip, 33)
      	SetBlipAsShortRange(blip, true)
	    BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('2. Adım: Eritme Bölgesi')
		EndTextCommandSetBlipName(blip)

		local blip3 = AddBlipForCoord(-622.112, -230.578, 38.057)
      	SetBlipSprite(blip3, 207)
      	SetBlipDisplay(blip3, 4)
      	SetBlipScale(blip3, 1.1)
     	SetBlipColour(blip3, 33)
      	SetBlipAsShortRange(blip3, true)
	    BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('3. Adım: Madenleri Satma Bölgesi')
		EndTextCommandSetBlipName(blip3)
	--end
end]]

Citizen.CreateThread(function()

    RequestModel(826475330)
    while not HasModelLoaded(826475330) do
        Wait(1)

    end

    -- PROVIDER
    resSeller = CreatePed(1, 826475330, -618.587, -228.168, 37.056, 124.46, false, true)
    SetBlockingOfNonTemporaryEvents(resSeller, true)
    SetPedDiesWhenInjured(resSeller, false)
    SetPedCanPlayAmbientAnims(resSeller, true)
    SetPedCanRagdollFromPlayerImpact(resSeller, false)
    SetEntityInvincible(resSeller, true)
    FreezeEntityPosition(resSeller, true)
    -- TaskStartScenarioInPlace(resSeller, "WORLD_HUMAN_SMOKING", 0, true);

end)

Citizen.CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())

        Citizen.Wait(0)
        local distance2 = GetDistanceBetweenCoords(coords, -618.933, -228.402, 38.056, true)
        --if PlayerData.job.name == 'miner' then
            DrawMarker(2, -618.933, -228.402, 38.056, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 41, 197, 1, 110, 0,
                1, 0, 1)

            if distance2 < 2 then
                if IsControlJustReleased(0, 38) then
                    if isMenuOn == false then

                        SetDisplay(not display)
                        isMenuOn = true
                    end
                end
            end
		--end
    end
end)

Citizen.CreateThread(function()
	while not done do
		Citizen.Wait(10)
	end
	if PlayerData.job.name == 'miner' then
		local blip2 = AddBlipForCoord(2947.458, 2783.615, 39.902)
		SetBlipSprite(blip2, 237)
        SetBlipDisplay(blip2, 4)
        SetBlipScale(blip2, 1.1)
        SetBlipColour(blip2, 33)
        SetBlipAsShortRange(blip2, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('1. Adım: Kazma Yeri')
        EndTextCommandSetBlipName(blip2)

        local blip = AddBlipForCoord(1084.781, -2002.84, 31.380)
        SetBlipSprite(blip, 365)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.1)
        SetBlipColour(blip, 33)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('2. Adım: Eritme Bölgesi')
        EndTextCommandSetBlipName(blip)

        local blip3 = AddBlipForCoord(-622.112, -230.578, 38.057)
        SetBlipSprite(blip3, 207)
        SetBlipDisplay(blip3, 4)
        SetBlipScale(blip3, 1.1)
        SetBlipColour(blip3, 33)
        SetBlipAsShortRange(blip3, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('3. Adım: Madenleri Satma Bölgesi')
        EndTextCommandSetBlipName(blip3)
		done = true
	end
end)

Citizen.CreateThread(function()
    spawnNewMarker1()

    while true do
        Citizen.Wait(4)
        while newSpawnReady do
            Citizen.Wait(4)

            spawnNewMarker1()
            newSpawnReady = false
            Citizen.Wait(Config.RefreshMarkerTimer)

            newSpawnReady = true

        end
    end

end)

RegisterNUICallback("sellResource", function()
    TriggerServerEvent("sellResource:minerJob")
end)

RegisterNUICallback('sellCopper', function()
    TriggerServerEvent('sellCopper:minerJob')
end)

RegisterNUICallback('sellGold', function()
    TriggerServerEvent('sellGold:minerJob')
end)

RegisterNUICallback('sellIron', function()
    TriggerServerEvent('sellIron:minerJob')
end)

RegisterNUICallback('sellDiamond', function()
    TriggerServerEvent('sellDiamond:minerJob')
end)

local marker1spawnt = false

RegisterNetEvent("showReward:minerJob")
AddEventHandler("showReward:minerJob", function(completReward)
    exports['mythic_notify']:DoHudText('success', 'Madenleri ' .. completReward .. '$ karşılığında sattın')

    totalOresCount = completReward
end)

function spawnNewMarker1()
    marker1spawnt = false

    Citizen.Wait(1000)
    marker1spawnt = true

end

local eritiyor = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)

        while marker1spawnt do
            Citizen.Wait(4)
            local pos = GetEntityCoords(GetPlayerPed(-1), false)
            if PlayerData.job.name == 'miner' then

                for k, v in pairs(Config.Zones) do
                    -- if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                    local yenideger = v.Pos.z - 1.3
                    -- DrawMarker(v.Type, v.Pos.x, v.Pos.y, yenideger, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
                    local delivery_point_distance = Vdist(v.Pos.x, v.Pos.y, v.Pos.z, pos.x, pos.y, pos.z)

                    if delivery_point_distance < 1.5 then

                        if isMining == false then
                            DisplayHelpText("Kazmak için ~INPUT_CONTEXT~ tuşuna bas")
                            local ped = PlayerPedId()

                            if (IsControlJustReleased(1, 38)) then
                                if GetSelectedPedWeapon(ped) == GetHashKey("weapon_hammer") then
                                    mining()
                                    local myCoords = GetEntityCoords(GetPlayerPed(-1))
                                    TriggerServerEvent('brn:PlayWithinDistance', 0.5, 'kazma', 1.0, myCoords)
                                    exports['progressBars']:startUI(7500, "Taşı kazıyorsun")
                                else
                                    exports['mythic_notify']:DoHudText('error', 'Elinde kazma yok!')

                                end
                            end
                        end
                    end
                end
                local pos = GetEntityCoords(GetPlayerPed(-1), false)
                DrawMarker(25, 1084.232, -2002.17, 30.493, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.2, 2.2, 0.8, 255, 128, 0, 100,
                    false, true, 2, false, false, false, false)
                local eritmeyeridis = Vdist(1084.232, -2002.17, 30.493, pos.x, pos.y, pos.z)

                if eritmeyeridis < 1.5 then
                    if not eritiyor then
                        DisplayHelpText("Eritmek için ~INPUT_CONTEXT~ tuşuna bas")

                        if (IsControlJustReleased(1, 38)) then
                            if canpress then
                                eritiyor = true
                                canpress = false
                                -- local myCoords = GetEntityCoords(GetPlayerPed(-1))
                                ESX.TriggerServerCallback('brn:miner:eritebilir', function(eritesikite, stoneCount)
                                    if eritesikite then
                                        exports['progressBars']:startUI(stoneCount * 2 * 1000, "Madenler Eritiliyor")
                                        local d = 0
                                        while stoneCount > d do
                                            if eritmeyeridis < 1.5 then
                                                Citizen.Wait(1000)
                                                local myCoords = GetEntityCoords(GetPlayerPed(-1))
                                                local eritmeyeridis_ =
                                                    Vdist(1084.232, -2002.17, 30.493, myCoords.x, myCoords.y, myCoords.z)
                                                TriggerServerEvent('brn:eritmeitem', stoneCount, eritmeyeridis_)
                                            end
                                            d = d + 1
                                            Citizen.Wait(1000)
                                        end
                                    else
                                        exports['mythic_notify']:DoHudText('error', 'Üzerinde taş yok!')
                                    end
                                end)
                                canpress = true
                            end
                        end
                    end
                else
                    if eritiyor then
                        exports['mythic_notify']:DoHudText('error', 'Eritme alanından uzaklaştın!')
                        stoneCount = 0
                        eritiyor = false
                    end
                end
            end
        end
    end
end)

function mining()
    isMining = true
    Citizen.CreateThread(function()
        while impacts < 3 do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            RequestAnimDict("melee@large_wpn@streamed_core_fps")
            Citizen.Wait(100)
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core_fps', 'ground_attack_-90', 100.0, 100.0, -1, 80, 0)
            -- SetEntityHeading(ped, 270.0)
            if impacts == 0 then
                -- pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 54, 0, 0, true, true, true) 
                -- AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
            end
            Citizen.Wait(2500)
            impacts = impacts + 1
            if impacts == 3 then
                -- DetachEntity(pickaxe, 1, true)
                -- DeleteEntity(pickaxe)
                -- DeleteObject(pickaxe)
                impacts = 0
                Citizen.Wait(1000)

                TriggerServerEvent("addItems:minerJob")
                isMining = false

                break
            end
        end
    end)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
