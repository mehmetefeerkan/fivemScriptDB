RegisterNetEvent('blips:motel')
AddEventHandler('blips:motel', function()
	DeleteWaypoint()
	SetNewWaypoint(326.7533, -208.341, 54.082)
	exports['mythic_notify']:DoHudText('error', 'Navigasyona moteli işaretledin!')
end)

RegisterNetEvent('blips:hospital')
AddEventHandler('blips:hospital', function()
	DeleteWaypoint()
	SetNewWaypoint(295.95, -584.41)
	exports['mythic_notify']:DoHudText('error', 'Navigasyona hastaneyi işaretledin!')
end)

RegisterNetEvent('blips:police')
AddEventHandler('blips:police', function()
	DeleteWaypoint()
	SetNewWaypoint(429.12, -979.85)
	exports['mythic_notify']:DoHudText('error', 'Navigasyona karakolu işaretledin!')
end)

RegisterNetEvent('blips:cardealer')
AddEventHandler('blips:cardealer', function()
	DeleteWaypoint()
	SetNewWaypoint(-33.78, -1101.85)
	exports['mythic_notify']:DoHudText('error', 'Navigasyona galeriyi işaretledin!')
end)

RegisterNetEvent('blips:fuel')
AddEventHandler('blips:fuel', function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords

	for _, gasStationCoords in pairs(Config.GasStations) do
		local dstcheck = GetDistanceBetweenCoords(coords, gasStationCoords)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords = gasStationCoords
		end
	end
	DeleteWaypoint()
	SetNewWaypoint(closestCoords)
	exports['mythic_notify']:DoHudText('error', 'Navigasyona en yakın benzinliği işaretledin!')
end)

RegisterNetEvent('blips:fuel')
AddEventHandler('blips:fuel', function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords

	for _, gasStationCoords in pairs(Config.Zones3) do
		local dstcheck = GetDistanceBetweenCoords(coords, gasStationCoords)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords = gasStationCoords
		end
	end
	DeleteWaypoint()
	SetNewWaypoint(closestCoords)
	exports['mythic_notify']:DoHudText('error', 'Navigasyona en yakın benzinliği işaretledin!')
end)

RegisterNetEvent('blips:clear')
AddEventHandler('blips:clear', function()
	DeleteWaypoint()
	exports['mythic_notify']:DoHudText('error', 'GPS işaretini kaldırdın!')
end)

RegisterNetEvent('blips:garage')
AddEventHandler('blips:garage', function()
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local fizzfauclose

	for _, garage in pairs(Config.Garage) do
		local dstcheck = GetDistanceBetweenCoords(coords, garage)

		if dstcheck < closest then
			 closest = dstcheck
			fizzfauclose = garage
		end
	end
	DeleteWaypoint()
	SetNewWaypoint(fizzfauclose)
	exports['mythic_notify']:DoHudText('error', 'Navigasyona en yakın garajı işaretledin!')
end)
