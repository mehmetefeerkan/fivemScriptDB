Config = {}
Config.Locale = 'en'

Config.Price = 10

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 2.2, y = 2.2, z = 0.8}
Config.MarkerColor  = {r = 255, g = 128, b = 0}
Config.MarkerType   = 23

Config.Zones = {}

Config.Shops = {
  {x=72.254,    y=-1399.102, z=28.476},
  {x=-703.776,  y=-152.258,  z=36.515},
  {x=-167.863,  y=-298.969,  z=38.763},
  {x=428.694,   y=-800.106,  z=28.591},
  {x=-829.413,  y=-1073.710, z=10.428},
  {x=-1447.797, y=-242.461,  z=48.920},
  {x=11.632,    y=6514.224,  z=30.977},
  {x=123.646,   y=-219.440,  z=53.657},
  {x=1696.291,  y=4829.312,  z=41.163},
  {x=618.093,   y=2759.629,  z=41.188},
  {x=1190.550,  y=2713.441,  z=37.322},
  {x=-1193.429, y=-772.262,  z=16.424},
  {x=-3172.496, y=1048.133,  z=19.963},
  {x=-1108.441, y=2708.923,  z=18.207},
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
