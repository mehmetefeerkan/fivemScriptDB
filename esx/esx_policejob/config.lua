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

Config.PoliceStations = {

	LSPD = {

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
			vector3(460.9715, -996.324, 30.689),
			--vector3(-449.88, 6011.32, 31.72) -- Ust Kasaba
		},

		Armories = {
			--vector3(473.59, -989.32, 24.91),
			--vector3(-441.63, 5987.78, 31.72) -- Ust Kasaba
		},

		Vehicles = {
			{ -- Sehir Merkezi
				Spawner = vector3(452.7792, -1014.76, 28.460),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(427.26, -1027.48, 28.58), heading = 7.78, radius = 6.0 },
					{ coords = vector3(434.85, -1027.04, 28.45), heading = 6.62, radius = 6.0 },
					{ coords = vector3(442.64, -1026.33, 28.3), heading = 4.17, radius = 6.0 },
					{ coords = vector3(434.24, -1015.21, 28.37), heading = 90.0, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{ -- Sehir Merkezi
				Spawner = vector3(453.1042, -985.513, 43.691),
				InsideShop = vector3(481.21, -982.13, 41.4),
				SpawnPoints = {
					{ coords = vector3(449.64, -981.14, 43.69), heading = 90.12, radius = 10.0 },
					{ coords = vector3(482.08, -981.98, 41.4), heading = 90.0, radius = 10.0 }
				}
			}
		},

		BossActions = {
			--vector3(448.23, -973.12, 30.3),
			--vector3(-433.32, 6002.2, 31.72)
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
			model = 'police',
			label = 'Cruiser 1',
			livery = 1,
			price = 1
		},
		{
			model = 'police2',
			label = 'Cruiser 2',
			livery = 1,
			price = 1
		},
		{
			model = 'police3',
			label = 'Cruiser 2',
			livery = 1,
			price = 1
		},
		{
			model = 'scoutpol',
			label = 'SUV',
			livery = 2,
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
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	lieutenant1 = {
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	lieutenant2 = {
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	captain = {
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	captain2 = {
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	commander = {
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	asistantchief = {
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	chief = {
		{
			model = 'riot',
			label = 'Riot',
			price = 2000
		},
	},

	hsu = {
		{
			model = 'rmodzl1police',
			label = 'High Speed Unit',
			price = 1
		},
	},
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	chef = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	lieutenant1 = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	lieutenant2 = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	captain = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	captain2 = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	commander = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	asistantchief = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	},

	chief = {
		{
			model = 'polmav',
			label = '🚁 Polis Helikopteri',
			livery = 2,
			price = 1
		}
	}	
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
	male = {
		['tshirt_1'] = 16,  ['tshirt_2'] = 0,
		['torso_1'] = 22,   ['torso_2'] = 3,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 16,
		['pants_1'] = 19,   ['pants_2'] = 0,
		['shoes_1'] = 40,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0
	},
	female = {
		['tshirt_1'] = 19,  ['tshirt_2'] = 0,
		['torso_1'] = 72,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 29,
		['pants_1'] = 18,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0
	}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	boss_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	lieutenant1_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	lieutenant2_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	captain_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	captain2_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	commander_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	asistantchief_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	chief_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	hsu_wear = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 29,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 7,  ['bproof_2'] = 0
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