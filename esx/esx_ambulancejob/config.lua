Config                            = {}

Config.DrawDistance               = 20

Config.Marker                     = {type = 27, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 700  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 500

Config.RespawnPoint = { coords = vector3(307.5813, -595.134, 43.286), heading = 29.03 }  

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(297.78, -584.33, 43.26),   
			sprite = 489,
			scale  = 1.0,
			color  = 1
		},

		AmbulanceActions = {
			vector3(309.4359, -602.647, 42.291)
		},

		Pharmacies = {
			--vector3(299.7954, -596.306, 43.284)    
		},

		Vehicles = {
			{
				Spawner = vector3(296.93, -602.3, 43.3),
				InsideShop = vector3(293.62, -610.42, 43.36),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 205, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(293.6263, -610.414, 42.913), heading = 341.89, radius = 4.0 },
					{ coords = vector3(293.6263, -610.414, 42.913), heading = 339.99, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(341.86, -580.51, 74.17),
				InsideShop = vector3(351.7429, -588.559, 74.165),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 205, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.78, -588.1, 74.17), heading = 142.7, radius = 10.0 }
				}
			}
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
			{
				From = vector3(325.5308, -598.797, 42.291),
				To = { coords = vector3(338.52, -583.85, 74.17), heading = 0.0 },
				Marker = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(338.92, -583.85, 73.17),
				To = { coords = vector3(325.5308, -598.797, 43.291), heading = 0.0 },
				Marker = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}


Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{ model = 'Ambulance', label = 'Ambulans Aracı 1', livery = 1, price = 1},
			{ model = 'dodgeEMS', label = 'Dodge Charger', livery = 1, price = 1},

		},
	
		doctor = {
			{ model = 'Ambulance', label = 'Ambulans Aracı 1', livery = 1, price = 1},
			{ model = 'dodgeEMS', label = 'Dodge Charger', livery = 1, price = 1},
		},
	
		chief_doctor = {
			{ model = 'Ambulance', label = 'Ambulans Aracı 1', livery = 1, price = 1},
			{ model = 'dodgeEMS', label = 'Dodge Charger', livery = 1, price = 1},
		},
	
		boss = {
			{ model = 'Ambulance', label = 'Ambulans Aracı 1', livery = 1, price = 1},
			{ model = 'dodgeEMS', label = 'Dodge Charger', livery = 1, price = 1},
		}	
	},

	helicopter = {

		ambulance = {

		},

		doctor = {
			{ 
				model = 'polmav', 
				label = 'Ambulans Helikopter', 
				livery = 2, 
				price = 1 
			}
		},
	
		chief_doctor = {
			{ 
				model = 'polmav', 
				label = 'Ambulans Helikopter', 
				livery = 2, 
				price = 1 
			}
		},
	
		boss = {
			{ 
				model = 'polmav', 
				label = 'Ambulans Helikopter', 
				livery = 2, 
				price = 1 
			}
		}
	}
}

Config.Uniforms = {
	ambulance_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 3,  ['tshirt_2'] = 0,
			['torso_1'] = 28,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 16,   ['pants_2'] = 3,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 33,  ['bproof_2'] = 0
		}
	},

	doctor_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 3,  ['tshirt_2'] = 0,
			['torso_1'] = 28,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 16,   ['pants_2'] = 3,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 33,  ['bproof_2'] = 0
		}
	},

	chief_doctor_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 3,  ['tshirt_2'] = 0,
			['torso_1'] = 28,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 16,   ['pants_2'] = 3,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 33,  ['bproof_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 16,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 3,  ['tshirt_2'] = 0,
			['torso_1'] = 28,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 16,   ['pants_2'] = 3,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 33,  ['bproof_2'] = 0
		}
	}
}
