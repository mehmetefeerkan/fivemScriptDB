ESX = nil
local Clockedin = false
local isCooking = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	Citizen.Wait(5000)
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
local HandWashed = false
RegisterNetEvent('dd_bshot:HandWash')
AddEventHandler('dd_bshot:HandWash', function()
	if not HandWashed then
		while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
			RequestAnimDict("amb@prop_human_bum_bin@idle_b")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		local finished = exports["taskbar"]:taskBar(3000,"Washing hands")
		if (finished == 100) then
			HandWashed = true
			Citizen.CreateThread(function()
				local spanToDirt = 180
				while spanToDirt > 0 do
					spanToDirt = spanToDirt - 1
					Citizen.Wait(1000)
				end
				HandWashed = false
				exports['okokNotify']:Alert("", "Your hands are dirty", 3000, 'warning')
			end)
		end
	else
		exports['okokNotify']:Alert("", "Hand washing not needed", 3000, 'info')
	end
end)
RegisterNetEvent('dd_bshot:Cooking')
AddEventHandler('dd_bshot:Cooking', function()
	if Clockedin then
		if HandWashed then
			OpenPrepMenu()
		else
			exports['okokNotify']:Alert("", "Please wash your hands", 3000, 'error')
		end
	end
end)
RegisterNetEvent('dd_bshot:Preparing')
AddEventHandler('dd_bshot:Preparing', function()
	if Clockedin then
		ToggleCrafting()
		b()
		c()
		e()
	end
end)
function Pricelist()
	local elements = {
		{label = '---Pricelist---'},
		{label = 'Sprunk | $ '..DD.sprunk * DD.Percentage},
		{label = 'The Bleeder | $ '..DD.bleeder * DD.Percentage},
		{label = 'Heart Stopper | $ '..DD.stopper * DD.Percentage},
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pricelist', {
		title    = 'Burger Shot',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
	end, function(data, menu)
		menu.close()
	end)
end
-------------------//PREPARE MENU//--------------------------
function OpenPrepMenu()
	exports['dd_context']:SetTitle("What do you want to cook?")

    exports['dd_context']:AddButton("Start Cooking" , "Cook 5 sets of vegetables" ,'bshot:vegetables' ,'b1' , 'm1')
	exports['dd_context']:AddButton("Start Cooking" , "Cook 5 sets of patty" ,'bshot:patty' ,'b2' , 'm2')

    exports['dd_context']:SubMenu("Vegetables" , "You need at least 5 fresh vegetables" , "m1" )
    exports['dd_context']:SubMenu("Ground Meat" , "You need at least 5 fresh meat" , "m2" )
end

RegisterNetEvent('bshot:vegetables')
AddEventHandler('bshot:vegetables', function()
	ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
		if quantity >= 1 then
			TriggerServerEvent('dd_bshot:removeItem', 'fresh_vegetables')
			VegeCraft()
			isCooking = true
		else
			exports['okokNotify']:Alert("", "Not enough vegetables", 3000, 'error')
		end			
	end, 'fresh_vegetables')
end)

RegisterNetEvent('bshot:patty')
AddEventHandler('bshot:patty', function()
	ESX.TriggerServerCallback('dd_core:getItemAmount', function(quantity)
		if quantity >= 1 then
			TriggerServerEvent('dd_bshot:removeItem', 'cowmeat_packed')
			MeatCraft()
			isCooking = true
		else
			exports['okokNotify']:Alert("", "Not enough fresh meat", 3000, 'error')
		end			
	end, 'cowmeat_packed')
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end
-------------------//LOCKERROOM//-------------------------
RegisterNetEvent('dd_bshot:Locker')
AddEventHandler('dd_bshot:Locker', function()
	OpenCloakroomMenu()
end)
function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	local elements = {
		{label = 'Clocked-in', 	shirts = grade},
		{label = 'Clocked-out', value = 'out'},
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = 'Locker Room',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)
		if data.current.shirts then
			ShirtsAnim()
			Citizen.Wait(1000)
			setShirts(data.current.shirts, playerPed)
		elseif data.current.value == 'out' then
			ShirtsAnim()
			Citizen.Wait(1000)
			Clockedin = false
			TriggerServerEvent('offDuty:bshot')
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end
function setShirts(shirts, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local shirtsObject
		if skin.sex == 0 then
			shirtsObject = DD.BshotShirt[shirts].male
		else
			shirtsObject = DD.BshotShirt[shirts].female
		end
		if shirtsObject then
			TriggerEvent('skinchanger:loadClothes', skin, shirtsObject)
			Clockedin = true
			TriggerServerEvent('onDuty:offbshot')
		else
			exports['okokNotify']:Alert("", "There is no uniform that fits you!", 3000, 'error')
		end
	end)
end
---//PREPARE//---
function VegeCraft()
	local ped = PlayerPedId()
	cook = DD.Cooktime * 10000
	Citizen.CreateThread(function()
	  RequestAnimDict("amb@world_human_stand_fire@male@idle_a")
	  Citizen.Wait(100)
	  TaskPlayAnim((ped), 'amb@world_human_stand_fire@male@idle_a', 'idle_a', 1.0, -1, -1, 50, 0, 0, 0, 0)
	  FreezeEntityPosition(PlayerPedId(), true)
	  exports['okokNotify']:Alert("", "Cooking", cook, 'success')
	  Citizen.Wait(cook)
	  TriggerServerEvent('dd_bshot:addItem', 'vegetables')
	  ClearPedTasks(ped)
	  FreezeEntityPosition(PlayerPedId(), false)
	  isCooking = false
	end)
  end
  function MeatCraft() 
	Citizen.Wait(100)
	local ped = PlayerPedId()
	cook = DD.Cooktime * 10000
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
	exports['okokNotify']:Alert("", "Cooking", cook, 'success')
	Citizen.Wait(cook)
	TriggerServerEvent('dd_bshot:addItem', 'c_patty')
	ClearPedTasks(PlayerPedId())	
	isCooking = false
  end

function ShirtsAnim() 
  local ped = PlayerPedId()
  Citizen.CreateThread(function()
    RequestAnimDict("clothingshirt")
    Citizen.Wait(100)
    TaskPlayAnim((ped), 'clothingshirt', 'try_shirt_positive_d', 1.0, -1, -1, 50, 0, 0, 0, 0)
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

RegisterCommand("bsbill", function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bshot' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer == -1 or closestDistance > 3.0 then
			exports['okokNotify']:Alert("", "No one to bill", 3000, 'error')
		else
			local dialog = exports['zf_dialog']:DialogInput({
			header = 'Create Bill',
				rows = {
				{
					id = 0,
					txt = 'Amount'
				},
				}
			})
			if dialog ~= nil then
				if dialog[1].input == nil then
					exports['okokNotify']:Alert("", "Invalid amount", 3000, 'error')
				else
					amount = dialog[1].input
					TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_burger', 'Burger Shot', amount)
				end          
			end
		end
	end
end)

----------------[[CRAFTING]]---------------------
local bInProgress,cInProgress,eInProgress=false,false,false
ToggleCrafting = function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'toggleCrafting'
	})
