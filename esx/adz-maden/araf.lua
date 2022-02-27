araf = {}

araf.Locale = 'tr'

araf.useSkillBar = true -- If you want to use skill bar, make it true. If it is true, araf.useProgbar have to be false.
araf.useProgbar = false -- If you want to use progress bar, make it true. If it is true, araf.useSkillBar have to be false.

araf.isMarkerOn = false
araf.markerSize = {x = 1.0, y = 1.0, z = 1.0}
araf.markerColour = {r = 0, g = 0, b = 255, a = 100}

araf.heating = vector3(1087.85, -2001.65, 30.88) -- Coordinates of iron heating place.
araf.wroughting = vector3(1109.58, -2007.79, 31.04) -- Coordinates of iron wroughting place.
araf.mining = { -- Coordinates of mining place.
    vector3(-591.51, 2076.02, 131.54),
    vector3(-592.51, 2079.16, 131.58),
    vector3(-591.02, 2072.97, 131.28)
}
--[[
araf.blips = {
    {coords = vector3(-592.23, 2079.13, 131.42), title = 'Maden Yatagi'},
    {coords = vector3( 1088.24, -2001.83, 30.88), title = 'Maden İsleme'},
}
--]]

araf.sleep = 2000 -- Sleep time.

araf.iron = 'iron' -- Iron item's name, you can change it for your database.
araf.heatedIron = 'heated_iron' -- Heated iron item's name, you can change it for your database.
araf.giveItemCount = 1 -- Amount of item to be given each time

araf.requiredItemCount = 2 -- Item count required for all steps.

araf.highChanceItems = { -- These are items what people will get if they are lucky.
    'silver',
    'gold',
    'copper',
}

araf.lowChanceItems = { -- These are items what people will get if they are unlucky.
    'silver',
    'gold',
    'copper'
}
