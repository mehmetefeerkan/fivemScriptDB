
Config = {}

Config.CheckOwnership = true -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "tr"

Config.OpenKey = 47

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Weight = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 5000

Config.localWeight = {
    bread = 2,
    water = 2,
    WEAPON_SMG = 10,
    packaged_chicken = 2000,
    chicken = 2000,
    packaged_plank = 2000,
    wood = 2000,
    wool = 2000,
    copper = 2000,
    iron = 2000,
    gold = 2000,
    diamond = 20000,
    weed = 5000,
    opium = 5000,
    coke = 5000,
    meth = 5000,
    alcohol = 2,
	black = 50000,
    stone = 2000
}

Config.VehicleWeight = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 70000, --SUV
    [3] = 30000, --Coupes
    [4] = 30000, --Muscle
    [5] = 30000, --Sports Classics
    [6] = 30000, --Sports
    [7] = 30000, --Super
    [8] = 15000, --Motorcycles
    [9] = 150000, --Off-road
    [10] = 8000000, --Industrial
    [11] = 70000, --Utility
    [12] = 100000, --Vans
    [13] = 0, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 8000000, --Commercial
    [21] = 0 --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
