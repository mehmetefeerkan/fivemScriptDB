local PlayerData = {}
ESX = nil

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

CreateThread(function()   
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
    SetAudioFlag("PoliceScannerDisabled",true);
end)

markets = {
    -- Markets
    {372.98,328.13,103.57,245.0,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {2676.57,3280.19,55.24,328.08,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1959.1,3741.48,32.34,296.51,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1392.33,3606.27,34.98,197.18,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1697.1,4923.52,42.06,327.59,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1728.39,6416.75,35.04,238.52,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1165.41,2710.95,38.15,178.92,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {549.33,2669.77,42.15,111.27,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-3243.93,1000.02,12.83,352.04,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-3040.49,583.88,7.91,17.94,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-2966.18,391.49,15.04,82.43,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1819.45,793.68,138.08,132.59,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1486.59,-377.41,40.16,125.62,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1221.37,-907.95,12.33,30.08,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-706.04,-914.4,19.22,90.99,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {24.38,-1345.72,29.5,271.7,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-47.24,-1758.68,29.42,54.73,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1134.22,-983.14,46.42,279.1,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1164,-323.63,691.21,92.28,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {2555,380.83,108.62,4.25,"mp_m_shopkeep_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- Ammunations
    {810.39,-2159.13,29.62,7.62,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {23.15,-1105.72,29.8,153.24,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {842.19,-1035.34,28.19,356.79,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-661.81,-933.35,21.83,192.2,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1304.06,-394.9,36.7,77.25,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {2567.4,292.6,108.73,358.85,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-3173.57,1088.71,20.84,248.39,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1118.99,2699.88,18.55,224.92,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-331.4,6085.45,31.45,218.1,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1692.51,3761.17,34.7,219.1,"s_m_y_ammucity_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- Dess shop
    {73.93,-1392.26,29.38,267.43,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {427.02,-806.97,29.49,75.06,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-822.66,-1071.97,11.33,204.33,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1194.81,-767.6,17.32,214.21,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-164.93,-302.71,39.73,238.74,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {127.41,-223.13,54.56,72.94,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-708.72,-152.07,37.42,113.2,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1448.94,-238.19,49.81,47.67,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-3168.91,1044.25,20.86,62.7,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1102.26,2711.85,19.11,221.31,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {612.98,2761.76,42.09,268.95,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1197.04,2711.8,38.22,175.41,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {1695.5,4822.63,42.06,82.89,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {5.59,6511.08,31.88,39.51,"u_f_y_hotposh_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- Sheriff
    -- {-448.49,6012.44,31.72,314.12,"csb_cop","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- Police
    {440.67,-978.87,30.69,180.03,"csb_prolsec","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- Simeon
    {-32.13,-1114.37,26.42,70.06,"cs_siemonyetarian","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    --Sheriff Karakolu
    -- {-444.55,6017.69,31.93,269.98,"csb_cop","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- {-441.99,6014.98,31.93,7.75,"csb_cop","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- {-458.4,6012.81,31.49,134.67,"csb_cop","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    --Lspd Karakolu
    -- {458.39,-1017.21,28.23,93.07,"s_m_y_cop_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- {434.1,-984.02,30.71,31.52,"s_m_y_cop_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- {434.13,-980.1,30.71,147.33,"s_m_y_cop_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    --Hastane
    -- {299.62,-586.54,43.28,307.44,"s_m_m_doctor_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- {300.64,-583.48,43.28,202.42,"s_m_m_doctor_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    -- {294.56,-600.48,43.3,163.53,"s_m_m_doctor_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    --Torbacı
    {1964.35,3818.48,32.4,351.24,"ig_claypain","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    --Bağlanmış Araçlar
    {1230.08,2726.45,38.01,181.12,"ig_old_man2","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    --Spor Salonu
    {-45.43,-1288.87,29.21,269.88,"u_m_y_babyd","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
	--Havalimanı Bağlanmış
	-- {-1241.36,-3389.78,13.94,32.49,"ig_old_man2","amb@world_human_hang_out_street@female_arms_crossed@base","base"},

}

AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for _,location in ipairs(markets) do
        x = location[1]
        y = location[2]
        z = location[3]
        heading = location[4]

        model = location[5]

        anim = location[6]
        animbone = location[7]

        local Hash = GetHashKey(model)
        local Ped = CreatePed(1, Hash, x,y,z-0.95, 0.0, false, true)
        if not HasModelLoaded(Hash) then
            RequestModel(Hash)
            Citizen.Wait(200)
        end
        SetEntityHeading(Ped, heading)
        FreezeEntityPosition(Ped, true)
        loadAnimDict( anim )
        TaskPlayAnim(Ped, anim, animbone, 1.0,-1.0, -1, 1, 1, true, true, true)
        SetBlockingOfNonTemporaryEvents(Ped, true) -- değiştirmeyin / do not touch
        SetPedDiesWhenInjured(Ped, false) -- pedin ölümlü veya ölümsüz olmasını ayarlamak için / makes ped immortal
        SetPedCanPlayAmbientAnims(Ped, true) -- değiştirmeyin / do not touch
        SetPedCanRagdollFromPlayerImpact(Ped, false) --pedin yere düşmesini engellemek için / makes ped stil stand even get attacked
        SetEntityInvincible(Ped, true)	-- pedin ölümsüz olması için / makes ped invincible
        FreezeEntityPosition(Ped, true)
    end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	-- TriggerServerEvent('esx_policejob:forceBlip')
end)


--HAVALİMANI BAĞLANMIŞ
-- Citizen.CreateThread(function()
-- while true do
-- Citizen.Wait(1)
-- local ped = PlayerPedId()
-- local pedCoords = GetEntityCoords(ped)
-- local dstCheck = GetDistanceBetweenCoords(pedCoords, -1241.36,-3389.78,13.94, true)
-- if dstCheck <= 3.0 then
--     sleepThread = 5
-- --DrawText3Ds(1964.35, 3818.48, 32.4, '[~g~E~s~] Kenevirleri torbacıya sat')
-- DrawText3Ds(-1241.36,-3389.78,13.94, '[~g~E~s~] Baglanmıs Ucaklar')
-- end
-- end
-- end)


--KENEVIR İŞLEME/SATIŞ

Citizen.CreateThread(function()
while true do
    sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, -718.10, -1159.6, 10.6088, true)
if dstCheck < 5.0 then
    sleep = 5
end
if dstCheck <= 3.0 then
    sleepThread = 5
--DrawText3Ds(1964.35, 3818.48, 32.4, '[~g~E~s~] Kenevirleri torbacıya sat')
DrawText3Ds(-718.10, -1159.6, 10.60884, 'Balları satmak için [~g~E~s~]')
end
Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
    while true do
        sleep = 2000
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local dstCheck = GetDistanceBetweenCoords(pedCoords, 1964.35, 3818.48, 32.2, true)
    if dstCheck < 5.0 then
        sleep = 5
    end
    if dstCheck <= 3.0 then
        sleepThread = 5
    --DrawText3Ds(1964.35, 3818.48, 32.4, '[~g~E~s~] Kenevirleri torbacıya sat')
    DrawText3Ds(1964.35, 3818.48, 32.4, 'Kenevirleri satmak icin [~g~E~s~] tuşuna bas!')
    end
    Citizen.Wait(sleep)
    end
    end)

Citizen.CreateThread(function()
    while true do
        sleep = 2000
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local dstCheck = GetDistanceBetweenCoords(pedCoords, -1101.64, 2723.18, 17.8, true)
    if dstCheck < 5.0 then
        sleep = 5
    end
    if dstCheck <= 3.0 then
        sleepThread = 5
    DrawText3Ds(-1101.64, 2723.18, 17.8, '[~g~E~s~] Kenevirleri isle')
    end
    Citizen.Wait(sleep)
    end
    end)

Citizen.CreateThread(function()
    while true do
    sleep = 2000
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local dstCheck = GetDistanceBetweenCoords(pedCoords, 1059.96, -3203.05, -40.16, true)
    if dstCheck < 5.0 then
        sleep = 5
    end
    if dstCheck <= 3.0 then
        sleepThread = 5
    DrawText3Ds(1059.96, -3203.05, -40.16, '[~g~E~s~] Kenevir Topla')
    end
    Citizen.Wait(sleep)
    end
    end)

--SHERIFF KARAKOLU

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, -458.4, 6012.81, 31.49, true)
if PlayerData.job and PlayerData.job.name == 'sheriff' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(-458.4, 6012.81, 31.49, '[~g~E~s~] Garajı ac')
end
end
Citizen.Wait(sleep)
end
end)


-- Citizen.CreateThread(function()
-- while true do
-- sleep = 2000
-- local ped = PlayerPedId()
-- local pedCoords = GetEntityCoords(ped)
-- local dstCheck = GetDistanceBetweenCoords(pedCoords, -439.84, 5992.05, 31.72, true)
-- if PlayerData.job and PlayerData.job.name == 'sheriff' then
    -- if dstCheck < 5.0 then
        -- sleep = 5
    -- end
-- if dstCheck <= 4.0 then
    -- sleepThread = 5
-- DrawText3Ds(-439.84, 5992.05, 31.72, '[~g~E~s~] Kıyafet degistir')
-- end
-- end
-- Citizen.Wait(sleep)
-- end
-- end)

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, -430.35, 5999.07, 31.72, true)
if PlayerData.job and PlayerData.job.name == 'sheriff' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(-430.35, 5999.07, 31.72, '[~g~E~s~] Cephanelik')
end
end
Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, -450.35, 6010.99, 31.72, true)
if PlayerData.job and PlayerData.job.name == 'sheriff' and PlayerData.job.grade == 'boss' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(-450.35, 6010.99, 31.72, '[~g~E~s~] Sheriff Kasası')
end
end
Citizen.Wait(sleep)
end
end)

-- POLIS KARAKOLU

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, 458.39, -1017.21, 28.23, true)
if PlayerData.job and PlayerData.job.name == 'police' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(458.39, -1017.21, 28.23, '[~g~E~s~] Garajı Ac')
end
end
Citizen.Wait(sleep)
end
end)

-- Citizen.CreateThread(function()
-- while true do
-- sleep = 2000
-- local ped = PlayerPedId()
-- local pedCoords = GetEntityCoords(ped)
-- local dstCheck = GetDistanceBetweenCoords(pedCoords, 452.6, -992.8, 30.6, true)
-- if PlayerData.job and PlayerData.job.name == 'police' then
    -- if dstCheck < 5.0 then
        -- sleep = 5
    -- end
-- if dstCheck <= 4.0 then
    -- sleepThread = 5
-- DrawText3Ds(452.6, -992.8, 30.6, '[~g~E~s~] Kıyafet degistir')
-- end
-- end
-- Citizen.Wait(sleep)
-- end
-- end)

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, 452.4, -980.19, 30.6, true)
if PlayerData.job and PlayerData.job.name == 'police' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(452.4, -980.19, 30.6, '[~g~E~s~] Cephanelik')
end
end
Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, 448.4, -973.2, 30.6, true)
if PlayerData.job and PlayerData.job.name == 'police' and PlayerData.job.grade == 'boss' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(448.4, -973.2, 30.6, '[~g~E~s~] Genel Müdür Kasası')
end
end
Citizen.Wait(sleep)
end
end)

-- HASTANE

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, 294.56, -600.48, 43.3, true)
if PlayerData.job and PlayerData.job.name == 'ambulance' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(294.56, -600.48, 43.3, '[~g~E~s~] Garajı Ac')
end
end
Citizen.Wait(sleep)
end
end)

-- Citizen.CreateThread(function()
-- while true do
-- sleep = 2000
-- local ped = PlayerPedId()
-- local pedCoords = GetEntityCoords(ped)
-- local dstCheck = GetDistanceBetweenCoords(pedCoords, 335.53, -575.18, 43.33, true)
-- if PlayerData.job and PlayerData.job.name == 'ambulance' then
    -- if dstCheck < 5.0 then
        -- sleep = 5
    -- end
-- if dstCheck <= 4.0 then
    -- sleepThread = 5
-- DrawText3Ds(335.53, -575.18, 43.33, '[~g~E~s~] Kıyafet degistir')
-- end
-- end
-- Citizen.Wait(sleep)
-- end
-- end)

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, 326.53, -575.96, 43.32, true)
if PlayerData.job and PlayerData.job.name == 'ambulance' then
    if dstCheck < 5.0 then
        sleep = 5
    end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(326.53, -575.96, 43.32, '[~g~E~s~] Ecza Deposu')
end
end
Citizen.Wait(sleep)
end
end)

Citizen.CreateThread(function()
while true do
sleep = 2000
local ped = PlayerPedId()
local pedCoords = GetEntityCoords(ped)
local dstCheck = GetDistanceBetweenCoords(pedCoords, 1230.08, 2726.45, 38.01, true)
if dstCheck < 5.0 then
    sleep = 5
end
if dstCheck <= 4.0 then
    sleepThread = 5
DrawText3Ds(1230.08, 2726.45, 38.01, '[~g~E~s~] Baglanmıs Araçlar')
end
Citizen.Wait(sleep)
end
end)

function DrawText3Ds(x,y,z, text)
local onScreen,_x,_y=World3dToScreen2d(x,y,z)
local px,py,pz=table.unpack(GetGameplayCamCoords())

SetTextScale(0.35, 0.35)
SetTextFont(4)
SetTextProportional(1)
SetTextColour(255, 255, 255, 215)
SetTextEntry("STRING")
SetTextCentre(1)
AddTextComponentString(text)
DrawText(_x,_y)
local factor = (string.len(text)) / 370
DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 80)
end