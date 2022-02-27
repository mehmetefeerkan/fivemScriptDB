Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.2, y = 1.2, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 5 * 60000 -- 5 mins

Config.EnableJobBlip              = true -- enable blips for cops on duty, requires esx_society
Config.EnableCustomPeds           = false -- enable custom peds in cloak room? See Config.CustomPeds below to customize peds

Config.EnableESXService           = false -- enable esx service?
Config.MaxInService               = -1

Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Vehicles = {
			{
				Spawner = vector3(428.26, -1013.08, 28.92),
				InsideShop = vector3(462.54, -1015.72, 41.01),
				SpawnPoints = {
					{ coords = vector3(428.38, -1021.63, 28.70), heading = 87.05, radius = 6.0 },
					{ coords = vector3(434.99, -1021.63, 28.70), heading = 87.05, radius = 6.0 },
					{ coords = vector3(435.34, -1026.45, 28.70), heading = 87.05, radius = 6.0 },
					{ coords = vector3(441.03, -1021.50, 28.70), heading = 87.05, radius = 6.0 },
					{ coords = vector3(441.40, -1026.28, 28.70), heading = 87.05, radius = 6.0 }
				}
			}

		},

		Helicopters = {
			{
				Spawner = vector3(462.04, -980.98, 43.69),
				InsideShop = vector3(449.04, -981.23, 43.23),
				SpawnPoints = {
					{ coords = vector3(449.04, -981.23, 43.23), heading = 83.31, radius = 10.0 }
				}
			}

		},

	}

}

Config.AuthorizedVehicles = {
	car = {
		cadet = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
		},
		officer = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
			{ model = 'dodgePD', label = 'Dodge PD', price = 1000 },
		},
		senior_officer = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
			{ model = 'dodgePD', label = 'Dodge PD', price = 1000 },
		},
		seargent = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
			{ model = 'dodgePD', label = 'Dodge PD', price = 1000 },
		},
		lieutenant = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
			{ model = 'dodgePD', label = 'Dodge PD', price = 1000 },
			{ model = 'audipd', label = 'Audi PD', price = 1000 },
		},
		captain = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
			{ model = 'dodgePD', label = 'Dodge PD', price = 1000 },
			{ model = 'audipd', label = 'Audi PD', price = 1000 },
		},
		asst_cop = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
			{ model = 'dodgePD', label = 'Dodge PD', price = 1000 },
			{ model = 'audipd', label = 'Audi PD', price = 1000 },
			{ model = 'g63amg6x6cop', label = '6X6 PD', price = 1000 },
		},
		boss = {
			{ model = 'policeb', label = 'Police Bike', price = 1000 },
			{ model = 'dodgePD', label = 'Dodge PD', price = 1000 },
			{ model = 'audipd', label = 'Audi PD', price = 1000 },
			{ model = 'g63amg6x6cop', label = '6X6 PD', price = 1000 },
			{ model = 'fbi', label = 'Dodge SRT PD', price = 1000 },
		},
	
	},

	helicopter = {		
		officer = {

		},
		senior_officer = {

		},
	
		colonel = {

		},
	
		seargent = {

		},
		lieutenant = {
			{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 1 },
		},
		captain = {
			{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 1 },
		},
		asst_cop = {
			{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 1 },
		},
		
		boss = {
			{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 1 },
		}
	}
}
