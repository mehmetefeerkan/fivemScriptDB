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
Config.DrawDistance = 5.0

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
	Color = 64,
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
	x = 1.0, y = 1.0, z = 0.5  -- Standard Size Circle
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

-- POLIS ARAÇLARI BAĞLANMIŞ --

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

-- AMBULANCE ARAÇLARI BAĞLANMIŞ --

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

-- ARAÇ GARAJLARI --

Config.CarGarages = {
	Garage_Parking1 = {
		GaragePoint = { x = 223.48, y = -761.68, z = 30.82 },
		SpawnPoint = { x = 230.25, y = -743.01, z = 30.82, h = 152.93 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking2 = {
		GaragePoint = { x = 1737.59, y = 3710.2, z = 34.14 },
		SpawnPoint = { x = 1737.84, y = 3719.28, z = 33.04, h = 21.22 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking3 = {
		GaragePoint = { x = -733.62, y = -71.04, z = 41.75 },
		SpawnPoint = { x = -735.55, y = -60.5, z = 41.75, h = 116.86 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking4 = {
		GaragePoint = { x = 1852.75, y = 2578.97, z = 45.67 },
		SpawnPoint = { x = 1855.11, y = 2592.72, z = 44.67, h = 274.8 },
		DeletePoint = { x = 0, y = 0, z = 0 } -- z = 44.67
	},
	Garage_Parking5 = {
		GaragePoint = { x = 1212.32, y = 339.94, z = 81.99 },
		SpawnPoint = { x = 1199.02, y = 330.92, z = 80.99, h = 144.86 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},	
	Garage_Parking6 = {
		GaragePoint = { x = 282.01, y = 68.41, z = 94.37 },
		SpawnPoint = { x = 285.07, y = 76.15, z = 94.36, h = 245.91 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking7 = {
		GaragePoint = { x = 273.35, y = -343.33, z = 44.92 },
		SpawnPoint = { x = 274.27, y = -330.21, z = 44.92, h = 161.57 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking8 = {
		GaragePoint = { x = -1594.85, y = -873.94, z = 9.94 },
		SpawnPoint = { x = -1603.22, y = -886.54, z = 9.56, h = 324.74 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking9 = {
		GaragePoint = { x = 45.84, y = -1732.4, z = 29.3 },
		SpawnPoint = { x = 33.7, y = -1727.55, z = 29.3, h = 52.13 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking10 = {
		GaragePoint = { x = 361.12, y = -1690.49, z = 32.53 },
		SpawnPoint = { x = 355.69, y = -1676.61, z = 32.54, h = 140.06 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking11 = {
		GaragePoint = { x = 421.99, y = -1326.06, z = 46.05 },
		SpawnPoint = { x = 414.56, y = -1334.97, z = 46.05, h = 319.05 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking12 = {
		GaragePoint = { x = -569.87, y = 316.27, z = 84.46 },
		SpawnPoint = { x = -580.5, y = 316.75, z = 84.78, h = 353.15 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking13 = {
		GaragePoint = { x = -1977.68, y = -291.78, z = 44.11 },
		SpawnPoint = { x = -1988.8, y = -302.79, z = 44.11, h = 241.01 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking14 = {
		GaragePoint = { x = -693.9, y = -738.11, z = 29.36 },
		SpawnPoint = { x = -704.44, y = -733.67, z = 28.74, h = 183.3 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	},
	Garage_Parking15 = {
		GaragePoint = { x = -372.926, y = -108.799, z = 38.681 },
		SpawnPoint = { x = -362.57, y = -114.74, z = 39.0115, h = 152.0 },
		DeletePoint = { x = 0, y = 0, z = 0 }
	}
}

-- BAĞKANMIŞ ARAÇLAR --

Config.CarPounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 408.61, y = -1625.47, z = 28.75 },
		SpawnPoint = { x = 405.64, y = -1643.4, z = 27.61, h = 229.54 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1651.38, y = 3804.84, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -234.82, y = 6198.65, z = 30.94 },
		SpawnPoint = { x = -230.08, y = 6190.24, z = 30.49, h = 140.24 }
	}
}

-- BOT GARAJI --

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

-- BOT BAĞLANMIŞ --

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

-- UÇAK GARAJI

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

-- UÇAK BAĞLANMIŞ --

Config.AircraftPounds = {
	Pound_LSAirport = {
		PoundPoint = { x = -1243.0, y = -3391.92, z = 13.94 },
		SpawnPoint = { x = -1272.27, y = -3382.46, z = 12.94, h = 330.25 }
	}
}