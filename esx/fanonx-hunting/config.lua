Config = {}

-- [GENERAL]:
Config.EnableFootprints     = true
Config.PNearAnimalToEscape  = 40      -- if the distance between a player and the animal is less than this value, it will run away (not for native animals)

-- [HARVESTING]:
Config.HeadshotForPerfect = true      -- In order to receve the perfect item, you will need to get perfect in Config.WeaponDamages and also kill the animal with an headshot 
Config.TimeToHarvest      = 15000     -- number of milliseconds to complete harvesting
Config.CameraMovement     = true      -- if true camera animation when harvesting animals
Config.MinLeather         = 1         -- the minimum number of leather you can drop
Config.MaxLeather         = 1         -- the maximum number of leather you can drop 
Config.CanDropMeat        = true      -- false if you don't want that animals can drop meat
Config.MeatItem           = "meat"    -- item name for meat
Config.MinMeat            = 2         -- the minimum number of leather you can drop
Config.MaxMeat            = 3         -- the maximum number of leather you can drop
Config.CanDropSpecial     = true      -- false if you don't want that animals can drop special items (see Config.Animals)
Config.SpecialProb        = 96        -- probability, example: the script generates a random number from 1 to 100, if the random number is higher (>) than this one it will drop (so 10% probability)

-- [BAIT]:
Config.EnableBait           = true
Config.BlipOnBaitAnimal     = true
Config.BaitPlacingTime      = 15000     -- milliseconds
Config.BaitItemName         = "animal_bait"
Config.BaitAnimals          = {"a_c_deer", "a_c_boar", "a_c_mtlion", "a_c_coyote"}  -- animal that can spawn when placing a bait (need to be also in Config.Animals)
Config.TimeForAnimalToLeave = 10000     -- animal once reached bait will wait this time before walking away milliseconds
Config.BaitSpawnRadious     = 30        -- when you place a bait, the animal will spawn in this radious (I raccomend 200) 
Config.TimeBetween          = 120       -- IN SECONDS, time you need to wait before placing another bait


-- [ANIMALS / WEAPONS]:
    -- MODEL: the model of animal you want to spawn / hunt 
    -- BAD/GOOD/PERFECT: the item dropped when harvesting that animal
    -- DIMENSION: size of the animal, you need this with Config.WeaponDamages

Config.Animals = {
    {dimension = "big", model = "a_c_deer", bad = "leather_deer_bad", badCost = 2, good = "leather_deer_good", goodCost = 4, perfect = "leather_deer_perfect", perfectCost = 6, hash = -664053099, specialItem = "deer_blood", specialItemCost = 7, isIllegal = false},
    {dimension = "medBig", model = "a_c_boar", bad = "leather_boar_bad", badCost = 2, good = "leather_boar_good", goodCost = 4, perfect = "leather_boar_perfect", perfectCost = 6, hash = -832573324, specialItem = "", specialItemCost = 0, isIllegal = false},
    {dimension = "medBig", model = "a_c_mtlion", bad = "leather_mlion_bad", badCost = 2, good = "leather_mlion_good", goodCost = 4, perfect = "leather_mlion_perfect", perfectCost = 6, hash = 307287994, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 1, illegalGoodCost = 2, illegalPerfectCost = 3},
    {dimension = "medium", model = "a_c_coyote", bad = "leather_coyote_bad", badCost = 2, good = "leather_coyote_good", goodCost = 4, perfect = "leather_coyote_perfect", perfectCost = 6, hash = 1682622302, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 1, illegalGoodCost = 2, illegalPerfectCost = 3},
    {dimension = "small", model = "a_c_rabbit_01", bad = "leather_rabbit_bad", badCost = 2, good = "leather_rabbit_good", goodCost = 4, perfect = "leather_rabbit_perfect", perfectCost = 6, hash = -541762431, specialItem = "", specialItemCost = 0, isIllegal = false},
    {dimension = "medium", model = "a_c_cormorant", bad = "leather_cormorant_bad", badCost = 2, good = "leather_cormorant_good", goodCost = 4, perfect = "leather_cormorant_perfect", perfectCost = 6, hash = 1457690978, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 1, illegalGoodCost = 2, illegalPerfectCost = 3},
    {dimension = "small", model = "a_c_chickenhawk", bad = "leather_chickenhawk_bad", badCost = 2, good = "leather_chickenhawk_good", goodCost = 4, perfect = "leather_chickenhawk_perfect", perfectCost = 6, hash = -1430839454, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 1, illegalGoodCost = 2, illegalPerfectCost = 3}
}   -- IMPORTANT: dimension name must be one of these "small" / "medium" / "medBig" / "big"
    -- IMPORTANT: you don't have to change hash numbers
    -- IMPORTANT: you need to have bad / good / perfect items in your items database

