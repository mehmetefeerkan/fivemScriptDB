local recoils = {


	-- pistols
	[416676503] = 0.34,

	--smg
	[-957766203] = 0.22,

	-- rifles
	[970310034] = 0.17,

}


local myRecoilFactor = 0.0
RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)

    myRecoilFactor = sendFactor / 5 + 0.0

end)


function quickmafs(dir)
	local x = 0.0
	local y = 0.0
	local dir = dir
	if dir >= 0.0 and dir <= 90.0 then
		local factor = (dir/9.2) / 10
		x = -1.0 + factor
		y = 0.0 - factor
	end

	if dir > 90.0 and dir <= 180.0 then
		dirp = dir - 90.0
		local factor = (dirp/9.2) / 10
		x = 0.0 + factor
		y = -1.0 + factor
	end

	if dir > 180.0 and dir <= 270.0 then
		dirp = dir - 180.0
		local factor = (dirp/9.2) / 10
		x = 1.0 - factor
		y = 0.0 + factor
	end

	if dir > 270.0 and dir <= 360.0 then
		dirp = dir - 270.0
		local factor = (dirp/9.2) / 10	
		x = 0.0 - factor
		y = 1.0 - factor
	end
	return x,y
end

Citizen.CreateThread( function()

	
	while true do 

		 if IsPedArmed(PlayerPedId(), 6) then
		 	Citizen.Wait(1)
		 else
		 	Citizen.Wait(1500)
		 end  

	    if IsPedShooting(PlayerPedId()) then
	    	local ply = PlayerPedId()
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
	    	local MovementSpeed = math.ceil(GetEntitySpeed(ply))

	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local _,wep = GetCurrentPedWeapon(ply)

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(100,140+MovementSpeed)/100
	        local rifle = false


          	if group == 970310034 then
          		rifle = true
          	end

          	if cameraDistance < 5.3 then
          		cameraDistance = 1.5
          	else
          		if cameraDistance < 8.0 then
          			cameraDistance = 4.0
          		else
          			cameraDistance = 7.0
          		end
          	end


	        if Vehicled then
	        	recoil = recoil + (recoil * cameraDistance)
	        else
	        	recoil = recoil * 0.8
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.7
		        if rifle then
		        	recoil = recoil * 0.1
		        end

	        end

	        if rifle then
	        	recoil = recoil * 0.7
	        end

	        local rightleft = math.random(4)
	        local h = GetGameplayCamRelativeHeading()
	        local hf = math.random(10,40+MovementSpeed)/100

	        if Vehicled then
	        	hf = hf * 2.0

	        end

	        if rightleft == 1 then
	        	SetGameplayCamRelativeHeading(h+hf)
	        elseif rightleft == 2 then
	        	SetGameplayCamRelativeHeading(h-hf)
	        end 
        
	        local set = p+recoil

	       	SetGameplayCamRelativePitch(set,0.8)    	       	

	       	
	      -- 	print(GetGameplayCamRelativePitch())

	    end
	end

end)