-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFS = MF_Stress
local TSC = ESX.TriggerServerCallback
local TSE = TriggerServerEvent
local CT = Citizen.CreateThread

function MFS:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    self.PlayerData = ESX.GetPlayerData()
    TSC('MF_Stress:GetStartData', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function MFS:Start()
  while not self.StatusLoaded do Citizen.Wait(0); end
  if self.dS and self.cS then self:Update(); end
end

MFS.IsBusy = false
MFS.DoingAnimation = false

function MFS:Update(...)
  local lastHealth = GetEntityHealth(PlayerPedId())
  while self.dS and self.cS do
    local plyPed = PlayerPedId()

    -- Vehicles
    if IsPedInAnyVehicle(plyPed,false) then
      self.IsDriving = true
      local speed = GetEntitySpeed(GetVehiclePedIsIn(plyPed,true)) * 3.6
      local onBike = IsPedOnAnyBike(plyPed)

      local multiplier = math.max(1.0,speed / self.StressAtSpeed)

      if onBike then
        if speed > self.RelaxAtSpeed and speed < self.StressAtSpeed then
          self.DoRelax = math.min((self.DoRelax or 0) + (self.StaticRelief * 10000),1000000)
          Citizen.Wait(1000)
        elseif speed > self.StressAtSpeed then
          TriggerEvent('esx_status:add','stress',(self.StaticAdder * 10000)*multiplier)
          Citizen.Wait(1000)
        end
      else
        if speed > self.StressAtSpeed then
          TriggerEvent('esx_status:add','stress',(self.StaticAdder * 10000)*multiplier)
          Citizen.Wait(1000)
        end
      end
    else
      self.IsDriving = false
    end 

    -- Interior
    if GetInteriorFromEntity(plyPed) == 197121 then
      self.DoRelax = math.min((self.DoRelax or 0) + (self.StaticRelief * 10000),1000000)
    end

    -- Swimming
    if IsPedSwimming(plyPed) then
      self.IsSwimming = true
      self.DoRelax = math.min((self.DoRelax or 0) + (self.StaticRelief * 10000),1000000)
    else
      self.IsSwimming = false
    end

    -- Combat
    if IsPedShooting(plyPed) or IsPedInMeleeCombat(plyPed) then
      if not self.IsBusy then self.IsBusy = true; end
      if IsPedInMeleeCombat(plyPed) then 
        TriggerEvent('esx_status:add','stress',self.CombatAdder * 10000)
        Citizen.Wait(1000)
      else
        TriggerEvent('esx_status:add','stress',self.ShootingAdder * 10000)
      end
    else
      if not self.IsSwimming and not self.DoingAnimation and not self.IsDriving then
        self.IsBusy = false
      elseif self.IsSwimming or self.DoingAnimation or self.IsDriving then 
        self.IsBusy = true
      end
    end

    -- Damaged
    --[[ if GetEntityHealth(plyPed) < lastHealth then
      lastHealth = GetEntityHealth(plyPed)
      TriggerEvent('esx_status:add','stress',self.CombatAdder * 10000)
    end ]]

    Citizen.Wait(0)
  end
end

function MFS:StressCheck(...)
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end

  local lastCough = GetGameTimer()
  local lastVomit = GetGameTimer()

  while true do 
    Citizen.Wait(1000)
    TriggerEvent('esx_status:getStatus','stress',function(status)
      local plyPed = PlayerPedId()
      if status.val >= (self.GetSickAt * 10000) then
        if not HasAnimDictLoaded("timetable@gardener@smoking_joint") then
          while not HasAnimDictLoaded("timetable@gardener@smoking_joint") do RequestAnimDict("timetable@gardener@smoking_joint"); Citizen.Wait(0); end
        end

        if not self.IsSick then
          self.IsSick = true
          -- exports['mythic_notify']:SendAlert('error', 'Stresin arttı')
          TriggerEvent('notification', 'Stresin arttı', 2)
        else
          --[[ if (GetGameTimer() - lastCough) > self.CoughTimer * 1000 then
            if not IsPedShooting(plyPed) and not IsPedInMeleeCombat(plyPed) then
              lastCough = GetGameTimer()
              while self.IsBusy do Citizen.Wait(100); end
              self.DoingAnimation = true
              --TaskPlayAnim(plyPed, "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
              Citizen.Wait(3000)
              ClearPedSecondaryTask(PlayerPedId())
              self.DoingAnimation = false
            end
          end ]]

          if status.val >= (self.ExtremelySickAt * 10000) then
            local plyPed = PlayerPedId()
            if not self.ExtremelySick then
              self.ExtremelySick = true
              -- exports['mythic_notify']:SendAlert('error', 'Stresin arttı')
              TriggerEvent('notification', 'Stresin arttı', 2)
              -- SetPedHeadOverlay(plyPed, 5, 26, (3 / 10) + 0.0)
              -- SetPedHeadOverlayColor(plyPed, 5, 2, 0)  
              -- SetPedHeadOverlay(plyPed, 7, 9,  (10 / 10) + 0.0)
            end

            --[[ if not HasAnimDictLoaded("oddjobs@taxi@tie") then RequestAnimDict("oddjobs@taxi@tie"); end
            while not HasAnimDictLoaded("oddjobs@taxi@tie") do  Citizen.Wait(0); end

            if (GetGameTimer() - lastVomit) > self.VomitTimer * 1000 then    
              if not IsPedShooting(plyPed) and not IsPedInMeleeCombat(plyPed) then
                lastVomit = GetGameTimer() 
                self.DoingAnimation = true
                --TaskPlayAnim(PlayerPedId(), "oddjobs@taxi@tie", "vomit_outside", 8.0, 8.0, -1, 50, 0, false, false, false)  
                Citizen.Wait(7000)
                ClearPedSecondaryTask(PlayerPedId())
                while self.IsBusy do Citizen.Wait(100); end
                self.DoingAnimation = false
                local hp = GetEntityHealth(PlayerPedId())
                if hp-self.VomitHealthLoss > 100 then SetEntityHealth(PlayerPedId(), hp - self.VomitHealthLoss); end
              end
            end]]
          elseif self.ExtremelySick then 
            self.ExtremelySick = false
            -- exports['mythic_notify']:SendAlert('inform', 'Stresin azaldı')
            TriggerEvent('notification', 'Stresin azaldı', 1)
          end
        end
      elseif status.val <= (self.GetSickAt * 10000) then
        if self.IsSick then
          self.IsSick = false
          -- exports['mythic_notify']:SendAlert('inform', 'Stresin azaldı')
          TriggerEvent('notification', 'Stresin azaldı', 1)
          ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('esx_skinchanger:loadSkin', skin)
          end)
        end
      end

      if status.val > 0 then
        if self.DoRelax and self.DoRelax > 0 then
          TriggerEvent('esx_status:remove','stress',1*10000)
          self.DoRelax = self.DoRelax - 1*10000
        end
      end
    end)
  end
end

function MFS.SetJob(source,job)
  local self = MFS
  self.PlayerData.job = job
end

function MFS.StatusLoaded(source)
  local self = MFS
  TriggerEvent('esx_status:registerStatus', 'stress', 0, '#CFAD0F', function(status)
    return true
  end, function(status)
    status.remove(0)
  end)
  self.StatusLoaded = true
end

function MFS.RelaxPlayer(source,val)
  local self = MFS
  if not source then return; end
  if not val then val = source; end
  self.DoRelax = math.min((self.DoRelax or 0) + val,100)
end

function MFS.StressPlayer(source,name,val)
  local self = MFS
  if not source or not name then return; end
  if not val then val = name; name = source; end
  if name == 'stress' then self.DoRelax = 0; end
end

function MFS.DoSmoke(source,getHigh)
  local self = MFS
  if not source then return; end
  local adder = 0
  if getHigh then adder = self.JointRelief
  else adder = self.SmokeRelief; end
  if adder > 0 then adder = adder * 10000; self.DoRelax = math.min((self.DoRelax or 0) + adder,1000000); end
  local plyPed = PlayerPedId()
  while self.IsBusy do Citizen.Wait(100); end
  self.DoingAnimation = true
  TaskStartScenarioInPlace(plyPed,"WORLD_HUMAN_SMOKING_POT",-1,true)
  Citizen.Wait(5000)
  ClearPedTasksImmediately(plyPed)
  self.DoingAnimation = false
  if getHigh then self:GetHigh(); end 
end

function MFS:GetHigh(...)
  if self.IsHigh then return; end
  self.IsHigh = true
  CT(function(...)
    local tick = 0.0
    local timer = GetGameTimer()
    local plyPed = PlayerPedId()
    SetTimecycleModifier("BikerFilter")
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)  
    SetTimecycleModifierStrength(0)
    SetPedMotionBlur(plyPed, true)

    while (GetGameTimer() - timer) < self.DrugsTimer * 1000 do
      SetTimecycleModifierStrength(tick)
      SetGameplayCamShakeAmplitude(tick)
      tick = tick + 0.001
      tick = math.min(1.0, tick)
      Citizen.Wait(0)
    end

    while tick > 0.0 do
      SetTimecycleModifierStrength(tick)
      SetGameplayCamShakeAmplitude(tick)
      tick = tick - 0.001   
      Citizen.Wait(0)
    end

    ClearTimecycleModifier()
    SetPedMotionBlur(PlayerPedId(), false)
    self.IsHigh = false
  end)
