araf = {}

araf.Locale = 'tr'

araf.useSkillBar = true -- If you want to use skill bar, make it true. If it is true, araf.useProgbar have to be false.
araf.useProgbar = false -- If you want to use progress bar, make it true. If it is true, araf.useSkillBar have to be false.

araf.isMarkerOn = false
araf.markerSize = {x = 0.6, y = 0.6, z = 0.6}
araf.markerColour = {r = 255, g = 156, b = 0, a = 100}

araf.heating = vector3(1273.46, -1719.90, 54.77) -- Coordinates of iron heating place.
araf.wroughting = vector3(1137.552, -470.99, 66.65) -- Coordinates of iron wroughting place.
araf.mining = { -- Coordinates of mining place.
    vector3(1272.01, -1711.67, 54.77),
    vector3(1275.218, -1710.58, 54.75)
}
--[[
araf.blips = {
    {coords = vector3(-592.23, 2079.13, 131.42), title = 'Maden Yatagi'},
    {coords = vector3( 1088.24, -2001.83, 30.88), title = 'Maden İsleme'},
}
--]]

araf.sleep = 2000 -- Sleep time.

araf.iron = 'pc1' -- Iron item's name, you can change it for your database.
araf.heatedIron = 'pc2' -- Heated iron item's name, you can change it for your database.
araf.giveItemCount = 1 -- Amount of item to be given each time

araf.requiredItemCount = 2 -- Item count required for all steps.

araf.highChanceItems = { -- These are items what people will get if they are lucky.
    'battery',
    'battery'
}

araf.lowChanceItems = { -- These are items what people will get if they are unlucky.
    'anakart',
    'sata',
    'pci',
    'ekrankarti'
}
