--[[
***** How to Setup a vehicle_names.lua for Custom Addon Vehicles *****
* Create a vehicle_names.lua & past the below Code
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	--Example 1: AddTextEntry('SPAWN_NAME_HERE', 'VEHICLE_NAME_HERE')
	--Example 2: AddTextEntry('f350', '2013 Ford F350')
end)
]]

Config = {}
Config.Locale = 'en'

Config.KickPossibleCheaters = true -- If true it will kick the player that tries store a vehicle that they changed the Hash or Plate.
Config.UseCustomKickMessage = true -- If KickPossibleCheaters is true you can set a Custom Kick Message in the locales.

Config.UseDamageMult = false -- If true it costs more to store a Broken Vehicle.
Config.DamageMult = 10 -- Higher Number = Higher Repair Price.

Config.CarPoundPrice      = 500 -- Car Pound Price.
Config.BoatPoundPrice     = 150 -- Boat Pound Price.
Config.AircraftPoundPrice = 750 -- Aircraft Pound Price.

Config.PolicingPoundPrice  = 10 -- Policing Pound Price.
Config.AmbulancePoundPrice = 10 -- Ambulance Pound Price.

Config.UseCarGarages        = true -- Allows use of Car Garages.
Config.UseGorunmezGarages   = true -- Allows use of Car Garages.
Config.UseBoatGarages       = true -- Allows use of Boat Garages.
Config.UseAircraftGarages   = true -- Allows use of Aircraft Garages.
Config.UsePrivateCarGarages = false -- Allows use of Private Car Garages.
Config.UseJobCarGarages     = true -- Allows use of Job Garages.

Config.DontShowPoundCarsInGarage = true -- If set to true it won't show Cars at the Pound in the Garage.
Config.ShowVehicleLocation       = false -- If set to true it will show the Location of the Vehicle in the Pound/Garage in the Garage menu.
Config.UseVehicleNamesLua        = false -- Must setup a vehicle_names.lua for Custom Addon Vehicles.

Config.ShowGarageSpacer1 = false -- If true it shows Spacer 1 in the List.
Config.ShowGarageSpacer2 = true -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowGarageSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.ShowPoundSpacer2 = true -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowPoundSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.MarkerType   = 20
Config.DrawDistance = 50.0

Config.BlipGarage = {
	Sprite = 290,
	Color = 53,
	Display = 2,
	Scale = 0.4
}

Config.BlipGaragePrivate = {
	Sprite = 290,
	Color = 53,
	Display = 2,
	Scale = 0.5
}

Config.BlipPound = {
	Sprite = 67,
	Color = 64,
	Display = 2,
	Scale = 0.6
}

Config.BlipPoundA = {
	Sprite = 67,
	Color = 6,
	Display = 2,
	Scale = 0.6
}

Config.BlipJobPound = {
	Sprite = 67,
	Color = 49,
	Display = 2,
	Scale = 0.5
}

Config.PointMarker = {
	r = 235, g = 64, b = 52,     -- Green Color
	x = 1.5, y = 1.5, z = 0.5  -- Standard Size Circle
}

Config.DeleteMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 1.0, y = 1.0, z = 0.5  -- Big Size Circle
}

Config.PoundMarker = {
	r = 0, g = 0, b = 100,     -- Blue Color
	x = 1.0, y = 1.0, z = 0.5  -- Standard Size Circle
}

Config.JobPoundMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 1.0, y = 1.0, z = 0.5  -- Standard Size Circle
}

-- Start of Jobs

Config.PolicePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.79 },
		SpawnPoint = { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 38.15 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -447.64, y = 5991.14, z = 31.84 },
		SpawnPoint = { x = -454.91, y = 5998.07, z = 31.34, h = 44.91 }
	}
}

Config.AmbulancePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.79 },
		SpawnPoint = { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 38.15 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.99 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
}

-- End of Jobs
-- Start of Cars


