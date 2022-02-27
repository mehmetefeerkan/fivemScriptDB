
KVL = {
    [1] = {
      type = "collecting",
      coords = vector3(707.0196, -960.233, 30.395),
      --Items = {
      --  [1] = {
      --    name = "yun",
      --    count = 1
      --  },
      --}
    },
    [2] = {
      type = "processing", -- Yün İşleme Kısmı
      coords = vector3(712.4254, -959.450, 30.395),
      --Items = {
      --  [1] = {
      --    name = "islenmis_yun",
      --    count = 1
      --  }
      --},
      --ReqItems = {
       -- [1] = {
       --   name = "yun",
       --   count = 2
        --}
      --}
    },
    [3] = {
      type = "fabric", -- Kumaş Üretme
      coords = vector3(707.0533, -966.899, 30.412),
    },
    [4] = {
        type = "gomlekdikme", -- Gömlek Dikme
        coords = vector3(713.2622, -972.247, 30.395),
       -- Items = {
        --  [1] = {
        --    name = "gomlek",
        --    count = 1
        --  }
       -- },
        --ReqItems = {
        --  [1] = {
        --    name = "gomlek_kumasi",
        --    count = 1
       -- }
      --}
    },
    [5] = {
        type = "tshirtdikme", -- Tshirt Dikme
        coords = vector3(716.4606, -961.597, 30.395),
        --Items = {
        --  [1] = {
        --    name = "tshirt",
        --    count = 1
        --  }
       -- },
        --ReqItems = {
        --  [1] = {
        --    name = "tshirt_kumasi",
        --    count = 1
        --  }
      --},
    },
    [6] = {
      type = "pantolondikme", -- Pantolon Dikme
      coords = vector3(713.2764, -967.849, 30.395),
      --Items = {
      --  [1] = {
      --    name = "pantolon",
     --     count = 1
     --   }
     -- },
     -- ReqItems = {
      --  [1] = {
      --    name = "pantolon_kumasi",
      --    count = 1
      --}
    --}
  },
}

Config = {}

Config.NPCEnable = true -- npc olup olmayacagı
Config.NPCHash = 68070371 -- npc hash kodu
Config.NPCDealer = { x = 719.0637, y = -992.150, z = 22.949, h = 344.06 }
Config.NPCText = { x = 719.0637, y = -992.150, z = 24.849 }