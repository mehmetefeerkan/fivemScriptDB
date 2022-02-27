Config = {}

-- Configs
Config.RegularPrice = 9999999999999
Config.WhitelistedJobsPrice = 1
Config.RepairDistanceAroundBlip = 30
Config.ProgressBarTime = 5000

-- Language Labels
Config.BlipLabel = 'Tamir Bölgesi'
Config.SuggestionCommand = '/repair'
Config.SuggestionLabel = '[TamirAlanı] Aracını tamir et'
Config.ProgressLabel = 'Aracın tamir ediliyor'

Config.RepairZone = {
	[1] = { ["x"] = 427.15,["y"] = -1022.9, ["z"] = 28.46},
	[2] = { ["x"] = -474.49,["y"] = 6014.83, ["z"] = 31.34}
}

Config.WhitelistedJob = {
	'police',
	'ambulance',
	'sheriff'
}
