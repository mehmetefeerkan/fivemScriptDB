----[[DrawText3D3]]------
Config                            	= {}
Config.DrawDistance              	= 100.0
Config.MarkerType                 	= 1
Config.MarkerSize                 	= {x = 1.2, y = 1.2, z = 0.5}
Config.MarkerColor                	= {r = 50, g = 50, b = 204}
Config.Usinglimit				  	= false
Config.EnableJobBlip              	= true
Config.MaxInService               	= -1
Config.EnableLicenses  			  	= false
Config.EnablePlayerManagement     	= true
Config.EnableESXIdentity          	= true
Config.EnableESXService           	= false
Config.EnableSocietyOwnedVehicles 	= false
Config.inWh    					= ""
Config.outWh    				= ""
Config.UseUiBased 				= false
-----------------repairkit-------------
Config.InfiniteRepairs				= false 	-- Should one repairkit last forever?
Config.InfiniteRepairsTyreKit		= false		-- Should one tyrekit last forever?
Config.IfMecaIsOnline				= true		-- Set to true if you don't want your players to use the RepairKit and TireKit if a mechanic is online
Config.RepairTime					= 110 		-- In seconds, how long should a repair take?
Config.TyreKitTime					= 30 		-- In seconds, how long does it took to replace the tyre?
Config.IgnoreAbort					= true 		-- Remove repairkit from inventory even if user aborts repairs?
Config.IgnoreTyreAbort		 		= true	 	-- Remove repairkit from inventory even if user aborts repairs?
Config.AllowMecano					= true	 	-- Allow mechanics to use this repairkit? (If you want this to work set "Config.IfMecaIsOnline" to false, it's a known bug that will be fixed as soon as possible)
Config.RealisticVehicleFailure		= true 		-- Set to true if you are using the resource "RealisticVehicleFailure"
Config.ExplosionOnFailedRepair		= false		-- Set to true if you wan't to use "Config.ExplosionChance"
Config.ExplosionChance				= 100		-- The lower it is, the more it has a chance to make the engine fail and the car explode. (1 = 100%, 2 = 50%, 4 = 25%, 10 = 10%, 100 = 1%, etc)
Config.EnableProgressBar			= true		-- If you don't want a progress bar when your player use the item or you don't want to use the resource "progressBars" then set it to false
Config.MechOL						= 1
Config.NPCSpawnDistance          	= 500.0
Config.NPCNextToDistance          	= 25.0
Config.NPCJobEarnings             	= { min = 15, max = 40 }
Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo',
}
-- Config.VehicleStation = {
-- 	Mekaniko = {
-- 		Blip = {
-- 			Coords  = vector3(-39.92, -1042.91, 28.47),
-- 			Sprite  = 643,
-- 			Display = 4,
-- 			Scale   = 1.5,
-- 			Colour  = 46,
-- 		},
-- 		BlipPaleto = {
-- 			Coords  = vector3(98.64, 6621.12, 32.44),
-- 			Sprite  = 402,
-- 			Display = 4,
-- 			Scale   = 1.2,
-- 			Colour  = 2,
-- 		}
-- 	}
-- }

Config.Zones = {
	
	VehicleSpawnPoint = {
		Pos   = { x = 814.10, y = -988.32, z = 26.24},
		Heading = 272.12,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1,
	},
}

Config.Uniforms = {

	intern_mech = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
			pants_1 = 98,   pants_2 = 4,
			shoes_1 = 73,   shoes_2 = 1,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 1,
			torso_1 = 246,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	junior_mech = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
			pants_1 = 98,   pants_2 = 4,
			shoes_1 = 73,   shoes_2 = 1,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 1,
			torso_1 = 246,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	senior_mech = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
			pants_1 = 98,   pants_2 = 4,
			shoes_1 = 73,   shoes_2 = 1,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 1,
			torso_1 = 246,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	lead_mech = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
			pants_1 = 98,   pants_2 = 4,
			shoes_1 = 73,   shoes_2 = 1,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 249,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 30,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	asst_boss_mech = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
			pants_1 = 98,   pants_2 = 4,
			shoes_1 = 73,   shoes_2 = 1,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 249,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 30,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	assistant_head_mechanic = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
			pants_1 = 98,   pants_2 = 4,
			shoes_1 = 73,   shoes_2 = 1,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 249,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 30,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	boss = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
			pants_1 = 98,   pants_2 = 4,
			shoes_1 = 73,   shoes_2 = 1,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 249,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 77,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	}

}

