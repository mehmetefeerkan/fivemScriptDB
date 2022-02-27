Config                            = {}
Config.DrawDistance               = 20.0
Config.Locale = 'en'
Config.DeliveryTime = 600 -- IN SECOUNDS DEFAULT (18000) IS 5 HOURS / 300 MINUTES
Config.TimeBetweenRobberies = 4320
Config.CutOnRobbery = 50 -- IN PERCENTAGE FROM THE TARGET SHOP
Config.RequiredPolices = 3 -- For the robbery
Config.SellValue = 1 -- This is the shops value divided by 2
Config.ChangeNamePrice = 500 -- In $ - how much you can change the shops name for

-- CONFIG ITEMS, DON'T FORGET TO ADD CORRECT NUMBER IN THE BRACKETS
Config.Items = {
    [1] = {label = "Su",       item = "water",        price = 25},
    [2] = {label = "Ekmek",      item = "bread",       price = 30},
    [1] = {label = "Tamir Kiti",       item = "fixkit",        price = 7500},
    [3] = {label = "Telefon",      item = "phone",       price = 200},
    [4] = {label = "Sigara",      item = "cigarett",       price = 22},
    [5] = {label = "Çakmak",      item = "cakmak",       price = 45},
    [6] = {label = "Tamir kiti",      item = "fixkit",       price = 4500},
    [7] = {label = "Sandviç",      item = "sandwich",       price = 30},
    [8] = {label = "Cips",      item = "chips",       price = 25},
    [9] = {label = "Çikolata",      item = "chocolate",       price = 32},
    [10] = {label = "CupCake",      item = "cupcake",       price = 31},
    [11] = {label = "Hamburger",      item = "hamburger",       price = 32},
    [12] = {label = "Bolnoixcajou",      item = "bolnoixcajou",       price = 25},
    [13] = {label = "Bolchips",      item = "bolchips",       price = 25},
    [14] = {label = "Cola",      item = "cocacola",       price = 35},
    --[15] = {label = "Redbull",      item = "redgull",       price = 35},
	  [15] = {label = "Temizleme Bezi",      item = "gul",       price = 150},
	  [16] = {label = "Aseton",      item = "acetone",       price = 150},
    [17] = {label = "Lityum Batarya",      item = "lithium",       price = 150},
    [198] = {label = "Ağır Zırh",      item = "armour",       price = 10},
    [198] = {label = "GPS",      item = "gps",       price = 1}, 
    [198] = {label = "Telsiz",      item = "radio",       price = 1},
    [198] = {label = "Polis Tableti",      item = "ptab",       price = 1},
    [198] = {label = "Telefon",      item = "phone",       price = 1},
    [198] = {label = "Su",      item = "water",       price = 1},
    [198] = {label = "Tamir Kiti",      item = "fixkit",       price = 1},
    [198] = {label = "Ekmek",      item = "bread",       price = 1},
    [198] = {label = "Tamir Kiti",      item = "fixkit",       price = 1},

  
	--[16] = {label = "Pet Maması",      item = "croquettes",       price = 35},
}

