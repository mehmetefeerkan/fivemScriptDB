ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('utx-cartax:tax')
AddEventHandler('utx-cartax:tax', function()

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE type = @type AND job = @job',
    {
        ['@type'] = 'car',
        ['@job'] = 'civ'
    },
    function(result)
        for i=1, #result, 1 do
            local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)
            local data = json.decode(result[i].vehicle)
            local vergimiktari = VergiMiktariniGetir(data.model)
            local sinirvergi = SinirVergiyiGetir(data.model)
            if vergimiktari ~= nil and sinirvergi ~= nil then
                if result[i].tax >= sinirvergi then
                    MySQL.Async.execute('INSERT INTO `impounded_vehicles` (`owner`, `vehicle`, `type`, `job`, `plate`, `tax`) VALUES(@owner, @vehicle, @type, @job, @plate, @tax)',
                    {
                        ['@owner'] = result[i].owner,
                        ['@vehicle'] = result[i].vehicle,
                        ['@type'] = 'car',
                        ['@job'] = 'civ',
                        ['@plate'] = result[i].plate,
                        ['@tax'] = result[i].tax
                    })
                    Citizen.Wait(0)
                    MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @owner AND vehicle = @vehicle AND type = @type AND job = @job AND plate = @plate',
                    {
                        ['@owner'] = result[i].owner,
                        ['@vehicle'] = result[i].vehicle,
                        ['@type'] = 'car',
                        ['@job'] = 'civ',
                        ['@plate'] = result[i].plate
                    })
                    if xPlayer ~= nil then
                        xPlayer.showNotification('Your car with plate '..result[i].plate..' is impounded for tax debt. You can get your car back from the tax office.')
                    end
                else
                    MySQL.Async.execute('UPDATE owned_vehicles SET tax = tax + @tax WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
                    {
                        ['@tax'] = vergimiktari,
                        ['@owner'] = result[i].owner,
                        ['@type'] = 'car',
                        ['@job'] = 'civ',
                        ['@plate'] = result[i].plate
                    })
                end
            end
        end
        print('^2[utx-cartax]^0 Tax cut is successful!')
    end)
end)

function VergiMiktariniGetir(arachash)
    MySQL.Async.fetchAll('SELECT * FROM vehicles',
    {

    },
    function(result)
        for i = 1, #result, 1 do
            local model = GetHashKey(result[i].model)
            if model == arachash then
                aracfiyat = (result[i].price / Config.VergiBolum)
            end
        end
    end)
    Citizen.Wait(100)
    return aracfiyat
end

function SinirVergiyiGetir(arachash2)
    MySQL.Async.fetchAll('SELECT * FROM vehicles',
    {

    },
    function(result)
        for i = 1, #result, 1 do
            local model2 = GetHashKey(result[i].model)
            if model2 == arachash2 then
                aracfiyat2 = (result[i].price / Config.SinirVergiBolum)
            end
        end
    end)
    Citizen.Wait(100)
    return aracfiyat2
end

