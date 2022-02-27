Config = {}

Config.Debug = false -- only in dev mode.

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}
--[[
Config.FishingRestaurant = {
    ["name"] = "Balık Satış",
    ["blip"] = {
        ["sprite"] = 280,
        ["color"] = 26
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6,
        ["position"] = vector3(-1038.4545898438, -1397.0551757813, 5.553192615509),
        ["heading"] = 75.0
    }
}
--]]
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
    },
    ["turtle"] = {
        ["name"] = "turtle"

    }
}

Config.Command = "none" -- if set to "" or "none" command will not work. otherwise item use will be used.