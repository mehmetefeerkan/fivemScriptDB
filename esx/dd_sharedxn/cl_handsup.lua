local isDead = false
local isHandsUp = false
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)

Citizen.CreateThread(function()
	inLoops.CreateLoop(15, handsup1)
end )

handsup1 = function()

    if IsControlJustPressed(1, 323) and not isDead then --Start holding X
        local player = PlayerPedId()

        if ( DoesEntityExist( player ) and not IsEntityDead( player ) ) then

            if IsEntityPlayingAnim(player, "random@mugging3", "handsup_standing_base", 3) then
                ClearPedSecondaryTask(player)
                isHandsUp = false
            else
                loadAnimDict( "random@mugging3" )
                TaskPlayAnim(player, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
                -- SetCurrentPedWeapon(player, GetHashKey('WEAPON_UNARMED'), true)
                RemoveAnimDict("random@mugging3")
                isHandsUp = true
            end
        end
    end

end

Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if isHandsUp then
			sleep = 0
			DisableControlAction(0, 106, true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(sleep)
	end
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end