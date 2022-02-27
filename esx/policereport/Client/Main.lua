local isProximity = false
local isProximity2 = false
local ped = 0
local one_time = false

AddEventHandler('playerSpawned', function()
    setConfig()
end)

AddEventHandler('onResourceStart', function()
    Wait(5000)
    setConfig()
end)

function setConfig()
    SendNUIMessage({
        config = true,
        translate = translate,
        NameResource = GetCurrentResourceName()
    })

    if ped == 0 and not one_time then
		one_time = true
        RequestModel(GetHashKey(model_npc))
        while not HasModelLoaded(GetHashKey(model_npc)) do
            Wait(1)
        end
        
        for i,k in pairs(npc_coords) do
            ped = CreatePed(7, model_npc, k.x, k.y, k.z, npc_heading[i], false, false)
			SetEntityCoordsNoOffset(ped, k.x, k.y, k.z)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)
			Wait(500)
            Anim()
        end
    end
end

CreateThread(function()
    while true do
        local sleep = 1000

        if isProximity or isProximity2 then
            -- if isProximity and IsControlJustReleased(0, key_report) then
            --     TriggerServerEvent('lg: openReport')
            if isProximity2 and IsControlJustReleased(0, key_police) then
                TriggerServerEvent('lg: openAllReports')
            end

            sleep = 10
        else
            sleep = 1000
        end

        Wait(sleep)
    end

end)

CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1))

        local closest = false
        for i,k in pairs(npc_coords) do
            if #(pos - k) < distance_to_show_notify_npc then
                if not isProximity then
                    TriggerEvent('lg: PoliceReportNotify', translate.TR_PROXIMITY_NPC)    
                end

                isProximity = true
                closest = true
            end
        end

        if not closest then
            isProximity = false
        end       
        
        closest = false
        for i,k in pairs(computer_coords) do
            if #(pos - k) < distance_to_show_notify_computer then
                if not isProximity2 then
                    TriggerEvent('lg: PoliceReportNotify', translate.TR_PROXIMITY_COMPUTER)
                end

                isProximity2 = true
                closest = true
            end
        end

        if not closest then
            isProximity2 = false
        end
            
        
        Wait(1000)
    end
end)

RegisterNetEvent('lg: openReport')
AddEventHandler('lg: openReport', function(namePlayer)
    if not wait_time then
        SendNUIMessage({
            openReport = true,
            namePlayer = namePlayer
        })

        SetNuiFocus(true, true)
    else
        TriggerEvent('lg: PoliceReportNotify', translate.TR_WAIT)
    end
end)

RegisterNetEvent('lg: openAllReports')
AddEventHandler('lg: openAllReports', function(result)
    SendNUIMessage({
        openAllReports = true,
        reports = result
    })

    SetNuiFocus(true, true)
end)

RegisterNetEvent('lg: PoliceReportNotify')
AddEventHandler('lg: PoliceReportNotify', function(notify)
    SendNUIMessage({
        Notify = notify
    })
end)

RegisterNUICallback('saveReport', function(data, cb)
    wait_time = true
    SetTimeout(1000*time_wait_new, function()
        wait_time = false
    end)
    
    TriggerServerEvent("lg: saveReport", data)

    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)

    cb('ok')
end)

local prop = nil
function Anim()
    while not HasAnimDictLoaded('missheistdockssetup1clipboard@base') do
        RequestAnimDict('missheistdockssetup1clipboard@base')
        Wait(10)
    end

    TaskPlayAnim(ped, 'missheistdockssetup1clipboard@base', 'base', 2.0, 2.0, -1, 51, 0, false, false, false)
    RemoveAnimDict('missheistdockssetup1clipboard@base')

    local Player = ped
    local x,y,z = table.unpack(GetEntityCoords(Player))

    if not HasModelLoaded("prop_notepad_01") then
        while not HasModelLoaded(GetHashKey("prop_notepad_01")) do
            RequestModel(GetHashKey("prop_notepad_01"))
            Wait(10)
        end
    end

    prop = CreateObject(GetHashKey("prop_notepad_01"), x, y, z+0.2,  false,  false, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded("prop_notepad_01")
end

function StopAnim()
    ClearPedTasks(ped)
    if prop then
        DeleteEntity(prop)
    end
end