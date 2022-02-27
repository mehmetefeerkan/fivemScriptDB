Config = {}

Config.Debug = false -- only in dev mode.

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}

Config.FishingRestaurant = {
    ["name"] = "Balık Restorantı",
    ["blip"] = {
        ["sprite"] = 427,
        ["color"] = 3
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6,
        ["position"] = vector3(-1832.8, -1202.33, 14.3),
        ["heading"] = 154.0
    }
}

Config.FishingItems = {
    ["rod"] = {
        ["name"] = "fishingrod",
        ["label"] = "Olta"
    },
    ["bait"] = {
        ["name"] = "fishbait",
        ["label"] = "Balık Yemi"
    },
    ["fish"] = {
        ["name"] = "fish",
        ["label"] = "Çiğ balık",
        ["price"] = 250 -- this is the price for each fish captured.
    }
}

Config.Command = "none" -- if set to "" or "none" command will not work. otherwise item use will be used.