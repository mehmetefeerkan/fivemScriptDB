Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 3
Config.TimerBeforeNewRob    = 18000 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = false -- give black money? If disabled it will give cash instead

Stores = {
	["market1"] = {
		position = { x = 379.19, y = 332.08, z = 103.57},
		reward = math.random(150000, 250000),
		nameOfStore = "Market 1",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market2"] = {
		position = { x = 2550.15, y = 385.37, z = 108.62 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 2",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market3"] = {
		position = { x = -3047.08, y = 586.37, z = 7.91 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 3",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market4"] = {
		position = { x = -1480.09, y = -373.35, z = 39.16 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 4",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market5"] = {
		position = { x = 1396.21, y = 3611.28, z = 34.98 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 5",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market66"] = {
		position = { x = -2959.15, y = 388.54, z = 14.04 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 6",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market6"] = {
		position = { x = 2673.59, y = 3286.2, z = 55.24 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 7",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market7"] = {
		position = { x = -43.7, y = -1750.58, z = 29.42 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 8",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market8"] = {
		position = { x = 1161.15, y = -315.73, z = 69.21 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 9",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market9"] = {
		position = { x = -708.29, y = -905.99, z = 19.22 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 10",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market10"] = {
		position = { x = -1827.32, y = 798.78, z = 138.16 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 11",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market11"] = {
		position = { x = 1705.41, y = 4920.56, z = 42.06 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 12",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market12"] = {
		position = { x = 1959.04, y = 3747.93, z = 32.34 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 13",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market13"] = {
		position = { x = 1126.83, y = -982.6, z = 45.42 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 14",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market14"] = {
		position = { x = 28.48, y = -1339.94, z = 29.5 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 15",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
--[[	["market15bar"] = {
		position = { x = -1384.41, y = -628.71, z = 29.82 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market",
		secondsRemaining = 5, -- seconds
		lastRobbed = 0
	}, --]]
	["market16"] = {
		position = { x = 546.86, y = 2663.71, z = 42.16 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 16",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market17"] = {
		position = { x = -3249.3, y = 1004.54, z = 12.83 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 17",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market25"] = {
		position = { x = 28.48, y = -1339.94, z = 29.5 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 17",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	},
	["market18"] = {
		position = { x = 1166.89, y = 2718.14, z = 37.163 },
		reward = math.random(150000, 250000),
		nameOfStore = "Market 18",
		secondsRemaining = 500, -- seconds
		lastRobbed = 0
	}
}
