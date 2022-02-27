Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

--Config.Payout = math.random(300, 800)
Config.CompanyVehicle = "burrito3"
Config.DepositPrice = 2
Config.Gardener = {
    Base = {
		Pos   = {x = -1753.25, y = -724.20, z = 10.40},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 27,
        BlipSprite = 613,
        BlipLabel = '[Gardener] Base',
        BlipColor = 43,
        BlipScale = 0.8,
	},
    Garage = {
        Pos   = {x = -1744.87, y = -727.46, z = 10.42},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 27,
        BlipSprite = 524,
        BlipLabel = '[Gardener] Garage',
        BlipColor = 43,
        BlipScale = 0.5,
	},
    GarageSpawnPoint = {
		Pos1   = {x = -1742.93, y = -724.02, z = 10.44, h = 229.58},
        Pos2   = {x = -1741.03, y = -721.79, z = 10.47, h = 229.58},
	},
    DefaultMarker = {
		Size  = {x = 1.2, y = 1.2, z = 1.0},
        Color = {r = 78, g = 2453, b = 175},
        Type  = 27,
	},
}

Config.Gardens = {
	{StreetHouse = "Rockford Hills"},
    {StreetHouse = "West Vinewood"},
    {StreetHouse = "Vinewood Hills"},
    {StreetHouse = "El Burro Heights"},
    {StreetHouse = "Richman"},
    {StreetHouse = "Mirror Park"},
    {StreetHouse = "East Vinewood"},
}

Config.RockfordHills = {
    {x = -880.44, y = 16.42, z = 44.38, h = 151.12, blip, ped,
    houseX = -888.01, 
    houseY = 42.4, 
    houseZ = 49.15, 
    houseH = 232.8},
}

Config.RockfordHillsWork = {
    {x = -878.83, y = 38.23, z = 49.01, taked = false, blip},
    {x = -881.33, y = 39.17, z = 49.02, taked = false, blip},
    {x = -882.55, y = 36.61, z = 49.00, taked = false, blip},
    {x = -869.00, y = 45.58, z = 48.79, taked = false, blip},
    {x = -870.27, y = 43.21, z = 48.77, taked = false, blip},
    {x = -867.60, y = 39.79, z = 48.73, taked = false, blip},
    {x = -864.34, y = 38.14, z = 48.66, taked = false, blip},
    {x = -883.38, y = 47.40, z = 48.76, taked = false, blip},
    {x = -880.56, y = 49.26, z = 48.76, taked = false, blip},
    {x = -890.94, y = 36.98, z = 48.79, taked = false, blip},
}

Config.WestVinewood = {
    {x = -850.40, y = 297.6, z = 86.32, h = 303.2, blip, ped,
    houseX = -886.72, 
    houseY = 321.24, 
    houseZ = 83.88, 
    houseH = 242.52},
}

Config.WestVinewoodWork = {
    {x = -853.23, y = 297.86, z = 86.78, taked = false, blip},
    {x = -855.17, y = 296.78, z = 86.78, taked = false, blip},
    {x = -857.03, y = 295.87, z = 86.78, taked = false, blip},
    {x = -859.28, y = 294.94, z = 86.31, taked = false, blip},
    {x = -860.97, y = 294.54, z = 86.30, taked = false, blip},
    {x = -863.06, y = 294.47, z = 85.77, taked = false, blip},
    {x = -864.73, y = 294.64, z = 85.77, taked = false, blip},
    {x = -867.17, y = 295.15, z = 85.23, taked = false, blip},
    {x = -868.93, y = 295.76, z = 85.23, taked = false, blip},
    {x = -870.88, y = 296.79, z = 84.76, taked = false, blip},
    {x = -872.54, y = 297.78, z = 84.76, taked = false, blip},
}

Config.VinewoodHills = {
    {x = -420.04, y = 551.93, z = 122.73, h = 153.34, blip, ped,
    houseX = -425.96, 
    houseY = 572.24, 
    houseZ = 125.06, 
    houseH = 239.35},
}

