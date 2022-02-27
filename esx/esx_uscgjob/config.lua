Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society
Config.EnableSheriffDP            = false -- enable if u're using sheriff department

Config.MaxInService               = -1
Config.Locale = 'en'

Config.UscgStations = {

	USCG = {

		Blip = {
			Coords  = vector3(438.58, -982.53, 30.67), -- Şehir Merkezi
			Sprite  = 526,
			Display = 4,
			Scale   = 1.2,
			Colour  = 30
		},
		
		SheriffBlip = {
			Coords  = vector3(-446.08, 6013.59, 31.72), -- Ust Kasaba
			Sprite  = 526,
			Display = 4,
			Scale   = 1.2,
			Colour  = 69
		},

		Cloakrooms = {
			vector3(-2357.03, 3254.19, 32.81),
			vector3(0, 0, 0) -- Ust Kasaba
		},

		Armories = {
			--vector3(473.59, -989.32, 24.91),
			--vector3(-441.63, 5987.78, 31.72) -- Ust Kasaba
		},

		Vehicles = {
			{ -- Sehir Merkezi
				Spawner = vector3(-2158.61, 3251.94, 32.81),
				InsideShop = vector4(-1831.66, 2977.07, 32.54, 59.82),
				SpawnPoints = {
					{ coords = vector3(-2135.25, 3255.39, 32.81), heading = 143.56, radius = 6.0 },
					{ coords = vector3(-2140.54, 3257.11, 32.81), heading = 143.56, radius = 6.0 },
				}
			},
			{ -- Ust Kasaba
				Spawner = vector3(0.0, 0.0, 0.0),
				InsideShop = vector3(-462.67, 6042.64, 30.99),
				SpawnPoints = {
					{ coords = vector3(-483.20, 6024.77, 30.92), heading = 224.36, radius = 6.0 },
					{ coords = vector3(-476.23, 6031.84, 30.92), heading = 244.17, radius = 6.0 },
					{ coords = vector3(-469.17, 6038.78, 30.92), heading = 223.55, radius = 6.0 }
				}
			},
			{ -- Alt Kasaba
				Spawner = vector3(0.0, 0.0, 0.0),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(1847.45, 3671.99, 33.62), heading = 209.74, radius = 6.0 },
					{ coords = vector3(1853.86, 3675.83, 33.66), heading = 210.51, radius = 6.0 },
					{ coords = vector3(1864.85, 3682.19, 33.62), heading = 120.61, radius = 6.0 }
				}
			}
			
		},

		Helicopters = {
			{ -- Sehir Merkezi
				Spawner = vector3(-1989.89, 2822.758, 32.810),
				InsideShop = vector3(-1973.10, 2814.475, 32.810),
				SpawnPoints = {
					{ coords = vector3(-1985.99, 2846.687, 32.810), heading = 90.12, radius = 10.0 },
				}
			},
			{ -- Ust Kasaba
				Spawner = vector3(0.0, 0.0, 0.0),
				InsideShop = vector3(-467.78, 5979.91, 31.71),
				SpawnPoints = {
					{ coords = vector3(-475.2, 5988.46, 31.73), heading = 318.94, radius = 10.0 }
				}
			}
			--[[{ --Alt Kasaba
				Spawner = vector3(462.22, -981.41, 43.69),
				InsideShop = vector3(481.21, -982.13, 41.4),
				SpawnPoints = {
					{ coords = vector3(449.64, -981.14, 43.69), heading = 90.12, radius = 10.0 },
					{ coords = vector3(482.08, -981.98, 41.4), heading = 90.0, radius = 10.0 }
				}
			}--]]
		},

		boat = {
			{ -- Sehir Merkezi
				Spawner = vector3(-3131.19, 3414.63, 1.8),
				InsideShop = vector3(-1973.10, 2814.475, 32.810),
				SpawnPoints = {
					{ coords = vector3(-1985.99, 2846.687, 32.810), heading = 90.12, radius = 10.0 },
				}
			},
			--{ -- Ust Kasaba
				--Spawner = vector3(0.0, 0.0, 0.0),
				--InsideShop = vector3(-467.78, 5979.91, 31.71),
				--SpawnPoints = {
					--{ coords = vector3(-475.2, 5988.46, 31.73), heading = 318.94, radius = 10.0 }
				--}
			--}
			--[[{ --Alt Kasaba
				Spawner = vector3(462.22, -981.41, 43.69),
				InsideShop = vector3(481.21, -982.13, 41.4),
				SpawnPoints = {
					{ coords = vector3(449.64, -981.14, 43.69), heading = 90.12, radius = 10.0 },
					{ coords = vector3(482.08, -981.98, 41.4), heading = 90.0, radius = 10.0 }
				}
			}--]]
		},

		BossActions = {
			vector3(0, 0, 0),
			vector3(0, 0, 0)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 }
	},

	officer = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
	},

	sergeant = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 }
	},

	intendent = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 }
	},

	lieutenant = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 }
	},

	chef = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 0, nil }, price = 0 }
	},

	boss = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 0, nil }, price = 0 }
	},
	
	srecruit = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 }
	},

	sofficer = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
	},

	ssergeant = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 }
	},

	sintendent = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 }
	},

	slieutenant = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 }
	},

	schef = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 0, nil }, price = 0 }
	},

	sboss = {
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 1000, nil }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, -1, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, nil }, price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 0, nil }, price = 0 }
	}
	
	
}

Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'apc',
			label = 'Apc',
			price = 1
		},
		{
			model = 'barracks',
			label = 'Barracks',
			price = 1
		},
		{
			model = 'barrage',
			label = 'Barrage',
			price = 1
		},
		{
			model = 'chernobog',
			label = 'Chernobog',
			price = 1
		},
		{
			model = 'crusader',
			label = 'Crusader',
			price = 1
		},
		{
			model = 'halftrack',
			label = 'Halftrack',
			price = 1
		},
		{
			model = 'rhino',
			label = 'Rhino',
			price = 1
		},
		{
			model = 'trailersmall2',
			label = 'Trailersmall2',
			price = 1
		},
		{
			model = 'insurgent2',
			label = 'Insurgent2',
			price = 1
		},
		{
			model = 'nightshark',
			label = 'Nightshark',
			price = 1
		},
		{
			model = 'menacer',
			label = 'Menacer',
			price = 1
		},
		--{
			--model = 'squaddie',
			--label = 'Squaddie',
			--price = 1
		--},
		{
			model = 'cognoscenti2',
			label = 'Cognoscenti2',
			price = 1
		},
		{
			model = 'caddy3',
			label = 'Caddy3',
			price = 1
		},
	},

	recruit = {

	},

	officer = {

	},

	sergeant = {

	},

	intendent = {


	},

	lieutenant = {

	},

	chef = {

	},
	
	boss = {

	}
}

