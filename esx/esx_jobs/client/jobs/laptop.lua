Config.Jobs.stark = { --copyrighted by. Vols and vNo... If u steal this, we will fuck u.
  BlipInfos = {
    Sprite = 521,
    Color = 49
  },
  Zones = {
	
	CloakRoom = {
      Pos   = {x = -403.4, y =6317.6 ,z =28.0 }, 
      Size  = {x = 1.5, y = 1.5, z = 1.0},
      Color = {r = 0, g = 255, b = 255},
      Marker= 1,
      Blip  = true,
      Name  = _U('l_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },
	


    HarvestFruit = {
      Pos   = {x = -289.21, y = 102.44, z = 67.42},  
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 205, g = 0, b = 41},
      Marker= 1,
      Blip  = true,
      Name  = _U('l_harvesl_fruit'),
      Type  = "work",
      Item  = {
        {
          name   = _U('l_harvesl_fruit'),
          db_name= "donanim",
          time   = 1000,
          max    = 100,
          add    = 1,
          remove = 1,
		  requires = "nothing",
          requires_name = "Nothing",
          drop   = 100
        }
      },
      Hint  = _U('l_harvesl_fr')
    },

    Fermentation = {
      Pos   = {x = -303.83, y = 104.65, z = 66.91},  
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 205, g = 0, b = 41},
      Marker= 1,
      Blip  = true,
      Name  = _U('l_fermentation'),
      Type  = "work",
      Item  = {
        {
          name   = _U('l_fermentation'),
          db_name= "kasa",
          time   = 1000,
          max    = 200,
          add    = 2,
          remove = 1,
          requires = "donanim",
          requires_name = _U('l_harvesl_fruit'),
          drop   = 100
        }
      },
      Hint  = _U('l_fermentate_fruit')
    },

    AlcoholPackaging = {
      Pos   = {x = -279.31, y = 105.72, z = 67.68},  
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 205, g = 0, b = 41},
      Marker= 1,
      Blip  = true,
      Name  = _U('l_package'),
      Type  = "work",
      Item  = {
        {
          name   = _U('l_packagealcohol'),
          db_name= "laptopp",
          time   = 1000,
          max    = 100,
          add    = 1,
          remove = 2,
          requires = "kasa",
          requires_name = _U('l_fermentation'),
          drop   = 100
        }
      },
      Hint  = _U('l_unpackaged_fruit')
    },
    Delivery = {
      Pos   = {x = -974.24, y = -1968.62, z = 12.19},  
      Color = {r = 205, g = 0, b = 41},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= 1,
      Blip  = true,
      Name  = _U('l_delivery_point'),
      Type  = "delivery",
      Spawner = 1,
      Item  = {
        {
          name   = _U('delivery'),
          time   = 500,
          remove = 1,
          max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
		  price = math.random(40,50),
          requires = "laptopp",
          requires_name = _U('l_alcohol'),
          drop   = 100
        }
      },
      Hint  = _U('l_deliver')
    }	
  }
}
