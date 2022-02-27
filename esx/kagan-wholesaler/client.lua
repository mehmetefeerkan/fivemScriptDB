ESX = nil
PlayerData = {}
menu = false
menu2 = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    
    local blip = AddBlipForCoord( Config.NPCShop.x, Config.NPCShop.y, Config.NPCShop.z, - 1)
    SetBlipSprite(blip, 500)
    SetBlipColour(blip, 1)
    SetBlipScale  (blip, 0.6)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Toptancı')
    EndTextCommandSetBlipName(blip)
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

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

RegisterCommand('menukapat', function()
    ESX.UI.Menu.CloseAll()
end)

function menuac()
    ESX.UI.Menu.CloseAll()
    local elements = {}

    for k,v in pairs(Config.Recipes) do
        table.insert(elements, {label = v.GiveItem.label, value = k})
    end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gps', {
		title = 'Toptancı',
		align = 'top-left',
        elements = elements
    },function(data, menu)
		if data.current.value ~= nil then
            -- recipeItem(data.current.value)
            TriggerServerEvent('kagan-toptanci:item', data.current.value) 
            ESX.UI.Menu.CloseAll()
        else
            ESX.UI.Menu.CloseAll()
		end
	end)
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if IsControlJustPressed(0, 194) then 
            if menu == true then
                ESX.UI.Menu.CloseAll()
                menu = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        local sleep = 1000
        if Vdist2(GetEntityCoords(PlayerPedId(), false), -232.198, -914.976, 32.310) < 3.5 then
            DrawText3D(-232.198, -914.976, 32.310, '[E] - Toptanci')
            sleep = 7
            if IsControlJustPressed(0, 38) then
                menuac()
                menu = true
            end
        end
      Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    if Config.NPCEnable == true then
        RequestModel(Config.NPCHash)
        while not HasModelLoaded(Config.NPCHash) do
            Wait(1)
        end
    
        stanley = CreatePed(1, Config.NPCHash, Config.NPCShop.x, Config.NPCShop.y, Config.NPCShop.z, Config.NPCShop.h, false, true)
        SetBlockingOfNonTemporaryEvents(stanley, true)
        SetPedDiesWhenInjured(stanley, false)
        SetPedCanPlayAmbientAnims(stanley, true)
        SetPedCanRagdollFromPlayerImpact(stanley, false)
        SetEntityInvincible(stanley, true)
        FreezeEntityPosition(stanley, true)
        TaskStartScenarioInPlace(stanley, "WORLD_HUMAN_CLIPBOARD", 0, true);
    end
end)
