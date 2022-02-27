Config = {}

Config.Debug = false -- only in dev mode.

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}

Config.FishingRestaurant = {
    ["name"] = "Oduncu Köyü Fabrikası",
    ["blip"] = {
        ["sprite"] = 280,
        ["color"] = 0
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6,
        ["position"] = vector3(-528.1245898438, 5318.5651757813, 74.953192615509),
        ["heading"] = 75.0
    }
}

Config.FishingItems = {
    ["rod"] = {
        ["name"] = "james_fishingrod",
        ["label"] = "Olta"
    },
    ["bait"] = {
        ["name"] = "james_fishingbait",
        ["label"] = "Balık Yemi"
    },
    ["fish"] = {
        ["name"] = "fish",
        ["label"] = "Çiğ balık",
        ["price"] = 60 -- this is the price for each fish captured.
    }
}

Config.Command = "none" -- if set to "" or "none" command will not work. otherwise item use will be used.