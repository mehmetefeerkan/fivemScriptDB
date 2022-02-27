Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

Config.CarModelName = 'kalahari'
Config.DepositPrice = 2
Config.Payout = 3

Config.Locations = {
    ['main'] = {
        label = '[Fruit Picker] Shed',
        coords = {x = 416.27, y = 6520.77, z = 27.72, h = 261.93},
    },
    ['cardeposit'] = {
        label = '[Fruit Picker] Garage',
        coords = {x = 408.1, y = 6494.77, z = 28.03, h = 170.13},
    },
    ['transformfruit'] = {
        label = '[Fruit Picker] Fruit Wash',
        coords = {x = 94.03, y = 6355.89, z = 31.38, h = 24.55},
    },
    ['sellfruit'] = {
        label = '[Fruit Picker] Store',
        coords = {x = -2173.82, y = 4282.12, z = 49.12, h = 240.82},
    },
    ['carspawnpoint'] = {
        coords = {x = 408.66, y = 6491.04, z = 28.16, h = 82.98},
    },
}

Config.OrangeSpots = {
	{ x = 355.23, y = 6504.32, z = 28.47, taked = false, blip},
	{ x = 347.93, y = 6504.91, z = 28.8, taked = false, blip},
	{ x = 363.31, y = 6505.33, z = 28.54, taked = false, blip},
	{ x = 370.1, y = 6505.51, z = 28.42, taked = false, blip},
}

Config.AppleSpots = {
	{ x = 273.61, y = 6506.77, z = 30.41, taked = false, blip},
	{ x = 263.99, y = 6505.59, z = 30.68, taked = false, blip},
	{ x = 256.21, y = 6503.45, z = 30.87, taked = false, blip},
	{ x = 246.77, y = 6502.49, z = 31.05, taked = false, blip},
}

Config.StrawberrySpots = {
	{ x = 283.28, y = 6481.79, z = 30.05, taked = false, blip},
	{ x = 273.95, y = 6481.06, z = 30.32, taked = false, blip},
	{ x = 259.04, y = 6479.87, z = 30.65, taked = false, blip},
	{ x = 238.66, y = 6478.22, z = 31.02, taked = false, blip},
}

Config.Clothes = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 158,   ['torso_2'] = 0,
        ['arms'] = 67,
        ['pants_1'] = 70,   ['pants_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 4,   ['torso_2'] = 14,
        ['arms'] = 4,
        ['pants_1'] = 25,   ['pants_2'] = 1,
        ['shoes_1'] = 16,   ['shoes_2'] = 4,
    }
}