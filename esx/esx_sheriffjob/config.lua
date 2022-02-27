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

Config.SheriffStations = {

	LSSD = {

		Blip = {
			Coords  = vector3(-446.08, 6013.59, 31.72), -- Ust Kasaba
			Sprite  = 526,
			Display = 4,
			Scale   = 1.2,
			Colour  = 69
		},
		
		SheriffBlip = {
			Coords  = vector3(-446.08, 6013.59, 31.72), -- Ust Kasaba
			Sprite  = 526,
			Display = 4,
			Scale   = 1.2,
			Colour  = 69
		},

		Cloakrooms = {
			vector3(-449.819, 6011.411, 31.716),
			--vector3(-449.88, 6011.32, 31.72) -- Ust Kasaba
		},

		Armories = {
			--vector3(473.59, -989.32, 24.91),
			--vector3(-441.63, 5987.78, 31.72) -- Ust Kasaba
		},

		Vehicles = {
			{ -- Sehir Merkezi
				Spawner = vector3(-444.009, 5994.129, 31.345),
				InsideShop = vector3(-463.602, 5982.708, 31.315),
				SpawnPoints = {
					{ coords = vector3(-453.218, 5998.438, 31.340), heading = 85.76, radius = 6.0 },
					{ coords = vector3(-454.875, 6001.837, 31.340), heading = 6.62, radius = 6.0 },
					{ coords = vector3(-481.036, 6023.659, 31.340), heading = 38.81, radius = 6.0 },
					{ coords = vector3(-477.844, 6026.350, 31.340), heading = 38.81, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{ -- Sehir Merkezi
				Spawner = vector3(-462.700, 5995.019, 31.245),
				InsideShop = vector3(-482.686, 5994.411, 31.336),
				SpawnPoints = {
					{ coords = vector3(-475.747, 5988.057, 31.336), heading = 314.72, radius = 10.0 },
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
			model = 'Sheriff',
			label = 'Cruiser',
			livery = 1,
			price = 1
		},
		{
			model = 'Sheriff2',
			label = 'SUV',
			livery = 1,
			price = 1
		},
	},

	cadet = {
		
	},

	officer = {
		
	},

	officer2 = {
		
	},

	officer3 = {

	},

	officer4 = {

	},

	sergeant = {

	},
	
	sergeant2 = {

	},

	lieutenant1 = {

	},

	lieutenant2 = {

	},

	captain = {

	},

	captain2 = {

	},

	commander = {

	},

	undersheriff = {

	},

	boss = {

	},
}

Config.AuthorizedHelicopters = {
	cadet = {
		
	},

	officer = {
		
	},

	officer2 = {
		
	},

	officer3 = {

	},

	officer4 = {

	},

	sergeant = {

	},
	
	sergeant2 = {

	},

	lieutenant1 = {

	},

	lieutenant2 = {

	},

	captain = {

	},

	captain2 = {

	},

	commander = {

	},

	undersheriff = {
		{
			model = 'polmav',
			label = 'Air',
			livery = 2,
			price = 1
		}
	},

	boss = {

	},
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	cadet_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	officer2_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	officer3_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	officer4_wear = { -- currently the same as intendent_wear
	male = {
		['tshirt_1'] = 17,  ['tshirt_2'] = 0,
		['torso_1'] = 96,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 22,
		['pants_1'] = 74,   ['pants_2'] = 6,
		['shoes_1'] = 20,   ['shoes_2'] = 2,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0
	},
	female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 18,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 19,
		['pants_1'] = 18,   ['pants_2'] = 0,
		['shoes_1'] = 41,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0
	}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	sergeant2_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	lieutenant1_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	lieutenant2_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	captain_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	captain2_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	commander_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	undersheriff_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	boss_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 74,   ['pants_2'] = 6,
			['shoes_1'] = 20,   ['shoes_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 40,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 28,  ['bproof_2'] = 0
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