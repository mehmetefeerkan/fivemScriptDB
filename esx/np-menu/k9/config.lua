K9Config = {}
K9Config = setmetatable(K9Config, {})

K9Config.OpenMenuIdentifierRestriction = false
K9Config.OpenMenuPedRestriction = false
K9Config.LicenseIdentifiers = {
	"license:c06fbf1faaf995c7b9e207ef77712971a3ed4dc3"
}
K9Config.SteamIdentifiers = {
	"steam:1100001139ef023",
	"steam:11000011d034542",
	"steam:11000013c453a6f"
}
K9Config.PedsList = {
	"s_m_y_cop_01",
	"s_m_y_sheriff_01"
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
	{item = "Kokain", illegal = true},
	{item = "İşlenmiş Kenevir", illegal = true},
	{item = "Blunt Spray", illegal = false},
	{item = "Crowbar", illegal = false},
	{item = "Maymuncuk", illegal = true},
	{item = "Baggies", illegal = false},
	{item = "Used Needle", illegal = false},
	{item = "Open Container", illegal = false},
}

-- Language --
K9Config.LanguageChoice = "English"
K9Config.Languages = {
	["English"] = {
		follow = "Takip ediyor",
		stop = "Durdu",
		attack = "Isırıyor",
		enter = "İçinde",
		exit = "Dışında"
	}
}