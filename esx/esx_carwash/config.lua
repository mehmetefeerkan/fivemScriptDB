Config = {}



-- Possible languages: 'en'
Config.Locale = 'en'



-- Blip related settings.
Config.ShowBlips = true     -- Show blips? ( true | false )
Config.BlipColor = 4        -- Blip color. ( https://wiki.rage.mp/index.php?title=Blips#Blip_colors )
Config.BlipDisplay = 2      -- Blip display (0 = Don't show, 2 = On main and minimap, 3 = Main map only, 5 = Minimap only)
Config.BlipScale = 0.7      -- Blip scale. Recommended: 1.0 - 0.5
Config.BlipSprite = 100     -- Blip type. ( https://wiki.rage.mp/index.php?title=Blips#Blip_model )



-- Marker related settings.
Config.ShowMarkers = true   -- Show markers? ( true | false )
Config.DrawDistance = 50    -- How close you have to be for the markers to appear.
Config.MarkerType = 1       -- Marker type. ( https://wiki.rage.mp/index.php?title=Markers )
Config.MarkerColor = { r = 255, g = 255, b = 255, a = 35 }  -- Marker color. Red, green, blue and alpha (transparency - 0 to 100).



-- Price multiplied by dirt level. There's 16 dirt levels, from 0 to 15. Price 4 means completely dirty car costs $60 to clean.
Config.Price = 4



-- Specify how long it takes to clean the vehicle in seconds. Set to 0 for instant clean.
Config.Timer = 5



-- Locations. "extents" specifies the radius of it, useful for smaller carwashes.
Config.Locations = {
    cw1 = { -- Innocence Blvd, Strawberry
        location = { x = 26.58, y = -1391.88, z = 28.37 },
        extents  = 6.0
    },
    cw2 = { -- Carson Ave, Davis
        location = { x = 169.35, y = -1716.72, z = 28.30 },
        extents  = 6.0
    },
    cw3 = { -- Lindsay Circus, Little Seoul
        location = { x = -699.78, y = -933.04, z = 18.02 },
        extents  = 6.0
    },
    cw4 = { -- Algonquin Blvd, Sandy Shores
        location = { x = 1361.88, y = 3592.44, z = 33.95 },
        extents  = 6.0
    }
}