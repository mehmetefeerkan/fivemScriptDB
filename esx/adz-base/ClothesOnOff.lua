----------------------------------------------------------------------------------------
--------------------------------- Chat Commands ----------------------------------------
----------------------------------------------------------------------------------------

RegisterCommand("mask", function(source, args, rawCommand)
	TriggerEvent('mask')
end, false)

RegisterCommand("hat", function(source, args, rawCommand)
    TriggerEvent('hat')
end, false)

RegisterCommand("gloves", function(source, args, rawCommand)
    TriggerEvent('handske')
end, false)

RegisterCommand("glasses", function(source, args, rawCommand)
    TriggerEvent('briller')
end, false)

RegisterCommand("neck", function(source, args, rawCommand)
    TriggerEvent('hals')
end, false)

RegisterCommand("armor", function(source, args, rawCommand)
    TriggerEvent('vest')
end, false)

RegisterCommand("backpack", function(source, args, rawCommand)
    TriggerEvent('ryg')
end, false)

RegisterCommand("pants", function(source, args, rawCommand)
    TriggerEvent('bukser')
end, false)

RegisterCommand("rightarm", function(source, args, rawCommand)
    TriggerEvent('harm')
end, false)

RegisterCommand("leftarm", function(source, args, rawCommand)
    TriggerEvent('varm')
end, false)

RegisterCommand("ear", function(source, args, rawCommand)
    TriggerEvent('ear')
end, false)

RegisterCommand("shoes", function(source, args, rawCommand)
    TriggerEvent('sko')
end, false)

RegisterCommand("shoesF", function(source, args, rawCommand)
    TriggerEvent('skoF')
end, false)

RegisterCommand("shirt", function(source, args, rawCommand)
    TriggerEvent('shirt')
end, false)

RegisterCommand("shirtF", function(source, args, rawCommand)
    TriggerEvent('shirtF')
end, false)

RegisterCommand("pantsF", function(source, args, rawCommand)
    TriggerEvent('bukserF')
end, false)

--[[RegisterCommand("phat", function(source, args, rawCommand)
    TriggerEvent('phat')
end, false)

RegisterCommand("pbriller", function(source, args, rawCommand)
    TriggerEvent('pbriller')
end, false)

RegisterCommand("pshirt", function(source, args, rawCommand)
    TriggerEvent('pshirt')
end, false)--]]

----------------------------------------------------------------------------------------
--------------------------------- Selve animationen ------------------------------------
----------------------------------------------------------------------------------------

