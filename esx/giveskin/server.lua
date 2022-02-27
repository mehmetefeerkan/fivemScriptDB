local skins = {
    ['steam:1100001076fad39'] = 'u_m_y_mani', --seko
}

RegisterServerEvent('playerSpawn')
AddEventHandler('playerSpawn', function()
    local steamID = nil
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, 5) == "steam" then
            steamID = string.lower(v)
            break
        end
    end
    local skin = nil
    if skins[steamID] ~= nil then
        skin = skins[steamID]
    end
    TriggerClientEvent("applyskin", source, skin)
end)