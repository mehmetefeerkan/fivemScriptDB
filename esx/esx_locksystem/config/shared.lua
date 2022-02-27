--//EDITED BY ceranim0x#4783


local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

_VERSION = 3.1

globalConf = {
	["SERVER"] = {
		versionChecker = false,			-- Set to false for disable the version checker
		enableGiveKey = false			-- Enable or disable the /givekey chatCommand
	},

	["CLIENT"] = {
		percentage = 100,				-- Percentage chance of finding keys
		notification = 1,				-- 0 = Disable | 1 = LockSystem notification | 2 = chatMessage notification
		key = Keys['L'],				-- e.g : Keys["H"] will be change the U key to the H key for lock/unlock a vehicle
		disableCar_NPC = true,			-- Set to true for disable NPC's car
		lockTimer = 0,					-- Timer between two changes (open/close - in seconds)
	}
}

---- Random messages generated during key recovery.
-- You can add or remove some.
-- Don't forget commas, otherwise you will get an error when running the script
randomMsg =
{
	"Araç kilidini aldın. Kitlemek için tekrar bas.",
	"Araç kilidini aldın. Kitlemek için tekrar bas.",
	"Araç kilidini aldın. Kitlemek için tekrar bas.",
}
