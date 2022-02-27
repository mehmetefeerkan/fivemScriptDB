local Clockedin, PlayerData = false, {}
ESX = nil
local inMission = false
local MissionCoords = false
local Mblip = false
local isCooking = false
local ct = Citizen.CreateThread
ct(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
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
RegisterNetEvent('dd_bean:HandWash')
AddEventHandler('dd_bean:HandWash', function()
	if not HandWashed then
		SetEntityCoords(PlayerPedId(), -630.7, 223.52, 81.88-0.95)
		SetEntityHeading(PlayerPedId(), 183.97)
		while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
			RequestAnimDict("amb@prop_human_bum_bin@idle_b")
			Citizen.Wait(5)
		end
		TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 2.0, 1.0, -1, 18, 0, 0, 0, 0)
		local finished = exports["taskbar"]:taskBar(3000,"Washing hands")
		if (finished == 100) then
			HandWashed = true
			ct(function()
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
RegisterNetEvent('dd_bean:Cooking')
AddEventHandler('dd_bean:Cooking', function()
	if Clockedin then
		if HandWashed then
			OpenPrepMenu()
		else
			exports['okokNotify']:Alert("", "Please wash your hands", 3000, 'error')
		end
	end
end)
RegisterNetEvent('dd_bean:Preparing')
AddEventHandler('dd_bean:Preparing', function()
	if Clockedin then
		ToggleCrafting()
		a()
		b()
		c()
		d()
		e()
		f()
	end
end)

-------------------//PREPARE MENU//--------------------------
function OpenPrepMenu()
	exports['dd_context']:SetTitle("What do you want to do?")

    exports['dd_context']:AddButton("Start" , "Powder 5 sets of coffe beans" ,'bean:powdering' ,'b1' , 'm1')

    exports['dd_context']:SubMenu("Powder coffee beans" , "You need a beans" , "m1" )
end
RegisterNetEvent('bean:powdering')
AddEventHandler('bean:powdering', function()
	ESX.TriggerServerCallback('dd_bean:getItemAmount', function(quantity)
		if quantity >= 5 then
			
			Powdering()
			isCooking = true
		else
			exports['okokNotify']:Alert("", "Not enough beans", 3000, 'error')
		end			
	end, 'coffee_beans')
end)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end
------------------------------------------------------
RegisterNetEvent("dd_bean:ToggleAction")
AddEventHandler("dd_bean:ToggleAction", function()
	OpenMobileRestoActionsMenu()
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end
----------------//LOCKERROOM//-------------------------
RegisterNetEvent('dd_bean:Locker')
AddEventHandler('dd_bean:Locker', function()
	OpenCloakroomMenu()
end)
function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

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
			TriggerServerEvent('offDuty:bean')
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
			shirtsObject = DD.BeanShirt[shirts].male
		else
			shirtsObject = DD.BeanShirt[shirts].female
		end
		if shirtsObject then
			TriggerEvent('skinchanger:loadClothes', skin, shirtsObject)
			Clockedin = true
			TriggerServerEvent('onDuty:offbean')
		else
			exports['okokNotify']:Alert("", "There is no uniform that fits you!", 3000, 'error')
		end
	end)
end

---//PREPARE//---
function Powdering()
	local ped = PlayerPedId()
	cook = DD.Cooktime * 10000
	SetEntityCoords(PlayerPedId(),-627.94, 223.49, 81.88-0.95)
	SetEntityHeading(PlayerPedId(), 216.31)

	while (not HasAnimDictLoaded("anim@amb@business@coc@coc_unpack_cut_left@")) do
		RequestAnimDict("anim@amb@business@coc@coc_unpack_cut_left@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(ped, "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v4_coccutter", 8.0, 8.0, -1, 18, 0, 0, 0, 0)

	local finished = exports["skillbar"]:taskBar(math.random(1500,10000),math.random(5,15))
	if finished ~= 100 then
		ClearPedTasks(ped)	
	else 
		local finished2 = exports["skillbar"]:taskBar(math.random(1500,10000),math.random(5,15))
		if finished2 ~= 100 then
			ClearPedTasks(ped)	
		else
			local finished3 = exports["skillbar"]:taskBar(math.random(1500,10000),math.random(5,15))
			if finished3 ~= 100 then
				ClearPedTasks(ped)	
			else 
				local finished4 = exports["skillbar"]:taskBar(math.random(1500,10000),math.random(5,15))
				if finished4 ~= 100 then
					ClearPedTasks(ped)	
				else 
					ClearPedTasks(ped)
					TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
					Citizen.Wait(1000)
					TriggerServerEvent('dd_bean:removeItem', 'coffee_beans')
					ClearPedTasks(ped)
					TriggerServerEvent('dd_bean:addItem', 'coffee_powder')
					isCooking = false
				end
			end
		end
	end
  end
  function MeatCraft() 
	Citizen.Wait(100)
	local ped = PlayerPedId()
	cook = DD.Cooktime * 10000
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
	exports['okokNotify']:Alert("", "Cooking", cook, 'success')
	Citizen.Wait(cook)
	TriggerServerEvent('dd_bean:addItem', 'groundmeat')
	ClearPedTasks(PlayerPedId())	
	isCooking = false
  end
  function Hotdog() 
	Citizen.Wait(100)
	local ped = PlayerPedId()
	cook = DD.Cooktime * 10000
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
	exports['okokNotify']:Alert("", "Cooking", cook, 'success')
	Citizen.Wait(cook)
	TriggerServerEvent('dd_bean:addItem', 'c_hotdog')
	ClearPedTasks(PlayerPedId())	
	isCooking = false
  end
---------------------ANIMATIONS-----------------------
---//UPPER ANIMATION//---
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

RegisterCommand("bbill", function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'beanmachine' then
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
					TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'society_bean', 'bean Machine', amount)
				end          
			end
		end
	end
end)

----------------[[CRAFTING]]---------------------
local aInProgress,bInProgress,cInProgress,dInProgress,eInProgress,fInProgress = false,false,false,false,false,false

ToggleCrafting = function()
	SetNuiFocus(true, true)
	SendNUIMessage({action = 'toggleCrafting'})
end
aCl = function()
	local label
	if not aInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({action = 'aa', data = label})
end
bCl = function()
	local label
	if not bInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({action = 'bb', data = label})
end
cCl = function()
	local label
	if not cInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({action = 'cc', data = label})
end
dCl = function()
	local label
	if not dInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({action = 'dd', data = label})
end
eCl = function()
	local label
	if not eInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({action = 'ee', data = label})
end
fCl = function()
	local label
	if not fInProgress then label = 'Order' else label = 'Processing...' end
	SendNUIMessage({action = 'ff', data = label})
end
a = function()
	ESX.TriggerServerCallback('dd_bean:coffee_b', function(canCraft)
		local label = 'Not Available'
		if canCraft then
			label = 'Blk. Coffee'
		end
		SendNUIMessage({
			action = 'aa',
			data = label
		})
	end)
end

RegisterNUICallback('coffee_b', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'beanmachine' and not aInProgress then
		TriggerServerEvent('dd_bean:OrderCL', 'Black Coffee')
		exports['okokNotify']:Alert("", "Order recieved", 3000, 'success')
		aInProgress = true
		Citizen.Wait(60000)
		aInProgress = false
	else
		ESX.TriggerServerCallback('dd_bean:coffee_b', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				SetEntityCoords(PlayerPedId(),-635.29, 235.97, 81.88-0.95)
				SetEntityHeading(PlayerPedId(), 36.38)
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
				local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished ~= 100 then
					ClearPedTasks(plyr)		   
				else
					TriggerServerEvent('dd_bean:assemblingSUCCESSS', 'coffee_b', 1)
					Citizen.Wait(2000)
					ClearPedTasks(plyr)
				end	
			else
				exports['okokNotify']:Alert("", "Not Enough ingredients", 3000, 'error')
			end
		end)
	end
end)

b = function()
	ESX.TriggerServerCallback('dd_bean:coffee_r', function(canCraft)
		local label = 'Not Available'
		if canCraft then
			label = 'Reg. Coffee'
		end
		SendNUIMessage({
			action = 'bb',
			data = label
		})
	end)
end

RegisterNUICallback('coffee_r', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'beanmachine' and not bInProgress then
		TriggerServerEvent('dd_bean:OrderCL', 'Regular Coffee')
		exports['okokNotify']:Alert("", "Order recieved", 3000, 'success')
		bInProgress = true
		Citizen.Wait(60000)
		bInProgress = false
	else
		ESX.TriggerServerCallback('dd_bean:coffee_r', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				SetEntityCoords(PlayerPedId(),-635.29, 235.97, 81.88-0.95)
				SetEntityHeading(PlayerPedId(), 36.38)
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
				local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished ~= 100 then
					ClearPedTasks(plyr)		   
				else
					TriggerServerEvent('dd_bean:assemblingSUCCESSS', 'coffee_r', 1)
					Citizen.Wait(2000)
					ClearPedTasks(plyr)
				end	
			else
				exports['okokNotify']:Alert("", "Not Enough ingredients", 3000, 'error')
			end
		end)
	end
end)

c = function()
	ESX.TriggerServerCallback('dd_bean:cappuccino', function(canCraft)
		local label = 'Not Available'
		if canCraft then
			label = 'Cappuccino'
		end
		SendNUIMessage({
			action = 'cc',
			data = label
		})
	end)
end
RegisterNUICallback('cappuccino', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'beanmachine' and not cInProgress then
		TriggerServerEvent('dd_bean:OrderCL', 'Cappuccino')
		exports['okokNotify']:Alert("", "Order recieved", 3000, 'success')
		cInProgress = true
		Citizen.Wait(60000)
		cInProgress = false
	else
		ESX.TriggerServerCallback('dd_bean:cappuccino', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				SetEntityCoords(PlayerPedId(),-635.29, 235.97, 81.88-0.95)
				SetEntityHeading(PlayerPedId(), 36.38)
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
				local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished ~= 100 then
					ClearPedTasks(plyr)		   
				else
					TriggerServerEvent('dd_bean:assemblingSUCCESSS', 'cappuccino', 1)
					Citizen.Wait(2000)
					ClearPedTasks(plyr)
				end	
			else
				exports['okokNotify']:Alert("", "Not Enough ingredients", 3000, 'error')
			end
		end)
	end
end)

d = function()
	ESX.TriggerServerCallback('dd_bean:cheesecake', function(canCraft)
		local label = 'Not Available'
		if canCraft then
			label = 'Cheese Cake'
		end
		SendNUIMessage({
			action = 'dd',
			data = label
		})
	end)
end
RegisterNUICallback('cheesecake', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'beanmachine' and not dInProgress then
		TriggerServerEvent('dd_bean:OrderCL', 'Cheese Cake')
		exports['okokNotify']:Alert("", "Order recieved", 3000, 'success')
		dInProgress = true
		Citizen.Wait(60000)
		dInProgress = false
	else
		ESX.TriggerServerCallback('dd_bean:cheesecake', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				SetEntityCoords(PlayerPedId(),-635.29, 235.97, 81.88-0.95)
				SetEntityHeading(PlayerPedId(), 36.38)
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
				local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished ~= 100 then
					ClearPedTasks(plyr)		   
				else
					Citizen.Wait(2000)
					TriggerServerEvent('dd_bean:assemblingSUCCESSS', 'cheesecake', 1)
					ClearPedTasks(plyr)
				end	
			else
				exports['okokNotify']:Alert("", "Not available", 3000, 'error')
			end
		end)
	end
end)
e = function()
	ESX.TriggerServerCallback('dd_bean:sandwich', function(canCraft)
		local label = 'Not Available'
		if canCraft then
			label = 'Sandwich'
		end
		SendNUIMessage({
			action = 'ee',
			data = label
		})
	end)
end
RegisterNUICallback('sandwich', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'beanmachine' and not eInProgress then
		TriggerServerEvent('dd_bean:OrderCL', 'Sandwich')
		exports['okokNotify']:Alert("", "Order recieved", 3000, 'success')
		eInProgress = true
		Citizen.Wait(60000)
		eInProgress = false
	else
		ESX.TriggerServerCallback('dd_bean:sandwich', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				SetEntityCoords(PlayerPedId(),-635.29, 235.97, 81.88-0.95)
				SetEntityHeading(PlayerPedId(), 36.38)
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
				local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished ~= 100 then
					ClearPedTasks(plyr)		   
				else
					Citizen.Wait(2000)
					TriggerServerEvent('dd_bean:assemblingSUCCESSS', 'sandwich', 1)
					ClearPedTasks(plyr)
				end	
			else
				exports['okokNotify']:Alert("", "Not available", 3000, 'error')
			end
		end)
	end
end)
f = function()
	ESX.TriggerServerCallback('dd_bean:donut', function(canCraft)
		local label = 'Not Available'
		if canCraft then
			label = 'Daughnut'
		end
		SendNUIMessage({
			action = 'ff',
			data = label
		})
	end)
end
RegisterNUICallback('donut', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'beanmachine' and not fInProgress then
		TriggerServerEvent('dd_bean:OrderCL', 'Daughnut')
		exports['okokNotify']:Alert("", "Order recieved", 3000, 'success')
		fInProgress = true
		Citizen.Wait(60000)
		fInProgress = false
	else
		ESX.TriggerServerCallback('dd_bean:donut', function(canCraft)
			if canCraft then
				ToggleCraftingOff()
				local plyr = PlayerPedId()
				SetEntityCoords(PlayerPedId(),-635.29, 235.97, 81.88-0.95)
				SetEntityHeading(PlayerPedId(), 36.38)
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
				local finished = exports["skillbar"]:taskBar(math.random(6000,10000),math.random(5,15))
				if finished ~= 100 then
					ClearPedTasks(plyr)		   
				else
					Citizen.Wait(2000)
					TriggerServerEvent('dd_bean:assemblingSUCCESSS', 'donut', 1)
					ClearPedTasks(plyr)
				end	
			else
				exports['okokNotify']:Alert("", "Not available", 3000, 'error')
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

