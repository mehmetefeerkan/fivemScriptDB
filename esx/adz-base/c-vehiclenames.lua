ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local Vehicles = {
    {label = 'Polis Victoria', spawnName = 'policeold'},
    {label = 'Polis Bravado', spawnName = 'police2'},
    {label = 'Bufallo Sivil', spawnName = 'police42'},
    {label = 'Polis Torrence', spawnName = 'police3'},
    {label = 'Torrence Sivil', spawnName = 'lcpdumk4'},
    {label = 'Polis Van', spawnName = 'polspeedo'},
    {label = 'Van Sivil', spawnName = 'lcpdvan3'},	
    {label = 'Victoria Sivil', spawnName = 'lcpdumk'},
    {label = 'Polis SUV', spawnName = 'pscout'},
    {label = 'Suv Sivil', spawnName = 'lcpdumk6'},
    {label = 'Polis Riot', spawnName = 'polriot'},
    {label = 'Polis 4X4', spawnName = 'beachp'},
    {label = 'Polis Motor', spawnName = 'lspdb'},
    {label = 'High Speed Unit', spawnName = 'polchar'},
    {label = 'Polis Raptor 4X4', spawnName = 'polraptor'},
    {label = 'State Bravado', spawnName = 'state'},
    {label = 'State SUV', spawnName = 'state2'},
    {label = 'State Caracara', spawnName = 'state3'},
    {label = 'Medic Dodge', spawnName = 'dodgeems'}

}

Citizen.CreateThread(function()
    for num,vehicle in ipairs(Vehicles) do
        AddTextEntryByHash(GetHashKey(vehicle.spawnName), vehicle.label)
    end
end)

Citizen.CreateThread(function()
    AddTextEntry('policeold', 'Polis Victoria')
    AddTextEntry('police2', 'Polis Bravado')
	AddTextEntry('police42', 'Bufallo Sivil')
    AddTextEntry('police3', 'Polis Torrence')
    AddTextEntry('lcpdumk4', 'Torrence Sivil')
    AddTextEntry('polspeedo', 'Polis Van')
    AddTextEntry('lcpdvan3', 'Van Sivil')
    AddTextEntry('lcpdumk', 'Victoria Sivil')
    AddTextEntry('pscout', 'Polis SUV')
    AddTextEntry('lcpdumk6', 'Suv Sivil')
    AddTextEntry('polriot', 'Polis Riot')
    AddTextEntry('beachp', 'Polis 4X4')
    AddTextEntry('lspdb', 'Polis Motor')
    AddTextEntry('polchar', 'High Speed Unit')
    AddTextEntry('polraptor', 'Polis Raptor 4X4')
    AddTextEntry('state', 'State Bravado')
    AddTextEntry('state2', 'State SUV')
    AddTextEntry('state3', 'State Caracara')
    AddTextEntry('dodgeems', 'Medic Dodge')	
end)