end

function MFS.DoDrink(source,alchohol)
  local self = MFS
  if not source then return; end
  local adder = 0
  if alchohol then adder = self.AlchoholRelief
  else adder = self.DrinkingRelief
  end
  if adder > 0 then adder = adder * 10000; self.DoRelax = math.min((self.DoRelax or 0) + adder,1000000); end
  local plyPed = PlayerPedId()
  while self.IsBusy do Citizen.Wait(100); end
  self.DoingAnimation = true
  TaskStartScenarioInPlace(plyPed,"WORLD_HUMAN_DRINKING",-1,false)
  Citizen.Wait(5000)
  ClearPedTasksImmediately(plyPed)
  self.DoingAnimation = false
  if alchohol then self:GetDrunk(); end
end

function MFS:GetDrunk(...)
  if self.IsDrink then return; end
  self.IsDrinking = true  
  CT(function(...)
    local tick = 0.0
    local timer = GetGameTimer()
    local plyPed = PlayerPedId()
    SetTimecycleModifier("drunk")
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)  
    SetTimecycleModifierStrength(0)
    SetPedMotionBlur(plyPed, true)

    while not HasClipSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do RequestClipSet("MOVE_M@DRUNK@VERYDRUNK"); Citizen.Wait(0); end
    SetPedMovementClipset(plyPed, "MOVE_M@DRUNK@VERYDRUNK", 1.0)

    while (GetGameTimer() - timer) < self.DrugsTimer * 1000 do
      SetTimecycleModifierStrength(tick)
      SetGameplayCamShakeAmplitude(tick)
      tick = tick + 0.001
      tick = math.min(1.0, tick)
      Citizen.Wait(0)
    end

    while tick > 0.0 do
      SetTimecycleModifierStrength(tick)
      SetGameplayCamShakeAmplitude(tick)
      tick = tick - 0.001   
      Citizen.Wait(0)
    end

    ClearTimecycleModifier()
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
    SetPedMotionBlur(PlayerPedId(), false)
    self.IsHigh = false
  end)
