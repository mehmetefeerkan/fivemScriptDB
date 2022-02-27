RegisterNetEvent("lexia:togglegas")
AddEventHandler("lexia:togglegas", function()
   -- DeleteWaypoint()

    local currentGasBlip = 0

	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords

	for k,v in pairs(GasStations) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
            closestCoords = v
        end
    end

    SetNewWaypoint(closestCoords)
    exports["mythic_notify"]:SendAlert("inform", "En yakın benzinci GPS'de işaretlendi.", 3500)

end)

RegisterNetEvent("lexia:togglebarber")
AddEventHandler("lexia:togglebarber", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords1

	for k,v in pairs(BarberShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords1 = v
		end
    end
    
    SetNewWaypoint(closestCoords1)
    exports["mythic_notify"]:SendAlert("inform", "En yakın berber GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("lexia:toggletattos")
AddEventHandler("lexia:toggletattos", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(TattoShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "En yakın dövmeci  GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("lexia:toggleclothes")
AddEventHandler("lexia:toggleclothes", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(ClotheShop) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "En yakın kıyafet dükkanı  GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("lexia:togglebank")
AddEventHandler("lexia:togglebank", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Bank) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "En yakın banka GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("lexia:togglegarage")
AddEventHandler("lexia:togglegarage", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Garage) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "En yakın market  GPS'de işaretlendi.", 3500)
end)

RegisterNetEvent("lexia:togglemarket")
AddEventHandler("lexia:togglemarket", function()
   -- DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 1000
	local closestCoords2

	for k,v in pairs(Shops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports["mythic_notify"]:SendAlert("inform", "En yakın market  GPS'de işaretlendi.", 3500)
end)

Garage = { 
vector3(223.48, -761.68, 30.82),
vector3(1737.59, 3710.2, 34.14),
vector3(733.62, -71.04,  41.75),
vector3(1852.75, 2578.97, 45.67 ),
vector3(1212.32, 339.94, 81.99),
vector3(282.01, 68.41, 94.37),
vector3(273.35, -343.33,  44.92),
vector3(-1594.85, -873.94, 9.94),
vector3(45.84, -1732.4, 29.3),
vector3(361.12, -1690.49, 32.53 ),
vector3(421.99, -1326.06, 46.05 ),
vector3(-569.87, 316.27, 84.46),
vector3(-1977.68, -291.78, 44.11), 
vector3(-693.9, -738.11, 29.36)
}

Bank = {     
	vector3(241.727, 220.706, 106.286), -- blip id, blip color, x, y, z, scale, name/label
	vector3(150.266, -1040.203, 29.374),
	vector3(-1212.980, -330.841, 37.787),
	vector3(-2962.582, 482.627, 15.703),
	vector3(-112.202, 6469.295, 31.626),
	vector3(314.187, -278.621, 54.170),
	vector3(-351.534, -49.529, 49.042),
	vector3(1175.0643310547, 2706.6435546875, 38.094036102295)
}

Shops = {     
	vector3( -48.37, -1757.93, 29.42),
	vector3(25.74672, -1347.16, 29.497),
	vector3(-1222.26, -906.86, 12.33),
	vector3(-1487.62, -378.60, 40.16),
	vector3(-707.31, -914.66, 19.22),
	vector3(1135.7, -982.79, 46.42),
	vector3(373.55, 325.52, 103.57),
	vector3(1163.67, -323.92,69.21),
	vector3(2557.44, 382.03, 108.62),
	vector3(-3039.16, 585.71, 7.91),
	vector3(-3242.11, 1001.20, 12.83),
	vector3(-2967.78, 391.49, 15.04),
	vector3(-1820.38, 792.69, 138.11),
	vector3(547.75, 2671.53, 42.16),
	vector3(1165.36, 2709.45, 38.16),
	vector3(2678.82, 3280.36, 55.24),
	vector3(1961.17, 3740.5, 32.34),
	vector3(1393.13, 3605.2, 34.98),
	vector3(1697.92, 4924.46, 42.06)
}

ClotheShop = {
	vector3(72.3, -1399.1, 29.4),
	vector3(-703.8, -152.3, 37.4),
	vector3(-167.9, -299.0, 39.7),
	vector3(428.7, -800.1, 29.5),
	vector3(-829.4, -1073.7, 11.3),
	vector3(-1447.8, -242.5, 49.8),
	vector3(11.6, 6514.2, 31.9),
	vector3(123.6, -219.4, 54.6),
	vector3(1696.3, 4829.3, 42.1),
	vector3(618.1, 2759.6, 42.1),
	vector3(1190.6, 2713.4, 38.2),
	vector3(-1193.4, -772.3, 17.3),
	vector3(-3172.5, 1048.1, 20.9),
	vector3(-1108.4, 2708.9, 19.1)
}

TattoShops = {
	vector3(1322.6, -1651.9, 51.2),
	vector3(-1153.6, -1425.6, 3.9),
	vector3(322.1, 180.4, 102.5),
	vector3(-3170.0, 1075.0, 19.8),
	vector3(1864.6, 3747.7, 32.0),
	vector3(-293.7, 6200.0, 30.4)
}

BarberShops = {
	vector3(-814.3, -183.8, 37.6),
	vector3(136.8, -1708.4, 29.3),
	vector3(-1282.6, -1116.8, 7.0),
	vector3(1931.5, 3729.7, 32.8),
	vector3(1212.8, -472.9, 66.2),
	vector3(-32.9, -152.3, 57.1),
	vector3(-278.1, 6228.5, 31.7)
}

GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}