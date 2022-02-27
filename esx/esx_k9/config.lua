K9Config = {}
K9Config = setmetatable(K9Config, {})

K9Config.OpenMenuIdentifierRestriction = true
K9Config.OpenMenuPedRestriction = true

K9Config.LicenseIdentifiers = {
	-- "license:76561198128308167"
}

K9Config.SteamIdentifiers = {

}
K9Config.PedsList = {
	"s_m_y_cop_01",
	"s_m_y_sheriff_01",
	"mp_m_freemode_01",
	"mp_f_freemode_01",
	"LanaPolice",
}

-- Restricts the dog to getting into certain vehicles
K9Config.VehicleRestriction = false
K9Config.VehiclesList = {

}

-- Searching Type ( RANDOM [AVAILABLE] | VRP [NOT AVAILABLE] | ESX [NOT AVAILABLE] )
K9Config.SearchType = "Random"
K9Config.OpenDoorsOnSearch = true

-- Used for Random Search Type --
K9Config.Items = {
	{item = "marijuana", illegal = true},
	{item = "weed", illegal = true},
}

-- Language --
K9Config.LanguageChoice = "Polish"
K9Config.Languages = {
	["Polish"] = {
		follow = ", Gel!",
		stop = ", Dur!",
		paw = ", Bana patini ver!",
		beg = ", Proś!",
		good = ", Tamam hadi!",
		attack = ", Saldır!",
		enter = ", Atla!",
		exit = ", Git!"
	}
}