Config.CarGarages = {
	Garage_CentralLS = {
		GaragePoint = { x = 223.797, y = -760.415, z = 30.646 },
		SpawnPoint = { x = 229.700, y = -800.1149, z = 29.5722, h = 157.84 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Motell = {
		GaragePoint = { x = 273.01, y = -342.81, z = 44.92 },
		SpawnPoint = { x = 292.09, y = -332.95, z = 44.92, h = 159.19 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_CentralLuciano = {
		GaragePoint = { x = 22.22, y = 544.32, z = 176.03 },
		SpawnPoint = { x = 14.15, y = 549.072, z = 176.22 ,  h = 60.84 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_Theboss = {
		GaragePoint = { x = 966.65, y = -1019.81, z = 40.85 },
		SpawnPoint = { x = 975.4, y = -1020.07, z = 41.08 ,  h = 274.67 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_CentralCakir = {
		GaragePoint = { x = 1367.43, y = 1156.56, z = 113.75 },
		SpawnPoint = { x = 1359.68, y = 1155.82, z = 113.76, h = 157.84 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_night = {
		GaragePoint = { x = 169.59, y = -3178.59, z = 5.82 },
		SpawnPoint = { x = 173.93, y = -3178.34, z = 5.7, h = 305.62 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_231 = {
		GaragePoint = { x = 51.85, y = 3727.61, z = 39.51 },
		SpawnPoint = { x = 47.93, y = 3731.98, z = 39.68, h = 119.87 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_ss11 = {
		GaragePoint = { x = -165.97, y = 932.7, z = 235.66 },
		SpawnPoint = { x = -158.11, y = 929.07, z = 235.66, h = 217.94 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_ss16 = {
		GaragePoint = { x = -1790.48, y = 458.25, z = 128.31 },
		SpawnPoint = { x = -1795.42, y = 457.49, z = 128.31, h = 88.36},
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_ss12 = {
		GaragePoint = { x = -445.19, y = -800.73, z = 30.54 },
		SpawnPoint = { x = -445.19, y = -800.73, z = 30.54, h = 94.29 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_ss13 = {
		GaragePoint = { x = 2519.65, y = 1991.02, z = 19.97 },
		SpawnPoint = { x = 2519.65, y = 1991.02, z = 19.97, h = 197.62 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_ss13 = {
		GaragePoint = { x = -295.23, y = -422.64, z = 30.24 },
		SpawnPoint = { x = -289.65, y = -412.35, z = 29.96, h = 197.62 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_ss14 = {
		GaragePoint = { x = 762.27, y = -1212.28, z = 24.69 },
		SpawnPoint = { x = 764.6, y = -1204.56, z = 24.33, h = 176.49 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_2323 = {
		GaragePoint = { x = -105.58, y = 826.19, z = 235.72 },
		SpawnPoint = { x = -107.11, y = 840.4, z = 235.63, h = 344.63 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_CentralCakirr = {
		GaragePoint = { x = 237.97, y = -35.54, z = 69.73 },
		SpawnPoint = { x = 234.61, y = -34.13, z = 69.72, h = 70.44 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_1234 = {
		GaragePoint = { x = -812.29, y = 187.54, z = 72.47 },
		SpawnPoint = { x = -821.08, y = 183.53, z = 72.02, h = 121.93 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_chimen = {
		GaragePoint = { x = -188.93, y = -1290.35, z = 31.3 },
		SpawnPoint = { x = -182.07, y = -1290.83, z = 31.3, h = 181.55 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_CUSTOMSS  = {
		GaragePoint = { x = -365.41, y = -109.24, z = 38.7 },
		SpawnPoint = { x = -366.21, y = -114.39, z = 38.7, h = 152.74 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_helikopter  = {
		GaragePoint = { x = -1258.51, y = -3347.97, z = 13.95 },
		SpawnPoint = { x = -1247.12, y = -3330.4, z = 13.95, h = 92.15 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_felix = {
		GaragePoint = { x = -112.92, y = 1005.66, z = 235.77 },
		SpawnPoint = { x = -119.53, y = 1003.63, z = 235.73, h = 107.93 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }	
	},
	Garage_Playboy = {
		GaragePoint = { x = -1529.33, y = 83.5, z = 56.66 },
		SpawnPoint = { x = -1523.14, y = 88.48, z = 56.45, h = 254.99 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},			
	Garage_CentralMotel = {
		GaragePoint = { x = 438.59, y = 221.99, z = 103.17 },
		SpawnPoint = { x = 423.260, y = 228.34, z = 103.1922, h = 69.84 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},			
	Garage_BozkurtMekanik = {
		GaragePoint = { x = 551.33, y = -207.31, z = 54.06 },
		SpawnPoint = { x = 546.11, y = -215.38, z = 52.34, h = 161.16 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Grovegangg = {
		GaragePoint = { x = -129.18, y = -1618.2, z = 32.51 },
		SpawnPoint = { x = -117.67, y = -1613.07, z = 31.95, h = 322.84 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Anarchy = {
		GaragePoint = { x = 987.09, y = -139.2, z = 73.09 },
		SpawnPoint = { x = 972.51, y = -130.19, z = 74.25, h = 59.48 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_CentralLLS = {
		GaragePoint = { x = -1573.83, y = -264.171, z = 48.28 },
		SpawnPoint = { x = -1576.85, y = -271.82, z = 48.28, h = 172.66 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Cardealer = {
		GaragePoint = { x = -15.95, y = -1097.97, z = 26.67 },
		SpawnPoint = { x = -13.99, y = -1108.12, z = 26.6722, h = 100.84 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Sandy = {
		GaragePoint = { x = 1722.66, y = 3713.74, z = 34.21 },
		SpawnPoint = { x = 1737.84, y = 3719.28, z = 33.04, h = 21.22 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	-- Garage_Prison = {
	-- 	GaragePoint = { x = 1855.77, y = 2585.96, z = 45.67 },
	-- 	SpawnPoint = { x = 1855.11, y = 2592.72, z = 44.67, h = 274.8 },
	-- 	DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	-- },
	Garage_RaceTrack = {
		GaragePoint = { x = 1207.9, y = 343.8, z = 81.99 },
		SpawnPoint = { x = 1199.02, y = 330.92, z = 80.99, h = 144.86 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Tacos = {
		GaragePoint = { x = 45.5, y = -1623.01, z = 29.32 },
		SpawnPoint = { x = 45.09, y = -1614.14, z = 29.36, h = 52.37 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_RaceTrack = {
		GaragePoint = { x = -608.28, y = -1008.01, z = 21.78 },
		SpawnPoint = { x = -608.78, y = -1000.58, z = 21.79, h = 88.73 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
}


Config.GorunmezGarages = {
	Garage_Emlak = {
		GaragePoint = { x = -41.69, y = -786.63, z = 44.24 },
		SpawnPoint = { x = -38.78, y = -784.45, z = 44.06, h = 275.39 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Emlak2 = {
		GaragePoint = { x = -110.26, y = -594.74, z = 36.28 },
		SpawnPoint = { x = -101.8, y = -597.24, z = 36.06, h = 251.18 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},	
	Garage_Emlak3 = {
		GaragePoint = { x = -75.25, y = -819.8, z = 35.98 },
		SpawnPoint = { x = -77.58, y = -817.34, z = 326.18, h = 291.65 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }	
	},
	-- Garage_1lojistik = {
	-- 	GaragePoint = { x = 476.19, y = -3358.75, z = 6.07 },
	-- 	SpawnPoint = { x = 480.34, y = -3352.31, z = 6.07, h = 267.96 },
	-- 	DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	-- },
	Garage_Alleyblackmarkt= {
		GaragePoint = { x = 822.13, y = -2142.48, z = 28.87 },
		SpawnPoint = { x = 823.15, y = -2135.28, z = 29.29, h = 0.52 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Alleyorganize= {
		GaragePoint = { x = -1576.32, y = -78.06, z = 54.13 },
		SpawnPoint = { x = -1570.4, y = -81.53, z = 54.13, h = 275.44 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Ballasgangg = {
		GaragePoint = { x = 88.61, y = -1968.11, z = 20.75 },
		SpawnPoint = { x = 112.98, y = -1945.32, z = 20.76, h = 329.05 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Vagosgangg = {
		GaragePoint = { x = 939.71, y = -2194.85, z = 30.55 },
		SpawnPoint = { x = 950.68, y = -2185.26, z = 30.56, h = 80.95 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Bloodzgangg = {
		GaragePoint = { x = -1491.06, y = -665.22, z = 28.94 },
		SpawnPoint = { x = -1478.4, y = -665.69, z = 28.94, h = 304.21 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_cali = {
		GaragePoint = { x = -2596.404, y = 1931.209, z = 166.7576 }, 
		SpawnPoint = { x = -2588.835, y = 1931.209, z = 166.7576, h = 304.21 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Gmggarageee = {
		GaragePoint = { x = 497.67, y = -1322.09, z = 29.29 },
		SpawnPoint = { x = 496.48, y = -1327.85, z = 29.34, h = 11.76 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Motifgarage = {
		GaragePoint = { x = 719.29, y = -1062.57, z = 22.13 },
		SpawnPoint = { x = 717.58, y = -1057.81, z = 21.99, h = 29.02 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_Bullssecurity = {
		GaragePoint = { x = -1842.23, y = -363.88, z = 49.39 },
		SpawnPoint = { x = -1843.84, y = -372.58, z = 48.28, h = 133.63 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_LosAztecasss = {
		GaragePoint = { x = 306.08, y = -2023.58, z = 20.32 },
		SpawnPoint = { x = 316.14, y = -2032.74, z = 20.56, h = 320.43 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_KaraAilesi = {
		GaragePoint = { x = -1534.66, y = 889.13, z = 181.8 },
		SpawnPoint = { x = -1541.76, y = 886.74, z = 181.5, h = 202.68 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_DiabloMekanik = {
		GaragePoint = { x = -1115.84, y = -2009.95, z = 13.18 },
		SpawnPoint = { x = -1122.95, y = -2001.08, z = 13.17, h = 227.31 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_IvanMalikane = {
		GaragePoint = { x = -676.88, y = 903.55, z = 230.58 },
		SpawnPoint = { x = -670.15, y = 912.02, z = 230.26, h = 284.49 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_MermiHelikopter = {
		GaragePoint = { x = -74.63, y = -821.93, z = 326.18 },
		SpawnPoint = { x = -75.32, y = -819.65, z = 326.18, h = 1.51 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
	Garage_KaraHelikopter = {
		GaragePoint = { x = -1565.8, y = 840.62, z = 184.2 },
		SpawnPoint = { x = -1567.63, y = 848.87, z = 183.76, h = 294.21 },
		DeletePoint = { x = 0.0, y = 0.0, z = 0.0 }
	},
}


Config.CarPounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 407.03, y = -1639.39, z = 29.29 },
		SpawnPoint = { x = 410.52, y = -1649.06, z = 29.29, h = 230.32 }
	},
	Pound_Havalimani = {
		PoundPoint = { x = -1241.36, y = -3389.78, z = 13.94 },  
		SpawnPoint = { x = -1271.45, y = -3382, z = 13.94, h = 329.69 }
	}
	
}

-- End of Cars
-- Start of Boats

Config.BoatGarages = {
	Garage_LSDock = {
		GaragePoint = { x = -735.87, y = -1325.08, z = 1.6 },
		SpawnPoint = { x = -718.87, y = -1320.18, z = -0.47477427124977, h = 45.0 },
		DeletePoint = { x = -731.15, y = -1334.71, z = 0.47477427124977 }
	},
	Garage_PaletoDock = {
		GaragePoint = { x = -283.74, y = 6629.51, z = 7.3 },
		SpawnPoint = { x = -290.46, y = 6622.72, z = -0.47477427124977, h = 52.0 },
		DeletePoint = { x = -304.66, y = 6607.36, z = 0.97477427124977 }
	},
}

Config.BoatPounds = {
	Pound_LSDock = {
		PoundPoint = { x = -738.67, y = -1400.43, z = 5.0 },
		SpawnPoint = { x = -738.33, y = -1381.51, z = 0.12, h = 137.85 }
	},
	Pound_SandyDock = {
		PoundPoint = { x = 1299.36, y = 4217.93, z = 33.91 },
		SpawnPoint = { x = 1294.35, y = 4226.31, z = 30.36, h = 345.0 }
	},
	Pound_PaletoDock = {
		PoundPoint = { x = -270.2, y = 6642.43, z = 7.36 },
		SpawnPoint = { x = -290.38, y = 6638.54, z = -0.47477427124977, h = 130.0 }
	}
}

-- End of Boats
-- Start of Aircrafts

Config.AircraftGarages = {
	Garage_LSAirport = {
		GaragePoint = { x = -1617.14, y = -3145.52, z = 13.99 },
		SpawnPoint = { x = -1657.99, y = -3134.38, z = 12.99, h = 330.11 },
		DeletePoint = { x = -1642.12, y = -3144.25, z = 13.99 }
	},
	Garage_SandyAirport = {
		GaragePoint = { x = 1723.84, y = 3288.29, z = 41.16 },
		SpawnPoint = { x = 1710.85, y = 3259.06, z = 40.69, h = 104.66 },
		DeletePoint = { x = 1714.45, y = 3246.75, z = 41.07 }
	},
	Garage_Sehir = {
		GaragePoint = { x = -721.15, y = -1452.29, z = 5.01 },
		SpawnPoint = { x = -725.08, y = -1444.31, z = 5.1, h = 44.89 },
		DeletePoint = { x = -725.6, y = -1444.18, z = 5.7 }
	},	
	Garage_GrapeseedAirport = {
		GaragePoint = { x = 2152.83, y = 4797.03, z = 41.19 },
		SpawnPoint = { x = 2122.72, y = 4804.85, z = 40.78, h = 115.04 },
		DeletePoint = { x = 2082.36, y = 4806.06, z = 41.07 }
	}
}

Config.AircraftPounds = {
	Pound_LSAirport = {
		PoundPoint = { x = -1243.0, y = -3391.92, z = 13.94 },
		SpawnPoint = { x = -1272.27, y = -3382.46, z = 12.94, h = 330.25 }
	}
}

-- End of Aircrafts
-- Start of Private Garages

Config.PrivateCarGarages = {
	-- Maze Bank Building Garages
	Garage_MazeBankBuilding = {
		Private = "MazeBankBuilding",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_OldSpiceWarm = {
		Private = "OldSpiceWarm",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_OldSpiceClassical = {
		Private = "OldSpiceClassical",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_OldSpiceVintage = {
		Private = "OldSpiceVintage",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_ExecutiveRich = {
		Private = "ExecutiveRich",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_ExecutiveCool = {
		Private = "ExecutiveCool",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_ExecutiveContrast = {
		Private = "ExecutiveContrast",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_PowerBrokerIce = {
		Private = "PowerBrokerIce",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_PowerBrokerConservative = {
		Private = "PowerBrokerConservative",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_PowerBrokerPolished = {
		Private = "PowerBrokerPolished",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	-- End of Maze Bank Building Garages
	-- Start of Lom Bank Garages
	Garage_LomBank = {
		Private = "LomBank",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBOldSpiceWarm = {
		Private = "LBOldSpiceWarm",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBOldSpiceClassical = {
		Private = "LBOldSpiceClassical",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBOldSpiceVintage = {
		Private = "LBOldSpiceVintage",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBExecutiveRich = {
		Private = "LBExecutiveRich",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBExecutiveCool = {
		Private = "LBExecutiveCool",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBExecutiveContrast = {
		Private = "LBExecutiveContrast",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBPowerBrokerIce = {
		Private = "LBPowerBrokerIce",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBPowerBrokerConservative = {
		Private = "LBPowerBrokerConservative",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBPowerBrokerPolished = {
		Private = "LBPowerBrokerPolished",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	-- End of Lom Bank Garages
	-- Start of Maze Bank West Garages
	Garage_MazeBankWest = {
		Private = "MazeBankWest",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWOldSpiceWarm = {
		Private = "MBWOldSpiceWarm",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWOldSpiceClassical = {
		Private = "MBWOldSpiceClassical",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWOldSpiceVintage = {
		Private = "MBWOldSpiceVintage",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWExecutiveRich = {
		Private = "MBWExecutiveRich",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWExecutiveCool = {
		Private = "MBWExecutiveCool",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWExecutiveContrast = {
		Private = "MBWExecutiveContrast",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWPowerBrokerIce = {
		Private = "MBWPowerBrokerIce",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWPowerBrokerConvservative = {
		Private = "MBWPowerBrokerConvservative",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWPowerBrokerPolished = {
		Private = "MBWPowerBrokerPolished",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	-- End of Maze Bank West Garages
	-- Start of Intergrity Way Garages
	Garage_IntegrityWay = {
		Private = "IntegrityWay",
		GaragePoint = { x = -14.1, y = -614.93, z = 34.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 34.073 }
	},
	Garage_IntegrityWay28 = {
		Private = "IntegrityWay28",
		GaragePoint = { x = -14.1, y = -614.93, z = 34.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 34.073 }
	},
	Garage_IntegrityWay30 = {
		Private = "IntegrityWay30",
		GaragePoint = { x = -14.1, y = -614.93, z = 34.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 34.073 }
	},
	-- End of Intergrity Way Garages
	-- Start of Dell Perro Heights Garages
	Garage_DellPerroHeights = {
		Private = "DellPerroHeights",
		GaragePoint = { x = -1477.15, y = -517.17, z = 33.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 30.582 }
	},
	Garage_DellPerroHeightst4 = {
		Private = "DellPerroHeightst4",
		GaragePoint = { x = -1477.15, y = -517.17, z = 33.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 30.582 }
	},
	Garage_DellPerroHeightst7 = {
		Private = "DellPerroHeightst7",
		GaragePoint = { x = -1477.15, y = -517.17, z = 33.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 30.582 }
	},
	-- End of Dell Perro Heights Garages
	-- Start of Milton Drive Garages
	Garage_MiltonDrive = {
		Private = "MiltonDrive",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Modern1Apartment = {
		Private = "Modern1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Modern2Apartment = {
		Private = "Modern2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Modern3Apartment = {
		Private = "Modern3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Mody1Apartment = {
		Private = "Mody1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Mody2Apartment = {
		Private = "Mody2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Mody3Apartment = {
		Private = "Mody3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Vibrant1Apartment = {
		Private = "Vibrant1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Vibrant2Apartment = {
		Private = "Vibrant2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Vibrant3Apartment = {
		Private = "Vibrant3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Sharp1Apartment = {
		Private = "Sharp1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Sharp2Apartment = {
		Private = "Sharp2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Sharp3Apartment = {
		Private = "Sharp3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Monochrome1Apartment = {
		Private = "Monochrome1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Monochrome2Apartment = {
		Private = "Monochrome2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Monochrome3Apartment = {
		Private = "Monochrome3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Seductive1Apartment = {
		Private = "Seductive1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Seductive2Apartment = {
		Private = "Seductive2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Seductive3Apartment = {
		Private = "Seductive3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Regal1Apartment = {
		Private = "Regal1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Regal2Apartment = {
		Private = "Regal2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Regal3Apartment = {
		Private = "Regal3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Aqua1Apartment = {
		Private = "Aqua1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Aqua2Apartment = {
		Private = "Aqua2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Aqua3Apartment = {
		Private = "Aqua3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	-- End of Milton Drive Garages
	-- Start of Single Garages
	Garage_RichardMajesticApt2 = {
		Private = "RichardMajesticApt2",
		GaragePoint = { x = -887.5, y = -349.58, z = 33.534 },
		SpawnPoint = { x = -886.03, y = -343.78, z = 33.534, h = 206.79 },
		DeletePoint = { x = -894.324, y = -349.326, z = 33.534 }
	},
	Garage_WildOatsDrive = {
		Private = "WildOatsDrive",
		GaragePoint = { x = -178.65, y = 503.45, z = 135.85 },
		SpawnPoint = { x = -189.98, y = 505.8, z = 133.48, h = 282.62 },
		DeletePoint = { x = -189.28, y = 500.56, z = 132.93 }
	},
	Garage_WhispymoundDrive = {
		Private = "WhispymoundDrive",
		GaragePoint = { x = 123.65, y = 565.75, z = 183.04 },
		SpawnPoint = { x = 130.11, y = 571.47, z = 182.42, h = 270.71 },
		DeletePoint = { x = 131.97, y = 566.77, z = 181.95 }
	},
	Garage_NorthConkerAvenue2044 = {
		Private = "NorthConkerAvenue2044",
		GaragePoint = { x = 348.18, y = 443.01, z = 146.7 },
		SpawnPoint = { x = 358.397, y = 437.064, z = 144.277, h = 285.911 },
		DeletePoint = { x = 351.383, y = 438.865, z = 145.66 }
	},
	Garage_NorthConkerAvenue2045 = {
		Private = "NorthConkerAvenue2045",
		GaragePoint = { x = 370.69, y = 430.76, z = 144.11 },
		SpawnPoint = { x = 392.88, y = 434.54, z = 142.17, h = 264.94 },
		DeletePoint = { x = 389.72, y = 429.95, z = 141.81 }
	},
	Garage_HillcrestAvenue2862 = {
		Private = "HillcrestAvenue2862",
		GaragePoint = { x = -688.71, y = 597.57, z = 142.64 },
		SpawnPoint = { x = -683.72, y = 609.88, z = 143.28, h = 338.06 },
		DeletePoint = { x = -685.259, y = 601.083, z = 142.365 }
	},
	Garage_HillcrestAvenue2868 = {
		Private = "HillcrestAvenue2868",
		GaragePoint = { x = -752.753, y = 624.901, z = 141.2 },
		SpawnPoint = { x = -749.32, y = 628.61, z = 141.48, h = 197.14 },
		DeletePoint = { x = -754.286, y = 631.581, z = 141.2 }
	},
	Garage_HillcrestAvenue2874 = {
		Private = "HillcrestAvenue2874",
		GaragePoint = { x = -859.01, y = 695.95, z = 147.93 },
		SpawnPoint = { x = -863.681, y = 698.72, z = 147.052, h = 341.77 },
		DeletePoint = { x = -855.66, y = 698.77, z = 147.81 }
	},
	Garage_MadWayneThunder = {
		Private = "MadWayneThunder",
		GaragePoint = { x = -1290.95, y = 454.52, z = 96.66 },
		SpawnPoint = { x = -1297.62, y = 459.28, z = 96.48, h = 285.652 },
		DeletePoint = { x = -1298.088, y = 468.952, z = 96.0 }
	},
	Garage_TinselTowersApt12 = {
		Private = "TinselTowersApt12",
		GaragePoint = { x = -616.74, y = 56.38, z = 42.736 },
		SpawnPoint = { x = -620.588, y = 60.102, z = 42.736, h = 109.316 },
		DeletePoint = { x = -621.128, y = 52.691, z = 42.735 }
	},
	-- End of Single Garages
	-- Start of VENT Custom Garages
	Garage_MedEndApartment1 = {
		Private = "MedEndApartment1",
		GaragePoint = { x = 240.23, y = 3102.84, z = 41.49 },
		SpawnPoint = { x = 233.58, y = 3094.29, z = 41.49, h = 93.91 },
		DeletePoint = { x = 237.52, y = 3112.63, z = 41.39 }
	},
	Garage_MedEndApartment2 = {
		Private = "MedEndApartment2",
		GaragePoint = { x = 246.08, y = 3174.63, z = 41.72 },
		SpawnPoint = { x = 234.15, y = 3164.37, z = 41.54, h = 102.03 },
		DeletePoint = { x = 240.72, y = 3165.53, z = 41.65 }
	},
	Garage_MedEndApartment3 = {
		Private = "MedEndApartment3",
		GaragePoint = { x = 984.92, y = 2668.95, z = 39.06 },
		SpawnPoint = { x = 993.96, y = 2672.68, z = 39.06, h = 0.61 },
		DeletePoint = { x = 994.04, y = 2662.1, z = 39.13 }
	},
	Garage_MedEndApartment4 = {
		Private = "MedEndApartment4",
		GaragePoint = { x = 196.49, y = 3027.48, z = 42.89 },
		SpawnPoint = { x = 203.1, y = 3039.47, z = 42.08, h = 271.3 },
		DeletePoint = { x = 192.24, y = 3037.95, z = 42.89 }
	},
	Garage_MedEndApartment5 = {
		Private = "MedEndApartment5",
		GaragePoint = { x = 1724.49, y = 4638.13, z = 42.31 },
		SpawnPoint = { x = 1723.98, y = 4630.19, z = 42.23, h = 117.88 },
		DeletePoint = { x = 1733.66, y = 4635.08, z = 42.24 }
	},
	Garage_MedEndApartment6 = {
		Private = "MedEndApartment6",
		GaragePoint = { x = 1670.76, y = 4740.99, z = 41.08 },
		SpawnPoint = { x = 1673.47, y = 4756.51, z = 40.91, h = 12.82 },
		DeletePoint = { x = 1668.46, y = 4750.83, z = 40.88 }
	},
	Garage_MedEndApartment7 = {
		Private = "MedEndApartment7",
		GaragePoint = { x = 15.24, y = 6573.38, z = 31.72 },
		SpawnPoint = { x = 16.77, y = 6581.68, z = 31.42, h = 222.6 },
		DeletePoint = { x = 10.45, y = 6588.04, z = 31.47 }
	},
	Garage_MedEndApartment8 = {
		Private = "MedEndApartment8",
		GaragePoint = { x = -374.73, y = 6187.06, z = 30.54 },
		SpawnPoint = { x = -377.97, y = 6183.73, z = 30.49, h = 223.71 },
		DeletePoint = { x = -383.31, y = 6188.85, z = 30.49 }
	},
	Garage_MedEndApartment9 = {
		Private = "MedEndApartment9",
		GaragePoint = { x = -24.6, y = 6605.99, z = 30.45 },
		SpawnPoint = { x = -16.0, y = 6607.74, z = 30.18, h = 35.31 },
		DeletePoint = { x = -9.36, y = 6598.86, z = 30.47 }
	},
	Garage_MedEndApartment10 = {
		Private = "MedEndApartment10",
		GaragePoint = { x = -365.18, y = 6323.95, z = 28.9 },
		SpawnPoint = { x = -359.49, y = 6327.41, z = 28.83, h = 218.58 },
		DeletePoint = { x = -353.47, y = 6334.57, z = 28.83 }
	}
	-- End of VENT Custom Garages
}

-- End of Private Garages
