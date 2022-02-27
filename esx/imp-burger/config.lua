KVL = {
    [1] = {
      type = "shipments", -- Buzdolabından alınan itemler kısmı
      coords = vector3(-1203.16, -892.371, 13.995),
      Items = {
        [1] = {
          name = "frozenmeat",
          count = 1
        },
        [2] = {
          name = "frozenbread",
          count = 1
        },
        [3] = {
            name = "dirtymarul",
            count = 1
        },
      }
    },
    [2] = {
      type = "processmeat", -- Buzlanmış eti hazır hale getirme kısmı
      coords = vector3(-1202.33, -896.855, 13.995),
      Items = {
        [1] = {
          name = "burgermeat",
          count = 1
        }
      },
      ReqItems = {
        [1] = {
          name = "frozenmeat",
          count = 1
        }
      }
    },
    [3] = {
        type = "processbread", -- Buzlanmış ekmeği hazır hale getirme kısmı
        coords = vector3(-1198.86, -901.954, 13.995),
        Items = {
          [1] = {
            name = "burgerbread",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "frozenbread",
            count = 1
        }
      }
    },
    [4] = {
        type = "washmarul", -- Marul yıkama kısmı
        coords = vector3(-1196.80, -901.341, 13.995),
        Items = {
          [1] = {
            name = "burgermarul",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "dirtymarul",
            count = 1
        }
      }
    },
    [5] = {
        type = "cooking", -- Hazırlama kısmı
        coords = vector3(-1197.65, -897.421, 13.995),
        Items = {
          [1] = {
            name = "khamburger",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "burgermeat",
            count = 1
          },
          [2] = {
            name = "burgerbread",
            count = 1
          },
          [3] = {
            name = "burgermarul",
            count = 1
          }
        }
      },
  }


Config = {}

Config.NPCEnable = true -- npc olup olmayacagı
Config.NPCHash = 68070371 -- npc hash kodu
Config.NPCDealer = { x = -467.281, y = -679.481, z = 31.710, h = 344.06 }
Config.NPCText = { x = -467.281, y = -679.481, z = 33.710 }

Config.Price = 100
Config.Item = 'khamburger'