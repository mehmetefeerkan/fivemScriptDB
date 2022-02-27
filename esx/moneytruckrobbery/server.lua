--[[
███████╗███████╗███╗   ██╗████████╗██╗██╗  ██╗ ██╗ ██╗ ███████╗ ██╗ ██╗ ██████╗ 
╚══███╔╝██╔════╝████╗  ██║╚══██╔══╝██║██║  ██║████████╗██╔════╝███║███║██╔════╝ 
  ███╔╝ █████╗  ██╔██╗ ██║   ██║   ██║███████║╚██╔═██╔╝███████╗╚██║╚██║███████╗ 
 ███╔╝  ██╔══╝  ██║╚██╗██║   ██║   ██║██╔══██║████████╗╚════██║ ██║ ██║██╔═══██╗
███████╗███████╗██║ ╚████║   ██║   ██║██║  ██║╚██╔═██╔╝███████║ ██║ ██║╚██████╔╝
╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═╝ ╚═╝ ╚═╝ ╚══════╝ ╚═╝ ╚═╝ ╚═════╝
--]]

ESX = nil
local moneytruck = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bankakarti', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('znt:Itemcheck', source)

end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

    for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected + 1
        end
    end
    SetTimeout(120 * 1000 , CountCops)
end

CountCops()


RegisterNetEvent('znt:Itemcheck')
AddEventHandler('znt:Itemcheck', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isRobbing = true

    local item = xPlayer.getQuantity(Config.Item)
    if not moneytruck then
    if isRobbing and item > 0 and amount > 0 then
        CountCops()
        if CopsConnected >= Config.Copsneeded then
            moneytruck = true
            TriggerClientEvent('znt:berkesex',source,true)
        else
            isRobbing = false
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = ("Yeterli polis yok") })
         end
    else
        isRobbing = false
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = ("Kart uyumsuz") })
    end
else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = ("Bu kamyon zaten soyulmuş") })
end    
end)

RobbedPlates = {}

RegisterNetEvent('znt:UpdatePlates')
AddEventHandler('znt:UpdatePlates', function(UpdatedTable, Plate)
    local xPlayers = ESX.GetPlayers()
    RobbedPlates = UpdatedTable
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer ~= nil then
            UpdatedTable[Plate] = true
            TriggerClientEvent('znt:newTable', xPlayers[i], UpdatedTable)
        end
    end
end)

function RandomItem()
	return Config.Items[math.random(#Config.Items)]
end

function RandomNumber()
	return math.random(1,5)
end

RegisterNetEvent('znt:Payout')
AddEventHandler('znt:Payout', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Robbing = false
    local timer = 0

    Robbing = true
    xPlayer.removeInventoryItem("guvenlikkarti1", 1)
    xPlayer.addInventoryItem('guvenlikkarti', 1)
    while Robbing == true do
        timer = timer + 3.5
        Citizen.Wait(3500)  --// Delay between receiving Items/Cash might need to play around with this if you decide to change the default timer (Config.Timer)
        if math.random(1,30) <= 15 then
            xPlayer.addInventoryItem('gold', (math.random(5,20)))
        else
            xPlayer.addInventoryItem(RandomItem(), RandomNumber())
        end
        if timer >= Config.Timer then
            Robbing = false
            break
        end
    end
end)

RegisterNetEvent('znt:moneytruck_false')
AddEventHandler('znt:moneytruck_false', function()
    if moneytruck then
        moneytruck = false
    end
end)