OpenFineMenu = function()
	AnimFailed()
	playAnim('mp_common', 'anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, false)

	exports['dd_context']:SetTitle("City Fines")

    exports['dd_context']:AddButton("Driving on the wrong side of the road" , "" ,'offense:traffic1' ,'b1' , 'm1')
    exports['dd_context']:AddButton("Illegal U-Turn" , "" ,'offense:traffic2' ,'b1' , 'm1')
    exports['dd_context']:AddButton("Illegal Parking" , "" ,'offense:traffic3' ,'b1' , 'm1')
    exports['dd_context']:AddButton("Failing to stop at a Stop Sign" , "" ,'offense:traffic4' ,'b1' , 'm1')
    exports['dd_context']:AddButton("Failing to stop at a Red Light" , "" ,'offense:traffic5' ,'b1' , 'm1')
    exports['dd_context']:AddButton("Driving without a License" , "" ,'offense:traffic6' ,'b1' , 'm1')
    exports['dd_context']:AddButton("Hit and Run" , "" ,'offense:traffic7' ,'b1' , 'm1')

    exports['dd_context']:AddButton("Obstruction of Justice" , "" ,'offense:minor1' ,'b1' , 'm2')
    exports['dd_context']:AddButton("Insults towards Civilans" , "" ,'offense:minor2' ,'b1' , 'm2')
    exports['dd_context']:AddButton("Disrespecting of an LEO" , "" ,'offense:minor3' ,'b1' , 'm2')
    exports['dd_context']:AddButton("Verbal Threat towards a Civilan" , "" ,'offense:minor4' ,'b1' , 'm2')
    exports['dd_context']:AddButton("Verbal Threat towards an LEO" , "" ,'offense:minor5' ,'b1' , 'm2')
    exports['dd_context']:AddButton("Providing False Information" , "" ,'offense:minor6' ,'b1' , 'm2')
    exports['dd_context']:AddButton("Attempt of Corruption" , "" ,'offense:minor7' ,'b1' , 'm2')

    exports['dd_context']:AddButton("No Firearms License" , "" ,'offense:average1' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Possession of an Illegal Weapon" , "" ,'offense:average2' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Possession of Burglary Tools" , "" ,'offense:average3' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Grand Theft Auto" , "" ,'offense:average4' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Intent to Sell/Distrube of an illegal Substance" , "" ,'offense:average5' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Frabrication of an Illegal Substance" , "" ,'offense:average6' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Possession of an Illegal Substance" , "" ,'offense:average7' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Kidnapping of a Civilan" , "" ,'offense:average8' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Kidnapping of an LEO" , "" ,'offense:average9' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Robbery of a Store" , "" ,'offense:average10' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Robbery of a Jewelry" , "" ,'offense:average11' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Armed Robbery of a Bank(Small)" , "" ,'offense:average12' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Armed Robbery of a Big Bank" , "" ,'offense:average13' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Armed Robbery of a Yatch" , "" ,'offense:average14' ,'b1' , 'm3')
    exports['dd_context']:AddButton("Armed Robbery of a Humane Lab" , "" ,'offense:average15' ,'b1' , 'm3')

    exports['dd_context']:AddButton("Assault on a Civilian" , "" ,'offense:major1' ,'b1' , 'm4')
    exports['dd_context']:AddButton("Assault of an LEO" , "" ,'offense:major2' ,'b1' , 'm4')
    exports['dd_context']:AddButton("Attempt of Murder of a Civilian" , "" ,'offense:major3' ,'b1' , 'm4')
    exports['dd_context']:AddButton("Attempt of Murder of an LEO" , "" ,'offense:major4' ,'b1' , 'm4')
    exports['dd_context']:AddButton("Murder of a Civilian" , "" ,'offense:majo5r' ,'b1' , 'm4')
    exports['dd_context']:AddButton("Murder of an LEO" , "" ,'offense:major6' ,'b1' , 'm4')

    exports['dd_context']:SubMenu("Traffic Offense" , "Traffic and road violations" , "m1" )
    exports['dd_context']:SubMenu("Minor Offense" , "Level 1 violations" , "m2" )
    exports['dd_context']:SubMenu("Average Offense" , "Level 2 violations" , "m3" )
    exports['dd_context']:SubMenu("Major Offense" , "Level 3 violations" , "m4" )
end


---------------[[TRAFFIC OFFENSE]]---------------
RegisterNetEvent('offense:traffic1')
AddEventHandler('offense:traffic1', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Driving on the wrong side of the road', 1000)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:traffic2')
AddEventHandler('offense:traffic2', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Illegal U-Turn', 1000)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:traffic3')
AddEventHandler('offense:traffic3', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Illegal Parking', 1500)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:traffic4')
AddEventHandler('offense:traffic4', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Failing to stop at a Stop Sign', 1500)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:traffic5')
AddEventHandler('offense:traffic5', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Failing to stop at a Red Light', 1500)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:traffic6')
AddEventHandler('offense:traffic6', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Driving without a License', 2500)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:traffic7')
AddEventHandler('offense:traffic7', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Hit and Run', 7500)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
--------------[[MINOR OFFENSE]]-------------------------
RegisterNetEvent('offense:minor1')
AddEventHandler('offense:minor1', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Obstruction of Justice', 10000)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:minor2')
AddEventHandler('offense:minor2', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Insults towards Civilans', 1750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:minor3')
AddEventHandler('offense:minor3', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Disrespecting of an LEO', 1750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:minor4')
AddEventHandler('offense:minor4', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Verbal Threat towards a Civilan', 1750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:minor5')
AddEventHandler('offense:minor5', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Verbal Threat towards an LEO', 1750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:minor6')
AddEventHandler('offense:minor6', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Providing False Information', 2750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:minor7')
AddEventHandler('offense:minor7', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Attempt of Corruption', 3750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
-------------------[[AVERAGE OFFENSE]]------------------------
RegisterNetEvent('offense:average1')
AddEventHandler('offense:average1', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: No Firearms License', 7500)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average2')
AddEventHandler('offense:average2', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Possession of an Illegal Weapon', 5000)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average3')
AddEventHandler('offense:average3', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Possession of Burglary Tools', 7750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average4')
AddEventHandler('offense:average4', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Grand Theft Auto', 18750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average5')
AddEventHandler('offense:average5', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Intent to Sell/Distrube of an illegal Substance', 10750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average6')
AddEventHandler('offense:average6', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Frabrication of an Illegal Substance', 10750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average7')
AddEventHandler('offense:average7', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Possession of an Illegal Substance', 7500)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average8')
AddEventHandler('offense:average8', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Kidnapping of a Civilan', 6750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average9')
AddEventHandler('offense:average9', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Kidnapping of an LEO', 7750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average10')
AddEventHandler('offense:average10', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Robbery of a Store', 4750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average11')
AddEventHandler('offense:average11', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Robbery of a Jewelry', 7750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average12')
AddEventHandler('offense:average12', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Armed Robbery of a Bank(Small)', 5750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average13')
AddEventHandler('offense:average13', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Armed Robbery of a Big Bank', 8750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average14')
AddEventHandler('offense:average14', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Armed Robbery of a Yatch', 6750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:average15')
AddEventHandler('offense:average15', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Armed Robbery of a Humane Lab', 7750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)

--------------------[[MAJOR OFFENSE]]------------------------
RegisterNetEvent('offense:major1')
AddEventHandler('offense:major1', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Assault on a Civilian', 10000)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:major2')
AddEventHandler('offense:major2', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Assault of an LEO', 10750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:major3')
AddEventHandler('offense:major3', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Attempt of Murder of a Civilian', 7750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:major4')
AddEventHandler('offense:major4', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Attempt of Murder of an LEO', 8750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:major5')
AddEventHandler('offense:major5', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Murder of a Civilian', 20750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('offense:major6')
AddEventHandler('offense:major6', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Fine: Murder of an LEO', 20750)
    else
        exports['dd_core']:notify('error', 'No one near you!')					
    end
    ClearPedTasks(PlayerPedId())
end)
