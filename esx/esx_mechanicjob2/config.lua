Config                            = {}
Config.Locale                     = 'en'

Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = false
Config.EnableSocietyOwnedVehicles = false

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }

Config.Jobs = {
	["mechanic2"] = {
		--blip =  {x = 938.24, y = -970.75, z = 38.92},
		telefon = "Satılık Mekanik",
		VehicleSpawnPoint = {
				--Pos   = vector3(-180.99, -1284.64, 31.3),
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = -1
			},
		
		locations = {
			MechanicActions = {
				--Pos   = { x = -192.27, y = -1293.57, z = 30.39 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Color = { r = 204, g = 204, b = 0 },
				Type  = 1
			},
			DeleteVehicle = {
				--Pos   = { x = -189.64, y = -1276.44, z = 30.38 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Color = { r = 204, g = 204, b = 0 },
				Type  = 1
			},
		},
	},
	["mechanic1"] = {
		--blip =  {x = -339.54, y = -132.14, z = 38.41},
		telefon = "Satılık Mekanik",
		VehicleSpawnPoint = {
				--Pos   = vector3(-180.99, -1284.64, 31.3),
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = -1
			},
		
		locations = {
			MechanicActions = {
				Pos   = { x = -340.64, y = -132.92, z = 39.41 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Color = { r = 204, g = 204, b = 0 },
				Type  = 1
			},
			DeleteVehicle = {
				--Pos   = { x = -189.64, y = -1276.44, z = 30.38 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Color = { r = 204, g = 204, b = 0 },
				Type  = 1
			},
		},
	},
	--["mechanic"] = {
		--blip = {x = -211.2, y = -1324.78, z = 30.89 },
		--telefon = "RED GAREGE",
		--locations = {
			--VehicleSpawnPoint = {
				--Pos   = vector3( 978.94, -114.49, 74.29),
				--Size  = { x = 1.5, y = 1.5, z = 1.0 },
				--Type  = -1
			--},
			--MechanicActions = {
				--Pos   = { x = 971.43, y = -115.08, z = 73.28 },
				--Size  = { x = 1.5, y = 1.5, z = 1.0 },
				--Color = { r = 204, g = 204, b = 0 },
				--Type  = 1
			--},
			--DeleteVehicle = {
				--Pos   = { x = 981.66, y = -114.02, z = 72.96 },
				--Size  = { x = 1.5, y = 1.5, z = 1.0 },
				--Color = { r = 204, g = 204, b = 0 },
				--Type  = 1
			--},
			
		--},
	--},
	--["mekanik4"] = {
		--blip = {x = -211.15, y = -1324.13, z = 30.89 },
		--telefon = "Türkoğlu Mekanik",
		--locations = {
			--VehicleSpawnPoint = {
				--Pos   = vector3( 978.94, -114.49, 74.29),
				--Size  = { x = 1.5, y = 1.5, z = 1.0 },
				--Type  = -1
			--},
			--MechanicActions = {
				--Pos   = { x = 971.43, y = -115.08, z = 73.28 },
				--Size  = { x = 1.5, y = 1.5, z = 1.0 },
				--Color = { r = 204, g = 204, b = 0 },
				--Type  = 1
			--},
			--DeleteVehicle = {
				--Pos   = { x = 981.66, y = -114.02, z = 72.96 },
				--Size  = { x = 1.5, y = 1.5, z = 1.0 },
				--Color = { r = 204, g = 204, b = 0 },
				--Type  = 1
			--},
			
		--},
	--},
	["mechanic"] = {
		blip =  {x = -237.66, y = -1306.27, z = 31.34},
		telefon = "Satılık Mekanik",
		VehicleSpawnPoint = {
				Pos   = vector3(-204.13, -1303.14, 31.28),
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Type  = -1
			},
		
		locations = {
			MechanicActions = {
				Pos   = { x = -241.16, y = -1337.77, z = 30.9 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Color = { r = 204, g = 204, b = 0 },
				Type  = 2
			},
			DeleteVehicle = {
				Pos   = { x = -226.75, y = -1293.14, z = 31.33 },
				Size  = { x = 1.5, y = 1.5, z = 1.0 },
				Color = { r = 204, g = 204, b = 0 },
				Type  = 2
			},
		},
	},
}


Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo'
}

Config.Zones = {

	MechanicActions = {
		Pos   = { x = 1.5, y = 1.5, z = 1.5 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	Garage = {
		Pos   = { x = 1.5, y = 1.5, z = 1.5},
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	Craft = {
		Pos   = { x = 0, y = 0, z = 0 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	

	VehicleDeleter = {
		Pos   = { x = 0, y = 0, z = 0 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	VehicleDelivery = {
		Pos   = { x = 0, y = 0, z = 0 },
		Size  = { x = 20.0, y = 20.0, z = 3.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
}

Config.Towables = {
	vector3(-2480.9, -212.0, 17.4),
	vector3(-2723.4, 13.2, 15.1),
	vector3(-3169.6, 976.2, 15.0),
	vector3(-3139.8, 1078.7, 20.2),
	vector3(-1656.9, -246.2, 54.5),
	vector3(-1586.7, -647.6, 29.4),
	vector3(-1036.1, -491.1, 36.2),
	vector3(-1029.2, -475.5, 36.4),
	vector3(75.2, 164.9, 104.7),
	vector3(-534.6, -756.7, 31.6),
	vector3(487.2, -30.8, 88.9),
	vector3(-772.2, -1281.8, 4.6),
	vector3(-663.8, -1207.0, 10.2),
	vector3(719.1, -767.8, 24.9),
	vector3(-971.0, -2410.4, 13.3),
	vector3(-1067.5, -2571.4, 13.2),
	vector3(-619.2, -2207.3, 5.6),
	vector3(1192.1, -1336.9, 35.1),
	vector3(-432.8, -2166.1, 9.9),
	vector3(-451.8, -2269.3, 7.2),
	vector3(939.3, -2197.5, 30.5),
	vector3(-556.1, -1794.7, 22.0),
	vector3(591.7, -2628.2, 5.6),
	vector3(1654.5, -2535.8, 74.5),
	vector3(1642.6, -2413.3, 93.1),
	vector3(1371.3, -2549.5, 47.6),
	vector3(383.8, -1652.9, 37.3),
	vector3(27.2, -1030.9, 29.4),
	vector3(229.3, -365.9, 43.8),
	vector3(-85.8, -51.7, 61.1),
	vector3(-4.6, -670.3, 31.9),
	vector3(-111.9, 92.0, 71.1),
	vector3(-314.3, -698.2, 32.5),
	vector3(-366.9, 115.5, 65.6),
	vector3(-592.1, 138.2, 60.1),
	vector3(-1613.9, 18.8, 61.8),
	vector3(-1709.8, 55.1, 65.7),
	vector3(-521.9, -266.8, 34.9),
	vector3(-451.1, -333.5, 34.0),
	vector3(322.4, -1900.5, 25.8)
}

for k,v in ipairs(Config.Towables) do
	Config.Zones['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end
