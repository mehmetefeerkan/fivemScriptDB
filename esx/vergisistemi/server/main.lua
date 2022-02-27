ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetUsersForTax(d, h, m)
    MySQL.ready(function()        
        MySQL.Async.fetchAll('SELECT * FROM users',{},function(AllUser)
            RunTax(AllUser)
        end)
    end)  
end

-- Bank Taxing
function BankTax(AllUser)
    local tax = nil 
    for i=1 , #AllUser,1 do 
        if (AllUser[i].bank <= Config.HoboClassLimit) then --Hobo Class
            tax = 0
        elseif (AllUser[i].bank < Config.PoorClassLimit) then --Poor Class
            local taxpercent = Config.PoorClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000 
        elseif (AllUser[i].bank < Config.LowerClassLimit) then --Lower Class
            local taxpercent = Config.LowerClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000 
        elseif (AllUser[i].bank < Config.LowerMiddleClassLimit) then --Lower Middle Class
            local taxpercent = Config.LowerMiddleClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000 
        elseif (AllUser[i].bank < Config.MiddleClassLimit) then --Middle Class
            local taxpercent = Config.MiddleClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        elseif (AllUser[i].bank < Config.UpperMiddleClassLimit) then --Upper Middle Class
            local taxpercent = Config.UpperMiddleClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        elseif (AllUser[i].bank < Config.LowerHigherClassLimit) then --Lower Higher Class
            local taxpercent = Config.LowerHigherClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        elseif  (AllUser[i].bank < Config.HigherClassLimit) then --Higher Class
            local taxpercent = Config.HigherClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        else --Upper Higher Class 
            local taxpercent = Config.UpperHigherClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        end
        local xPlayer = ESX.GetPlayerFromIdentifier(AllUser[i].identifier)
        if(xPlayer ~= nil) then 
            if tax ~= 0 then                 
                TriggerClientEvent('tax:sendTax', xPlayer.source, xPlayer.source, 'Banka Vergisi', ESX.Math.Round(tax))  
            end         
        end
    end 
end

-- Car Taxing
function CarsTax(AllUser)     
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles',{},function(AllCars)
        local taxMultiplier = Config.CarTax
        for i=1 , #AllUser,1 do 
            local carCount = 0
            for a=1 , #AllCars,1 do 
                if AllUser[i].identifier == AllCars[a].owner and (AllCars[a].job ~= 'police' and AllCars[a].job ~= 'ambulance') then
                    carCount = carCount + 1
                end
            end
            if carCount > 0 then
                local tax = carCount * taxMultiplier
                local xPlayer = ESX.GetPlayerFromIdentifier(AllUser[i].identifier)
                if(xPlayer ~= nil) then                     
                    TriggerClientEvent('tax:sendTax', xPlayer.source, xPlayer.source, 'Araba Vergisi', ESX.Math.Round(tax))  
                end
            end            
        end
    end)
end

function RunTax(AllUser)
    BankTax(AllUser)
    CarsTax(AllUser)
    Wait(Config.TaxInterval)
    GetUsersForTax()
end

GetUsersForTax()