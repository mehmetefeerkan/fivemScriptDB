---------------------------NewsPaper----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------
local display, toggleDisplay, paperon, param = false, true, true, ""
local PaperStandModels = { [3108197479] = true,[1211559620] = true,[3917076173] = true,[720581693] = true,[261193082] = true,[2911910593] = true, [1375076930] = true, [917457845] = true, [3538814340] = true, [3456106952] = true,}
Citizen.CreateThread(function(); print('Newspaper Starting'); if Config.usingESX then; ESX = nil; PlayerData = {}; Citizen.CreateThread(function()
while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end); print("loading ESX"); Citizen.Wait(0); end;
while ESX.GetPlayerData().job == nil do Citizen.Wait(10); end; PlayerData = ESX.GetPlayerData(); print("ESX loaded"); end);
Citizen.CreateThread(function() Citizen.Wait(10000); TriggerEvent("newspaper:off"); TriggerServerEvent("newspaper:update"); print("ESX-Newspaper by NuketheWhales7#7777 loaded"); end)
else Citizen.CreateThread(function() Citizen.Wait(10000); TriggerEvent("newspaper:off"); TriggerServerEvent("newspaper:update"); print("Newspaper by NuketheWhales7#7777 loaded"); end); end; end)
RegisterCommand(Config.NewsCommand, function(); if Config.useNewsStands then if CanGrabPaper then if toggleDisplay then TriggerEvent("newspaper:on"); toggleDisplay = false; paperon = true
else TriggerEvent("newspaper:off"); toggleDisplay = true; paperon = false; end; else TriggerEvent("newspaper:off"); toggleDisplay23 = true; paperon = false; end
else if toggleDisplay then TriggerEvent("newspaper:on"); toggleDisplay = false; paperon = true; else; TriggerEvent("newspaper:off"); toggleDisplay = true; paperon = false; end; end; end)
Citizen.CreateThread(function() if Config.useNewsStands then Citizen.CreateThread(function() while true do Citizen.Wait(1000); local paperObject, paperDistance = Stand()
if paperDistance < 3 then CanGrabPaper = true else CanGrabPaper = false if paperon then TriggerEvent("newspaper:off"); toggleDisplay = true; paperon = false;end; end; end; end); end; end)
function Stand() local coords, paperStands = GetEntityCoords(PlayerPedId()), {}; local handle, object = FindFirstObject(); local success; repeat; if PaperStandModels[GetEntityModel(object)] then table.insert(paperStands, object) end; success, object = FindNextObject(handle, object); until not success
EndFindObject(handle); local paperObject, paperDistance = 0, 1000; for k,v in pairs(paperStands) do local dstcheck = GetDistanceBetweenCoords(coords, GetEntityCoords(v)); if dstcheck < paperDistance then paperDistance = dstcheck; paperObject = v; end; end; return paperObject, paperDistance; end

RegisterNetEvent("newspaper:off")
AddEventHandler("newspaper:off", function(value)
    SendNUIMessage({
        type = 'ui',
        display = false
    })
end)

RegisterNetEvent("newspaper:on")
AddEventHandler("newspaper:on", function(value)
    SendNUIMessage({
        type = 'ui',
        display = true
    })
end)

RegisterNetEvent("newspaper:headlineTitle1")
AddEventHandler("newspaper:headlineTitle1", function(param)
    SendNUIMessage({
        type = 'updateTitle1',
        headlineTitle1 = param
    })
end)

RegisterNetEvent("newspaper:headlineTitle2")
AddEventHandler("newspaper:headlineTitle2", function(param)
    SendNUIMessage({
        type = 'updateTitle2',
        headlineTitle2 = param
    })
end)

RegisterNetEvent("newspaper:headline1")
AddEventHandler("newspaper:headline1", function(param)
    SendNUIMessage({
        type = 'updateHeadline1',
        headline1 = param
    })
end)

RegisterNetEvent("newspaper:headline2")
AddEventHandler("newspaper:headline2", function(param)
    SendNUIMessage({
        type = 'updateHeadline2',
        headline2 = param
    })
end)

RegisterNetEvent("newspaper:arrest1")
AddEventHandler("newspaper:arrest1", function(param)
    SendNUIMessage({
        type = 'updateArrest1',
        arrest1 = param
    })
end)

RegisterNetEvent("newspaper:arrest2")
AddEventHandler("newspaper:arrest2", function(param)
    SendNUIMessage({
        type = 'updateArrest2',
        arrest2 = param
    })
end)

RegisterNetEvent("newspaper:arrest3")
AddEventHandler("newspaper:arrest3", function(param)
    SendNUIMessage({
        type = 'updateArrest3',
        arrest3 = param
    })
end)

---------------------------NewsPaper----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------