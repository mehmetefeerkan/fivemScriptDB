Config = {
    Recipes = {
		["Balık"] = {
            RequiredItems = {
                {Item = 'fish', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Balık - $100', Count = 100}
        },
        ["Not Defteri"] = {
            RequiredItems = {
                {Item = 'notdefteri', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Not Defteri - $15', Count = 15}
        },
        ["Temizlik Bezi"] = {
            RequiredItems = {
                {Item = 'temizlikbezi', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Temizlik Bezi - $15', Count = 15}
        },
        ["Bal"] = {
            RequiredItems = {
                {Item = 'honey_b', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Bal - $100', Count = 100}
        },
		["Poşet"] = {
            RequiredItems = {
                {Item = 'poset', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Poşet - $15', Count = 15}
        },
        ["Kagit"] = {
            RequiredItems = {
                {Item = 'kagit', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Kağıt - $15', Count = 15}
        }
    },
}

Config.ToptanciCoords = vector3(vector3(-232.198, -914.976, 32.310))

Config.NPCEnable = true -- npc olup olmayacagı
Config.NPCHash = 68070371 -- npc hash kodu
Config.NPCShop = { x = -232.321, y = -915.469, z = 31.310, h = 344.06 }