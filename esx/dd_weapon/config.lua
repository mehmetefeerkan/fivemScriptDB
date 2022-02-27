Config = {}

Config.noAttackWhenArmed = true
Config.DisabledBlindfire = true
Config.DontFuckingJumpAndJump = true
Config.DisabledDriveBy = true
Config.AllowCriticalOneHit = true

Config.AmmoBoxes = {
	Pistol = 250, -- 9mm @ 0.28 per round | 50 x 1.05 = 14
	SMG = 250, -- 9mm @ 0.28 per round | 50 x 1.05 = 14
	Shotgun = 125, -- 12g @ 0.36 per round | 25 x 0.36 = 9
	Rifle = 250, -- 5.56 @ 0.47 per round | 25 x 0.47 = 11.75 (12)
	MG = 250, -- 5.56 @ 0.47 per round | 50 x 0.47 = 23.50 (24)
	Sniper = 20, -- 7.62 @ 1.05 per round | 20 x 1.05 = 21
	Flare = 5, -- Not doing Realistic Price
	BoxBig = 100,
	BoxSmall = 50
}
Config.Removeables = {
	-- true = Removes when used | false = Does opposite of true
	Bandage = true,
	BulletProofVest = true,
	Defib = false,
	Drill = false,
	Firework = true,
	FirstAidKit = true,
	OxygenMask = true,
	RepairKit = true,
	TireKit = true,
	WeaKit = false,
	AmmoBoxes = true,
	-- true = Removes if Failed | false = Doesn't remove if Failed
	LockPick = true
}
Config.Weapons = {
	Pistols = {
		{weaponName = 'WEAPON_PISTOL', weaponHash = GetHashKey('WEAPON_PISTOL')},
		{weaponName = 'WEAPON_COMBATPISTOL', weaponHash = GetHashKey('WEAPON_COMBATPISTOL')},
		{weaponName = 'WEAPON_APPISTOL', weaponHash = GetHashKey('WEAPON_APPISTOL')},
		{weaponName = 'WEAPON_PISTOL50', weaponHash = GetHashKey('WEAPON_PISTOL50')},
		{weaponName = 'WEAPON_SNSPISTOL', weaponHash = GetHashKey('WEAPON_SNSPISTOL')},
		{weaponName = 'WEAPON_HEAVYPISTOL', weaponHash = GetHashKey('WEAPON_HEAVYPISTOL')},
		{weaponName = 'WEAPON_VINTAGEPISTOL', weaponHash = GetHashKey('WEAPON_VINTAGEPISTOL')},
		{weaponName = 'WEAPON_MACHINEPISTOL', weaponHash = GetHashKey('WEAPON_MACHINEPISTOL')},
		{weaponName = 'WEAPON_REVOLVER', weaponHash = GetHashKey('WEAPON_REVOLVER')},
		{weaponName = 'WEAPON_MARKSMANPISTOL', weaponHash = GetHashKey('WEAPON_MARKSMANPISTOL')},
		{weaponName = 'WEAPON_DOUBLEACTION', weaponHash = GetHashKey('WEAPON_DOUBLEACTION')}
	},
	SMGs = {
		{weaponName = 'WEAPON_SMG', weaponHash = GetHashKey('WEAPON_SMG')},
		{weaponName = 'WEAPON_ASSAULTSMG', weaponHash = GetHashKey('WEAPON_ASSAULTSMG')},
		{weaponName = 'WEAPON_MICROSMG', weaponHash = GetHashKey('WEAPON_MICROSMG')},
		{weaponName = 'WEAPON_MINISMG', weaponHash = GetHashKey('WEAPON_MINISMG')},
		{weaponName = 'WEAPON_COMBATPDW', weaponHash = GetHashKey('WEAPON_COMBATPDW')},
		{weaponName = 'WEAPON_SMG_MK2', weaponHash = GetHashKey('WEAPON_SMG_MK2')}
	},
	Shotguns = {
		{weaponName = 'WEAPON_PUMPSHOTGUN', weaponHash = GetHashKey('WEAPON_PUMPSHOTGUN')},
		{weaponName = 'WEAPON_SAWNOFFSHOTGUN', weaponHash = GetHashKey('WEAPON_SAWNOFFSHOTGUN')},
		{weaponName = 'WEAPON_ASSAULTSHOTGUN', weaponHash = GetHashKey('WEAPON_ASSAULTSHOTGUN')},
		{weaponName = 'WEAPON_BULLPUPSHOTGUN', weaponHash = GetHashKey('WEAPON_BULLPUPSHOTGUN')},
		{weaponName = 'WEAPON_HEAVYSHOTGUN', weaponHash = GetHashKey('WEAPON_HEAVYSHOTGUN')},
		{weaponName = 'WEAPON_DBSHOTGUN', weaponHash = GetHashKey('WEAPON_DBSHOTGUN')},
		{weaponName = 'WEAPON_AUTOSHOTGUN', weaponHash = GetHashKey('WEAPON_AUTOSHOTGUN')},
		{weaponName = 'WEAPON_MUSKET', weaponHash = GetHashKey('WEAPON_MUSKET')}
	},
	Rifles = {
		{weaponName = 'WEAPON_ASSAULTRIFLE', weaponHash = GetHashKey('WEAPON_ASSAULTRIFLE')},
		{weaponName = 'WEAPON_CARBINERIFLE', weaponHash = GetHashKey('WEAPON_CARBINERIFLE')},
		{weaponName = 'WEAPON_ADVANCEDRIFLE', weaponHash = GetHashKey('WEAPON_ADVANCEDRIFLE')},
		{weaponName = 'WEAPON_SPECIALCARBINE', weaponHash = GetHashKey('WEAPON_SPECIALCARBINE')},
		{weaponName = 'WEAPON_BULLPUPRIFLE', weaponHash = GetHashKey('WEAPON_BULLPUPRIFLE')},
		{weaponName = 'WEAPON_COMPACTRIFLE', weaponHash = GetHashKey('WEAPON_COMPACTRIFLE')}
	},
	MGs = {
		{weaponName = 'WEAPON_MG', weaponHash = GetHashKey('WEAPON_MG')},
		{weaponName = 'WEAPON_COMBATMG', weaponHash = GetHashKey('WEAPON_COMBATMG')},
		{weaponName = 'WEAPON_GUSENBERG', weaponHash = GetHashKey('WEAPON_GUSENBERG')}
	},
	Snipers = {
		{weaponName = 'WEAPON_SNIPERRIFLE', weaponHash = GetHashKey('WEAPON_SNIPERRIFLE')},
		{weaponName = 'WEAPON_HEAVYSNIPER', weaponHash = GetHashKey('WEAPON_HEAVYSNIPER')},
		{weaponName = 'WEAPON_MARKSMANRIFLE', weaponHash = GetHashKey('WEAPON_MARKSMANRIFLE')}
	},
	Flares = {
		{weaponName = 'WEAPON_FLAREGUN', weaponHash = GetHashKey('WEAPON_FLAREGUN')}
	}
}

