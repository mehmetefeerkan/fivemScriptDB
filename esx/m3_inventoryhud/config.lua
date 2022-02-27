Config = {}
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.
Config.TrunkAndGloveboxOpenControl = 182

Config.UseLimit = false
Config.UseWeight = true

-- List of item names that will close ui when used
Config.CloseUiItems = {"wallet", "fishingrod", "radio", "notepad", "licenseplate", "lockpick", "fitbit"}

Config.UnlistedAccountsList = {"bank"}

Config.Shops = { 
    ['Polis Silah Deposu'] = {
        coords = {vector3(484.2, -1002.05, 25.73)},
        items = {
            { name = "disc_ammo_pistol", price = 0, count = 1, grade = 0 },
            { name = "disc_ammo_pistol_large", price = 0, count = 1, grade = 0 },
            { name = "disc_ammo_rifle", price = 0, count = 1, grade = 0 },
            { name = "disc_ammo_rifle_large", price = 0, count = 1, grade = 0 },
            { name = "disc_ammo_shotgun", price = 0, count = 1, grade = 0 },
            { name = "disc_ammo_smg", price = 0, count = 1, grade = 0 },
            { name = "disc_ammo_snp", price = 0, count = 1, grade = 0 },
			{ name = "WEAPON_COMBATPISTOL", price = 0, count = 1, grade = 0 },
			{ name = "WEAPON_SMG", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_STUNGUN", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_NIGHTSTICK", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_FLASHLIGHT", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_FLARE", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_PUMPSHOTGUN", price = 0, count = 1, grade = 2 },
            { name = "WEAPON_CARBINERIFLE", price = 0, count = 1, grade = 3 },
			{ name = "WEAPON_FLARE", price = 0, count = 1, grade = 1 },
			{ name = "radio", price = 0, count = 1, grade = 1 },
			{ name = "WEAPON_HEAVYPISTOL", price = 0 },
        },
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 0, g = 0, b = 255 },
        use3dtext = false,
        msg = 'Cephaneliğe erişmek için ~INPUT_CONTEXT~ tuşuna basınız.', --or '[E] - İlaçlar',
        blip = false, --{id = 15, scale = 0.5, color = 1, title = 'İlaç Deposu'},
        job = {'police'}
    },
    ['Market'] = {
        coords = {
            vector3(25.95, -1347.27, 29.5),
            vector3(373.875, 325.896, 103.566),
            vector3(2557.458, 382.282, 106.622),
            vector3(-3038.939, 585.954, 7.908),
            vector3(-3241.927, 1001.462, 12.830),
            vector3(547.431, 2671.710, 42.156),
            vector3(1961.464, 3740.672, 32.343),
            vector3(2678.916, 3280.671, 55.241),
            vector3(1729.563, 6414.126, 36.037),
            vector3(-48.519, -1757.514, 29.421),
            vector3(1163.373, -323.801, 68.205),
            vector3(-707.501, -914.260, 19.215),
            vector3(-1820.523, 792.518, 138.118),
            vector3(1698.388, 4924.404, 42.063),
            vector3(1135.808, -982.281, 46.415),
            vector3(-1222.915, -906.983, 12.326),
            vector3(-1487.553, -379.107, 40.163),
            vector3(-2968.243, 390.910, 15.043),
            vector3(1166.024, 2708.930, 38.157),
            vector3(1392.562, 3604.684, 34.980)
        },
        items = {
            {name = 'water',price = 20 },
            {name = 'bread',price = 20 },
			{name = 'blue_phone',price = 250 },
			{name = 'cigarett',price = 10 },
			{name = 'sandwich',price = 10 },
			{name = 'chips',price = 25 },
			{name = 'energy',price = 75 },
			{name = 'karbonat',price = 1500 },
			{name = 'lighter',price = 90 },
			{name = 'chocolate',price = 25 },
			{name = 'cola',price = 75 },
			{name = 'fixkit',price = 5500 },
			{name = 'hamburger',price = 30 },
			{name = 'cupcake',price = 30 },
			{name = 'fishingrod',price = 30 },
			{name = 'fishbait',price = 30 },
			{name = 'megaburger',price = 30 },
			{name = 'megaxhamburger',price = 60 },
			{name = 'milkshake',price = 30 },
        },
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 255, g = 255, b = 255 },
        use3dtext = true,
        msg =  '[E] - Market',
        blip = {id = 59, scale = 0.5, color = 2, title = 'Market'},
        job = {'all'}
    },
    ['EMS Market'] = {
        coords = {
            vector3(310.53, -599.17, 43.29)
        },
        items = {
            { name = "bandage", price = 0 },
            { name = "medikit", price = 0 },
            { name = "phone", price = 0 },
            { name = "radio", price = 0 },
            { name = "WEAPON_STUNGUN", price = 0 },
            { name = "kapsul", price = 0 },
        },
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 255, g = 255, b = 255 },
        use3dtext = true,
        msg =  '[E] - EMS Market',
        blip = false, --{id = 59, scale = 0.5, color = 2, title = 'Market'},
        job = {'ambulance'}
    },
    ['Megamall'] = {
        coords = {vector3(46.56, -1749.71, 29.63)},
        items = {
            { name = "blue_phone", price = 250 },
            { name = "poset", price = 400 },
            { name = "tornavida", price = 40000 },
            { name = "faxkit", price = 1000 },
            { name = "lockpick", price = 2500 },
        },
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 255, g = 255, b = 255 },
        use3dtext = true,
        msg = '[E] - Megamall',
        blip = {id = 59, scale = 0.5, color = 5, title = 'Megamall'},
        job = {'all'}
    },
} 


