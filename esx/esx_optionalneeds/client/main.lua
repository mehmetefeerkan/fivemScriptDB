ESX                  = nil
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function Drunk(level, start)
  
  Citizen.CreateThread(function()

    local playerPed = PlayerPedId()

    if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end

    if level == 0 then

      RequestAnimSet("move_m@drunk@slightlydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)

    elseif level == 1 then

      RequestAnimSet("move_m@drunk@moderatedrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)

    elseif level == 2 then

      RequestAnimSet("move_m@drunk@verydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)

    end

    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)

    if start then
      DoScreenFadeIn(800)
    end

  end)

end

function Reality()

  Citizen.CreateThread(function()

    local playerPed = PlayerPedId()

    DoScreenFadeOut(800)
    Wait(1000)

    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)

    DoScreenFadeIn(800)

  end)

end

AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				
				if status.val > 0 then
					
          local start = true

          if IsAlreadyDrunk then
            start = false
          end

          local level = 0

          if status.val <= 250000 then
            level = 0
          elseif status.val <= 500000 then
            level = 1
          else
            level = 2
          end

          if level ~= DrunkLevel then
            Drunk(level, start)
          end

          IsAlreadyDrunk = true
          DrunkLevel     = level
				end

				if status.val == 0 then
          
          if IsAlreadyDrunk then
            Reality()
          end

          IsAlreadyDrunk = false
          DrunkLevel     = -1

				end

			end)

		end

	end)

end)

RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  
  local playerPed = PlayerPedId()
  
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)

end)

--Adrenalin
RegisterNetEvent("esx_optionalneeds:onAdrenaline")
AddEventHandler("esx_optionalneeds:onAdrenaline", function()

    local lib, anim = 'fbi_3_int-0', 'cs_fib3_syringe-0'  -- usage animation (I fucked this up and don't bother to add working animation)
    local playerPed = PlayerPedId()

    ESX.ShowNotification('Her şey artık daha net!') -- usage notification // English: "Everything is crystal clear now.
        TriggerEvent('esx_optionalneeds:adrenaline')
	adrenalinetki()		-- below effect
end)

-------------EFEKTLER---------------
local hizliKos = false -- hızlı koşma var // this is for fast run
local yavasKos = false -- yavaş koşma var // this is for slow run



function adrenalinetki()           -- yavaş koşma için call // check if slow run activated
    while true do
      Citizen.Wait(16)
      if yavasKos then
        SetPedMoveRateOverride(PlayerPedId(), 0.1) -- you can edit this ratio : values above 1.0 make charater move faster / values belowe 1.0 make charater slower / 1.0 is default speed - This makes characters movement faster, which means even your walking speed
      end
      if hizliKos then
        SetPedMoveRateOverride(PlayerPedId(), 1.050) -- you can edit this ratio : values above 1.0 make charater move faster / values belowe 1.0 make charater slower / 1.0 is default speed - This makes characters movement faster, which means even your walking speed
      end
    end
  end

--Agresif ve Sınırsız Stamina
RegisterNetEvent("esx_optionalneeds:adrenaline")
AddEventHandler("esx_optionalneeds:adrenaline", function()
    local count = 0

    Citizen.Wait(1000)
    SetPedMotionBlur(PlayerPedId(), true) -- Adds very little blur effect
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetTimecycleModifier("underwater_deep")  -- Display filter to make it funnier and realistic
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.35)   -- This ratio is for sprinting speed not movement speed so it will only effective when your character sprints, max is 1.49 / aboe 1.49 won't effect speed
    hizliKos = true  -- activites fast movement (not sprinting speed but overall speed)
    SetPedArmour(PlayerPedId(), 100)
    SetEntityHealth(PlayerPedId(), 200)
    DoScreenFadeIn(1000)
	repeat  -- Start of the cycle
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)   -- Shaking cam effect
    RestorePlayerStamina(PlayerId(), 1.0)   -- This is for resetting stamina
    Citizen.Wait(5000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
    Citizen.Wait(5000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
    Citizen.Wait(5000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
    Citizen.Wait(5000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
    Citizen.Wait(5000)
		count = count  + 1
	until count == 5  -- One cycle takes 10 seconds, if you put 15 in this value adrenaline effect will take 150 seconds
    hizliKos = false  -- deactivates speed
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier() -- clears display filter
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0) -- sets sprint speed to defualt
    SetPedMotionBlur(PlayerPedId(), false) -- removes blur
    count = 0  -- sets cylce count to 0 for next usage
    ESX.ShowNotification('Yavaşlıyorsun ve yorgun düşüyorsun...') -- sends notification when effect is over // English : "You are exhausted, slowing down..."
    yavasKos = true  -- sets speed to very slow to animiate exhausting effect
    Citizen.Wait(10000)  -- this values determines how long the exhausting effect // value is in miliseconds
    yavasKos = false -- removes slow speed
    ESX.ShowNotification('Tekrar eski haline döndün.') -- show notification that you are now feeling okay // English : "You are feeling okay."
end)