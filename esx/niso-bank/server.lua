ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("niso-bank:doQuickDeposit")
AddEventHandler("niso-bank:doQuickDeposit", function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local curBank = xPlayer.getAccount("bank").money
    local para = xPlayer.getMoney()
    while xPlayer == nil do Wait(0) end
    if amount == nil or amount <= 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert',src, { type = 'error', length = 5000, text = "ERROR MESAJI" })
    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
        TriggerClientEvent("niso-bank:refreshBank", src)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', length = 5000, text = "You made a cash deposit of $ " .. amount .. " successfully." })
        --TriggerClientEvent("notification", src, "You made a cash deposit of $ " .. amount .. " successfully.", 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert',src, { type = 'error', length = 5000, text = "You don't have that amount on your cash wallet." })
        --TriggerClientEvent("notification", src, "You don't have that amount on your cash wallet.", 2)
    end
end)

RegisterServerEvent("niso-bank:doQuickWithdraw")
AddEventHandler("niso-bank:doQuickWithdraw", function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local curBank = xPlayer.getAccount("bank").money
    while xPlayer == nil do Wait(0) end
    if tonumber(amount) <= curBank then
        xPlayer.removeAccountMoney('bank', tonumber(amount))
        xPlayer.addMoney(tonumber(amount))
        TriggerClientEvent("niso-bank:refreshBank", src)
        TriggerClientEvent('mythic_notify:client:SendAlert',src, { type = 'inform', length = 5000, text = "You made a cash withdrawl of $ " .. amount .. " successfully." })
        --TriggerClientEvent("notification", src, "You made a cash withdrawl of $ " .. amount .. " successfully.", 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert',src, { type = 'error', length = 5000, text = "You don't have that amount on your bank wallet." })
        --TriggerClientEvent("notification", src, "You don't have that amount on your bank wallet.", 2)
    end
end)

RegisterServerEvent("niso-bank:doQuickWithdrawATM")
AddEventHandler("niso-bank:doQuickWithdrawATM", function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local curBank = xPlayer.getAccount("bank").money
    while xPlayer == nil do Wait(0) end
    if tonumber(amount) <= curBank then
        xPlayer.removeAccountMoney('bank', tonumber(amount))
        xPlayer.addMoney( tonumber(amount))
        TriggerClientEvent("niso-bank:refreshAtm", src)
        TriggerClientEvent('mythic_notify:client:SendAlert',src, { type = 'inform', length = 5000, text = "You made a cash withdrawl of $ " .. amount .. " successfully." })
        --TriggerClientEvent("notification", src, "You made a cash withdrawl of $ " .. amount .. " successfully.", 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert',src, { type = 'error', length = 5000, text = "You don't have that amount on your bank wallet." })
        --TriggerClientEvent("notification", src, "You don't have that amount on your bank wallet.", 2)
    end
end)

RegisterServerEvent("niso-bank:checkWallet")
AddEventHandler("niso-bank:checkWallet", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local bank = xPlayer.getAccount("bank").money
    local cash = xPlayer.getMoney()
    TriggerClientEvent("checkWallet", src, bank, cash)
end)