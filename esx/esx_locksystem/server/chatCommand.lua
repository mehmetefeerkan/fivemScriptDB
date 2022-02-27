--//EDITED BY ceranim0x#4783

if(globalConf["SERVER"].enableGiveKey)then
    RegisterCommand('anahtarver', function(source, args, rawCommand)
        local src = source
        local identifier = GetPlayerIdentifiers(src)[1]

        if(args[1])then
            local targetId = args[1]
            local targetIdentifier = GetPlayerIdentifiers(targetId)[1]
            if(targetIdentifier)then
                if(targetIdentifier ~= identifier)then
                    if(args[2])then
                        local plate = string.lower(args[2])
                        if(owners[plate])then
                            if(owners[plate] == identifier)then
                                alreadyHas = false
                                for k, v in pairs(secondOwners) do
                                    if(k == plate)then
                                        for _, val in ipairs(v) do
                                            if(val == targetIdentifier)then
                                                alreadyHas = true
                                            end
                                        end
                                    end
                                end

                                
                                if(not alreadyHas)then
                                    TriggerClientEvent("ls:giveKeys", targetIdentifier, plate)
                                    TriggerEvent("ls:addSecondOwner", targetIdentifier, plate)

                                    TriggerClientEvent("ls:notify", targetId, "You have been received the keys of vehicle " .. plate .. " by " .. GetPlayerName(src))
                                    TriggerClientEvent("ls:notify", src, "You gave the keys of vehicle " .. plate .. " to " .. GetPlayerName(targetId))
                                else
                                    TriggerClientEvent("ls:notify", src, "The target already has the keys of the vehicle")
                                    TriggerClientEvent("ls:notify", targetId, GetPlayerName(src) .. " tried to give you his keys, but you already had them")
                                end
                            else
                                TriggerClientEvent("ls:notify", src, "Bu senin aracın değil.")
                            end
                        else
                            TriggerClientEvent("ls:notify", src, "Bu plakalı araç yok")
                        end
                    else
                        TriggerClientEvent("ls:notify", src, "İkinci eksik argüman: /anahtarver <id> <plaka>")
                    end
                else
                    TriggerClientEvent("ls:notify", src, "Kendini hedefleyemezsin.")
                end
            else
                TriggerClientEvent("ls:notify", src, "Oyuncu Bulunamadı")
            end
        else
            TriggerClientEvent("ls:notify", src, 'Birinci eksik argüman : /anahtarver <id> <plaka>')
        end

        CancelEvent()
    end)
end
