Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors 
	{
		textCoords = vector3(434.4144, -981.8556, 30.6953),    
		authorizedJobs = {'police'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 270.0,
				objCoords = vector3(434.7444, -980.7556, 30.8153)
			},
			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 90.0,
				objCoords = vector3(434.7444,-983.0781,30.8153)
		   }
		}
},
{
	textCoords = vector3(489.1202, -1020.05, 28.212),    
	authorizedJobs = {'police'},
	locked = true,
	distance = 9.8,
	doors = {
		{
			objName = "hei_prop_station_gate",
			objYaw = -270.0,
			objCoords = vector3(488.9350, -1017.80, 28.211)
		}
	}
},
{
   textCoords = vector3(457.00, -972.28, 30.7153),
   authorizedJobs = {'police'},
   locked = true,
   distance = 2,
   doors = {
	   {
		   objName = "gabz_mrpd_reception_entrancedoor",
		   objYaw = 180.0,
		   objCoords = vector3(455.8862, -972.2543, 30.81531)
	   },
	   {
		   objName = "gabz_mrpd_reception_entrancedoor",
		   objYaw = 360.0,
		   objCoords = vector3(455.2087, -972.2543, 30.81531)
	  }
   }
},
{
   textCoords = vector3(441.8, -998.73, 30.7353),
   authorizedJobs = {'police'},
   locked = true,
   distance = 2,
   doors = {
	   {
		   objName = "gabz_mrpd_reception_entrancedoor",
		   objYaw = 360.0,
		   objCoords = vector3(440.7392, -998.7462, 30.8153)
	   },
	   {
		   objName = "gabz_mrpd_reception_entrancedoor",
		   objYaw = 180.0,
		   objCoords = vector3(443.0618,-998.7462,30.8153)
	  }
   }
},
{
textCoords = vector3(469.43, -986.26, 30.79),
authorizedJobs = {'police'},
locked = true,
distance = 2,
doors = {
   {
	   objName = "gabz_mrpd_door_01",
	   objYaw = 270.0,
	   objCoords = vector3(469.4406, -985.0313, 30.82319)
   },
   {
	   objName = "gabz_mrpd_door_01",
	   objYaw = 90.0,
	   objCoords = vector3(469.4406,-987.4377,30.82319)
  }
}
},
{
textCoords = vector3(468.37, -1014.21, 26.42),
authorizedJobs = {'police'},
locked = true,
distance = 2,
doors = {
   {
	   objName = "gabz_mrpd_door_03",
	   objYaw = 180.0,
	   objCoords = vector3(469.7743, -1014.406, 26.48697)
   },
   {
	   objName = "gabz_mrpd_door_03",
	   objYaw = 360.0,
	   objCoords = vector3(467.3686,-1014.406,26.48697)
  }
}
},
{    --walker gunshop
	textCoords = vector3(17.3284, -1115.0, 29.7970),
	authorizedJobs = {'walker'},
	locked = true,
	distance = 2,
	doors = {
	   {
		   objName = "v_ilev_gc_door04",
		   objYaw = 160.0,
		   objCoords = vector3(17.3284, -1115.0, 29.7970)
	   },
	   {
		objName = "v_ilev_gc_door03",
		objYaw = -20.0,
		objCoords = vector3(17.3284, -1115.0, 29.7970)
	}
	}
	},
{
textCoords = vector3(-443.5, 6016.3, 32.0),
authorizedJobs = { 'police', 'sheriff' },
locked = false,
distance = 2.5,
doors = {
   {
	   objName = 'v_ilev_shrf2door',
	   objYaw = -45.0,
	   objCoords  = vector3(-443.1, 6015.6, 31.7),
   },

   {
	   objName = 'v_ilev_shrf2door',
	   objYaw = 135.0,
	   objCoords  = vector3(-443.9, 6016.6, 31.7)
   }
}
},

