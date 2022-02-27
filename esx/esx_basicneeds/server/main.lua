ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 5000)
	--TriggerClientEvent('esx_status:remove', source, 'thirst', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Ekmek yiyorsun.'})
end)

ESX.RegisterUsableItem('zurna', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('zurna', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 5000)
	--TriggerClientEvent('esx_status:remove', source, 'thirst', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Zurna Dürüm yiyorsun.'})
end)

ESX.RegisterUsableItem('cake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cake', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 5000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'ng_proc_food_ornge1a', 0.12, 0.045, 0.06, 45.0, 175.0, 0.0)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Kek yiyorsun.'})
end)

ESX.RegisterUsableItem('pembedildo', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pembedildo', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 8000)
	TriggerClientEvent('esx_basicneeds:onEatdildo', source, 'ng_proc_food_ornge1a', 0.12, 0.045, 0.06, 45.0, 175.0, 0.0)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Yarramı yiyorsun.'})
end)

ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 5000)
	--TriggerClientEvent('esx_status:remove', source, 'thirst', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_sandwich_01', 0.12, 0.028, 0.03, -240.0, -180.0, 0.0)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Sandviç yiyorsun.'})
end)

ESX.RegisterUsableItem('chocolate', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chocolate', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 5000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_choc_ego', 0.12, 0.035, 0.009, -30.0, -240.0, -120.0)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Çikolata yiyorsun.'})
end)

--

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_ld_flow_bottle')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Su içiyorsun.'})
end)

ESX.RegisterUsableItem('energy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('energy', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_ld_can_01')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Enerji içeceği içiyorsun.'})
end)

ESX.RegisterUsableItem('cola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_ecola_can')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Kola içiyorsun.'})
end)

ESX.RegisterUsableItem('soda', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('soda', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_ld_can_01')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Gazoz içiyorsun.'})
end)

ESX.RegisterUsableItem('tea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_ld_can_01')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Gazoz içiyorsun.'})
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_ld_can_01')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'İcetea içiyorsun.'})
end)

ESX.RegisterUsableItem('coffee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffee', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_fib_coffee')
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Kahve içiyorsun.'})
end)

--

ESX.RegisterUsableItem('wine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('wine', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source, 'prop_wine_bot_01', 0.008, -0.02, -0.3, 90.0, 270.0, 90.0)
	TriggerClientEvent('esx_basicneeds:addDrunkLevel', source, 10)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Şarap içiyorsun.'})
end)

ESX.RegisterUsableItem('beer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source, 'prop_amb_beer_bottle', 0.12, 0.008, 0.03, 240.0, -60.0, 0.0)
	TriggerClientEvent('esx_basicneeds:addDrunkLevel', source, 5)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Şarap içiyorsun.'})
end)


ESX.RegisterUsableItem('champagne', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('champagne', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source, 'prop_wine_white', 0.008, -0.02, -0.3, 90.0, 270.0, 90.0)
	TriggerClientEvent('esx_basicneeds:addDrunkLevel', source, 20)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Şampanya içiyorsun.'})
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source, 'prop_vodka_bottle', 0.008, -0.02, -0.3, 90.0, 270.0, 90.0)
	TriggerClientEvent('esx_basicneeds:addDrunkLevel', source, 25)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Votka içiyorsun.'})
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source, 'prop_tequila_bottle', 0.008, -0.02, -0.3, 90.0, 270.0, 90.0)
	TriggerClientEvent('esx_basicneeds:addDrunkLevel', source, 15)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Tekila içiyorsun.'})
end)

ESX.RegisterUsableItem('rum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rum', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source, 'prop_rum_bottle', 0.008, -0.02, -0.3, 90.0, 270.0, 90.0)
	TriggerClientEvent('esx_basicneeds:addDrunkLevel', source, 15)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Rom içiyorsun.'})
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 5000)
	TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source, 'prop_cs_whiskey_bottle', 0.008, -0.02, -0.2, 90.0, 270.0, 90.0)
	TriggerClientEvent('esx_basicneeds:addDrunkLevel', source, 25)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Viski içiyorsun.'})
end)

--

ESX.RegisterUsableItem('cigaret', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
	if lighter.count > 0 then
		xPlayer.removeInventoryItem('cigaret', 1)
		TriggerClientEvent('esx_basicneeds:onSmoke', source)
		TriggerClientEvent('esx_status:remove', source, 'stress', 5000) -- %5
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Sigara içiyorsun.'})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Çakmağa ihtiyacın var!'})
	end
end)

ESX.RegisterUsableItem('oxy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('oxy', 1)

	TriggerClientEvent('esx_status:remove', source, 'stress', 5000) -- %10
	TriggerClientEvent('esx_basicneeds:onPill', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Oxy içiyorsun.'})
end)

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'Heal Verildi.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
