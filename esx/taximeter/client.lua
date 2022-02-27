-- Settings
local enableTaxiGui = true -- Enables the GUI (Default: true)
local fareCost = 1.16 --(1.66 = $100 per minute) Cost per second
local costPerMile = 15.0
local initialFare = 10.0 -- the cost to start a fare

local testMode = true -- enables spawn car command

DecorRegister("fares", 1)
DecorRegister("miles", 1)
DecorRegister("meteractive", 2)
DecorRegister("initialFare", 1)
DecorRegister("costPerMile", 1)
DecorRegister("fareCost", 1)

-- NUI Variables
local inTaxi = false
local meterOpen = false
local meterActive = false

-- Open Gui and Focus NUI
function openGui()
  SendNUIMessage({openMeter = true})
end

-- Close Gui and disable NUI
function closeGui()
  SendNUIMessage({openMeter = false})
  meterOpen = false
end

RegisterNetEvent('taxi:cost')
AddEventHandler('taxi:cost', function()
  while true do
    Citizen.Wait(2000)
    local ped = PlayerPedId(), false
    local veh = GetVehiclePedIsIn(ped, false)
    if IsInTaxi() and GetPedInVehicleSeat(veh, -1) ~= ped then
      local ped = PlayerPedId(), false
      local veh = GetVehiclePedIsIn(ped, false)
      TriggerEvent('taxi:updatefare', veh)
      openGui()
      meterOpen = true
    end
    if meterActive and GetPedInVehicleSeat(veh, -1) == ped then
      local _fare = DecorGetFloat(veh, "fares")
      local _miles = DecorGetFloat(veh, "miles")
      local _fareCost = DecorGetFloat(veh, "fareCost")

      if _fareCost ~= 0 then
        DecorSetFloat(veh, "fares", _fare + _fareCost)
      else
        DecorSetFloat(veh, "fares", _fare + fareCost)
      end
      DecorSetFloat(veh, "miles", _miles + round(GetEntitySpeed(veh) * 0.000621371, 5))
      TriggerEvent('taxi:updatefare', veh)
    end
    if IsInTaxi() and not GetPedInVehicleSeat(veh, -1) == ped then
      TriggerEvent('taxi:updatefare', veh)
    end
  end
end)

RegisterCommand('taksimetre', function()
	TriggerEvent('taxi:ui')
	TriggerEvent('taxi:cost')
	msg = "NUMPAD8 Tuşuna basarak taksimetreyi açabilirsin."
    TriggerEvent('notification', msg, 1)
end)

RegisterNetEvent('taxi:ui')
AddEventHandler('taxi:ui', function()
	while true do
      Citizen.Wait(0)
      if(IsInTaxi()) then
        inTaxi = true
        local ped = PlayerPedId(), false
        local veh = GetVehiclePedIsIn(ped, false)
        if(IsInTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
          if IsControlJustReleased(0, 111)  then -- NUM8
            TriggerEvent('taxi:toggleDisplay')
            Citizen.Wait(100)
          end
          if IsControlJustReleased(0, 108)  then -- NUM4
            TriggerEvent('taxi:toggleHire')
            Citizen.Wait(100)
          end
          if IsControlJustReleased(0,109) then -- NUM6
            TriggerEvent('taxi:resetMeter')
            Citizen.Wait(100)
          end
        end
      else
        if(meterOpen) then
          closeGui()
        end
        meterOpen = false
      end
    end
end)

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNetEvent('taxi:toggleDisplay')
AddEventHandler('taxi:toggleDisplay', function()
  local ped = PlayerPedId(), false
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsInTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterOpen then
      closeGui()
      meterOpen = false
    else
      local _fare = DecorGetFloat(veh, "fares")
      if _fare < initialFare then
        DecorSetFloat(veh, "fares", initialFare)
      end
      TriggerEvent('taxi:updatefare', veh)
      openGui()
      meterOpen = true
    end
  end
end)

RegisterNetEvent('taxi:toggleHire')
AddEventHandler('taxi:toggleHire', function()
  local ped = PlayerPedId(), false
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsInTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterActive then
      SendNUIMessage({meterActive = false})
      meterActive = false
      DecorSetBool(veh, "meteractive", false)
      Citizen.Trace("Trigger OFF")
    else
      SendNUIMessage({meterActive = true})
      meterActive = true
      DecorSetBool(veh, "meteractive", true)
      Citizen.Trace("Trigger ON")
    end
  end
end)

RegisterNetEvent('taxi:resetMeter')
AddEventHandler('taxi:resetMeter', function()
  local ped = PlayerPedId(), false, false
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsInTaxi() and GetPedInVehicleSeat(veh, -1) == ped) then
    local _fare = DecorGetFloat(veh, "fares")
    local _miles = DecorGetFloat(veh, "miles")
    DecorSetFloat(veh, "initialFare", initialFare)
    DecorSetFloat(veh, "costPerMile", costPerMile)
    DecorSetFloat(veh, "fareCost", fareCost)
    DecorSetFloat(veh, "fares", DecorGetFloat(veh, "initialFare"))
    DecorSetFloat(veh, "miles", 0.0)
    TriggerEvent('taxi:updatefare', veh)
  end
end)

-- Check if player is in a vehicle
function IsInVehicle()
  local ply = PlayerPedId(), false
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-- Check if player is in a Taxi
function IsInTaxi()
  local ped = PlayerPedId(), false, false
  local veh = GetVehiclePedIsIn(ped, false)
  local model = GetEntityModel(veh)
  local displaytext = GetDisplayNameFromVehicleModel(model)
  local name = GetLabelText(displaytext)
  if (name == "Taxi") then
    return true
  else
    return false
  end
end

-- Check if player is in a Taxi
function ReturnVehicle()
  local ped = PlayerPedId(), false
  local veh = GetVehiclePedIsIn(ped, false)
  local model = GetEntityModel(veh)
  local displaytext = GetDisplayNameFromVehicleModel(model)
  local name = GetLabelText(displaytext)
end

-- Check if player is near another player
function IsNearPlayer(player)
  local ply = PlayerPedId(), false
  local plyCoords, letSleep = GetEntityCoords(ply, 0), false
  local distance = GetDistanceBetweenCoords(plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
  local distancebey = 1
  if distancebey < distance then
  local letSleep = false
  end
  if letSleep then
  Citizen.Wait(500)
  end
end

-- Send NUI message to update
RegisterNetEvent('taxi:updatefare')
AddEventHandler('taxi:updatefare', function(veh)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
  local _fare = DecorGetFloat(veh, "fares")
  local _miles = DecorGetFloat(veh, "miles")
  local farecost = _fare + (_miles * DecorGetFloat(veh, "costPerMile"))


	SendNUIMessage({
		updateBalance = true,
		balance = string.format("%.2f", farecost),
    player = string.format("%.2f", _miles),
    meterActive = DecorGetBool(veh, "meteractive")
	})
end)


