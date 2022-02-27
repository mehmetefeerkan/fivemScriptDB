PlayerData = {}

local done = false

ESX = nil
 Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    done = true
end)

local ozelblip = {
	{title="Ivan Fight Club", colour=1, id=437, x = 925.49, y = -1783.74, z = 30.8}
}

Citizen.CreateThread(function()
   while not done do
        Citizen.Wait(10)
    end
	if PlayerData.job.name == 'ivanclub' then 
    for _, info in pairs(ozelblip) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
	end
end)