Config.WeaponDamages = {
    -- According to the type of weapon (category) used to kill the animal, it will drop a certain type of skin based on his size (Config.Animals dimension)
    -- EXAMPLE: if i kill with a sniper a big animal in this case it will give me perfect item
    {category = "unarmed", small = "bad", medium = "bad", medBig = "bad", big = "bad"},
    {category = "melee", small = "bad", medium = "bad", medBig = "bad", big = "bad"},
    {category = "pistol", small = "good", medium = "good", medBig = "bad", big = "bad"},
    {category = "subgun", small = "bad", medium = "bad", medBig = "good", big = "bad"},
    {category = "shootgun", small = "bad", medium = "bad", medBig = "good", big = "bad"},
    {category = "rifle", small = "bad", medium = "bad", medBig = "bad", big = "bad"},
    {category = "snip", small = "bad", medium = "good", medBig = "perfect", big = "perfect"}
}   -- IMPORTANT: you don't have to change category names

Config.NativeAnimal      = false   -- false if you want to spawn your animals (modify AnimalModels) and not use native ones
Config.SpawnAnimalNumber = 10     -- number of animal to spawn if you aren't using native animals
Config.KnifesForHarvest  = {'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_DAGGER'}  -- you can harvest an animal only with these knifes


-- [HUNTING ZONES]:
Config.huntAllMap  = true   -- true if you want to enable hunting in all the map
Config.huntPoint   = {
    {x = -1133.44, y = 4605.55, z = 144.96},
    { x = 1996.02, y = 4982.71, z = 40.63}
}   -- if Config.huntAllMap false you have to decide a point in the map and the radious where you can hunt
Config.huntRadious = 400


-- [CAMPFIRE]:
Config.EnableCampfire       = true
Config.CampfireCommand      = "campfire" -- don't put the slash before
Config.CampfireProp         = "prop_beach_fire" -- name for the prop to spawn
Config.CampfireNameItem1    = "coal"     -- name for item1 in crafting
Config.CampfireCountItem1   = 2          -- number of pieces you need for item1
Config.CampfireNameItem2    = "wood"     -- name for item2 in crafting
Config.CampfireCountItem2   = 4          -- number of pieces you need for item2
Config.CampPlacingTime      = 15000      -- milliseconds
Config.KeyCampfireMenu      = "E"        -- ["E"]
Config.MeatName             = "meat"     
Config.CookingTime          = 20000      -- milliseconds
Config.CookedMeatName       = "cookedMeat"
Config.KeyDestroyCampfire   = "G"        -- ["G"]
Config.noCampfireZoneRadious = 1000
Config.noCampfireZone       = {
    {x = -259.24, y = -1900.51, z = 27.76}
}   --you can add multiple of them (remember ",")


-- [SELLING ITEMS]:
Config.MeatCost = 20
-- see also Config.Animals for prices


-- [BLIPS]:
Config.BlipOnEntity = true  -- if not using native animals 
Config.Blips = {
    {coords = vector3(1225.43, -3246.84, 4.55), name = "Hunting selling zone", sprite = 442, colour = 27},
    -- {coords = vector3(-1133.44, 4605.55, 144.96), name = "Hunting", sprite = 161, colour = 27},
    {coords = vector3(-1133.44, 4605.55, 144.96), name = "Hunting Zone", sprite = 442, colour = 27}
}


-- [LOCATIONS]:
Config.Locations = {
    SellZone = { x = 1225.43, y = -3246.84, z = 4.55 },
    IllegalNPC = { x = 1996.02, y = 4982.71, z = 40.63, h = 219.41}
}


-- [LANGUAGE]:
Config.Text = {
    ['before_harvest']   = 'Press [~g~E~w~] to harvest',
	['harvesting']       = 'Harvesting animal...',
    ['need_knife']       = 'You need a knife to harvest',
    ['receved_leather']  = 'You receaved leather',
	['ruined_leather']   = 'The leather is too ruined',
	['receved_meat']     = 'You receaved meat',
	['special_item']     = 'You recived a special item',
    ----
    ['campfire']         = 'Press [~g~E~w~] to cook, [~g~G~w~] to remove',
    ['cooking']          = 'Cooking meat',
    ['placing_campfire'] = 'Placing campfire...',
    ['cant_place_camp']  = "You can't place your campfire here",
    ----
    ['cant_place_bait']  = "You can't place your bait here",
    ['placing_bait']     = 'Placing bait...',
    ['between_bait']     = 'You need to wait before use it again',
	['no_effects_bait']  = 'Your bait had any effects',
    ----
    ['sell_items']       = 'Press [~g~E~w~] to sell',
	['sold']             = 'Successfully sold',
	----
	['no_material']      = "You don't have enough material",
    ['you_didnt_kill_it'] = "You didn't kill the animal"
}