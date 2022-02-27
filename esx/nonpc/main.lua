Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) 

		-- Eğer oyunda NPC istemiyorsan değeri 0 olarak bırak. Ancak NPC istiyor ve yoğunluklarını ayarlayacak isen değerleri değiştirebilirsin.
		SetVehicleDensityMultiplierThisFrame(1.0) -- Trafik yoğunlu
		SetPedDensityMultiplierThisFrame(1.0) -- NPC/PEDS yoğunluğu
		SetRandomVehicleDensityMultiplierThisFrame(1.0) -- Rastgele araçlar (otoparktan araç çıkması vs) 
		SetParkedVehicleDensityMultiplierThisFrame(1.0) -- Rastgele park etmiş araçlar
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- Rastgele NPC/PEDS senaryoları
		SetGarbageTrucks(false) -- Rastgele ortaya çıkan çöp kamyonları [true/false]
		SetRandomBoats(false) -- Rastgele denizde/suda tekne çıkması [true/false]
		SetCreateRandomCops(false) -- Rastgele polisler (araç/yaya)[true/false]
		SetCreateRandomCopsNotOnScenarios(false) -- Rastgele polisler (senaryo değil)[true/false]
		SetCreateRandomCopsOnScenarios(false) -- Rastgele polisler (senaryo)[true/false]
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		--ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		--RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
	end
end)



Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
	  -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
	  RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
	  RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
	  RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
	end
  end)