RegisterNetEvent("mask")
AddEventHandler("mask", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('misscommon@std_take_off_masks')
    while not HasAnimDictLoaded('misscommon@std_take_off_masks') do
        Citizen.Wait(1)
    end

    RequestAnimDict('mp_masks@on_foot')
    while not HasAnimDictLoaded('mp_masks@on_foot') do
        Citizen.Wait(1)
    end

    if not mask then
    mask = true
    MaskDrawable, MaskTexture, MaskPalette = GetPedDrawableVariation(playerPed, 1), GetPedTextureVariation(playerPed, 1), GetPedPaletteVariation(playerPed, 1)
    TaskPlayAnim(playerPed, "misscommon@std_take_off_masks", "take_off_mask_rps", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1000)
    SetPedComponentVariation(playerPed, 1, 0, 0, MaskPalette)
    ClearPedTasks(playerPed)
else 
    mask = false
    TaskPlayAnim(playerPed, "mp_masks@on_foot", "put_on_mask", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(500)
    SetPedComponentVariation(playerPed, 1, MaskDrawable, MaskTexture, MaskPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("hat")
AddEventHandler("hat", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('veh@common@fp_helmet@')
    while not HasAnimDictLoaded('veh@common@fp_helmet@') do
        Citizen.Wait(1)
    end

    RequestAnimDict('missheistdockssetup1hardhat@')
    while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
        Citizen.Wait(1)
    end

    if not hat then 
    hat = true
    HatDrawable, HatTexture = GetPedPropIndex(playerPed, 0), GetPedPropTextureIndex(playerPed, 0)
    TaskPlayAnim(playerPed, "veh@common@fp_helmet@", "take_off_helmet_stand", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(800)
    ClearPedProp(playerPed, 0)
    Citizen.Wait(400)
    ClearPedTasks(playerPed)
else 
    hat = false
    TaskPlayAnim(playerPed, "missheistdockssetup1hardhat@", "put_on_hat", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedPropIndex(playerPed, 0, HatDrawable, HatTexture, true)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("handske")
AddEventHandler("handske", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('switch@michael@closet')
    while not HasAnimDictLoaded('switch@michael@closet') do
        Citizen.Wait(1)
    end

    if not handsker then
    handsker = true
    GlovesDrawable, GlovesTexture, GlovesPalette = GetPedDrawableVariation(playerPed, 3), GetPedTextureVariation(playerPed, 3), GetPedPaletteVariation(playerPed, 3)
    TaskPlayAnim(playerPed, "switch@michael@closet", "closet_b", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 3, 15, 0, GlovesPalette)
    ClearPedTasks(playerPed)
else 
    handsker = false
    TaskPlayAnim(playerPed, "switch@michael@closet", "closet_c", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 3, GlovesDrawable, GlovesTexture, GlovesPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("briller")
AddEventHandler("briller", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingspecs')
    while not HasAnimDictLoaded('clothingspecs') do
        Citizen.Wait(1)
    end

    if not briller then
    briller = true 
    GlassesDrawable, GlassesTexture = GetPedPropIndex(playerPed, 1), GetPedPropTextureIndex(playerPed, 1)
    TaskPlayAnim(playerPed, "clothingspecs", "take_off", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1200)
    ClearPedProp(playerPed, 1)
    ClearPedTasks(playerPed)
else 
    briller = false
    TaskPlayAnim(playerPed, "clothingspecs", "put_on", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(4000)
    SetPedPropIndex(playerPed, 1, GlassesDrawable, GlassesTexture, true)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("hals")
AddEventHandler("hals", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingtie')
    while not HasAnimDictLoaded('clothingtie') do
        Citizen.Wait(1)
    end

    if not hals then
    hals = true
    halsDrawable, halsTexture, halsPalette = GetPedDrawableVariation(playerPed, 7), GetPedTextureVariation(playerPed, 7), GetPedPaletteVariation(playerPed, 7)
    TaskPlayAnim(playerPed, "clothingtie", "try_tie_neutral_a", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(5000)
    SetPedComponentVariation(playerPed, 7, 0, 0, halsPalette)
    ClearPedTasks(playerPed)
else 
    hals = false
    TaskPlayAnim(playerPed, "clothingtie", "try_tie_neutral_a", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(5000)
    SetPedComponentVariation(playerPed, 7, halsDrawable, halsTexture, halsPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("vest")
AddEventHandler("vest", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingshirt')
    while not HasAnimDictLoaded('clothingshirt') do
        Citizen.Wait(1)
    end

    if not vest then
    vest = true
    vestDrawable, vestTexture, vestPalette = GetPedDrawableVariation(playerPed, 9), GetPedTextureVariation(playerPed, 9), GetPedPaletteVariation(playerPed, 9)
    TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(5000)
    SetPedComponentVariation(playerPed, 9, 0, 0, vestPalette)
    ClearPedTasks(playerPed)
else 
    vest = false
    TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(5000)
    SetPedComponentVariation(playerPed, 9, vestDrawable, vestTexture, vestPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("ryg")
AddEventHandler("ryg", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('missclothing')
    while not HasAnimDictLoaded('missclothing') do
        Citizen.Wait(1)
    end

    if not ryg then
    ryg = true
    rygDrawable, rygTexture, rygPalette = GetPedDrawableVariation(playerPed, 5), GetPedTextureVariation(playerPed, 5), GetPedPaletteVariation(playerPed, 5)
    TaskPlayAnim(playerPed, "missclothing", "wait_choice_a_storeclerk", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 5, 0, 0, rygPalette)
    ClearPedTasks(playerPed)
else 
    ryg = false
    TaskPlayAnim(playerPed, "missclothing", "wait_choice_a_storeclerk", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 5, rygDrawable, rygTexture, rygPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("bukser")
AddEventHandler("bukser", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingtrousers')
    while not HasAnimDictLoaded('clothingtrousers') do
        Citizen.Wait(1)
    end

    if not bukser then
    bukser = true
    bukserDrawable, bukserTexture, bukserPalette = GetPedDrawableVariation(playerPed, 4), GetPedTextureVariation(playerPed, 4), GetPedPaletteVariation(playerPed, 4)
    TaskPlayAnim(playerPed, "clothingtrousers", "try_trousers_negative_a", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 4, 21, 0, bukserPalette)
    ClearPedTasks(playerPed)
else 
    bukser = false
    TaskPlayAnim(playerPed, "clothingtrousers", "try_trousers_negative_a", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 4, bukserDrawable, bukserTexture, bukserPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("harm")
AddEventHandler("harm", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('amb@code_human_wander_idles@male@idle_a')
    while not HasAnimDictLoaded('amb@code_human_wander_idles@male@idle_a') do
        Citizen.Wait(1)
    end

    if not ur then 
    ur = true
    urDrawable, urTexture = GetPedPropIndex(playerPed, 6), GetPedPropTextureIndex(playerPed, 6)
    TaskPlayAnim(playerPed, "amb@code_human_wander_idles@male@idle_a", "idle_a_wristwatch", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    ClearPedProp(playerPed, 6)
    ClearPedTasks(playerPed)
else 
    ur = false
    TaskPlayAnim(playerPed, "amb@code_human_wander_idles@male@idle_a", "idle_a_wristwatch", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedPropIndex(playerPed, 6, urDrawable, urTexture, true)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("varm")
AddEventHandler("varm", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('amb@code_human_wander_idles_fat@male@idle_a')
    while not HasAnimDictLoaded('amb@code_human_wander_idles_fat@male@idle_a') do
        Citizen.Wait(1)
    end

    if not arm then 
    arm = true
    armDrawable, armTexture = GetPedPropIndex(playerPed, 7), GetPedPropTextureIndex(playerPed, 7)
    TaskPlayAnim(playerPed, "amb@code_human_wander_idles_fat@male@idle_a", "idle_a_wristwatch", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    ClearPedProp(playerPed, 7)
    ClearPedTasks(playerPed)
else 
    arm = false
    TaskPlayAnim(playerPed, "amb@code_human_wander_idles_fat@male@idle_a", "idle_a_wristwatch", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedPropIndex(playerPed, 7, armDrawable, armTexture, true)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("ear")
AddEventHandler("ear", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('mini@ears_defenders')
    while not HasAnimDictLoaded('mini@ears_defenders') do
        Citizen.Wait(1)
    end

    if not ear then 
    ear = true
    earDrawable, earTexture = GetPedPropIndex(playerPed, 2), GetPedPropTextureIndex(playerPed, 2)
    TaskPlayAnim(playerPed, "mini@ears_defenders", "takeoff_earsdefenders_idle", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    ClearPedProp(playerPed, 2)
    ClearPedTasks(playerPed)
else 
    ear = false
    TaskPlayAnim(playerPed, "mini@ears_defenders", "takeoff_earsdefenders_idle", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedPropIndex(playerPed, 2, earDrawable, earTexture, true)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("sko")
AddEventHandler("sko", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingshoes')
    while not HasAnimDictLoaded('clothingshoes') do
        Citizen.Wait(1)
    end

    if not sko then
    sko = true
    skoDrawable, skoTexture, skoPalette = GetPedDrawableVariation(playerPed, 6), GetPedTextureVariation(playerPed, 6), GetPedPaletteVariation(playerPed, 6)
    TaskPlayAnim(playerPed, "clothingshoes", "check_out_a", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 6, 34, 0, skoPalette)
    ClearPedTasks(playerPed)
else 
    sko = false
    TaskPlayAnim(playerPed, "clothingshoes", "check_out_a", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 6, skoDrawable, skoTexture, skoPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("skoF")
AddEventHandler("skoF", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingshoes')
    while not HasAnimDictLoaded('clothingshoes') do
        Citizen.Wait(1)
    end

    if not sko then
    sko = true
    skoDrawable, skoTexture, skoPalette = GetPedDrawableVariation(playerPed, 6), GetPedTextureVariation(playerPed, 6), GetPedPaletteVariation(playerPed, 6)
    TaskPlayAnim(playerPed, "clothingshoes", "check_out_a", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 6, 35, 0, skoPalette)
    ClearPedTasks(playerPed)
else 
    sko = false
    TaskPlayAnim(playerPed, "clothingshoes", "check_out_a", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 6, skoDrawable, skoTexture, skoPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("shirt")
AddEventHandler("shirt", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingshirt')
    while not HasAnimDictLoaded('clothingshirt') do
        Citizen.Wait(1)
    end

    if not shirt then
    shirt = true
    undershirtDrawable, undershirtTexture, undershirtPalette = GetPedDrawableVariation(playerPed, 8), GetPedTextureVariation(playerPed, 8), GetPedPaletteVariation(playerPed, 8)
    GlovesDrawable, GlovesTexture, GlovesPalette = GetPedDrawableVariation(playerPed, 3), GetPedTextureVariation(playerPed, 3), GetPedPaletteVariation(playerPed, 3)
    shirtDrawable, shirtTexture, shirtPalette = GetPedDrawableVariation(playerPed, 11), GetPedTextureVariation(playerPed, 11), GetPedPaletteVariation(playerPed, 11)
    TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 8, 15, 0, undershirtPalette)
    SetPedComponentVariation(playerPed, 11, 91, 0, shirtPalette)
    SetPedComponentVariation(playerPed, 3, 15, 0, GlovesPalette)
    ClearPedTasks(playerPed)
else 
    shirt = false
    TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 8, undershirtDrawable, undershirtTexture, undershirtPalette)
    SetPedComponentVariation(playerPed, 11, shirtDrawable, shirtTexture, shirtPalette)
    SetPedComponentVariation(playerPed, 3, GlovesDrawable, GlovesTexture, GlovesPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("shirtF")
AddEventHandler("shirtF", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingshirt')
    while not HasAnimDictLoaded('clothingshirt') do
        Citizen.Wait(1)
    end

    if not shirt then
    shirt = true
    undershirtDrawable, undershirtTexture, undershirtPalette = GetPedDrawableVariation(playerPed, 8), GetPedTextureVariation(playerPed, 8), GetPedPaletteVariation(playerPed, 8)
    GlovesDrawable, GlovesTexture, GlovesPalette = GetPedDrawableVariation(playerPed, 3), GetPedTextureVariation(playerPed, 3), GetPedPaletteVariation(playerPed, 3)
    shirtDrawable, shirtTexture, shirtPalette = GetPedDrawableVariation(playerPed, 11), GetPedTextureVariation(playerPed, 11), GetPedPaletteVariation(playerPed, 11)
    TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 8, 7, 0, undershirtPalette)
    SetPedComponentVariation(playerPed, 11, 82, 0, shirtPalette)
    SetPedComponentVariation(playerPed, 3, 15, 0, GlovesPalette)
    ClearPedTasks(playerPed)
else 
    shirt = false
    TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 8, undershirtDrawable, undershirtTexture, undershirtPalette)
    SetPedComponentVariation(playerPed, 11, shirtDrawable, shirtTexture, shirtPalette)
    SetPedComponentVariation(playerPed, 3, GlovesDrawable, GlovesTexture, GlovesPalette)
    ClearPedTasks(playerPed)
end
end)

RegisterNetEvent("bukserF")
AddEventHandler("bukserF", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingtrousers')
    while not HasAnimDictLoaded('clothingtrousers') do
        Citizen.Wait(1)
    end

    if not bukserF then
    bukserF = true
    bukserFDrawable, bukserFTexture, bukserFPalette = GetPedDrawableVariation(playerPed, 4), GetPedTextureVariation(playerPed, 4), GetPedPaletteVariation(playerPed, 4)
    TaskPlayAnim(playerPed, "clothingtrousers", "try_trousers_negative_a", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 4, 15, 0, bukserFPalette)
    ClearPedTasks(playerPed)
else 
    bukserF = false
    TaskPlayAnim(playerPed, "clothingtrousers", "try_trousers_negative_a", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(3000)
    SetPedComponentVariation(playerPed, 4, bukserFDrawable, bukserFTexture, bukserFPalette)
    ClearPedTasks(playerPed)
end
end)

--[[RegisterNetEvent("phat")
AddEventHandler("phat", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('missheistdockssetup1hardhat@')
    while not HasAnimDictLoaded('missheistdockssetup1hardhat@') do
        Citizen.Wait(1)
    end

    TaskPlayAnim(playerPed, "missheistdockssetup1hardhat@", "put_on_hat", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedPropIndex(playerPed, 0, 0, 0, true)
    ClearPedTasks(playerPed)
end)

RegisterNetEvent("pbriller")
AddEventHandler("pbriller", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('clothingspecs')
    while not HasAnimDictLoaded('clothingspecs') do
        Citizen.Wait(1)
    end

    briller = false
    TaskPlayAnim(playerPed, "clothingspecs", "put_on", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(4000)
    SetPedPropIndex(playerPed, 1, 0, 0, true)
    ClearPedTasks(playerPed)
end)

RegisterNetEvent("pshirt")
AddEventHandler("pshirt", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('switch@michael@closet')
    while not HasAnimDictLoaded('switch@michael@closet') do
        Citizen.Wait(1)
    end

    if not pshirt then
    pshirt = true
    GlovesDrawable, GlovesTexture, GlovesPalette = GetPedDrawableVariation(playerPed, 3), GetPedTextureVariation(playerPed, 3), GetPedPaletteVariation(playerPed, 3)
    shirtDrawable, shirtTexture, shirtPalette = GetPedDrawableVariation(playerPed, 11), GetPedTextureVariation(playerPed, 11), GetPedPaletteVariation(playerPed, 11)
    TaskPlayAnim(playerPed, "switch@michael@closet", "closet_b", 3.5, -8, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 3, 15, 0, GlovesPalette)
    SetPedComponentVariation(playerPed, 11, 0, 0, shirtPalette)
    ClearPedTasks(playerPed)
else 
    pshirt = false
    TaskPlayAnim(playerPed, "switch@michael@closet", "closet_c", 3.5, -8, -1, 49, 0, 0, 0, 0) 
    Citizen.Wait(1300)
    SetPedComponentVariation(playerPed, 3, GlovesDrawable, GlovesTexture, GlovesPalette)
    SetPedComponentVariation(playerPed, 11, shirtDrawable, shirtTexture, shirtPalette)
    ClearPedTasks(playerPed)
end
end)--]]


-- 11 = jakke
-- 10 = mærker/decals
-- 9 = Armorvest
-- 8 = Undershirt
-- 7 = Halskæde
-- 6 = sko
-- 5 = faldskærm
-- 4 = bukser

