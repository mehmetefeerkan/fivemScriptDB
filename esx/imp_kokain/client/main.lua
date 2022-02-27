ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local satiyormu = false
local satiskordinat = false
local satisblip = false

Citizen.CreateThread(function()
    local hash = GetHashKey(Config.PedHash)
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", Config.PedHash, Config.PedKonum.x, Config.PedKonum.y, Config.PedKonum.z, Config.PedKonum.h, false, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	TaskStartScenarioAtPosition(ped, "WORLD_HUMAN_COP_IDLES", Config.PedKonum.x, Config.PedKonum.y, Config.PedKonum.z, Config.PedKonum.h, -1, false, false)
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.PedKonum.x, Config.PedKonum.y, Config.PedKonum.z, true)
        local coords = GetBlipInfoIdCoord(satisblip)
        local dst2 = GetDistanceBetweenCoords(playercoords, coords[1], coords[2], coords[3], true)
        if dst < 3 then
            sleep = 7
            DrawText3D(Config.PedKonum.x, Config.PedKonum.y, Config.PedKonum.z + 1.0, '~g~E~s~ - Uyusturucu Satıcısı')
            if IsControlJustReleased(0, 38) then
                KokoSat()
            end
        end
        if satiyormu == true and satiskordinat ~= false and dst2 < 2 then
            sleep = 7
            DrawText3D(coords[1], coords[2], coords[3] + 1.0, '~g~E~s~ - Alıcıyla Konus')
            if koko
            if IsControlJustReleased(0, 38) then
                KokoSat2()
            end
        end
        Citizen.Wait(sleep)
    end
end)


function KokoSat()
    if not satiyormu then
        ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
            local random = math.random(1,#Config.Locations)
	        satisblip = true
	        satiskordinat = {
		        x = Config.Locations[random][1],
		        y = Config.Locations[random][2],
		        z = Config.Locations[random][3],
		        h = Config.Locations[random][4]
	        }
	        satisblip = SatisBlipOlustur(satiskordinat.x, satiskordinat.y, satiskordinat.z)
            satiyormu = true
            ESX.ShowNotification('Koko satmaya başladın!')
            local hash = GetHashKey('a_m_m_bevhills_01')
            while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(20)
            end
            npc = CreatePed("PED_TYPE_CIVFEMALE", 'a_m_m_bevhills_01', satiskordinat.x, satiskordinat.y, satiskordinat.z, satiskordinat.h, true, false)
            PlaceObjectOnGroundProperly(npc)
            SetEntityAsMissionEntity(npc)
            SetBlockingOfNonTemporaryEvents(npc, true)
            FreezeEntityPosition(npc, true)
            SetEntityInvincible(npc, true)
            TaskStartScenarioAtPosition(npc, "CODE_HUMAN_CROSS_ROAD_WAIT", satiskordinat.x, satiskordinat.y, satiskordinat.z, satiskordinat.h, -1, false, false)
        end, "koko_paketlenmis", 1)
    elseif satiyormu then
        ESX.ShowNotification('Zaten uyuşturucu satıyorsun!')
    end
end

function KokoSat2()
    exports['mythic_progbar']:Progress({
        name = "alicikonusma",
        duration = 10000,
        label = 'Alıcıyla konuşuyorsun...',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_common",
            anim = "givetake1_a",
            flags = 49,
        },
        prop = {
            model = "prop_weed_bottle",
            bone = 58866,
            coords = { x = 0.12, y = 0.0, z = 0.001 },
            rotation = { x = -150.0, y = 0.0, z = 0.0 },
        },
    }, function(cancelled)
        if not cancelled then
            TriggerServerEvent('utx-weed:sellweed')
            satiskordinat = false
            satiyormu = false
            ClearPedTasks(npc)
            SetPedAsNoLongerNeeded(npc)
            TaskWanderStandard(npc, 10.0, 10)
            ESX.ShowNotification('Başarıyla Kokain sattın!')
        else
         
        end
    end)
end

function SatisBlipOlustur(x,y,z)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip, 514)
	SetBlipColour(blip, 4)
	AddTextEntry('MYBLIP', "Alıcı")
	BeginTextCommandSetBlipName('MYBLIP')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	return blip
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if satiyormu == false and satisblip ~= false then
            sleep = 7
			RemoveBlip(satisblip)
			satisblip = false
        end
        Citizen.Wait(sleep)
    end
end)

if Config.SaticiBlip then
    local coords = vector3(Config.PedKonum.x, Config.PedKonum.y, Config.PedKonum.z)
    local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 500)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 1)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Kokain Satıcısı')
    EndTextCommandSetBlipName(blip)
end