RegisterServerEvent('utx-cartax:returncar')
AddEventHandler('utx-cartax:returncar', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
    {
        ['@owner'] = xPlayer.identifier,
        ['@type'] = 'car',
        ['@job'] = 'civ',
        ['@plate'] = plate
    },
    function(result)
        if result[1] then
            if result[1].tax ~= 0 then
                if money >= result[1].tax then
                    MySQL.Async.execute('UPDATE owned_vehicles SET tax = @tax WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
                    {
                        ['@tax'] = 0,
                        ['@owner'] = xPlayer.identifier,
                        ['@type'] = 'car',
                        ['@job'] = 'civ',
                        ['@plate'] = plate
                    })
                    xPlayer.removeMoney(result[1].tax)
                    xPlayer.showNotification('You paid '..result[1].tax..'$ tax of the car with plate '..plate..'.')
                else
                    xPlayer.showNotification('You don\'t have enough money to pay '..result[1].tax..'$ tax of the car with plate '..plate..'.')
                end
            end
        else
            MySQL.Async.fetchAll('SELECT * FROM impounded_vehicles WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
            {
                ['@owner'] = xPlayer.identifier,
                ['@type'] = 'car',
                ['@job'] = 'civ',
                ['@plate'] = plate
            },
            function(result)
                if result[1] then
                    if money >= result[1].tax then
                        MySQL.Async.execute('INSERT INTO `owned_vehicles` (`owner`, `vehicle`, `type`, `job`, `plate`, `tax`, `stored`) VALUES(@owner, @vehicle, @type, @job, @plate, @tax, @stored)',
                        {
                            ['@owner'] = xPlayer.identifier,
                            ['@vehicle'] = result[1].vehicle,
                            ['@type'] = 'car',
                            ['@job'] = 'civ',
                            ['@plate'] = plate,
                            ['@tax'] = 0,
                            ['@stored'] = 1
                        })
                        Citizen.Wait(0)
                        MySQL.Async.execute('DELETE FROM impounded_vehicles WHERE owner = @owner AND vehicle = @vehicle AND type = @type AND job = @job AND plate = @plate',
                        {
                            ['@owner'] = xPlayer.identifier,
                            ['@vehicle'] = result[1].vehicle,
                            ['@type'] = 'car',
                            ['@job'] = 'civ',
                            ['@plate'] = plate
                        })
                        xPlayer.removeMoney(result[1].tax)
                        xPlayer.showNotification('You paid '..result[1].tax..'$ tax of the car with plate '..plate..'. The car is sent back to your garage.')
                    else
                        xPlayer.showNotification('You don\'t have enough money to pay '..result[1].tax..'$ tax of the car with plate '..plate..'.')
                    end
                else
                    xPlayer.showNotification('Please enter a valid plate!')
                end
            end)
        end
    end)
end)

ESX.RegisterServerCallback('utx-cartax:carinfo', function(source, cb, hash)
    local vergi = VergiMiktariniGetir(hash)
    local sinirvergi = SinirVergiyiGetir(hash)
    cb(vergi, sinirvergi)
end)

ESX.RegisterServerCallback('utx-cartax:carinfo2', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
    {
        ['@owner'] = xPlayer.identifier,
        ['@type'] = 'car',
        ['@job'] = 'civ',
        ['@plate'] = plate
    },
    function(result)
        if result[1] then
            local vergi = result[1].tax
            cb(vergi)
        else
            MySQL.Async.fetchAll('SELECT * FROM impounded_vehicles WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
            {
                ['@owner'] = xPlayer.identifier,
                ['@type'] = 'car',
                ['@job'] = 'civ',
                ['@plate'] = plate
            },
            function(result)
                if result[1] then
                    local vergi = result[1].tax
                    cb(vergi)
                end
            end)
        end
    end)
end)

ESX.RegisterServerCallback('utx-cartax:carinfo3', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
    {
        ['@owner'] = xPlayer.identifier,
        ['@type'] = 'car',
        ['@job'] = 'civ',
        ['@plate'] = plate
    },
    function(result)
        if result[1] then
            if result[1].tax == 0 then
                xPlayer.showNotification('Your car don\t have any tax to be paid.')
            else
                local vergi = result[1].tax
                cb(vergi)
            end
        else
            MySQL.Async.fetchAll('SELECT * FROM impounded_vehicles WHERE owner = @owner AND type = @type AND job = @job AND plate = @plate',
            {
                ['@owner'] = xPlayer.identifier,
                ['@type'] = 'car',
                ['@job'] = 'civ',
                ['@plate'] = plate
            },
            function(result)
                if result[1] then
                    local vergi = result[1].tax
                    cb(vergi)
                else
                    xPlayer.showNotification('Please enter a valid plate!')
                end
            end)
        end
    end)
end)

VergiKontrol = function()
    TriggerEvent('utx-cartax:tax')
end

TriggerEvent('cron:runAt', Config.Hour, Config.Minute, VergiKontrol)
