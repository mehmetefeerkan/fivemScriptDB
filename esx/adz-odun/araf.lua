araf = {}

araf.Locale = 'tr'

araf.useSkillBar = true -- If you want to use skill bar, make it true. If it is true, araf.useProgbar have to be false.
araf.useProgbar = false -- If you want to use progress bar, make it true. If it is true, araf.useSkillBar have to be false.

araf.isMarkerOn = false
araf.markerSize = {x = 0.6, y = 0.6, z = 0.6}
araf.markerColour = {r = 255, g = 156, b = 0, a = 100}

araf.heating = vector3(-588.76, 5348.83, 70.28) -- Coordinates of iron heating place.
araf.wroughting = vector3(-590.95, 5342.05, 70.23) -- Coordinates of iron wroughting place.
araf.mining = { -- Coordinates of mining place.
    vector3(-553.1701, 5372.49, 70.35),
    vector3(-554.38, 5368.915, 70.36),
    vector3(-551.93, 5445.47, 64.03),
    vector3(-579.56, 5426.15, 58.53)
}
--[[
araf.blips = {
    {coords = vector3(-592.23, 2079.13, 131.42), title = 'Maden Yatagi'},
    {coords = vector3( 1088.24, -2001.83, 30.88), title = 'Maden İsleme'},
}
--]]

araf.sleep = 2000 -- Sleep time.

araf.iron = 'wood' -- Iron item's name, you can change it for your database.
araf.heatedIron = 'wood2' -- Heated iron item's name, you can change it for your database.
araf.giveItemCount = 1 -- Amount of item to be given each time

araf.requiredItemCount = 2 -- Item count required for all steps.

araf.highChanceItems = { -- These are items what people will get if they are lucky.
    'wood3',
    'wood3',
    'wood3',
    'wood3',
    'wood3'
}

araf.lowChanceItems = { -- These are items what people will get if they are unlucky.
    'wood3',
    'wood3',
    'wood3'
}
