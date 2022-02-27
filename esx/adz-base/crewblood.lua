function setBleedingOn(ped)
   SetEntityHealth(ped,GetEntityHealth(ped)-2)
   if not effect then
  --StartScreenEffect('Rampage', 0, true)
  effect = true
  end
   --ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
   exports['chubbsnotify']:DoLongHudText('error', ("Doktora görünmen gerek. Kanaman var!"))
   SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
   Wait(7000)

end

function setBleedingOff(ped)
   effect = false
   StopScreenEffect('Rampage')
   SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
end

local effect = false

Citizen.CreateThread(function()
while true do
Citizen.Wait(0)
local player = GetPlayerPed(-1)
local Health = GetEntityHealth(player)

 if Health <= 139  then
    setBleedingOn(player)
	setHurt()

 elseif Health > 140 then
   setBleedingOff(player)
   setNotHurt()
 end
end
end)
 
function InfoRanny(text)
SetNotificationTextEntry("STRING")
AddTextComponentString(text)
DrawNotification(false, false)
end

local hurt = false
function setHurt()
	hurt = true
    RequestAnimSet("move_m@injured")
	while not HasAnimSetLoaded("move_m@injured") do
		Wait(50)
	end
    SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
end

function setNotHurt()
	if hurt == true then
		hurt = false
		ResetPedMovementClipset(PlayerPedId())
		ResetPedWeaponMovementClipset(PlayerPedId())
		ResetPedStrafeClipset(PlayerPedId())
	end
end