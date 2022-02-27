---------- Aylak Man Tarafından Kodlanmıştır --------------

ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)


RegisterNetEvent('esx_parasut:startparasut')
AddEventHandler('esx_parasut:startparasut', function(source)
	parasutAnimation()
end)


function parasutAnimation()
      GiveWeaponToPed(PlayerPedId(), GetHashKey("GADGET_PARACHUTE"), true)            
end