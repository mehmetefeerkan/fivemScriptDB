ESX = nil
local GUI = {}
local PlayerData = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local lastChecked = 0


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)



RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
  "esx:playerLoaded",
  function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("esx_glovebox_inventory:getOwnedVehicle")
    lastChecked = GetGameTimer()
  end
)

AddEventHandler(
  "onResourceStart",
  function(resourceName)
    if(GetCurrentResourceName() ~= resourceName) then
      return
    end
    PlayerData = xPlayer
    TriggerServerEvent("esx_glovebox_inventory:getOwnedVehicle")
    lastChecked = GetGameTimer()
  end
)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	local PlayerData = ESX.GetPlayerData()
	if PlayerData == nil then
	    	PlayerData = ESX.GetPlayerData()
    		PlayerData.job = job
		print ('La guantera no puede sincronizar la profesión. Esto no es malo.') -- Cannot sync job, not bad
	else
		print ('La guantera ha sincronizado tu profesión.') -- Can sync job
		PlayerData.job = job
	end
end)

RegisterNetEvent("esx_glovebox_inventory:setOwnedVehicle")
AddEventHandler(
  "esx_glovebox_inventory:setOwnedVehicle",
  function(vehicle)
    vehiclePlate = vehicle
  end
)

function getItemyWeight(item)
  local itemWeight = 1
  local weight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if arrayWeight[item] ~= nil then
      itemWeight = arrayWeight[item]
    end
  end
  return itemWeight
end

function VehicleInFront()
  local pos = GetEntityCoords(PlayerPedId())
  local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.1, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

function openmenuvehicle()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local vehicle = VehicleInFront()
  globalplate = GetVehicleNumberPlateText(vehicle)

  if IsPedInAnyVehicle(playerPed) then
  ExecuteCommand("me torpidoyu açar")
    myVeh = false
    local thisVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    PlayerData = ESX.GetPlayerData()

    for i = 1, #vehiclePlate do
      local vPlate = all_trim(vehiclePlate[i].plate)
      local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))
      if vPlate == vFront then
        myVeh = true
      elseif lastChecked < GetGameTimer() - 60000 then
        TriggerServerEvent("esx_glovebox_inventory:getOwnedVehicle")
        lastChecked = GetGameTimer()
        Wait(2000)
        for i = 1, #vehiclePlate do
          local vPlate = all_trim(vehiclePlate[i].plate)
          local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))
          if vPlate == vFront then
            myVeh = true
          end
        end
      end
    end

    if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == "police") or (Config.CheckOwnership and myVeh) then
      if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
        CloseToVehicle = true
        local vehFront = GetVehiclePedIsIn(PlayerPedId(), false)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
        local closecar = GetVehiclePedIsIn(PlayerPedId(), false)

        if vehFront > 0 and closecar ~= nil then
          lastVehicle = vehFront
          local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
          local class = GetVehicleClass(vehFront)
          ESX.UI.Menu.CloseAll()
            if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
              CloseToVehicle = true
              OpenCoffresInventoryMenu(GetVehicleNumberPlateText(vehFront), Config.VehicleWeight[class], myVeh)
            end
        else
       
           -- exports['b1g_notify']:Notify('false', _U("no_veh_nearby"))
        end
        lastOpen = true
        GUI.Time = GetGameTimer()
      end
    else
      -- Not their vehicle
 
           -- exports['b1g_notify']:Notify('false', _U("nacho_veh"))
    end
  end
end
local count = 0

-- Key controls
Citizen.CreateThread(
  function()
    while true do
      Wait(0)
      if IsControlJustReleased(0, Config.OpenKey) and (GetGameTimer() - GUI.Time) > 1000 then
        openmenuvehicle()
        GUI.Time = GetGameTimer()
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Wait(0)
      local pos = GetEntityCoords(PlayerPedId())
      if CloseToVehicle then
        local vehicle = GetClosestVehicle(pos["x"], pos["y"], pos["z"], 2.0, 0, 70)
        if DoesEntityExist(vehicle) then
          CloseToVehicle = true
        else
          CloseToVehicle = false
          lastOpen = false
          ESX.UI.Menu.CloseAll()
          SetVehicleDoorShut(lastVehicle, 5, false)
        end
      end
    end
  end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
  "esx:playerLoaded",
  function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("esx_glovebox_inventory:getOwnedVehicle")
    lastChecked = GetGameTimer()
  end
)

function OpenCoffresInventoryMenu(plate, max, myVeh)
  ESX.TriggerServerCallback(
    "esx_glovebox:getInventoryV",
    function(inventory)
      text = _U("glovebox_info", plate, (inventory.weight / 100), (max / 100))
      data = {plate = plate, max = max, myVeh = myVeh, text = text}
      TriggerEvent("esx_inventoryhud:openGloveboxInventory", data, inventory.blackMoney, inventory.cashMoney, inventory.items, inventory.weapons)
    end,
    plate
  )
end

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end
