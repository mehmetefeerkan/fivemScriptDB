Config = {}

Config.Locale = 'tr'

Config.Delays = {
	mantarProcessing = 1000 * 10
}

Config.DrugDealerItems = {
	mantarlikek = 6500
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	mantar_processing = {label = _U('license_mantar'), price = 5000}
}

Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	mantarField = {coords = vector3(3248.41, -150.06, 16.84), name = _U('blip_mantar'), color = 25, sprite = 496, radius = 100.0},
	mantarProcessing = {coords = vector3(457.04, -2059.05, 23.99), name = _U('blip_mantarprocessing'), color = 25, sprite = 496, radius = 100.0},

    DrugDealer = {coords = vector3(1074.03, -2450.97, 29.12), name = _U('blip_drugdealer'), color = 6, sprite = 1, radius = 25.0},
}