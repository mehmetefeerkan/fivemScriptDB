Config.Jobs.ballas4 = { --copyrighted by. Vols and vNo... If u steal this, we will fuck u.
  BlipInfos = {
    Sprite = 93,
    Color = 49
  },
  Zones = {
	
	CloakRoom = {
      Pos   = {x = -556.3019580078, y = 275.5691845703, z = 82.08551197052},
      Size  = {x = 1.5, y = 1.5, z = 1.0},
      Color = {r = 0, g = 255, b = 255},
      Marker= 1,
      Blip  = true,
      Name  = _U('t_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },
	


    HarvestFruit = {
      Pos   = {x = -1917.0319580078, y = 1961.7891845703, z = 149.08551197052},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 205, g = 0, b = 41},
      Marker= 1,
      Blip  = true,
      Name  = _U('t_harvest_fruit'),
      Type  = "work",
      Item  = {
        {
          name   = _U('t_harvest_fruit'),
          db_name= "harvestfruit",
          time   = 1000,
          max    = 100,
          add    = 1,
          remove = 1,
		  requires = "nothing",
          requires_name = "Nothing",
          drop   = 100
        }
      },
      Hint  = _U('t_harvest_fr')
    },

    Fermentation = {
      Pos   = {x = -1912.51319580078, y = 2085.7891845703, z = 139.08551197052},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 205, g = 0, b = 41},
      Marker= 1,
      Blip  = true,
      Name  = _U('t_fermentation'),
      Type  = "work",
      Item  = {
        {
          name   = _U('t_fermentation'),
          db_name= "fermentation",
          time   = 1000,
          max    = 200,
          add    = 2,
          remove = 1,
          requires = "harvestfruit",
          requires_name = _U('t_harvest_fruit'),
          drop   = 100
        }
      },
      Hint  = _U('t_fermentate_fruit')
    },

    AlcoholPackaging = {
      Pos   = {x = -1925.1319580078, y = 2041.7891845703, z = 139.58551197052},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 205, g = 0, b = 41},
      Marker= 1,
      Blip  = true,
      Name  = _U('t_package'),
      Type  = "work",
      Item  = {
        {
          name   = _U('t_packagealcohol'),
          db_name= "alcohol",
          time   = 1000,
          max    = 100,
          add    = 1,
          remove = 2,
          requires = "fermentation",
          requires_name = _U('t_fermentation'),
          drop   = 100
        }
      },
      Hint  = _U('t_unpackaged_fruit')
    },
    Delivery = {
      Pos   = {x = -562.1319580078, y = 286.7891845703, z = 85.08551197052},
      Color = {r = 205, g = 0, b = 41},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= 1,
      Blip  = true,
      Name  = _U('t_delivery_point'),
      Type  = "delivery",
      Spawner = 1,
      Item  = {
        {
          name   = _U('delivery'),
          time   = 500,
          remove = 1,
          max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
		  price = math.random(44,46),
          requires = "alcohol",
          requires_name = _U('t_alcohol'),
          drop   = 100
        }
      },
      Hint  = _U('t_deliver')
    }	
  }
}
