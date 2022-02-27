ESX = nil
PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end 

	PlayerData = ESX.GetPlayerData()

end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-- Citizen.CreateThread(function()
-- while true do
	-- sleep = 5

-- if PlayerData.job and PlayerData.job.name == 'police' then
-- if IsPedDeadOrDying(GetPlayerPed(oluPlayer)) then
	-- if IsControlJustPressed(0, 38) then
		-- local oluPlayer, oluDistance = ESX.Game.GetClosestPlayer()
			-- if oluPlayer ~= -1 and oluDistance <= 2.0 then
				-- BandasiniAl(oluPlayer)
			-- end
		-- end
	-- else
		-- sleep = 5000
	-- end
-- end
-- Citizen.Wait(sleep)
-- end
-- end)


RegisterCommand('bandana', function()
if PlayerData.job and PlayerData.job.name == 'yesil' or PlayerData.job.name == 'mor' or PlayerData.job.name == 'sari' or PlayerData.job.name == 'kirmizi' or PlayerData.job.name == 'mavi' then
local oluPlayer, oluDistance = ESX.Game.GetClosestPlayer()
if IsPedDeadOrDying(GetPlayerPed(oluPlayer)) then
			if oluPlayer ~= -1 and oluDistance < 2 then
				BandasiniAl(oluPlayer)
			else
			TriggerEvent('notification', 'Yakınında ölü oyuncu yok!', 2)
			end
		end
 end
end)


function BandasiniAl(player)

	ESX.TriggerServerCallback('bz:bandana', function(data)

		for i=1, #data.envanter, 1 do
			if data.envanter[i].count < 0 then
				--BOS
			end
		end

	end, GetPlayerServerId(player))

end