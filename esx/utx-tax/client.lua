ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(1)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

AddEventHandler('playerSpawned', function(spawn)
    if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "offpolice" or ESX.PlayerData.job.name == "offambulance" then
        exports['mythic_notify']:DoCustomHudText('inform', 'Bu haftaki saatlik vergi: '..Config.MemurVergi..'$', 7500)
    else
        exports['mythic_notify']:DoCustomHudText('inform', 'Bu haftaki saatlik vergi: '..Config.SivilVergi..'$', 7500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Sure * 60000)
        if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "offpolice" or ESX.PlayerData.job.name == "offambulance" then
            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_government', 'Vergi', Config.MemurVergi)
            ESX.ShowNotification('Saatlik vergi faturanıza kesildi! Lütfen ödemeyi unutmayınız.')
        else
            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_government', 'Vergi', Config.SivilVergi)
            ESX.ShowNotification('Saatlik vergi faturanıza kesildi! Lütfen ödemeyi unutmayınız.')
        end
        print('Vergi kesimi başarılı!')
    end
end)