Config.Stashs = {
    ['PD Deposu'] = { 
        coords = {vector3(461.08, -981.27, 30.69)},
        useMarker = true,
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 255, g = 255, b = 255 },
        use3dtext = true,
        msg = '[E] - PD Deposu',
        job = 'police',
        maxweight = 1000 -- if u use weight, uncomment this line
    },
    ['Grove'] = { 
        coords = {vector3(-135.94, -1610.95, 35.03)},
        useMarker = true,
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 0, g = 255, b = 0 },
        use3dtext = true,
        msg = '[E] - Stash',
        job = 'grove',
        maxweight = 2000 -- if u use weight, uncomment this line
    },
    ['Ballas'] = { 
        coords = {vector3(120.62, -1970.57, 21.33)},
        useMarker = true,
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 102, g = 0, b = 153 },
        use3dtext = true,
        msg = '[E] - Stash',
        job = 'ballas',
        maxweight = 2000 -- if u use weight, uncomment this line
    },
    ['Vagos'] = { 
        coords = {vector3(333.78, -2015.29, 22.39)},
        useMarker = true,
        markerType = 2,
        markerSize = vector3(0.2, 0.2, 0.2),
        markerColour = { r = 255, g = 255, b = 0 },
        use3dtext = true,
        msg = '[E] - Stash',
        job = 'vagos',
        maxweight = 2000 -- if u use weight, uncomment this line
    },
}

Config.DeleteDrops = {
    Enabled = true,
    Time = 300 --second
}

Config.VehicleTrunkOrGloveboxItems = { --if your item table in the database has a weight column, you don't need to enter the items here --if u using default weapons(not item weapons), u can enter weapon names(like 'WEAPON_PISTOL')
    ['default'] = 0.2, --dont remove this line

    --items
    -- ['ambalaj'] = 0.02,

    --weapons
    -- ['WEAPON_PISTOL'] = 1.0,
}

Config.VehicleTrunks = { --if you set the value to 0, no inventory is opened in that class vehicle
    [0] = 10, --Compact
    [1] = 15, --Sedan
    [2] = 20, --SUV
    [3] = 13, --Coupes
    [4] = 15, --Muscle
    [5] = 13, --Sports Classics
    [6] = 12, --Sports
    [7] = 5, --Super
    [8] = 3, --Motorcycles
    [9] = 1250, --Off-road
    [10] = 13, --Industrial
    [11] = 13, --Utility
    [12] = 45, --Vans
    [13] = 0, --Cycles
    [14] = 5, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 20, --Service
    [18] = 20, --Emergency
    [19] = 10, --Military
    [20] = 60, --Commercial
    [21] = 0 --Trains
}

