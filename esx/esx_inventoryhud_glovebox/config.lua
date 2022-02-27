Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in glovebox.
Config.AllowPolice = true -- If true, police will be able to search players' glovebox.

Config.Locale = "tr"

Config.OpenKey = 244

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Weight = 6000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10

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
	money = 999999999,
    stone = 2000
}

Config.VehicleWeight = {
    [0] = 300, --Compact
    [1] = 400, --Sedan
    [2] = 700, --SUV
    [3] = 250, --Coupes
    [4] = 300, --Muscle
    [5] = 100, --Sports Classics
    [6] = 50, --Sports
    [7] = 50, --Super
    [8] = 50, --Motorcycles
    [9] = 1800, --Off-road
    [10] = 3000, --Industrial
    [11] = 700, --Utility
    [12] = 1000, --Vans
    [13] = 0, --Cycles
    [14] = 50, --Boats
    [15] = 200, --Helicopters
    [16] = 0, --Planes
    [17] = 400, --Service
    [18] = 400, --Emergency
    [19] = 0, --Military
    [20] = 3000, --Commercial
    [21] = 0 --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
