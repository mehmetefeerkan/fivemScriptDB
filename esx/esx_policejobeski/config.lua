Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableEUPMenu      		  = true -- turn this on if you want EUP Menu
Config.SavedClothes				  = true -- lsrp saved clothes
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Cloakrooms = {
			vector3(461.1649, -995.871, 30.689),
		},

		Armories = {
			--vector3(452.4, -980.19, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(426.08, -1024.07, 28.5),
				SpawnPoints = {
					{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
					{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(460.68, -980.61, 43.69),
				InsideShop = vector3(455.81, -993.8, 43.69),
				SpawnPoints = {
					{ coords = vector3(447.66, -981.41, 44.08), heading = 89.99, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		},

		PrivInv = {
			vector3(482.6741, -995.262, 30.689)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		-- { weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		-- { weapon = 'WEAPON_STUNGUN', price = 1500 },
		-- { weapon = 'WEAPON_FLASHLIGHT', price = 80 }
	},

	officer = {
		-- { weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 50000 },
		-- { weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		-- { weapon = 'WEAPON_ASSAULTSMG', price = 780 }
	},

	sergeant = {
		-- { weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_ASSAULTSMG', price = 780 }
	},

	intendent = {
		-- { weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		-- { weapon = 'WEAPON_ASSAULTSMG', price = 780 }
	},

	lieutenant = {
		-- { weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		-- { weapon = 'WEAPON_ASSAULTSMG', price = 780 }
	},

	chef = {
		-- { weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 1100 },
		-- { weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 640 },
		-- { weapon = 'WEAPON_ASSAULTSMG', price = 780 }
	},

	boss = {
		-- { weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 1100 },
		-- { weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 640 },
		-- { weapon = 'WEAPON_ASSAULTSMG', price = 780 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'chgr', label = 'LSPD Charger', price = 1 },
		{ model = 'pd21tahoe', label = 'LSPD TAHOE', price = 1 },
		{ model = 'gtr', label = 'LSPD MUSTANG', price = 1 },
		{ model = 'demon', label = 'LSPD DEMON ', price = 1 },
		{ model = '17fusionrb', label = 'LSPD FUSION', price = 1 },
		{ model = 'code3bmw', label = 'STATE Motor', price = 1 },
		{ model = 'code3harley', label = 'STATE Motor 2', price = 1 },
		{ model = 'code3camero', label = 'STATE High Speed', price = 1 },
		{ model = 'code3cvpi', label = 'STATE CVPI', price = 1 },
		{ model = 'code3durango', label = 'STATE DURANGO ', price = 1 },
		{ model = 'code3f250', label = 'STATE F250', price = 1 },
		{ model = 'code310charg', label = 'STATE CHARGER', price = 1 },
		{ model = 'pd20exped', label = 'STATE EXPED', price = 1 },
		{ model = 'code320exp', label = 'STATE EXP', price = 1 }
	},

	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {
		{ model = 'chgr', label = 'LSPD Charger', price = 1 },
		{ model = 'pd21tahoe', label = 'LSPD TAHOE', price = 1 },
		{ model = 'gtr', label = 'LSPD MUSTANG', price = 1 },
		{ model = 'demon', label = 'LSPD DEMON ', price = 1 },
		{ model = '17fusionrb', label = 'LSPD FUSION', price = 1 },
		{ model = 'code3bmw', label = 'STATE Motor', price = 1 },
		{ model = 'code3harley', label = 'STATE Motor 2', price = 1 },
		{ model = 'code3camero', label = 'STATE High Speed', price = 1 },
		{ model = 'code3cvpi', label = 'STATE CVPI', price = 1 },
		{ model = 'code3durango', label = 'STATE DURANGO ', price = 1 },
		{ model = 'code3f250', label = 'STATE F250', price = 1 },
		{ model = 'code310charg', label = 'STATE CHARGER', price = 1 },
		{ model = 'pd20exped', label = 'STATE EXPED', price = 1 },
		{ model = 'code320exp', label = 'STATE EXP', price = 1 },
	},

	lieutenant = {
		{ model = 'chgr', label = 'LSPD Charger', price = 1 },
		{ model = 'pd21tahoe', label = 'LSPD TAHOE', price = 1 },
		{ model = 'gtr', label = 'LSPD MUSTANG', price = 1 },
		{ model = 'demon', label = 'LSPD DEMON ', price = 1 },
		{ model = '17fusionrb', label = 'LSPD FUSION', price = 1 },
		{ model = 'code3bmw', label = 'STATE Motor', price = 1 },
		{ model = 'code3harley', label = 'STATE Motor 2', price = 1 },
		{ model = 'code3camero', label = 'STATE High Speed', price = 1 },
		{ model = 'code3cvpi', label = 'STATE CVPI', price = 1 },
		{ model = 'code3durango', label = 'STATE DURANGO ', price = 1 },
		{ model = 'code3f250', label = 'STATE F250', price = 1 },
		{ model = 'code310charg', label = 'STATE CHARGER', price = 1 },
		{ model = 'pd20exped', label = 'STATE EXPED', price = 1 },
		{ model = 'code320exp', label = 'STATE EXP', price = 1 },
	},

	chef = {
		{ model = 'chgr', label = 'LSPD Charger', price = 1 },
		{ model = 'pd21tahoe', label = 'LSPD TAHOE', price = 1 },
		{ model = 'gtr', label = 'LSPD MUSTANG', price = 1 },
		{ model = 'demon', label = 'LSPD DEMON ', price = 1 },
		{ model = '17fusionrb', label = 'LSPD FUSION', price = 1 },
		{ model = 'code3bmw', label = 'STATE Motor', price = 1 },
		{ model = 'code3harley', label = 'STATE Motor 2', price = 1 },
		{ model = 'code3camero', label = 'STATE High Speed', price = 1 },
		{ model = 'code3cvpi', label = 'STATE CVPI', price = 1 },
		{ model = 'code3durango', label = 'STATE DURANGO ', price = 1 },
		{ model = 'code3f250', label = 'STATE F250', price = 1 },
		{ model = 'code310charg', label = 'STATE CHARGER', price = 1 },
		{ model = 'pd20exped', label = 'STATE EXPED', price = 1 },
		{ model = 'code320exp', label = 'STATE EXP', price = 1 },
	},
	
	boss = {
		{ model = 'chgr', label = 'LSPD Charger', price = 1 },
		{ model = 'pd21tahoe', label = 'LSPD TAHOE', price = 1 },
		{ model = 'gtr', label = 'LSPD MUSTANG', price = 1 },
		{ model = 'demon', label = 'LSPD DEMON ', price = 1 },
		{ model = '17fusionrb', label = 'LSPD FUSION', price = 1 },
		{ model = 'code3bmw', label = 'STATE Motor', price = 1 },
		{ model = 'code3harley', label = 'STATE Motor 2', price = 1 },
		{ model = 'code3camero', label = 'STATE High Speed', price = 1 },
		{ model = 'code3cvpi', label = 'STATE CVPI', price = 1 },
		{ model = 'code3durango', label = 'STATE DURANGO ', price = 1 },
		{ model = 'code3f250', label = 'STATE F250', price = 1 },
		{ model = 'code310charg', label = 'STATE CHARGER', price = 1 },
		{ model = 'pd20exped', label = 'STATE EXPED', price = 1 },
		{ model = 'code320exp', label = 'STATE EXP', price = 1 },

	},
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},
		
	intendent = {},

	lieutenant = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 1 }
	},

	chef = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 1 }
	},

	boss = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 1 }
	}
}


Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
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
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
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
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { 
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
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
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
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { 
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
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
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