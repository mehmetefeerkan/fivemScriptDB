--Made by keke31
Config = {}
Config.ShowBlips = true

Config.Zones = {
    -- TAVUK
    TavukTopla = { 
        x = -62.4903, y = 6241.700, z = 31.086,
        BarText = "Tavuk Toplanıyor", 
        DravText = "~g~K~w~ - Tavuk Topla", 

        ItemGerek = false, 
        GerekItemIsim = "",
        GerekItemAdet = 0,

        ItemIsim = "adeztavuk",
        ItemAdet = 1,

        Dict = "mini@repair", 
        Anim = "fixing_a_ped", 

        BlipName = "Tavuk Toplama",  
        sprite = 177, 
        color = 46,
    },

    TavukKes = { 
        x = -78.1202, y = 6229.319, z = 31.086,
        BarText = "Tavuk Kesiliyor", 
        DravText = "~g~K~w~ - Tavuk Kes", 

        ItemGerek = true, 
        GerekItemIsim = "adeztavuk",
        GerekItemAdet = 1,

        ItemIsim = "slaughtered_chicken",
        ItemAdet = 1,

        Dict = "mini@repair", 
        Anim = "fixing_a_ped", 

        BlipName = "Tavuk Kesme",  
        sprite = 177, 
        color = 46,
    },

    TavukSatma = { 
        x = -102.110, y = 6208.790, z = 31.020,
        BarText = "Tavuk Satılıyor", 
        DravText = "~g~K~w~ - Tavuk Sat", 

        ItemGerek = true, 
        GerekItemIsim = "slaughtered_chicken",
        GerekItemAdet = 1,

        ItemIsim = "cash",
        ItemAdet = 10,

        Dict = "mini@repair", 
        Anim = "fixing_a_ped", 

        BlipName = "Tavuk Satış",  
        sprite = 177, 
        color = 46,
    },

    -- ODUN 
    OdunTopla = { 
        x = -554.100, y = 5370.614, z = 70.345,
        BarText = "Odun Toplanıyor", 
        DravText = "~g~K~w~ - Odun Topla", 

        ItemGerek = false, 
        GerekItemIsim = "",
        GerekItemAdet = 0,

        ItemIsim = "wood",
        ItemAdet = 1,

        Dict = "mini@repair", 
        Anim = "fixing_a_ped", 

        BlipName = "Odun Toplama",  
        sprite = 238, 
        color = 2,
    },

    OdunKesme = { 
        x = -552.129, y = 5328.060, z = 73.639,
        BarText = "Odun Kesiliyor", 
        DravText = "~g~K~w~ - Odun Kes", 

        ItemGerek = true, 
        GerekItemIsim = "wood",
        GerekItemAdet = 1,

        ItemIsim = "packaged_plank",
        ItemAdet = 1,

        Dict = "mini@repair", 
        Anim = "fixing_a_ped", 

        BlipName = "Odun Kesme",  
        sprite = 238, 
        color = 2,
    },

    OdunSatma = { 
        x = -501.589, y = 5277.410, z = 80.605,
        BarText = "Odun Satılıyor", 
        DravText = "~g~K~w~ - Odun Sat", 

        ItemGerek = true, 
        GerekItemIsim = "packaged_plank",
        GerekItemAdet = 1,

        ItemIsim = "cash",
        ItemAdet = 10,

        Dict = "mini@repair", 
        Anim = "fixing_a_ped", 

        BlipName = "Odun Satış",  
        sprite = 238, 
        color = 2,
    },
}