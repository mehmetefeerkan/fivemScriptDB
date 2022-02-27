Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How much people can be in service at once?

Config.Locale                     = 'tr'

Config.fbiStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(2529.92, -336.33, 101.89),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 39
		},

		Cloakrooms = {
			vector3(126.85, -729.13, 242.15)
		},

		Armories = {
			vector3(451.7, -980.1, -30.6)
		},

		StoragePut = {
			vector3(118.89, -729.51, 242.15)
		},

		StorageGet = {
			vector3(119.72, -727.4, 242.15)
		},

		Vehicles = {
			{
				Spawner = vector3(2537.11, -349.81, 93.14),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(2536.95, -377.57, 92.64), heading = 172.47, radius = 6.0}
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(-475.28, 5988.73, 31.34),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(-475.28, 5988.73, 31.34), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(156.55, -740.8, 242.15)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 1500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80}
	},

	officer = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	sergeant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	lieutenant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	boss = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	}
}

Config.AuthorizedVehicles = {
	car = {
		recruit = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		officer = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		officerii = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		officeriii = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		officeriiii = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		seniorofficer = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		deputycommisioner = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		commisioner = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		lieutenant = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		lieutenantii = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},

		captain = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},

		captainii = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		commander = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},
		assistchief = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		},

		boss = {
			{model = 'fibb', price = 1},
			{model = 'fibb2', price = 1},
			{model = 'fibc', price = 1},
			{model = 'fibc2', price = 1},
			{model = 'fibc3', price = 1},
			{model = 'fibc4', price = 1},
			{model = 'fibd', price = 1},
			{model = 'fibd2', price = 1},
			{model = 'fibd3', price = 1},
			{model = 'fibf', price = 1},
			{model = 'fibg', price = 1},
			{model = 'fibg2', price = 1},
			{model = 'fibg3', price = 1},
			{model = 'fibh', price = 1},
			{model = 'fibj', price = 1},
			{model = 'fibj2', price = 1},
			{model = 'fibk', price = 1},
			{model = 'fibk2', price = 1},
			{model = 'fibn', price = 1},
			{model = 'fibo', price = 1},
			{model = 'fibo2', price = 1},
			{model = 'fibr', price = 1},
			{model = 'fibr2', price = 1},
			{model = 'fibs', price = 1},
			{model = 'fibs2', price = 1},
			{model = 'fibs3', price = 1},
			{model = 'fibt', price = 1},
			{model = 'fibt2', price = 1},
			{model = 'fibw', price = 1},
			{model = 'fibx', price = 1},
			{model = 'fibx2', price = 1},
		}

	},

	helicopter = {
		recruit = {},

		officer = {},

		sergeant = {},

		lieutenant = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		boss = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		{label = 'fbi Ped', maleModel = 's_m_y_fbi_01', femaleModel = 's_f_y_fbi_01'},
		{label = 'fbi Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	recruit = {
		male = {
			tshirt_1 = 105,  tshirt_2 = 0,
			torso_1 = 220,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 1,
			pants_1 = 35,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			bags_1 = 52,     bags_2 = 0
		},
		female = {
			tshirt_1 = 1,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 2,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},

	officer = {
		male = {
			tshirt_1 = 105,  tshirt_2 = 0,
			torso_1 = 220,   torso_2 = 1,
			decals_1 = 15,   decals_2 = 0,
			arms = 1,
			pants_1 = 35,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			bags_1 = 52,     bags_2 = 0
		},
		female = {
			tshirt_1 = 1,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 2,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	officerii = {
		male = {
			tshirt_1 = 105,  tshirt_2 = 0,
			torso_1 = 220,   torso_2 = 1,
			decals_1 = 15,   decals_2 = 1,
			arms = 1,
			pants_1 = 35,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			bags_1 = 52,     bags_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	officeriii = {
		male = {
			tshirt_1 = 105,  tshirt_2 = 0,
			torso_1 = 220,   torso_2 = 1,
			decals_1 = 15,   decals_2 = 1,
			arms = 1,
			pants_1 = 35,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			bags_1 = 52,     bags_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	officeriiii = {
		male = {
			tshirt_1 = 105,  tshirt_2 = 0,
			torso_1 = 220,   torso_2 = 1,
			decals_1 = 15,   decals_2 = 1,
			arms = 1,
			pants_1 = 35,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			bags_1 = 52,     bags_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	lieutenant = {
		male = {
			tshirt_1 = 105,  tshirt_2 = 0,
			torso_1 = 220,   torso_2 = 1,
			decals_1 = 15,   decals_2 = 2,
			arms = 1,
			pants_1 = 35,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			bags_1 = 52,     bags_2 = 1
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	lieutenantii = {
		male = {
			tshirt_1 = 38,  tshirt_2 = 0,
			torso_1 = 2,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 52,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	captain = {
		male = {
			tshirt_1 = 38,  tshirt_2 = 0,
			torso_1 = 2,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 52,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0,
			
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	commander = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 2,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	assistchief = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 2,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	boss = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 2,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 4,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}