Config.WeaponsDamn = {
    ['WEAPON_UNARMED'] = {model = 'WEAPON_UNARMED', modifier = 0.01, enableCritical = true},
    ['WEAPON_NIGHTSTICK'] = {model = 'WEAPON_NIGHTSTICK', modifier = 0.01, enableCritical = true},
    ['WEAPON_FLASHLIGHT'] = {model = 'WEAPON_NIGHTSTICK', modifier = 0.01, enableCritical = true},

    ['WEAPON_KNIFE'] = {model = 'WEAPON_KNIFE', modifier = 0.01, enableCritical = true},
    ['WEAPON_KNUCKLE'] = {model = 'WEAPON_KNUCKLE', modifier = 0.01, enableCritical = true},
    ['WEAPON_NIGHTSTICK'] = {model = 'WEAPON_NIGHTSTICK', modifier = 0.01, enableCritical = true},
    ['WEAPON_HAMMER'] = {model = 'WEAPON_HAMMER', modifier = 0.01, enableCritical = true},
    ['WEAPON_BAT'] = {model = 'WEAPON_BAT', modifier = 0.01, enableCritical = true},
    ['WEAPON_GOLFCLUB'] = {model = 'WEAPON_GOLFCLUB', modifier = 0.01, enableCritical = true},
    ['WEAPON_CROWBAR'] = {model = 'WEAPON_CROWBAR', modifier = 0.01, enableCritical = true},
    ['WEAPON_BOTTLE'] = {model = 'WEAPON_BOTTLE', modifier = 0.01, enableCritical = true},
    ['WEAPON_DAGGER'] = {model = 'WEAPON_DAGGER', modifier = 0.01, enableCritical = true},
    ['WEAPON_HATCHET'] = {model = 'WEAPON_HATCHET', modifier = 0.01, enableCritical = true},
    ['WEAPON_MACHETE'] = {model = 'WEAPON_MACHETE', modifier = 0.01, enableCritical = true},
    ['WEAPON_SWITCHBLADE'] = {model = 'WEAPON_SWITCHBLADE', modifier = 0.01, enableCritical = true},
    ['WEAPON_PROXMINE'] = {model = 'WEAPON_PROXMINE', modifier = 0.01, enableCritical = true},
    ['WEAPON_BZGAS'] = {model = 'WEAPON_BZGAS', modifier = 0.01, enableCritical = true},
    ['WEAPON_SMOKEGRENADE'] = {model = 'WEAPON_SMOKEGRENADE', modifier = 0.01, enableCritical = true},
    ['WEAPON_MOLOTOV'] = {model = 'WEAPON_MOLOTOV', modifier = 0.01, enableCritical = true},
    ['WEAPON_REVOLVER'] = {model = 'WEAPON_REVOLVER', modifier = 0.01, enableCritical = true},
    ['WEAPON_POOLCUE'] = {model = 'WEAPON_POOLCUE', modifier = 0.01, enableCritical = true},
    ['WEAPON_PIPEWRENCH'] = {model = 'WEAPON_PIPEWRENCH', modifier = 0.01, enableCritical = true},
    ['WEAPON_PISTOL'] = {model = 'WEAPON_PISTOL', modifier = 0.01, enableCritical = true},
    ['WEAPON_PISTOL_MK2'] = {model = 'WEAPON_PISTOL_MK2', modifier = 0.01, enableCritical = true},
    ['WEAPON_COMBATPISTOL'] = {model = 'WEAPON_COMBATPISTOL', modifier = 0.01, enableCritical = true},
    ['WEAPON_APPISTOL'] = {model = 'WEAPON_APPISTOL', modifier = 0.01, enableCritical = true},
    ['WEAPON_PISTOL50'] = {model = 'WEAPON_PISTOL50', modifier = 0.01, enableCritical = true},
    ['WEAPON_SNSPISTOL'] = {model = 'WEAPON_SNSPISTOL', modifier = 0.01, enableCritical = true},
    ['WEAPON_HEAVYPISTOL'] = {model = 'WEAPON_HEAVYPISTOL', modifier = 0.01, enableCritical = true},
    ['WEAPON_VINTAGEPISTOL'] = {model = 'WEAPON_VINTAGEPISTOL', modifier = 0.01, enableCritical = true},
    ['WEAPON_FLAREGUN'] = {model = 'WEAPON_FLAREGUN', modifier = 0.01, enableCritical = true},
    ['WEAPON_MARKSMANPISTOL'] = {model = 'WEAPON_MARKSMANPISTOL', modifier = 0.01, enableCritical = true},
    ['WEAPON_MICROSMG'] = {model = 'WEAPON_MICROSMG', modifier = 0.01, enableCritical = true},
    ['WEAPON_MINISMG'] = {model = 'WEAPON_MINISMG', modifier = 0.01, enableCritical = true},
    ['WEAPON_SMG'] = {model = 'WEAPON_SMG', modifier = 0.01, enableCritical = true},
    ['WEAPON_SMG_MK2'] = {model = 'WEAPON_SMG_MK2', modifier = 0.01, enableCritical = true},
    ['WEAPON_ASSAULTSMG'] = {model = 'WEAPON_ASSAULTSMG', modifier = 0.01, enableCritical = true},
    ['WEAPON_MG'] = {model = 'WEAPON_MG', modifier = 0.01, enableCritical = true},
    ['WEAPON_COMBATMG'] = {model = 'WEAPON_COMBATMG', modifier = 0.01, enableCritical = true},
    ['WEAPON_COMBATMG_MK2'] = {model = 'WEAPON_COMBATMG_MK2', modifier = 0.01, enableCritical = true},
    ['WEAPON_COMBATPDW'] = {model = 'WEAPON_COMBATPDW', modifier = 0.01, enableCritical = true},
}
