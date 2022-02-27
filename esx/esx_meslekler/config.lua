Config = {}
Config.Locale                     = 'tr'
Config.TruckerPrice = 350
Config.ShipRetailPay = 350
Config.BuilderPrice = 70
Config.TrasherCarPrice = 1
Config.Trucker = {}
Config.Fisher = {}
Config.TrasherPay = 350

Config['Trucker'].Zones = {
	{
		AdutyPos = {
			{ x = 864.76, y = -2361.72, z = 31.52 }
		},
		
		TruckPos = {
		
			SpawnLocation = {
				{ x = 870.46, y = -2367.16, z = 30.35 }
			},
			
			DestroyLocation = {
				{ x = 870.04, y = -2360.8, z = 30.35 }
			}
			
		},
		
		SellPos = {
			{ x = 858.91, y = -2357.44, z = 30.35 }
		},
		
		LoadPos = {
			{ x = 2352.26, y = 3040.52, z = 48.15 }
		}	
	}
}

Config.MainUniforms = {
	male = {
		['sex'] = 0,
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 143,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 14,
		['pants_1'] = 69,   ['pants_2'] = 1,
		['shoes_1'] = 65,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0
	},
	female = {
		['sex'] = 1,		
		['tshirt_1'] = 36,  ['tshirt_2'] = 1,
		['torso_1'] = 49,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 0,
		['pants_1'] = 33,   ['pants_2'] = 0,
		['shoes_1'] = 26,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0
	}
}

Config.Fisher = { 
  {
    BoatPos = {
      { x = -1800.4, y = -1225.61, z = 1.58 }
    },
    
    BoatSpawnPos = {
      { x = -1791.38, y = -1230.19, z = 1.40 }
    },
    
    SellPos = {
      { x = -1845.18, y = -1196.07, z = 19.18 }
    },
    
    DoFish = {
      { x = -1827.9, y = -1268.62, z = 8.62 }
    },
	
	ShipHash = 'tug'
  }
}

Config.Builder = {
	{
		DutyPos = {
			{ x = -502.57, y = -1007.84, z = 29.13 }
		},

		LoadProduct = {
			{ x = -498.58, y = -994.45, z = 29.13 }
		},

		UnloadingProduct = {
			{ x = -467.51, y = -954.32, z = 47.98 }	
		},

		WheelBarrow = {
			{ x = -496.61, y = -1017.32, z = 29.13 }
		}
	}
}

Config.BuilderUniforms = {
	male = {
		['sex'] = 0,
		['tshirt_1'] = 34,  ['tshirt_2'] = 0,
		['torso_1'] = 151,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 68,
		['pants_1'] = 9,   ['pants_2'] = 0,
		['shoes_1'] = 19,   ['shoes_2'] = 0,
		['helmet_1'] = 25,  ['helmet_2'] = 0,
		['glasses_1'] = 25,  ['glasses_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0
	},
	female = {
		['sex'] = 1,		
		['tshirt_1'] = 36,  ['tshirt_2'] = 1,
		['torso_1'] = 73,   ['torso_2'] = 2,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 83,
		['pants_1'] = 45,   ['pants_2'] = 3,
		['shoes_1'] = 52,   ['shoes_2'] = 0,
		['helmet_1'] = 0,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0
	}
}

Config.Trasher = {
	{
		Containers = {			   
			{ x = -500.84, y = -1800.89, z = 21.99, a = 64.55 },
			{ x = -260.48, y = -1456.23, z = 31.25, a = 97.47 },
			{ x = -44.01,  y = -1380.61, z = 29.34, a = 7.65 },
			{ x = 174.65,  y = -1424.54, z = 29.27, a = 331.51 },
			{ x = 331.97,  y = -1350.18, z = 32.51, a = 47.92 },
			{ x = 237.61,  y = -1212.36, z = 29.31, a = 102.59 },
			{ x = 251.78,  y = -1003.74, z = 29.27, a = 78.22 },
			{ x = 237.3,   y = -824.72,  z = 30.1,  a = 157.41 },
			{ x = -192.26, y = -861.29,  z = 29.38, a = 249.92 },
			{ x = -292.95, y = -1339.39, z = 31.3,  a = 273.66 },
		},

		Duty = {
			{ x = -571.19, y = -1776.35, z = 23.18 },
		},

		CarSpawn = {
			{ x = -567.8, y = -1779.41, z = 23.18 }
		},

		CarSpawnPoint = {
			{ x = -572.43, y = -1785.39, z = 22.27, h = 142.57 }
		}
	}
}

Config.TrasherUniforms = {
	male = {
		['sex'] = 0,
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 149,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 63,
		['pants_1'] = 21,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 5,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0
	},
	female = {
		['sex'] = 1,		
		['tshirt_1'] = 36,  ['tshirt_2'] = 1,
		['torso_1'] = 73,   ['torso_2'] = 2,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 83,
		['pants_1'] = 35,   ['pants_2'] = 0,
		['shoes_1'] = 52,   ['shoes_2'] = 0,
		['helmet_1'] = 0,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0
	}
}