{
textCoords = vector3(471.34, -1009.17, 26.37),
authorizedJobs = {'police'},
locked = true,
distance = 2,
doors = {
   {
	   objName = "gabz_mrpd_door_02",
	   objYaw = 270.0,
	   objCoords = vector3(471.3679, -1007.793, 26.40548)
   },
   {
	   objName = "gabz_mrpd_door_02",
	   objYaw = 90.0,
	   objCoords = vector3(471.3758,-1010.198,26.40548)
  }
}
},
{
   objName = 'gabz_mrpd_door_04',
   objYaw = 360.0,
   objCoords  = vector3(440.5201, -977.6011, 30.82),
   textCoords = vector3(441.6701, -977.6011, 30.69), 
   authorizedJobs = { 'police' },
   locked = true
},
{
   objName = 'gabz_mrpd_door_05',
   objYaw = 180.0,
   objCoords  = vector3(440.5201, -986.2335, 30.82319),
   textCoords = vector3(441.64, -985.96, 30.69), 
   authorizedJobs = { 'police' },
   locked = true
},
{
   objName = 'gabz_mrpd_door_05',
   objYaw = 270.0,
   objCoords  = vector3(458.6543, -990.6498, 30.82),
   textCoords = vector3(458.79, -989.36, 30.69), 
   authorizedJobs = { 'police' },
   locked = true
},
{
   objName = 'gabz_mrpd_cells_door',
   objYaw = 270.0,
   objCoords  = vector3(476.6157, -1008.875, 26.48005),
   textCoords = vector3(476.76, -1008.24, 26.27), 
   authorizedJobs = { 'police' },
   locked = true
},
{--23
   objName = 'gabz_mrpd_cells_door',
   objYaw = 0.0,
   objCoords  = vector3(477.9126, -1012.189, 26.48005),
   textCoords = vector3(477.9126, -1012.189, 26.48005), 
   authorizedJobs = { 'police' },
   locked = true
},--22
   {
   objName = 'gabz_mrpd_cells_door',
   objYaw = 0.0,
   objCoords  = vector3(480.9128, -1012.189, 26.48005),
   textCoords = vector3(480.9128, -1012.189, 26.48005), 
   authorizedJobs = { 'police' },
   locked = true
},--21
{
   objName = 'gabz_mrpd_cells_door',
   objYaw = 0.0,
   objCoords  = vector3(483.9127, -1012.189, 26.48005),
   textCoords = vector3(483.9127, -1012.189, 26.48005), 
   authorizedJobs = { 'police' },
   locked = true
},-- 20
{
   objName = 'gabz_mrpd_cells_door',
   objYaw = 0.0,
   objCoords  = vector3(486.9131, -1012.189, 26.480005),
   textCoords = vector3(486.9131, -1012.189, 26.480005), 
   authorizedJobs = { 'police' },
   locked = true
},-- 19
{
   objName = 'gabz_mrpd_cells_door',
   objYaw = 180.0,
   objCoords  = vector3(484.1764, -1007.734, 26.480005),
   textCoords = vector3(484.1764, -1007.734, 26.480005), 
   authorizedJobs = { 'police' },
   locked = true
}, -- 18
{
   objName = 'gabz_mrpd_cells_door',
   objYaw = 180.0,
   objCoords  = vector3(481.0084, -1004.118, 26.480005),
   textCoords = vector3(481.0084, -1004.118, 26.480005), 
   authorizedJobs = { 'police' },
   locked = true
}, -- 14
{
   objName = 'gabz_mrpd_door_04',
   objYaw = 270.0,
   objCoords  = vector3(482.6703, -995.7285, 26.40548),
   textCoords = vector3(482.6703, -995.7285, 26.40548), 
   authorizedJobs = { 'police' },
   locked = true
}, -- 13
{
   objName = 'gabz_mrpd_door_04',
   objYaw = 270.0,
   objCoords  = vector3(482.6699, -992.2991, 26.40548),
   textCoords = vector3(482.6699, -992.2991, 26.40548), 
   authorizedJobs = { 'police' },
   locked = true
}, -- 12
{
   objName = 'gabz_mrpd_door_04',
   objYaw = 270.0,
   objCoords  = vector3(482.67010, -987.5792, 26.40548),
   textCoords = vector3(482.67010, -987.5792, 26.40548), 
   authorizedJobs = { 'police' },
   locked = true
}, -- 11
{
   objName = 'gabz_mrpd_door_04',
   objYaw = 270.0,
   objCoords  = vector3(482.66940, -983.9868, 26.40548),
   textCoords = vector3(482.66940, -983.9868, 26.40548), 
   authorizedJobs = { 'police' },
   locked = true
},-- 9
{
   objName = 'gabz_mrpd_door_03',
   objYaw = 133.0,
   objCoords  = vector3(475.8323, -990.4839, 26.40548),
   textCoords = vector3(475.8323, -990.4839, 26.40548), 
   authorizedJobs = { 'police' },
   locked = true
}, -- 3
{
   objName = 'gabz_mrpd_room13_parkingdoor',
   objYaw = 270.0,
   objCoords  = vector3(464.1591, -974.6656, 26.3707),
   textCoords = vector3(464.1591, -974.6656, 26.3707), 
   authorizedJobs = { 'police' },
   locked = true
}, -- 4
{
   objName = 'gabz_mrpd_room13_parkingdoor',
   objYaw = 90.0,
   objCoords  = vector3(464.1566, -997.5093, 26.3707),
   textCoords = vector3(464.1566, -997.5093, 26.3707), 
   authorizedJobs = { 'police' },
   locked = true
},
{
   objName = 'v_ilev_gc_door01',
   objYaw = -45.0,
   objCoords  = vector3(-451.4, 6006.8, 31.72),
   textCoords = vector3(-451.4, 6006.6, 32.22),
   authorizedJobs = { 'police', 'sheriff' },
   locked = true
},
{
   objName = 'v_ilev_gc_door01',
   objYaw = -225.0,
   objCoords  = vector3(-446.75, 6001.95, 31.22),
   textCoords = vector3(-446.75, 6001.75, 32.22),
   authorizedJobs = { 'police', 'sheriff' },
   locked = true
},
{
   objName = 'v_ilev_ph_cellgate',
   objYaw = -45.0,
   objCoords  = vector3(-428.6, 5997.17, 31.72),
   textCoords = vector3(-428.6, 5997.17, 32.22),
   authorizedJobs = { 'sheriff' },
   locked = true
},
{
   objName = 'v_ilev_ph_cellgate',
   objYaw = -45.0,
   objCoords  = vector3(-432.75, 5992.6, 31.72),
   textCoords = vector3(-432.75, 5992.6, 32.22),
   authorizedJobs = { 'police', 'sheriff' },
   locked = true
},