Config.Images = {
  [1] = {item = "water",   src = "img/bottle.png"},
  [2] = {item = "bread",   src = "img/burger.png"},
  [3] = {item = "phone",   src = "img/phone.png"},
  [4] = {item = "cigarett",   src = "img/cigarett.png"},
  [5] = {item = "cakmak",   src = "img/lighter.png"},
  [6] = {item = "fixkit",   src = "img/fixkit.png"},
  [7] = {item = "sandwich",   src = "img/sandwich.png"},
  [8] = {item = "chips",   src = "img/chips.png"},
  [9] = {item = "chocolate",   src = "img/chocolate.png"},
  [10] = {item = "cupcake",   src = "img/cupcake.png"},
  [11] = {item = "hamburger",   src = "img/hamburger.png"},
  [12] = {item = "Bolnoixcajou",   src = "img/bolnoixcajou.png"},
  [13] = {item = "bolchips",   src = "img/bolchips.png"},
  [14] = {item = "Cola",   src = "img/cocacola.png"},
  [15] = {item = "gul",   src = "img/gul.png"},
  [16] = {item = "acetone",   src = "img/acetone.png"},
  [17] = {item = "lithium",   src = "img/lithium.png"},
  [18] = {item = "wallet",   src = "img/wallet.png"},
  [19] = {item = "cheeseburger",   src = "img/cheeseburger.png"},
  [20] = {item = "cupkek",   src = "img/cupkek.png"},
  [21] = {item = "doublecheeseburger",   src = "img/doublecheeseburger.png"},
  [22] = {item = "kofte",   src = "img/kofte.png"},
  [23] = {item = "kulahdondurma",   src = "img/kulahdondurma.png"},
  [24] = {item = "megaburger",   src = "img/megaburger.png"},
  [25] = {item = "megaxhamburger",   src = "img/megaxhamburger.png"},
  [26] = {item = "milkshake",   src = "img/milkshake.png"},
  [27] = {item = "pankek",   src = "img/pankek.png"},
  [28] = {item = "sosisli",   src = "img/sosisli.png"},
  [29] = {item = "tavuknuggets",   src = "img/tavuknuggets.png"},
  [30] = {item = "tavuksoganhalkasi",   src = "img/tavuksoganhalkasi.png"},
  [31] = {item = "umbrella",   src = "img/umbrella.png"},
  [32] = {item = "whitewine",   src = "img/whitewine.png"},
  [33] = {item = "whitewine",   src = "img/fixkit.png"},
}

Config.Zones = {

  ShopCenter = {
    Pos   = {x = 6.09,   y = -708.89,  z = 44.97, number = 'center'},
  },
  Shop1 = {
    Pos   = {x = 373.875,   y = 325.896,  z = 102.566, number = 1},
  },
  Shop2 = {
    Pos = {x = 2557.458,  y = 382.282,  z = 107.622, number = 2},
  },
  Shop3 = {
    Pos = {x = -3038.939, y = 585.954,  z = 6.908, number = 3},
  },
  Shop4 = {
    Pos = {x = -1487.553, y = -379.107,  z = 39.163, number = 4},
  },
  Shop5 = {
    Pos = {x = 1392.562,  y = 3604.684,  z = 33.980, number = 5},
  },
  Shop6 = {
    Pos = {x = -2968.243, y = 390.910,   z = 14.043, number = 6},
  },
  Shop7 = {
    Pos = {x = 2678.916,  y = 3280.671, z = 54.241, number = 7},
  },
  Shop8 = {
    Pos = {x = -48.519,   y = -1757.514, z = 28.421, number = 8},
  },
  Shop9 = {
    Pos = {x = 1163.373,  y = -323.801,  z = 68.205, number = 9},
  },
  Shop10 = {
    Pos = {x = -707.501,  y = -914.260,  z = 18.215, number = 10},
  },
  Shop11 = {
    Pos = {x = -1820.523, y = 792.518,   z = 137.118, number = 11},
  },
  Shop12 = {
    Pos = {x = 1698.388,  y = 4924.404,  z = 41.063, number = 12},
  },
  Shop13 = {
    Pos = {x = 1961.464,  y = 3740.672, z = 31.343, number = 13},
  },
  Shop14 = {
    Pos = {x = 1135.808,  y = -982.281,  z = 45.415, number = 14},
  },
  Shop15 = {
    Pos = {x = 25.88,   y = -1347.1, z = 28.5, number = 15},
  },
  Shop17 = {
    Pos = {x = 547.431,   y = 2671.710, z = 41.156, number = 17},
  },
  Shop18 = {
    Pos = {x = -3241.927, y = 1001.462, z = 11.830, number = 18},
  },
  Shop19 = {
    Pos = {x = 1166.024,  y = 2708.930,  z = 37.157, number = 19},
  },
  Shop20 = {
    Pos = {x = 1729.216,  y = 6414.131, z = 34.037, number = 20}
  }
}

Config.Zonesx = {

  Shop21 = {
    Pos   = {x = 944.77,   y = 10.38,  z = 74.74, number = 21},
  },
  Shop22 = {
    Pos = {x = -428.14,  y = 5997.11,  z = 30.72, number = 22},
  },
  Shop23 = {
    Pos = {x = 457.47,  y = -981.17,  z = 29.69, number = 23},
  }
}