Config.VinewoodHillsWork = {
    {x = -428.35, y = 555.88, z = 123.36, taked = false, blip},
    {x = -431.58, y = 556.49, z = 123.29, taked = false, blip},
    {x = -433.72, y = 556.04, z = 123.21, taked = false, blip},
    {x = -436.09, y = 556.03, z = 123.17, taked = false, blip},
    {x = -436.34, y = 559.03, z = 123.13, taked = false, blip},
    {x = -433.18, y = 559.60, z = 123.33, taked = false, blip},
    {x = -429.65, y = 560.00, z = 123.80, taked = false, blip},
}

Config.ElBurroHeights = {
    {x = 1282.62, y = -1739.65, z = 52.79, h = 15.53, blip, ped,
    houseX = 1273.21, 
    houseY = -1749.16, 
    houseZ = 52.14, 
    houseH = 296.89},
}

Config.ElBurroHeightsWork = {
    {x = 1283.97, y = -1745.51, z = 52.18, taked = false, blip},
    {x = 1279.99, y = -1746.98, z = 52.03, taked = false, blip},
    {x = 1279.75, y = -1750.69, z = 52.03, taked = false, blip},
    {x = 1283.22, y = -1749.42, z = 52.03, taked = false, blip},
    {x = 1282.88, y = -1754.05, z = 52.03, taked = false, blip},
    {x = 1283.62, y = -1756.62, z = 52.03, taked = false, blip},
    {x = 1286.05, y = -1757.35, z = 52.03, taked = false, blip},
    {x = 1285.04, y = -1761.83, z = 52.03, taked = false, blip},
    {x = 1280.02, y = -1758.19, z = 52.03, taked = false, blip},
    {x = 1277.31, y = -1751.95, z = 52.03, taked = false, blip},
}

Config.Richman = {
    {x = -1925.00, y = 190.91, z = 84.34, h = 305.14, blip, ped,
    houseX = -1921.87, 
    houseY = 160.19, 
    houseZ = 84.58, 
    houseH = 307.37},
}

Config.RichmanWork = {
    {x = -1933.12, y = 177.03, z = 84.65, taked = false, blip},
    {x = -1931.20, y = 178.50, z = 84.65, taked = false, blip},
    {x = -1929.72, y = 179.51, z = 84.63, taked = false, blip},
    {x = -1927.73, y = 181.01, z = 84.56, taked = false, blip},
    {x = -1926.35, y = 181.89, z = 84.53, taked = false, blip},
    {x = -1924.29, y = 183.72, z = 84.39, taked = false, blip},
    {x = -1922.96, y = 184.79, z = 84.32, taked = false, blip},
    {x = -1921.41, y = 182.95, z = 84.45, taked = false, blip},
    {x = -1919.64, y = 180.64, z = 84.62, taked = false, blip},
    {x = -1917.93, y = 178.75, z = 84.65, taked = false, blip},
    {x = -1916.36, y = 176.53, z = 84.64, taked = false, blip},
    {x = -1914.73, y = 174.34, z = 84.64, taked = false, blip},
    {x = -1912.29, y = 171.68, z = 84.64, taked = false, blip},
    {x = -1910.82, y = 169.98, z = 84.64, taked = false, blip},
    {x = -1909.04, y = 168.02, z = 84.64, taked = false, blip},
}

Config.MirrorPark = {
    {x = 1353.35, y = -593.37, z = 74.34, h = 313.96, blip, ped,
    houseX = 1344.14, 
    houseY = -597.3, 
    houseZ = 74.34, 
    houseH = 324.45},
}