{
   objName = 'v_ilev_ph_cellgate',
   objYaw = -45.0,
   objCoords  = vector3(-431.75, 6000.17, 31.72),
   textCoords = vector3(-431.75, 6000.17, 32.22),
   authorizedJobs = { 'police', 'sheriff' },
   locked = true
},
{
   objName = 'v_ilev_cd_entrydoor',
   objYaw = 10.0,
   objCoords  = vector3(-453.75, 6011.35, 31.72),
   textCoords = vector3(-453.75, 6011.35, 32.22),
   authorizedJobs = { 'police', 'sheriff' },
   locked = true
},

	--
	-- SHERIFF DEPARTMENT
	--

	-- Entrance (double doors)
	-- {
	-- 	textCoords = vector3(-443.5, 6016.3, 32.0),
	-- 	authorizedJobs = { 'police', 'sheriff' },
	-- 	locked = false,
	-- 	distance = 2.5,
	-- 	doors = {
	-- 		{
	-- 			objName = 'v_ilev_shrf2door',
	-- 			objYaw = -45.0,
	-- 			objCoords  = vector3(-443.1, 6015.6, 31.7),
	-- 		},

	-- 		{
	-- 			objName = 'v_ilev_shrf2door',
	-- 			objYaw = 135.0,
	-- 			objCoords  = vector3(-443.9, 6016.6, 31.7)
	-- 		}
	-- 	}
	-- },
	
	
	
	-- {
	-- 	objName = 'v_ilev_fingate',
	-- 	objYaw = -45.0,
	-- 	objCoords  = vector3(-437, 5992.2, 31.72),
	-- 	textCoords = vector3(-437, 5992.2, 32.22),
	-- 	authorizedJobs = { 'police', 'sheriff' },
	-- 	locked = true
	-- },
	


	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	-- {
	-- 	objName = 'prop_gate_prison_01',
	-- 	objCoords  = vector3(1844.9, 2604.8, 44.6),
	-- 	textCoords = vector3(1844.9, 2608.5, 48.0),
	-- 	authorizedJobs = { 'police', 'sheriff' },
	-- 	locked = true,
	-- 	distance = 12,
	-- 	size = 2
	-- },

	-- {
	-- 	objName = 'prop_gate_prison_01',
	-- 	objCoords  = vector3(1818.5, 2604.8, 44.6),
	-- 	textCoords = vector3(1818.5, 2608.4, 48.0),
	-- 	authorizedJobs = { 'police', 'sheriff' },
	-- 	locked = true,
	-- 	distance = 12,
	-- 	size = 2
	-- },
	

	-- HAPISHANE
	{
		textCoords = vector3(1841.63, 2593.28, 45.9),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 3,
		doors = {
			{
				objYaw = -90.0,
				objName = "v_ilev_gtdoor",
				objCoords = vector3(1841.63, 2593.28, 45.9)
			},
		}
	},
	
	{
		textCoords = vector3(1767.42, 2593.18, 49.71),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'v_ilev_gtdoor',
				objYaw = -90.0,
				objCoords  = vector3(1767.42, 2593.18, 49.71)
			},
		}
	},
	{
		textCoords = vector3(1776.14,2588.42, 49.71),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "v_ilev_gtdoor",
				objYaw = 180.0,
				objCoords = vector3(1776.14,2588.42, 49.71)
			},
		}
	},
	{
		textCoords = vector3(1785.94,2600.25, 45.85),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "v_ilev_gtdoor",
				objYaw = 180.0,
				objCoords = vector3(1785.94,2600.25, 45.85)
			},
		}
	},
	{
		textCoords = vector3(1782.75,2598.58, 45.72),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "v_ilev_gtdoor",
				objYaw = -90.0,
				objCoords = vector3(1782.75,2598.58, 45.72)
			},
		}
	},

	{
		textCoords = vector3(1780.35,2597.18, 45.72),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "bobo_prison_isolated_gate",
				objYaw = 0,
				objCoords = vector3(1780.35,2597.18, 45.72)
			},
		}
	},
	{
		textCoords = vector3(1777.52,2597.15, 45.72),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "bobo_prison_isolated_gate",
				objYaw = 0,
				objCoords = vector3(1777.52,2597.15, 45.72)
			},
		}
	},
	{
		textCoords = vector3(1774.57,2597.13, 45.72),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "bobo_prison_isolated_gate",
				objYaw = 0,
				objCoords = vector3(1774.57,2597.13, 45.72)
			},
		}
	},
	{
		textCoords = vector3(1772.69,2598.11, 45.72),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "bobo_prison_isolated_gate",
				objYaw = -90.0,
				objCoords = vector3(1772.69,2598.11, 45.72)
			},
		}
	},
	{
		textCoords = vector3(1838.65,2588.23, 45.89),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "bobo_prison_cellgate",
				objYaw = 0,
				objCoords = vector3(1838.65,2588.23, 45.89)
			},
		}
	},
	{
		textCoords = vector3(1836.64,2593.51, 45.89),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "bobo_prison_cellgate",
				objYaw = 90.0,
				objCoords = vector3(1836.64,2593.51, 45.89)
			},
		}
	},
	{
		textCoords = vector3(1831.61,2593.58, 45.89),
		authorizedJobs = {'police','sheriff'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = "bobo_prison_cellgate",
				objYaw = 90.0,
				objCoords = vector3(1831.61,2593.58, 45.89)
			},
		}
	},	
	
	{
		textCoords = vector3(-2332.23, 3408.86, 30.67),
		authorizedJobs = {'uscg'},
		locked = true,
		distance = 12,
		doors = {
			{
				objName = "prop_gate_prison_01",
				objYaw = -131.0,
				objCoords = vector3(-2329.76, 3411.18, 30.21)
			},
		}
	},		

	{
		textCoords = vector3(-1561.84, 2766.01, 17.56),
		authorizedJobs = {'uscg'},
		locked = true,
		distance = 12,
		doors = {
			{
				objName = "prop_gate_prison_01",
				objYaw = 45.0,
				objCoords = vector3(-1564.34, 2763.58, 17.56)
			},
		}
	},	

	-- ZOOM CLUB BAR --
	
	

	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(420.1, -1017.3, 28.0),
		textCoords = vector3(420.1, -1021.0, 32.0),
		authorizedJobs = { 'police', 'sheriff' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}
