Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.cartelStations = {

  cartel = {

  Blip = {
      --Pos     = { x = 19.86, y = 535.45, z = 174.63 },
      --Sprite  = 181,
      --Display = 4,
      --Scale   = 1.2,
      --Colour  = 1,
    },

    AuthorizedWeapons = {
	  { name = 'WEAPON_PISTOL',	  price = 500000 },
	  { name = 'WEAPON_COMBATPISTOL',	  price = 1250000 },
	  { name = 'WEAPON_MICROSMG',	  price = 2500000 },
	  { name = 'WEAPON_ASSAULTRIFLE',	  price = 5000000 },
	  { name = 'WEAPON_KNIFE',	  price = 125000 },
	  { name = 'WEAPON_FLASHLIGHT',       price = 50000 },
 --     { name = 'WEAPON_ASSAULTSMG',       price = 1 },
 --     { name = 'WEAPON_ASSAULTRIFLE',     price = 1 },
 --     { name = 'WEAPON_PUMPSHOTGUN',      price = 1 },
 --     { name = 'WEAPON_STUNGUN',          price = 1 },
 --     { name = 'WEAPON_FIREEXTINGUISHER', price = 1 },
 --     { name = 'WEAPON_FLAREGUN',         price = 3000 },
 --     { name = 'GADGET_PARACHUTE',        price = 2000 },
 --     { name = 'WEAPON_SNIPERRIFLE',      price = 50000 },
 --     { name = 'WEAPON_FIREWORK',         price = 5000 },
 --     { name = 'WEAPON_BZGAS',            price = 8000 },
 --     { name = 'WEAPON_SMOKEGRENADE',     price = 8000 },
 --     { name = 'WEAPON_APPISTOL',         price = 12000 },
 --     { name = 'WEAPON_CARBINERIFLE',     price = 25000 },
 --     { name = 'WEAPON_HEAVYSNIPER',      price = 100000 },
 --     { name = 'WEAPON_FLARE',            price = 8000 },
 --     { name = 'WEAPON_SWITCHBLADE',      price = 500 },
 --	  { name = 'WEAPON_REVOLVER',         price = 6000 },
 --	  { name = 'WEAPON_POOLCUE',          price = 100 },
 --	  { name = 'WEAPON_GUSENBERG',        price = 17500 },
	  
    },

	  AuthorizedVehicles = {
		--  { name = 'schafter3',  label = 'Sivil Araç' },
		 -- { name = 'btype',      label = 'Roosevelt' },
		--  { name = 'sandking',   label = '4X4' },
		 -- { name = 'guardian',   label = 'Grand 4x4' },
		 -- { name = 'burrito3',   label = 'Fourgonnette' },
		 -- { name = 'mesa',       label = 'Tout-Terrain' },
	  },


    Cloakrooms = {
      { x = -2601.69, y = 1895.79, z = 162.75 },
    },

    Armories = {
      { x = -2603.65, y = 1915.59, z = 162.46 },
    },

    Vehicles = {
     -- {
        --Spawner    = { x = 13.40, y = 549.1, z = 175.187 },
       -- SpawnPoint = { x = 8.237, y = 556.963, z = 175.266 },
       -- Heading    = 90.0,
     -- }
    },
	
	Helicopters = {
  --[[    {
        Spawner    = { x = 20.312, y = 535.667, z = 173.627 },
        SpawnPoint = { x = 3.40, y = 525.56, z = 177.919 },
        Heading    = 0.0,
      }--]]
    },

    VehicleDeleters = {
    --  { x = 22.74, y = 545.9, z = 175.027 },
    --  { x = 21.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
  --    { x = 4.113, y = 526.897, z = 173.628 }
    },

  },

}
