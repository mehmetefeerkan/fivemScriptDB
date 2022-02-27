ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent("refreshItems:minerJob")
AddEventHandler("refreshItems:minerJob", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local goldCount = xPlayer.getInventoryItem('gold').count
    local ironCount = xPlayer.getInventoryItem('iron').count
    local copperCount = xPlayer.getInventoryItem('copper').count
    local diamondCount = xPlayer.getInventoryItem('diamond').count

    local GoldCount1 = goldCount * 1000    -- %5
    local CopperCount1 = copperCount * 160   -- %49
    local IronCount1 = ironCount * 300     -- %30
    local DiamondCount1 = diamondCount * 18000  -- %0.1
    local totalCount = GoldCount1 + CopperCount1 + IronCount1 + DiamondCount1

    TriggerClientEvent("refreshGold:minerJob", source, goldCount)
    TriggerClientEvent("refreshIron:minerJob", source, ironCount)
    TriggerClientEvent("refreshCopper:minerJob", source, copperCount)
    TriggerClientEvent("refreshDiamond:minerJob", source, diamondCount)
    TriggerClientEvent("refreshTotal:minerJob", source, totalCount)
end)

RegisterNetEvent("sellResource:minerJob")
AddEventHandler("sellResource:minerJob", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local goldCount = xPlayer.getInventoryItem('gold').count
    local ironCount = xPlayer.getInventoryItem('iron').count
    local copperCount = xPlayer.getInventoryItem('copper').count
    local diamondCount = xPlayer.getInventoryItem('diamond').count

    local randomGoldCash = 1000    -- %5
    local randomCopperCash = 160    -- %49
    local randomIronCash = 300      -- %30
    local randomDiamondCash = 18000   -- %0.1

    local goldReward = goldCount * randomGoldCash
    local ironReward = ironCount * randomIronCash
    local copperReward = copperCount * randomCopperCash
    local diamondReward = diamondCount * randomDiamondCash
    local completReward = goldReward + ironReward + copperReward + diamondReward

    if goldCount > 0 then
        xPlayer.removeInventoryItem("gold", goldCount)
        xPlayer.addMoney(goldReward)

    end
    if diamondCount > 0 then
        xPlayer.removeInventoryItem("diamond", diamondCount)
        xPlayer.addMoney(diamondReward)

    end
    if copperCount > 0 then
        xPlayer.removeInventoryItem("copper", copperCount)
        xPlayer.addMoney(copperReward)

    end
    if ironCount > 0 then
        xPlayer.removeInventoryItem("iron", ironCount)
        xPlayer.addMoney(ironReward)
    end

    if completReward == 0 then

    else
        TriggerClientEvent("showReward:minerJob", source, completReward)
    end

end)

RegisterNetEvent("sellCopper:minerJob")
AddEventHandler("sellCopper:minerJob", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local copperCount = xPlayer.getInventoryItem('copper').count

    local randomCopperCash = 160

    local copperReward = copperCount * randomCopperCash


    if copperCount > 0 then
        xPlayer.removeInventoryItem("copper", copperCount)
        xPlayer.addMoney(copperReward)

    end

    if copperReward == 0 then

    else
        TriggerClientEvent("showReward:minerJob", source, copperReward)
    end

end)

RegisterNetEvent("sellGold:minerJob")
AddEventHandler("sellGold:minerJob", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local goldCount = xPlayer.getInventoryItem('gold').count

    local randomGoldCash = 1000

    local goldReward = goldCount * randomGoldCash


    if goldCount > 0 then
        xPlayer.removeInventoryItem("gold", goldCount)
        xPlayer.addMoney(goldReward)

    end

    if goldReward == 0 then

    else
        TriggerClientEvent("showReward:minerJob", source, goldReward)
    end

end)

RegisterNetEvent("sellIron:minerJob")
AddEventHandler("sellIron:minerJob", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local ironCount = xPlayer.getInventoryItem('iron').count

    local randomIronCash = 300

    local ironReward = ironCount * randomIronCash


    if ironCount > 0 then
        xPlayer.removeInventoryItem("iron", ironCount)
        xPlayer.addMoney(ironReward)

    end

    if ironReward == 0 then

    else
        TriggerClientEvent("showReward:minerJob", source, ironReward)
    end

end)

RegisterNetEvent("sellDiamond:minerJob")
AddEventHandler("sellDiamond:minerJob", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local diamondCount = xPlayer.getInventoryItem('diamond').count

    local randomDiamondCash = 18000

    local diamondReward = diamondCount * randomDiamondCash


    if diamondCount > 0 then
        xPlayer.removeInventoryItem("diamond", diamondCount)
        xPlayer.addMoney(diamondReward)

    end

    if diamondReward == 0 then

    else
        TriggerClientEvent("showReward:minerJob", source, diamondReward)
    end

end)

RegisterNetEvent("addItems:minerJob")
AddEventHandler("addItems:minerJob", function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local stoneGiveCount = math.random(1, 2)

        if not xPlayer.canCarryItem('stone', 1) then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, {
                type = 'error',
                text = 'Daha fazlasını taşıyamazsın!'
            })
        else
            xPlayer.addInventoryItem("stone", stoneGiveCount)
        end

end)

RegisterNetEvent("brn:eritmeitem")
AddEventHandler("brn:eritmeitem", function(stoneCount, dis)
    if dis < 1.5 then
        local eritebilite = false
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        if stoneCount == 0 then
            eritebilite = false
        else
            eritebilite = true
            local rsSayi = math.random(300)

            if rsSayi == 31 then                       -- %0.1
                if not xPlayer.canCarryItem('diamond', 1) then
                    TriggerClientEvent('mythic_notify:client:SendAlert', _source, {
                        type = 'error',
                        text = 'Daha fazlasını taşıyamazsın!'
                    })
                end
                xPlayer.removeInventoryItem("stone", 1)
                xPlayer.addInventoryItem('diamond', 1)
            elseif rsSayi <= 100 then -- %49
                if not xPlayer.canCarryItem('iron', 1) then
                    TriggerClientEvent('mythic_notify:client:SendAlert', _source, {
                        type = 'error',
                        text = 'Daha fazlasını taşıyamazsın!'
                    })
                end
                xPlayer.removeInventoryItem("stone", 1)
                xPlayer.addInventoryItem('iron', 1)
            elseif 280 < rsSayi then    -- %2
                if not xPlayer.canCarryItem('gold', 1) then
                    TriggerClientEvent('mythic_notify:client:SendAlert', _source, {
                        type = 'error',
                        text = 'Daha fazlasını taşıyamazsın!'
                    })
                end
                xPlayer.removeInventoryItem("stone", 1)
                xPlayer.addInventoryItem('gold', 1)
            elseif rsSayi > 100 or rsSayi < 250 then   -- %30
                if not xPlayer.canCarryItem('copper', 1) then
                    TriggerClientEvent('mythic_notify:client:SendAlert', _source, {
                        type = 'error',
                        text = 'Daha fazlasını taşıyamazsın!'
                    })
                end
                xPlayer.removeInventoryItem("stone", 1)
                xPlayer.addInventoryItem('copper', 1)
            end
        end
    end
end)

ESX.RegisterServerCallback('brn:miner:eritebilir', function(source, cb)
    local eritebilite = false
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local stoneCount = xPlayer.getInventoryItem('stone').count
    if stoneCount == 0 then
        eritebilite = false
    else
        eritebilite = true
    end

    cb(eritebilite, stoneCount)
end)
