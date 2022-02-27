Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)
		local playerLocalisation = GetEntityCoords(playerPed)
		ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
		RemoveVehiclesFromGeneratorsInArea(498.4,-1024.99,35.59,402.84,-959.25,25.58,false)
		SetCreateRandomCops(false)
	end
end)