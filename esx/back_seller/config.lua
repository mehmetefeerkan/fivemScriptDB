
Config = {
    Recipes = {
        ["SARAP"] = {
            RequiredItems = {
                {Item = 'ptx_kacaksilah3', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Paketlenmis Sarap - $100', Count = 100}
        },
        ["FRAMBUAZ"] = {
            RequiredItems = {
                {Item = 'ptx_tarihieser3', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Paketlenmis Frambuaz- $120', Count = 120}
        },
         ["BALIK"] = {
             RequiredItems = {
                 {Item = 'fish', Count = 1}
             },
             GiveItem = {Item = 'cash', label = 'Balık - $60', Count = 60}
         },
         ["SILVER"] = {
             RequiredItems = {
                 {Item = 'silver', Count = 1}
             },
             GiveItem = {Item = 'cash', label = 'Gümüş - $75', Count = 75}
         },
         ["ALTIN"] = {
             RequiredItems = {
                 {Item = 'gold', Count = 1}
             },
             GiveItem = {Item = 'cash', label = 'Altın - $120', Count = 120}
         },
         ["COPPER"] = {
             RequiredItems = {
                 {Item = 'copper', Count = 1}
             },
             GiveItem = {Item = 'cash', label = 'Bakır - $50', Count = 50}
         },
        ["EKRANKART"] = {
            RequiredItems = {
                {Item = 'ekrankarti', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Ekran Kartı - $110', Count = 110}
        },
        ["ANAKART"] = {
            RequiredItems = {
                {Item = 'anakart', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Anakart - $100', Count = 100}
        },
        ["SATA"] = {
            RequiredItems = {
                {Item = 'sata', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Sata - $90', Count = 90}
        },
        ["PCI"] = {
            RequiredItems = {
                {Item = 'pci', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'PCI PORT - $90', Count = 90}
        },
        ["ROLEX"] = {
            RequiredItems = {
                {Item = 'rolex', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Rolex - $5000', Count = 500}
        },
        ["MERCAN"] = {
            RequiredItems = {
                {Item = 'mercan', Count = 1}
            },
            GiveItem = {Item = 'cash', label = 'Rolex - $190', Count = 190}
        },
    }
}

Config.ToptanciCoords = vector3(-137.984, -2383.55, 6.0000)

Config.NPCEnable = true -- npc olup olmayacagı
Config.NPCHash = 68070371 -- npc hash kodu
Config.NPCShop = { x = -137.984, y = -2383.55, z = 5.0000, h = 170.8 } -- npc nin nerede duracağı