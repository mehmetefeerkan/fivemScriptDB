RegisterCommand("kamera", function(source, args, raw)
    local src = source
    TriggerClientEvent("Cam:ToggleCam", src)
end)

RegisterCommand("boomcu", function(source, args, raw)
    local src = source
    TriggerClientEvent("Mic:ToggleBMic", src)
end)

RegisterCommand("mikrofon", function(source, args, raw)
    local src = source
    TriggerClientEvent("Mic:ToggleMic", src)
end)