end

bCl = function()
	local label
	if not bInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({
		action = 'bb',
		data = label
	})
end

cCl = function()
	local label
	if not cInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({
		action = 'cc',
		data = label
	})
end

eCl = function()
	local label
	if not eInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({
		action = 'ee',
		data = label
	})
end

b = function()
	ESX.TriggerServerCallback('dd_bshot:sprunk', function(canCraft)
		local label = 'Lack of Cash'
		if canCraft then
			label = 'Purchase Sprunk'
		end
		SendNUIMessage({
			action = 'bb',
			data = label
		})
	end)
end

RegisterNUICallback('sprunk', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'bshot' and not bInProgress then
		TriggerServerEvent('dd_bshot:OrderCL', 'Sprunk')
		exports['okokNotify']:Alert("", "Order recieved", 3000, 'success')
		bInProgress = true
		Citizen.Wait(60000)
		bInProgress = false
	else
		ESX.TriggerServerCallback('dd_bshot:sprunk', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				startMinigame('sprunk', plyr)
			else
				exports['okokNotify']:Alert("", "Sprunk price: "..DD.sprunk, 10000, 'info')
			end
		end)
	end
end)

c = function()
	ESX.TriggerServerCallback('dd_bshot:bleeder', function(canCraft)
		local label = 'Lack of ingredients'
		if canCraft then
			label = 'Make Bleeder'
		end
		SendNUIMessage({
			action = 'cc',
			data = label
		})
	end)
end

RegisterNUICallback('bleeder', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'bshot' and not cInProgress then
		TriggerServerEvent('dd_bshot:OrderCL', 'The Bleeder')
		exports['okokNotify']:Alert("", "Not Enough ingredients", 3000, 'success')
		cInProgress = true
		Citizen.Wait(60000)
		cInProgress = false
	else
		ESX.TriggerServerCallback('dd_bshot:bleeder', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				FreezeEntityPosition(PlayerPedId(), true)
				while (not HasAnimDictLoaded("mini@repair")) do
					RequestAnimDict("mini@repair")
					Citizen.Wait(5)
				end
				TaskPlayAnim(plyr, "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
				startMinigame('bleeder', plyr)
			else
				exports['okokNotify']:Alert("INGREDIENTS", "2 Patty, 1 Cheese, 1 Bun and 1 Chily Sauce", 10000, 'info')
			end
		end)
	end
end)

e = function()
	ESX.TriggerServerCallback('dd_bshot:stopper', function(canCraft)
		local label = 'Lack of ingredients'
		if canCraft then
			label = 'Make Heart Stopper'
		end
		SendNUIMessage({
			action = 'ee',
			data = label
		})
	end)
end
RegisterNUICallback('stopper', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'bshot' and not eInProgress then
		TriggerServerEvent('dd_bshot:OrderCL', 'Heart Stopper')
		exports['okokNotify']:Alert("", "Not Enough ingredients", 3000, 'success')
		eInProgress = true
		Citizen.Wait(60000)
		eInProgress = false
	else
		ESX.TriggerServerCallback('dd_bshot:stopper', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				FreezeEntityPosition(PlayerPedId(), true)
				while (not HasAnimDictLoaded("mini@repair")) do
					RequestAnimDict("mini@repair")
					Citizen.Wait(5)
				end
				TaskPlayAnim(plyr, "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 18, 0, 0, 0, 0)
				startMinigame('stopper', plyr)
			else
				exports['okokNotify']:Alert("INGREDIENTS", "4 Patty, 4 Cheese, 1 Bun , 2 Vegetable and 1 Chily Sauce", 10000, 'info')
			end
		end)
	end
end)

RegisterNUICallback('NUIFocusOff', function()
	ToggleCraftingOff()
end)

ToggleCraftingOff = function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		action = 'closeCrafting',
	})
end

startMinigame = function(reward,plyr)
	local count = 1
	local speed = 0.5
	exports["mf-inventory"]:startMinigame(count,speed,function(res)
		if res == true then
			TriggerServerEvent('dd_bshot:assemblingSUCCESSS', reward, 1)
			ClearPedTasks(plyr)
		else
			ClearPedTasks(plyr)
		end
	end)
end