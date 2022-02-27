ESX = nil

Currentstates = {

	[1] = { ["text"] = "Ellerin Kızardı", ["status"] = false, ["timer"] = 0 },

	[2] = { ["text"] = "Gözlerin Genişledi", ["status"] = false, ["timer"] = 0 },

	[3] = { ["text"] = "Gözlerin Kızardı", ["status"] = false, ["timer"] = 0 },

	[4] = { ["text"] = "Esrar Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[5] = { ["text"] = "Sargı Sardın", ["status"] = false, ["timer"] = 0 },

	[6] = { ["text"] = "Tedirginsin", ["status"] = false, ["timer"] = 0 },

	[7] = { ["text"] = "Koordinasyonsuz", ["status"] = false, ["timer"] = 0 },

	[8] = { ["text"] = "Alkol Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[9] = { ["text"] = "Benzin Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[10] = { ["text"] = "Barut Kalıntıların Var", ["status"] = false, ["timer"] = 0 },

	[11] = { ["text"] = "Kimyasal Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[12] = { ["text"] = "Metal Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[13] = { ["text"] = "Ellerinde Mürekkep Var", ["status"] = false, ["timer"] = 0 },

	[14] = { ["text"] = "Sigara Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[15] = { ["text"] = "Kamp Ekipmanları Var", ["status"] = false, ["timer"] = 0 },

	[16] = { ["text"] = "Demir Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[17] = { ["text"] = "Tisortünde Metal İzleri Var", ["status"] = false, ["timer"] = 0 },

	[18] = { ["text"] = "Cigara Kokuyorsun", ["status"] = false, ["timer"] = 0 },

	[19] = { ["text"] = "Nefes Almakta Zorlanıyorsun", ["status"] = false, ["timer"] = 0 },

	[20] = { ["text"] = "Terledin", ["status"] = false, ["timer"] = 0 },

	[21] = { ["text"] = "Kıyafetlerin Terledi", ["status"] = false, ["timer"] = 0 },	

    [22] = { ["text"] = "Kesiklerin Var", ["status"] = false, ["timer"] = 0 },

	[23] = { ["text"] = "Giysilerin Kötü", ["status"] = false, ["timer"] = 0 },		

    [24] = { ["text"] = "Sersem Görünüyorsun", ["status"] = false, ["timer"] = 0 },

    [25] = { ["text"] = "İyi Beslenmiş Görünüyorsun", ["status"] = false, ["timer"] = 0 },

    [26] = { ["text"] = "Ellerinde Çizikler Var.", ["status"] = false, ["timer"] = 0 }, 

    [27] = { ["text"] = "Uyarılıyorsun", ["status"] = false, ["timer"] = 0 }, 

}







RegisterNetEvent("fuge-state:stateSet")

AddEventHandler("fuge-state:stateSet",function(stateId,stateLength)

	if Currentstates[stateId]["timer"] < 10 and stateLength ~= 0 then

		TriggerEvent('chat:addMessage', {template = '<div class="chat-message state"><r> {0}</r> {1}</div>', args = { "STATUS: ",  Currentstates[stateId]["text"] } })

	end

	Currentstates[stateId]["timer"] = stateLength

end)





local lastTarget

local target

local targetLastHealth

local bodySweat = 0

local sweatTriggered = false

Citizen.CreateThread(function()



    while true do

        Wait(300)



        if IsPedInAnyVehicle(PlayerPedId(), false) then

        	local vehicle = GetVehiclePedIsUsing(PlayerPedId())

        	local bicycle = IsThisModelABicycle( GetEntityModel(vehicle) )

        	local speed = GetEntitySpeed(vehicle)

        	if bicycle and speed > 0 then

        		sweatTriggered = true

        		if bodySweat < 180 then

        			bodySweat = bodySweat + (150 + math.ceil(speed * 20))

        		else

        			bodySweat = bodySweat + (150 + math.ceil(speed * 10))

        		end



        		if bodySweat > 300 then

	        		bodySweat = 300

	        	end

        	end

        end
		
		if IsPedOnAnyBike(PlayerPedId(), false) then

        	local vehicle = GetVehiclePedIsUsing(PlayerPedId())

        	local bicycle = IsThisModelABicycle( GetEntityModel(vehicle) )

        	local speed = GetEntitySpeed(vehicle)

        	if bicycle and speed > 0 then

        		sweatTriggered = true

        		if bodySweat < 180 then

        			bodySweat = bodySweat + (150 + math.ceil(speed * 20))

        		else

        			bodySweat = bodySweat + (150 + math.ceil(speed * 10))

        		end



        		if bodySweat > 300 then

	        		bodySweat = 300

	        	end

        	end

        end



        if IsPedInMeleeCombat(PlayerPedId()) then

        	bodySweat = bodySweat + 300

        	sweatTriggered = true

			target = GetMeleeTargetForPed(PlayerPedId())

        	if target == lastTarget or lastTarget == nil then

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

        			lastTarget = target

        		end

        	else

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

	        		targetLastHealth = GetEntityHealth(target)

	        		lastTarget = target

	        	end

        	end

        end
		
		
		if IsPedInCombat(PlayerPedId()) then

        	bodySweat = bodySweat + 300

        	sweatTriggered = true

			target = GetCombatTargetForPed(PlayerPedId())

        	if target == lastTarget or lastTarget == nil then

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

        			lastTarget = target

        		end

        	else

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

	        		targetLastHealth = GetEntityHealth(target)

	        		lastTarget = target

	        	end

        	end

        end



        if IsPedSwimming(PlayerPedId()) then

        	local speed = GetEntitySpeed(PlayerPedId())

        	if speed > 0 then

        		sweatTriggered = true

        		TriggerEvent("fuge-state:stateSet",20,0)

        		TriggerEvent("fuge-state:stateSet",21,0)

        		TriggerEvent("fuge-state:stateSet",23,600)

        		if bodySweat < 180 then

        			bodySweat = bodySweat + (100 + math.ceil(speed * 10))

        		else

        			bodySweat = bodySweat + (100 + math.ceil(speed * 11))

        		end

        		



        		if bodySweat > 210 then

        			TriggerEvent("fuge-state:stateSet",19,600)

	        		bodySweat = 210

	        	end

        	end

        end



        if IsPedRunning(PlayerPedId()) then

        	bodySweat = bodySweat + 30

        	if bodySweat > 800then

        		bodySweat = 800

        	end

        elseif bodySweat > 0.0 then

        	if not sweatTriggered then

        		bodySweat = 0.0

        	end

        	if bodySweat < 1200 then

        		bodySweat = bodySweat - 1000

        	end

        	bodySweat = bodySweat - 100

        	if bodySweat == 0.0 then

        		sweatTriggered = false

        	end

        end

        if bodySweat > 200 and not IsPedSwimming(PlayerPedId()) then

			TriggerEvent("fuge-state:stateSet",19,300)

        end  



        if bodySweat > 300 and not IsPedSwimming(PlayerPedId()) and Currentstates[22]["timer"] < 50 then

			TriggerEvent("fuge-state:stateSet",20,450)

        end 

        if bodySweat > 800 and not IsPedSwimming(PlayerPedId()) and Currentstates[22]["timer"] < 50 then

        	sweatTriggered = true

			TriggerEvent("fuge-state:stateSet",21,600)

        end



    end

end)