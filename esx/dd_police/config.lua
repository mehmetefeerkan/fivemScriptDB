Config                          = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.2, y = 1.2, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
Config.EnablePlayerManagement   = true
Config.EnableArmoryManagement   = true
Config.EnableESXIdentity     	= true
Config.EnableLicenses           = false
Config.EnableHandcuffTimer      = true 
Config.HandcuffTimer            = 5 * 60000 
Config.EnableJobBlip            = true
Config.MaxInService             = -1
Config.UseLimit					= true --false if using weight and both
Config.UiMenu					= false --true if using UI menu
Config.inWh    					= ""
Config.outWh    				= ""
Config.PoliceHeadwear = {
	cadet = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	officer = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	senior_officer = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	seargent = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	lieutenant = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	captain = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	asst_cop = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	boss = {
		male = { helmet_1 = 90,  helmet_2 = 1},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	},
	helmet = {
		male = { helmet_1 = 126,  helmet_2 = 0},
		female =  { helmet_1 = 1181,  helmet_2 = 0},
	},
	cap = {
		male = { helmet_1 = 91,  helmet_2 = 4},
		female =  { helmet_1 = 82,  helmet_2 = 1},
	}
}

Config.PoliceVest = {
	vest = {
		male = { bproof_1 = 27,  bproof_2 = 0 },
		female = { bproof_1 = 1,  bproof_2 = 0 }
	}
}

Config.PoliceUniforms = {
	cadet = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},
	officer = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},
	senior_officer = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},
	seargent = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},
	lieutenant = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},
	captain = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},
	asst_cop = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},
	boss = {
		male = {
			tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 115,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 171	,
			pants_1 = 59,   pants_2 = 9,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 90,  helmet_2 = 1,
			chain_1 = 2,    chain_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	},

	combat = {
		male = {
			hair_1 = 0,  hair_2 = 0,
			tshirt_1 = 97,  tshirt_2 = 0,
			torso_1 = 74,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 24	,
			pants_1 = 38,   pants_2 = 0,
			shoes_1 = 40,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 96,  helmet_2 = 0,
			mask_1 = 197,   mask_2 = 0,
			bproof_1 = 9,   bproof_2 = 0,
		},
		female = {
			tshirt_1 = 27,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 31,
			pants_1 = 136,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			ears_1 = -1,     ears_2 = 0,
			helmet_1 = 82,  helmet_2 = 1,
			chain_1 = 95,    chain_2 = 0,
		}
	}
}