end

function MFS.HealPlayer(...)
  TriggerEvent('esx_status:remove','stress',1000000)
end

Citizen.CreateThread(function()
  while true do
    local hp = GetEntityHealth(PlayerPedId())
    TriggerEvent('esx_status:getStatus','stress', function(stress)
      if stress.val >= (MFS.ExtremelySickAt * 10000) then
        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.10)
        -- SetEntityHealth(PlayerPedId(), hp - 2);
      elseif stress.val >= (MFS.MildlySickAt * 10000) then
        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
        -- SetEntityHealth(PlayerPedId(), hp - 1);
      elseif stress.val >= (MFS.GetSickAt * 10000) then
        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
        -- SetEntityHealth(PlayerPedId(), hp - 1);
      end
    end)
  Citizen.Wait(1000)
  end
end)

-- Citizen.CreateThread(function()
--   while true do
--     TriggerEvent('esx_status:getStatus','stress', function(stress)
--       if stress.val >= (MFS.ExtremelySickAt * 20000) then
-- 		DoScreenFadeOut(1100)
-- 		Citizen.Wait(1000)
-- 		DoScreenFadeIn(1000)
--       end
--     end)
--   Citizen.Wait(7000)
--   end
-- end)

-- Citizen.CreateThread(function()
--   while true do
--     TriggerEvent('esx_status:getStatus','stress', function(stress)
--       if stress.val >= (MFS.MildlySickAt * 20000) and stress.val <= (MFS.ExtremelySickAt * 20000) then
-- 		DoScreenFadeOut(1100)
-- 		Citizen.Wait(1000)
-- 		DoScreenFadeIn(1000)
--       end
--     end)
--   Citizen.Wait(12000)
--   end
-- end)

-- Citizen.CreateThread(function()
--   while true do
--     TriggerEvent('esx_status:getStatus','stress', function(stress)
--       if stress.val >= (MFS.GetSickAt * 20000) and stress.val <= (MFS.MildlySickAt * 20000) then
-- 		DoScreenFadeOut(1100)
-- 		Citizen.Wait(1000)
-- 		DoScreenFadeIn(1000)
--       end
--     end)
--   Citizen.Wait(20000)
--   end
-- end)

NewEvent(true,MFS.SetJob,'esx:setJob')
NewEvent(true,MFS.StatusLoaded,'esx_status:loaded')
NewEvent(true,MFS.StressPlayer,'esx_status:add')
NewEvent(true,MFS.DoSmoke,'MF_Stress:Smoke')
NewEvent(true,MFS.DoDrink,'MF_Stress:Drink')
NewEvent(true,MFS.RelaxPlayer,'MF_Stress:Relax')
NewEvent(true,MFS.HealPlayer,'MF_Stress:Heal')

CT(function(...) MFS:Awake(...); end)
CT(function(...) MFS:StressCheck(...); end)