Config.VehicleGloveboxs = { --if you set the value to 0, no inventory is opened in that class vehicle
    [0] = 3, --Compact
    [1] = 5, --Sedan
    [2] = 5, --SUV
    [3] = 3, --Coupes
    [4] = 3, --Muscle
    [5] = 3, --Sports Classics
    [6] = 3, --Sports
    [7] = 3, --Super
    [8] = 0, --Motorcycles
    [9] = 5, --Off-road
    [10] = 5, --Industrial
    [11] = 5, --Utility
    [12] = 14, --Vans
    [13] = 0, --Cycles
    [14] = 0, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 5, --Service
    [18] = 5, --Emergency
    [19] = 5, --Military
    [20] = 5, --Commercial
    [21] = 0 --Trains
}

Config.NotifTexts = {
    ['use'] = 'Kullanıldı',
    ['add'] = 'Eklendi',
    ['remove'] = 'Silindi',
}

Config.ItemWeapons = { --only working with disc-ammo
    Enabled = true,
    Throwables = {
        WEAPON_MOLOTOV = 615608432,
        WEAPON_GRENADE = -1813897027,
        WEAPON_STICKYBOMB = 741814745,
        WEAPON_PROXMINE = -1420407917,
        WEAPON_SMOKEGRENADE = -37975472,
        WEAPON_PIPEBOMB = -1169823560,
        WEAPON_SNOWBALL = 126349499
    },
    
    FuelCan = 883325847,
}