Config.Aboat = {
	Shared = {
		{
			model = 'seashark2',
			label = 'seashark2',
			price = 1
		},
	},

	recruit = {

	},

	officer = {

	},

	sergeant = {

	},

	intendent = {


	},

	lieutenant = {

	},

	chef = {

	},
	
	boss = {

	}
}

Config.AuthorizedHelicopters = {
	recruit = { 
		--{
			--model = 'annihilator2',
			--label = 'Annihilator2',
			--price = 1
		--},
		{
			model = 'valkyrie2',
			label = 'Valkyrie2',
			price = 1
		},
		{
			model = 'savage',
			label = 'Savage',
			price = 1
		},
		{
			model = 'cargobob4',
			label = 'Cargobob4',
			price = 1
		},
		{
			model = 'tula',
			label = 'Tula',
			price = 1
		},
		{
			model = 'strikeforce',
			label = 'Strikeforce',
			price = 1
		},
		{
			model = 'bombushka',
			label = 'Bombushka',
			price = 1
		},
		{
			model = 'avenger',
			label = 'Avenger',
			price = 1
		},
		{
			model = 'lazer',
			label = 'Lazer',
			price = 1
		},
		{
			model = 'hydra',
			label = 'Hydra',
			price = 1
		},
		{
			model = 'mogul',
			label = 'Mogul',
			price = 1
		},
		{
			model = 'valkyrie2',
			label = 'Valkyrie2',
			price = 1
		},
		{
			model = 'titan',
			label = 'Titan',
			price = 1
		},
		{ 
			model = 'akula',
			label = 'Akula',
			price = 1
		},
		{ 
			model = 'besra',
			label = 'Besra',
			price = 1
		},
	},

	officer = {

	},

	sergeant = {

	},

	intendent = {

	},

	lieutenant = {

	},

	chef = {

	},

	boss = {

	},
	
	srecruit = {},

	sofficer = {},

	ssergeant = {},

	sintendent = {},

	slieutenant = {

	},

	schef = {

	},

	sboss = {

	}
	
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 43,  ['tshirt_2'] = 0,
			['torso_1'] = 50,   ['torso_2'] = 10,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 101,
			['pants_1'] = 136,   ['pants_2'] = 10,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 155,  ['helmet_2'] = 18,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 1,  ['tshirt_2'] = 0,
			['torso_1'] = 80,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 12,   ['shoes_2'] = 6,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
		['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 1,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 19,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}
}