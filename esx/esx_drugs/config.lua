Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 10  --10 saniye
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(2035.14, 4908.24, 42.31), name = _U('blip_weedfield'), color = 0, sprite = 0, radius = 0.0},
	WeedProcessing = {coords = vector3(-276.75, 2207.87, 129.29), name = _U('blip_weedprocessing'), color = 0, sprite = 0, radius = 0.0}
	--DrugDealer = {coords = vector3(3310.696, 5176.471, 19.614), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0}
}