Config.MirrorParkWork = {
    {x = 1354.49, y = -597.07, z = 74.49, taked = false, blip},
    {x = 1354.12, y = -599.34, z = 74.49, taked = false, blip},
    {x = 1354.67, y = -601.89, z = 74.51, taked = false, blip},
    {x = 1353.41, y = -602.25, z = 74.51, taked = false, blip},
    {x = 1353.55, y = -604.69, z = 74.49, taked = false, blip},
    {x = 1355.04, y = -607.13, z = 74.49, taked = false, blip},
    {x = 1352.89, y = -608.34, z = 74.49, taked = false, blip},
    {x = 1350.37, y = -608.97, z = 74.51, taked = false, blip},
    {x = 1351.57, y = -611.00, z = 74.48, taked = false, blip},
    {x = 1353.84, y = -613.13, z = 74.42, taked = false, blip},
    {x = 1352.24, y = -615.08, z = 74.39, taked = false, blip},
    {x = 1349.88, y = -614.12, z = 74.39, taked = false, blip},
    {x = 1355.05, y = -603.99, z = 74.49, taked = false, blip},
    {x = 1352.21, y = -606.17, z = 74.50, taked = false, blip},
    {x = 1354.00, y = -610.00, z = 74.45, taked = false, blip},
    {x = 1351.82, y = -612.78, z = 74.44, taked = false, blip},
    {x = 1348.99, y = -611.21, z = 74.48, taked = false, blip},
    {x = 1347.65, y = -613.82, z = 74.53, taked = false, blip},
    {x = 1347.94, y = -616.31, z = 74.39, taked = false, blip},
    {x = 1351.04, y = -617.49, z = 74.59, taked = false, blip},
    {x = 1353.67, y = -616.97, z = 74.42, taked = false, blip},
    {x = 1354.58, y = -620.51, z = 74.44, taked = false, blip},
    {x = 1352.31, y = -619.76, z = 74.54, taked = false, blip},
    {x = 1353.25, y = -622.97, z = 74.52, taked = false, blip},
    {x = 1353.91, y = -626.04, z = 74.50, taked = false, blip},
    {x = 1351.51, y = -625.05, z = 74.52, taked = false, blip},
    {x = 1348.35, y = -625.67, z = 74.41, taked = false, blip},
    {x = 1347.49, y = -622.78, z = 74.44, taked = false, blip},
    {x = 1348.56, y = -620.21, z = 74.47, taked = false, blip},
    {x = 1351.04, y = -619.85, z = 74.60, taked = false, blip},
}

Config.EastVinewood = {
    {x = 868.46, y = -208.67, z = 70.55, h = 149.26, blip, ped,
    houseX = 879.94, 
    houseY = -205.39, 
    houseZ = 71.98, 
    houseH = 59.15},
}

Config.EastVinewoodWork = {
    {x = 881.75, y = -210.70, z = 71.77, taked = false, blip},
    {x = 880.38, y = -213.61, z = 71.26, taked = false, blip},
    {x = 882.51, y = -212.83, z = 71.53, taked = false, blip},
    {x = 886.16, y = -213.94, z = 71.66, taked = false, blip},
    {x = 885.74, y = -216.52, z = 71.24, taked = false, blip},
    {x = 888.22, y = -216.35, z = 71.47, taked = false, blip},
    {x = 888.10, y = -217.93, z = 71.20, taked = false, blip},
    {x = 891.25, y = -214.25, z = 71.67, taked = false, blip},
    {x = 893.23, y = -210.89, z = 71.69, taked = false, blip},
    {x = 894.59, y = -208.65, z = 71.79, taked = false, blip},
    {x = 896.45, y = -205.50, z = 71.83, taked = false, blip},
}

Config.NPC = {
    ['Peds'] = {
    [1] = {ped = 'a_m_m_bevhills_01'},
    [2] = {ped = 'a_m_m_soucent_04'},
    [3] = {ped = 'a_m_y_busicas_01'},
    [4] = {ped = 'a_m_y_mexthug_01'},
    [5] = {ped = 'a_m_y_vinewood_03'},
    [6] = {ped = 'cs_mrk'},
    [7] = {ped = 'csb_denise_friend'},
    [8] = {ped = 'csb_sol'},
    [9] = {ped = 'a_f_m_soucentmc_01'},
    [10] = {ped = 'a_f_o_soucent_02'},
    },
}

Config.Clothes = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 158,   ['torso_2'] = 0,
        ['arms'] = 67,
        ['pants_1'] = 70,   ['pants_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 4,   ['torso_2'] = 14,
        ['arms'] = 4,
        ['pants_1'] = 25,   ['pants_2'] = 1,
        ['shoes_1'] = 16,   ['shoes_2'] = 4,
    }
}