Config.WeaponLabels = { -- only used for non item weapons
    ['WEAPON_KNIFE'] = 'Bıçak',
    ['WEAPON_NIGHTSTICK'] = 'Jop',
    ['WEAPON_HAMMER'] = 'Çekiç',
    ['WEAPON_BAT'] = 'Beyzbol Sopası',
    ['WEAPON_GOLFCLUB'] = 'Golf Sopası',
    ['WEAPON_CROWBAR'] = 'Levye',
    ['WEAPON_PISTOL'] = 'Tabanca',
    ['WEAPON_COMBATPISTOL'] = 'Combat Pistol',
    ['WEAPON_APPISTOL'] = 'AP pistol',
    ['WEAPON_PISTOL_MK2'] = 'Pistol MK2',
    ['WEAPON_SMG_MK2'] = 'SMG MK2',
    ['WEAPON_CARBINERIFLE_MK2'] = 'Carbine Rifle MK2',
    ['WEAPON_PISTOL50'] = 'Pistol .50',
    ['WEAPON_MICROSMG'] = 'Micro SMG',
    ['WEAPON_SMG'] = 'SMG',
    ['WEAPON_ASSAULTSMG'] = 'Assault SMG',
    ['WEAPON_ASSAULTRIFLE'] = 'Assault Rifle',
    ['WEAPON_CARBINERIFLE'] = 'Carbine Rifle',
    ['WEAPON_ADVANCEDRIFLE'] = 'Advanced Rifle',
    ['WEAPON_MG'] = 'MG',
    ['WEAPON_COMBATMG'] = 'Combat MG',
    ['WEAPON_PUMPSHOTGUN'] = 'Pump Shotgun',
    ['WEAPON_SAWNOFFSHOTGUN'] = 'Sawed off Shotgun',
    ['WEAPON_ASSAULTSHOTGUN'] = 'Assault Shotgun',
    ['WEAPON_BULLPUPSHOTGUN'] = 'Bullpup Shotgun',
    ['WEAPON_STUNGUN'] = 'Taser',
    ['WEAPON_SNIPERRIFLE'] = 'Sniper Rifle',
    ['WEAPON_HEAVYSNIPER'] = 'Heavy Sniper',
    ['WEAPON_GRENADELAUNCHER'] = 'Grenade Launcher',
    ['WEAPON_RPG'] = 'rocket launcher',
    ['WEAPON_STINGER'] = 'stinger',
    ['WEAPON_MINIGUN'] = 'minigun',
    ['WEAPON_GRENADE'] = 'Grenade',
    ['WEAPON_STICKYBOMB'] = 'Sticky Bomb',
    ['WEAPON_SMOKEGRENADE'] = 'Sis Bombası',
    ['WEAPON_BZGAS'] = 'BAYILTICI GAZ',
    ['WEAPON_MOLOTOV'] = 'Molotov Cocktail',
    ['WEAPON_FIREEXTINGUISHER'] = 'fire extinguisher',
    ['WEAPON_PETROLCAN'] = 'Jerrycan',
    ['WEAPON_DIGISCANNER'] = 'digiscanner',
    ['WEAPON_BALL'] = 'Ball',
    ['WEAPON_SNSPISTOL'] = 'Sns Pistol',
    ['WEAPON_BOTTLE'] = 'Bottle',
    ['WEAPON_GUSENBERG'] = 'Gusenberg sweeper',
    ['WEAPON_SPECIALCARBINE'] = 'Special Carbine',
    ['WEAPON_HEAVYPISTOL'] = 'Heavy Pistol',
    ['WEAPON_BULLPUPRIFLE'] = 'bullpup rifle',
    ['WEAPON_DAGGER'] = 'Dagger',
    ['WEAPON_VINTAGEPISTOL'] = 'Vintage pistol',
    ['WEAPON_FIREWORK'] = 'Firework',
    ['WEAPON_MUSKET'] = 'Musket',
    ['WEAPON_HEAVYSHOTGUN'] = 'Heavy Shotgun',
    ['WEAPON_MARKSMANRIFLE'] = 'Marksman Rifle',
    ['WEAPON_HOMINGLAUNCHER'] = 'homing launcher',
    ['WEAPON_PROXMINE'] = 'proximity mine',
    ['WEAPON_SNOWBALL'] = 'snow ball',
    ['WEAPON_FLAREGUN'] = 'flaregun',
    ['WEAPON_GARBAGEBAG'] = 'garbage bag',
    ['WEAPON_HANDCUFFS'] = 'handcuffs',
    ['WEAPON_COMBATPDW'] = 'combat pdw',
    ['WEAPON_MARKSMANPISTOL'] = 'Marksman Pistol',
    ['WEAPON_KNUCKLE'] = 'Knuckledusters',
    ['WEAPON_HATCHET'] = 'Hatchet',
    ['WEAPON_RAILGUN'] = 'railgun',
    ['WEAPON_MACHETE'] = 'Machete',
    ['WEAPON_MACHINEPISTOL'] = 'Machine pistol',
    ['WEAPON_SWITCHBLADE'] = 'Switchblade',
    ['WEAPON_REVOLVER'] = 'Heavy Revolver',
    ['WEAPON_DBSHOTGUN'] = 'double barrel shotgun',
    ['WEAPON_COMPACTRIFLE'] = 'Compact Rifle',
    ['WEAPON_AUTOSHOTGUN'] = 'auto shotgun',
    ['WEAPON_BATTLEAXE'] = 'Battle Axe',
    ['WEAPON_COMPACTLAUNCHER'] = 'compact launcher',
    ['WEAPON_MINISMG'] = 'Mini smg',
    ['WEAPON_PIPEBOMB'] = 'pipe bomb',
    ['WEAPON_POOLCUE'] = 'Pool Cue',
    ['WEAPON_WRENCH'] = 'Pipe Wrench',
    ['WEAPON_FLASHLIGHT'] = 'El Feneri',
    ['GADGET_NIGHTVISION'] = 'night vision',
    ['GADGET_PARACHUTE'] = 'parachute',
    ['WEAPON_FLARE'] = 'flare gun',
    ['WEAPON_DOUBLEACTION'] = 'Double-Action Revolver',
}

Config.GarbageProps = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_3a',
    'prop_dumpster_4a',
    'prop_dumpster_4b',
}

Config.GarbageItems = { -- only items not working with weapons or if u want put in weapon u must enable item weapons
    [1] = {
        name = 'vodka',
        count = math.random(1, 2)
    },
    [2] = {
        name = 'cigaret',
        count = math.random(3, 5)
    },
    [3] = {
        name = 'water',
        count = math.random(0, 1)
    },
    [4] = {
        name = 'sandwich',
        count = math.random(1, 2)
    },
    [5] = {
        name = 'lockpick',
        count = math.random(1, 2)
    },
}

Config.GarbageRefreshTime = 7200 --second