
KVL = {
    [1] = {
      type = "collecting",
      coords = vector3(1397.604, 3602.677, 38.93),
      --Items = {
      --  [1] = {
      --    name = "yun",
      --    count = 1
      --  },
      --}
    },
    [2] = {
      type = "processing", -- Yün İşleme Kısmı
      coords = vector3(1394.611, 3601.83, 38.93),
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
      coords = vector3(1389.7053, 3608.899, 38.412),
    },
    [4] = {
        type = "gomlekdikme", -- Gömlek Dikme
        coords = vector3(1392.0622, 3606.247, 38.395),
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
        coords = vector3(1388.8306, 3605.597, 38.395),
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
      coords = vector3(1389.85, 3603.244, 38.935),
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
Config.NPCDealer = { x = 0.0, y = 0.0, z = 0.00, h = 344.06 }
Config.NPCText = { x = 0.0, y = 0.0, z = 0.0 }