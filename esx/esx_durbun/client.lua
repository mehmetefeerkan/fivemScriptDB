-- FiveM Heli Cam by mraes
-- Version 1.3 2017-06-12

--CONFIG--
local fov_max = 150.0
local fov_min = 3.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right 
local speed_ud = 8.0 -- speed by which the camera pans up-down

local helicam = false
local fov = (fov_max+fov_min)*0.25
local vision_state = 0 -- 0 is normal, 1 is nightmode, 2 is thermal vision

--THREADS--

Citizen.CreateThread(function()
	while true do

        Citizen.Wait(0)

		local lPed = PlayerPedId()
		local heli = GetVehiclePedIsIn(lPed)
		
		if helicam then

			if not ( IsPedSittingInAnyVehicle( lPed ) ) then

						Citizen.CreateThread(function()

		                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
							PlayAmbientSpeech1(PlayerPedId(), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")

						end)

					else
					end	

					Wait(2000)

					SetTimecycleModifier("scanline_cam_cheap")

			SetTimecycleModifierStrength(1.0)

			-- local scaleform = RequestScaleformMovie("HELI_CAM")

			-- while not HasScaleformMovieLoaded(scaleform) do

				-- Citizen.Wait(10)

			-- end

			local lPed = PlayerPedId()
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, lPed, 0.0,0.0,1.0, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			-- PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			local locked_on_vehicle = nil

			while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and true do

				if IsControlJustPressed(0, 177) then -- Toggle Helicam

					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ClearPedTasks(PlayerPedId())
					helicam = false

				end

				if locked_on_vehicle then
					
				else
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)

					CheckInputRotation(cam, zoomvalue)

					local vehicle_detected = GetVehicleInView(cam)

				end

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(10)

			end

			helicam = false

			ClearTimecycleModifier()

			fov = (fov_max+fov_min)*0.5

			RenderScriptCams(false, false, 0, 1, 0)

			SetScaleformMovieAsNoLongerNeeded(scaleform)

			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

--EVENTS--

RegisterNetEvent('jumelles:Active') --Just added the event to activate the binoculars
AddEventHandler('jumelles:Active', function()
	helicam = not helicam
end)

--FUNCTIONS--

-- function IsPlayerInPolmav()
	-- local lPed = PlayerPedId()
	-- local vehicle = GetVehiclePedIsIn(lPed)
	-- return IsVehicleModel(vehicle, polmav_hash)
-- end


-- function ChangeVision()
	-- if vision_state == 0 then
		-- SetNightvision(true)
		-- vision_state = 1
	-- elseif vision_state == 1 then
		-- SetNightvision(false)
		-- SetSeethrough(true)
		-- vision_state = 2
	-- else
		-- SetSeethrough(false)
		-- vision_state = 0
	-- end
-- end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudComponentThisFrame(19) -- weapon wheel
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = PlayerPedId()
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,96) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,97) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	else
		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	--DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(PlayerPedId()), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end