Config.Overhaul = {
	intern_mech  = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 66,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 30,
			pants_1 = 39,   pants_2 = 0,
			shoes_1 = 82,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 2,
			torso_1 = 246,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	junior_mech  = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 66,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 30,
			pants_1 = 39,   pants_2 = 0,
			shoes_1 = 82,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 2,
			torso_1 = 246,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},

	senior_mech  = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 66,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 30,
			pants_1 = 39,   pants_2 = 0,
			shoes_1 = 82,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 2,
			torso_1 = 246,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},

	lead_mech  = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 66,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 30,
			pants_1 = 39,   pants_2 = 0,
			shoes_1 = 82,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 2,
			torso_1 = 246,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	asst_boss_mech  = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 66,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 30,
			pants_1 = 39,   pants_2 = 0,
			shoes_1 = 82,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 2,
			torso_1 = 246,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	assistant_head_mechanic  = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 66,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 30,
			pants_1 = 39,   pants_2 = 0,
			shoes_1 = 82,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 2,
			torso_1 = 246,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
	boss = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 66,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 30,
			pants_1 = 39,   pants_2 = 0,
			shoes_1 = 82,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 21,  tshirt_2 = 2,
			torso_1 = 246,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,
			pants_1 = 110,   pants_2 = 0,
			shoes_1 = 80,   shoes_2 = 14,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	}

}

Config.MechShirt = {
	zero = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
		},
		female = {
			tshirt_1 = 184,  tshirt_2 = 0,
			torso_1 = 171,   torso_2 = 2,
			arms = 24,
		}
	},
	one = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
		},
		female = {
			tshirt_1 = 184,  tshirt_2 = 0,
			torso_1 = 171,   torso_2 = 2,
			arms = 24,
		}
	},
	two = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
		},
		female = {
			tshirt_1 = 184,  tshirt_2 = 0,
			torso_1 = 171,   torso_2 = 2,
			arms = 24,
		}
	},
	three = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
		},
		female = {
			tshirt_1 = 184,  tshirt_2 = 0,
			torso_1 = 171,   torso_2 = 2,
			arms = 24,
		}
	},

	boss = {
		male = {
			tshirt_1 = 143,  tshirt_2 = 0,
			torso_1 = 208,   torso_2 = 2,
			arms = 19,
		},
		female = {
			tshirt_1 = 184,  tshirt_2 = 0,
			torso_1 = 171,   torso_2 = 2,
			arms = 24,
		}
	}

}
Config.MechPants = {
	zero = {
		male = {
			pants_1 = 98,   pants_2 = 4,
		},
		female = {
			pants_1 = 54,   pants_2 = 1,
		}
	},
	one = {
		male = {
			pants_1 = 98,   pants_2 = 4,
		},
		female = {
			pants_1 = 54,   pants_2 = 1,
		}
	},
	two = {
		male = {
			pants_1 = 98,   pants_2 = 4,
		},
		female = {
			pants_1 = 54,   pants_2 = 1,
		}
	},
	three = {
		male = {
			pants_1 = 98,   pants_2 = 4,
		},
		female = {
			pants_1 = 54,   pants_2 = 1,
		}
	},

	boss = {
		male = {
			pants_1 = 98,   pants_2 = 4,
		},
		female = {
			pants_1 = 54,   pants_2 = 1,
		}
	}

}
Config.MechShoes = {
	zero = {
		male = {
			shoes_1 = 73,   shoes_2 = 1,
		},
		female = {
			shoes_1 = 80,   shoes_2 = 14,
		}
	},
	one = {
		male = {
			shoes_1 = 73,   shoes_2 = 1,
		},
		female = {
			shoes_1 = 80,   shoes_2 = 14,
		}
	},
	two = {
		male = {
			shoes_1 = 73,   shoes_2 = 1,
		},
		female = {
			shoes_1 = 80,   shoes_2 = 14,
		}
	},
	three = {
		male = {
			shoes_1 = 73,   shoes_2 = 1,
		},
		female = {
			shoes_1 = 80,   shoes_2 = 14,
		}
	},

	boss = {
		male = {
			shoes_1 = 73,   shoes_2 = 1,
		},
		female = {
			shoes_1 = 80,   shoes_2 = 14,
		}
	}

}

Config.Time = 10 

Config.EmergencyVehicles = {
  "POLICE",
  "POLICE2"
}

Config.isMechJob = {
  "mechanic"
}
