ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	Citizen.Wait(0)
		TriggerEvent('esx_jb_dj:enabledjbooth', true)
	end
end)