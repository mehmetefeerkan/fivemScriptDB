Config = {}

-- Are you using ESX? Turn this to true if you would like fuel & jerry cans to cost something.
Config.UseESX = true

-- What should the price of jerry cans be?
Config.JerryCanCost = 550
Config.RefillCost = 400 -- If it is missing half of it capacity, this amount will be divided in half, and so on.

-- Fuel decor - No need to change this, just leave it.
Config.FuelDecor = "_FUEL_LEVEL"

-- What keys are disabled while you're fueling.
Config.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}

-- Want to use the HUD? Turn this to true.
Config.EnableHUD = false

-- Configure blips here. Turn both to false to disable blips all together.
Config.ShowNearestGasStationOnly = true
Config.ShowAllGasStations = false

-- Configure the strings as you wish here.
Config.Strings = {
	ExitVehicle = "Doldurmak için araçtan çıknız",
	EToRefuel = "Doldurmak için lütfen~g~E ~w~tuşuna basınız",
	JerryCanEmpty = "Bidon boş",
	FullTank = "Depon full",
	PurchaseJerryCan = "Benzin bidonu almak için lütfen ~g~E ~w~tuşuna bas fiyat: ~g~$" .. Config.JerryCanCost,
	CancelFuelingPump = "İptal etmek istiyorsan lütfen ~g~E ~w~tuşuna bas",
	CancelFuelingJerryCan = "İptal etmek istiyorsan lütfen ~g~E ~w~tuşuna bas",
	NotEnoughCash = "Yeterli paran yok",
	RefillJerryCan = "Bidonu tekrar doldurmak için ~g~E ~w~ tuşuna bas ",
	NotEnoughCashJerryCan = "Bidonu doldurmak için yeterli paran yok",
	JerryCanFull = "Bidonun zaten full",
	TotalCost = "Gider",
}

if not Config.UseESX then
	Config.Strings.PurchaseJerryCan = "Press ~g~E ~w~to grab a jerry can"
	Config.Strings.RefillJerryCan = "Press ~g~E ~w~ to refill the jerry can"
end

Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
Config.Blacklist = {
	--"Adder",
	--276773164
--	"-2100640717"
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
Config.RemoveHUDForBlacklistedVehicle = true

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
Config.Classes = {
	[0] = 1.0, -- Compacts
	[1] = 1.0, -- Sedans
	[2] = 1.0, -- SUVs
	[3] = 1.0, -- Coupes
	[4] = 1.0, -- Muscle
	[5] = 1.0, -- Sports Classics
	[6] = 1.0, -- Sports
	[7] = 1.0, -- Super
	[8] = 1.0, -- Motorcycles
	[9] = 1.0, -- Off-road
	[10] = 1.0, -- Industrial
	[11] = 1.0, -- Utility
	[12] = 1.0, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.0, -- Boats
	[15] = 1.0, -- Helicopters
	[16] = 1.0, -- Planes
	[17] = 1.0, -- Service
	[18] = 1.0, -- Emergency
	[19] = 1.0, -- Military
	[20] = 1.0, -- Commercial
	[21] = 1.0, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
Config.FuelUsage = {
	[1.0] = 1.2,
	[0.9] = 1.0,
	[0.8] = 0.8,
	[0.7] = 0.7,
	[0.6] = 0.6,
	[0.5] = 0.5,
	[0.4] = 0.4,
	[0.3] = 0.3,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Config.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

Config.Shops = {
vector3(373.875,325.896,102.566),
vector3(2557.458, 382.282,107.622),
vector3(-3038.939,585.954,6.908),
vector3(-3241.927,1001.462, 11.830),
vector3(547.431,2671.710, 41.156),
vector3(1961.464, 3740.672, 31.343),
vector3(2678.916, 3280.671, 54.241),
vector3(1729.216, 6414.131, 34.037),
vector3(-48.519,-1757.514, 28.421),
vector3(1163.373, -323.801,68.205),
vector3(-707.501, -914.260,18.215),
vector3(-1820.523,792.518, 137.118),
vector3(1698.388, 4924.404,41.063),
vector3(25.723,-1346.966, 28.497)
}


Config.Bars = {

vector3(1135.808,-982.281,45.415), 
vector3(-1487.553,-379.107,39.163), 
vector3(-2968.243,390.910, 14.043), 
vector3(1166.024,2708.930,37.157), 
vector3(1392.562,3604.684,33.980), 
vector3(-1393.409,-606.624,29.319)
}

Config.Bank = {
vector3(150.266,-1040.203,29.374), 
vector3(-1212.980,-330.841,37.787), 
vector3(-2962.582,482.627,15.703), 
vector3(-112.202,6469.295,31.626), 
vector3(314.187,-278.621,54.170), 
vector3(-351.534,-49.529,49.042), 
vector3(241.727,220.706,106.286), 
vector3(1175.064,2706.643,38.05)
}