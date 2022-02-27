ESX = nil
local camara = nil
local heading = 0
local plano = 'cara'				
local camcoord
local isOnCreator
local invisible = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- RegisterCommand("skincreator", function(source)
--     TriggerEvent('VexCreator:loadCreator')
-- end)

function changed(value1, value2)
    if value1 ~= value2 then
        return true
    else
        return false
    end
end

function ShowLocationSelection()
    SendNUIMessage({
		showLocationSelection = true
	})
end

function CloseVexCreator()
	local ped = PlayerPedId()
	VexCreator(false)
	isOnCreator = false
	SetCamActive(camara, false)
	RenderScriptCams(false, true, 500, true, true)
	camara = nil
	-- FreezeEntityPosition(ped, false)
	SetPlayerInvincible(ped, false)
    invisible = false
    Citizen.Wait(1000)
    SetEntityVisible(PlayerPedId(), true, 0)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
    -- SetEntityCollision(ped, true, true)
    CreateYourLooks()
end

function VexCreator(enable)
	SetNuiFocus(enable, enable)
	SendNUIMessage({
		showVexCreator = enable
	})
end

RegisterNUICallback('selectedspawn', function(data)
    CloseVexCreator()
	local location = data.location
    local ped = PlayerPedId()
    
    if location == "Airport" then
        DoScreenFadeOut(0)
        Citizen.Wait(1000)
        SetEntityCoords(PlayerPedId(),-1037.78,-2738.03,19.18)
        SetEntityHeading(PlayerPedId(),327.67)
        Citizen.Wait(2000)
        DoScreenFadeIn(3000)
    elseif location == "Train" then
        DoScreenFadeOut(0)
        Citizen.Wait(1000)
        SetEntityCoords(PlayerPedId(),-1341.9,-489.47,14.06)
        SetEntityHeading(PlayerPedId(),297.11)
        Citizen.Wait(2000)
        DoScreenFadeIn(3000)
    end
end)

RegisterNUICallback('rotar', function(data)
	local currentHeading = GetEntityHeading(PlayerPedId())
	heading = currentHeading+tonumber(data.value)
end)

RegisterNUICallback('cambiarplano', function(data)
	plano = data.plano
end)

RegisterNetEvent('VexCreator:loadCreator')
AddEventHandler('VexCreator:loadCreator', function()
    local playerPed    = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	camcoord  = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 3.0, 0.0)
    facecoord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.8, 0.6)
    clothescoord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0.1)
    invisible = true
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
    h = GetEntityHeading(PlayerPedId())
    heading = GetEntityHeading(PlayerPedId())
	isOnCreator = true
	VexCreator(true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(invisible)then
            SetEntityVisible(PlayerPedId(), false, 0)
            SetPlayerVisibleLocally(PlayerId(), true)
        end
    end
end)

RegisterNUICallback('updateSkin', function(data)

    v = data.value

    local player = PlayerPedId()

    if changed(dad, data.dad) or changed(mum, data.mum) or changed(morfpercent, data.morfpercent) or changed(skintone, data.skintone) or changed(sexo, data.sex) then
        dad = tonumber(data.dad)
	    mum = tonumber(data.mum)
        morfpercent = tonumber(data.morfpercent)
	    skintone = tonumber(data.skintone)
        local face_weight = 		(morfpercent / 100) + 0.0
		local skin_weight =			(skintone / 100) + 0.0
        SetPedHeadBlendData(player, mum, dad, 0, mum, dad, 0, face_weight, skin_weight, 0.0, false)
    end

    if changed(sexo, data.sex) then
        local face_weight = 		(morfpercent / 100) + 0.0
		local skin_weight =			(skintone / 100) + 0.0
        sexo = tonumber(data.sex)
        TriggerEvent('skinchanger:loadSkin', {sex = sexo})
        SetPedHeadBlendData(player, mum, dad, 0, mum, dad, 0, face_weight, skin_weight, 0.0, false)
    end

    if changed(nosewidth, data.nosewidth) then
        nosewidth = tonumber(data.nosewidth)
        SetPedFaceFeature(player,0,(nosewidth / 10) + 0.0)	-- Nose Width
    end

    if changed(noseh, data.noseh) then
        noseh = tonumber(data.noseh)
        SetPedFaceFeature(player,1,(noseh / 10) + 0.0) -- Nose Peak Height
    end

    if changed(nosepeakl, data.nosepeakl) then
        nosepeakl = tonumber(data.nosepeakl)
		SetPedFaceFeature(player,2,(nosepeakl / 10) + 0.0)	-- Nose Peak Length
    end

    if changed(noseboneh, data.noseboneh) then
        noseboneh = tonumber(data.noseboneh)
		SetPedFaceFeature(player,3,(noseboneh / 10) + 0.0) -- Nose Bone Height
    end

    if changed(nosepeakh, data.nosepeakh) then
        nosepeakh = tonumber(data.nosepeakh)
        SetPedFaceFeature(player,4,(nosepeakh / 10) + 0.0) -- Nose Peak Lowering
    end

    if changed(nosetwist, data.nosetwist) then
        nosetwist = tonumber(data.nosetwist)
        SetPedFaceFeature(player,5,(nosetwist / 10) + 0.0) -- Nose Bone Twist
    end

    if changed(eyesbrowh, data.eyesbrowh) then
        eyesbrowh = tonumber(data.eyesbrowh)
        SetPedFaceFeature(player,6,(eyesbrowh / 10) + 0.0) -- Eyebrow height
    end

    if changed(eyesbrowd, data.eyesbrowd) then
        eyesbrowd = tonumber(data.eyesbrowd)
        SetPedFaceFeature(player,7,(eyesbrowd / 10) + 0.0) -- Eyebrow depth
    end

    if changed(cheekboneh, data.cheekboneh) then
        cheekboneh = tonumber(data.cheekboneh)
        SetPedFaceFeature(player,8,(cheekboneh / 10) + 0.0) -- Cheekbones Height
    end

    if changed(cheekbonew, data.cheekbonew) then
        cheekbonew = tonumber(data.cheekbonew)
        SetPedFaceFeature(player,9,(cheekbonew / 10) + 0.0) -- Cheekbones Width
    end

    if changed(cheekw, data.cheekw) then
        cheekw = tonumber(data.cheekw)
        SetPedFaceFeature(player,10,(cheekw / 10) + 0.0) -- Cheeks Width
    end

    if changed(eyesquint, data.eyesquint) then
        eyesquint = tonumber(data.eyesquint)
        SetPedFaceFeature(player,11,(eyesquint / 10) + 0.0)	-- Eyes squint
    end

    if changed(lips, data.lips) then
        lips = tonumber(data.lips)
        SetPedFaceFeature(player,12,(lips / 10) + 0.0)	-- Lip Fullness
    end

    if changed(jawh, data.jawh) then
        jawh = tonumber(data.jawh)
        SetPedFaceFeature(player,13,(jawh / 10) + 0.0) -- Jaw Bone Width
    end

    if changed(jaww, data.jaww) then
        jaww = tonumber(data.jaww)
        SetPedFaceFeature(player,14,(jaww / 10) + 0.0) -- Jaw Bone Length
    end

    if changed(chinh, data.chinh) then
        chinh = tonumber(data.chinh)
        SetPedFaceFeature(player,15,(chinh / 10) + 0.0) -- Chin Height
    end

    if changed(chinl, data.chinl) then
        chinl = tonumber(data.chinl)
        SetPedFaceFeature(player,16,(chinl / 10) + 0.0) -- Chin Length
    end

    if changed(chinw, data.chinw) then
        chinw = tonumber(data.chinw)
        SetPedFaceFeature(player,17,(chinw / 10) + 0.0) -- Chin Width
    end

    if changed(chinhole, data.chinhole) then
        chinhole = tonumber(data.chinhole)
        SetPedFaceFeature(player,18,(chinhole / 10) + 0.0) -- Chin Hole Size
    end

    if changed(neck, data.neck) then
        neck = tonumber(data.neck)
        SetPedFaceFeature(player,19,(neck / 10) + 0.0) -- Neck Thickness
    end

    if changed(eyecolor, data.eyecolor) then
        eyecolor = tonumber(data.eyecolor)
        SetPedEyeColor(player, eyecolor) -- EyeColor
    end

    if changed(skinproblem, data.skinproblem) or changed(skinproblemopacity, data.skinproblemopacity) then
        skinproblem = tonumber(data.skinproblem)
        skinproblemopacity = tonumber(data.skinproblemopacity)    
        SetPedHeadOverlay(player,6,skinproblem,skinproblemopacity * 0.1)
    end

    if changed(freckle, data.freckle) or changed(freckleopacity, data.freckleopacity) then
        freckle = tonumber(data.freckle)
        freckleopacity = tonumber(data.freckleopacity)    
        SetPedHeadOverlay(player,9,freckle,freckleopacity * 0.1)
    end

    if changed(cicatrices, data.cicatrices) or changed(cicatricesp, data.cicatricesp) then
        cicatrices = tonumber(data.cicatrices)
        cicatricesp = tonumber(data.cicatricesp)    
        SetPedHeadOverlay(player,7,cicatrices, cicatricesp * 0.1)
    end

    if changed(wrinkle, data.wrinkle) or changed(wrinkleopacity, data.wrinkleopacity) then
        wrinkle = tonumber(data.wrinkle)
        wrinkleopacity = tonumber(data.wrinkleopacity)
        SetPedHeadOverlay(player, 3, wrinkle, wrinkleopacity * 0.1)    
    end

    if changed(hair, data.hair) or changed(hair2, data.hair2) then
        hair = tonumber(data.hair)
        hair2 = tonumber(data.hair2) 
        SetPedComponentVariation(player, 2, hair, hair2, 2)
    end

    if changed(haircolor, data.haircolor) or changed(haircolor2, data.haircolor2) then
        haircolor = tonumber(data.haircolor)
        haircolor2 = tonumber(data.haircolor2)    
        SetPedHairColor(player, haircolor, haircolor2)
    end

    if changed(eyebrow, data.eyebrow) or changed(eyebrowopacity, data.eyebrowopacity) or changed(eyebrowcolor, data.eyebrowcolor) then
        eyebrow = tonumber(data.eyebrow)
        eyebrowopacity = tonumber(data.eyebrowopacity)
        eyebrowcolor = tonumber(data.eyebrowcolor)
        SetPedHeadOverlay(player, 2, eyebrow, eyebrowopacity * 0.1)
        SetPedHeadOverlayColor(player, 2, 1, eyebrowcolor, eyebrowcolor)					-- Eyebrows Color
    end

    if changed(beard, data.beard) or changed(beardopacity, data.beardopacity) then
        beard = tonumber(data.beard)
        beardopacity = tonumber(data.beardopacity)    
        SetPedHeadOverlay(player, 1, beard, beardopacity * 0.1)   
    end

    if changed(beardcolor, data.beardcolor) then
        beardcolor = tonumber(data.beardcolor)
        SetPedHeadOverlayColor(player, 1, 1, beardcolor, beardcolor)    
    end

    if changed(makeuptype, data.makeuptype) or changed(makeupintensidad, data.makeupintensidad) then
        makeuptype = tonumber(data.makeuptype)
        makeupintensidad = tonumber(data.makeupintensidad)
        SetPedHeadOverlay(player, 4, makeuptype, makeupintensidad * 0.1) -- Makeup
    end

    if changed(lipsticktype, data.lipsticktype) or changed(lipstickintensidad, data.lipstickintensidad) then
        lipsticktype = tonumber(data.lipsticktype)
        lipstickintensidad = tonumber(data.lipstickintensidad)    
        SetPedHeadOverlay(player, 8, lipsticktype, lipstickintensidad * 0.1) -- lipstick
    end

    if changed(lipstickcolor1, data.lipstickcolor1) then
        lipstickcolor1 = tonumber(data.lipstickcolor1)
        SetPedHeadOverlayColor(player, 8, 1, lipstickcolor1, 0) -- Lipstick Color
    end

    if changed(makeupcolor1, data.makeupcolor1) or changed(makeupcolor2, data.makeupcolor2) then
        makeupcolor1 = tonumber(data.makeupcolor1)
        makeupcolor2 = tonumber(data.makeupcolor2)    
        SetPedHeadOverlayColor(player, 4, 1, makeupcolor1, makeupcolor2) -- Makeup Color
    end

    if changed(blushtype, data.blushtype) or changed(blushintensidad, data.blushintensidad) then
        blushtype = tonumber(data.blushtype)
        blushintensidad = tonumber(data.blushintensidad)    
        SetPedHeadOverlay(player, 5, blushtype, blushintensidad * 0.1) -- Blush + opacity
    end

    if changed(blushcolor, data.blushcolor) then
        blushcolor = data.blushcolor
        SetPedHeadOverlayColor(player, 5, 2, blushcolor) -- Blush Color
    end

    if changed(tshirt, data.tshirt) or changed(tshirtcolor, data.tshirtcolor) then
        tshirt = tonumber(data.tshirt)
        tshirtcolor = tonumber(data.tshirtcolor)
        SetPedComponentVariation(player, 8, tshirt, tshirtcolor, 2)	-- Tshirt
    end

    if changed(torso, data.torso) or changed(torsocolor, data.torsocolor) then
        torso = tonumber(data.torso)
        torsocolor = tonumber(data.torsocolor)
        SetPedComponentVariation(player, 11, torso, torsocolor, 2)	-- Torso
    end

    if changed(arms, data.arms) or changed(armscolor, data.armscolor) then
        arms = tonumber(data.arms)
        armscolor = tonumber(data.armscolor)
        SetPedComponentVariation(player, 3, arms, armscolor, 2)	-- Arms
    end

    if changed(pants, data.pants) or changed(pantscolor, data.pantscolor) then
        pants = tonumber(data.pants)
        pantscolor = tonumber(data.pantscolor)
        SetPedComponentVariation(player, 4, pants, pantscolor, 2)	-- Pants
    end

    if changed(shoes, data.shoes) or changed(shoescolor, data.shoescolor) then
        shoes = tonumber(data.shoes)
        shoescolor = tonumber(data.shoescolor)
        SetPedComponentVariation(player, 6, shoes, shoescolor, 2)	-- Shoes
    end

    if changed(ears, data.ears) or changed(earscolor, data.earscolor) then
        ears = tonumber(data.ears)
        earscolor = tonumber(data.earscolor)
        if ears == -1 then
            ClearPedProp(player, 2)
        else
            SetPedPropIndex(player, 2, ears, earscolor, 2)	-- Ears Accessories
        end
    end

    if changed(chain, data.chain) or changed(chaincolor, data.chaincolor) then
        chain = tonumber(data.chain)
        chaincolor = tonumber(data.chaincolor)
        SetPedComponentVariation(player, 7, chain, chaincolor, 2)	-- Chain
    end

    if changed(glasses, data.glasses) or changed(glassescolor, data.glassescolor) then
        glasses = tonumber(data.glasses)
        glassescolor = tonumber(data.glassescolor)
        if glasses == -1 then
            ClearPedProp(player, 1)
        else
            SetPedPropIndex(player, 1, glasses, glassescolor, 2)	-- Glasses
        end
    end

    if changed(watches, data.watches) or changed(watchescolor, data.watchescolor) then
        watches = tonumber(data.watches)
        watchescolor = tonumber(data.watchescolor)
        if watches == -1 then
            ClearPedProp(player, 6)
        else
            SetPedPropIndex(player, 6, watches, watchescolor, 2)	-- Watches
        end
    end

	if(v == true) then
		local skin = {}
		skin['dad'] = dad
		skin['mom'] = mum
		skin['sex'] = sexo
		skin['face_md_weight'] = morfpercent
		skin['skin_md_weight'] = skintone
		skin['lip_thickness'] = lips
		skin['neck_thickness'] = neck
		skin['jaw_1'] = jawh
		skin['jaw_2'] = jaww
		skin['chin_1'] = chinh
		skin['chin_2'] = chinl
		skin['chin_3'] = chinw
		skin['chin_4'] = chinhole
		skin['eye_squint'] = eyesquint
		skin['eyebrows_5'] = eyesbrowh
		skin['eyebrows_6'] = eyesbrowd
		skin['nose_1'] = nosewidth
		skin['nose_2'] = noseh
		skin['nose_3'] = nosepeakl
		skin['nose_4'] = noseboneh
		skin['nose_5'] = nosepeakh
		skin['nose_6'] = nosetwist
		skin['cheeks_1'] = cheekboneh
		skin['cheeks_2'] = cheekbonew
		skin['cheeks_3'] = cheekw
		skin['eye_color'] = eyecolor
		skin['complexion_1'] = skinproblem
		skin['complexion_2'] = skinproblemopacity
		skin['moles_1'] = freckle
		skin['moles_2'] = freckleopacity
		skin['sun_1'] = cicatrices
		skin['sun_2'] = cicatricesp
		skin['age_1'] = wrinkle
		skin['age_2'] = wrinkleopacity
		skin['hair_1'] = hair
		skin['hair_2'] = hair2
		skin['hair_color_1'] = haircolor
		skin['hair_color_2'] = haircolor2
		skin['eyebrows_1'] = eyebrow
		skin['eyebrows_2'] = eyebrowopacity
        skin['eyebrows_3'] = eyebrowcolor
        skin['eyebrows_4'] = eyebrowcolor
		skin['beard_1'] = beard
		skin['beard_2'] = beardopacity
		skin['beard_3'] = beardcolor
		skin['makeup_1'] = makeuptype
		skin['makeup_2'] = makeupintensidad
		skin['makeup_3'] = makeupcolor1
		skin['makeup_4'] = makeupcolor2
		skin['lipstick_1'] = lipsticktype
		skin['lipstick_2'] = lipstickintensidad
		skin['lipstick_3'] = lipstickcolor1
		skin['blush_1'] = blushtype
		skin['blush_2'] = blushintensidad
		skin['blush_3'] = blushcolor
		skin['arms'] = GetPedDrawableVariation(player, 3)
		skin['arms_2'] = GetPedTextureVariation(player, 3)
		skin['pants_1'] = GetPedDrawableVariation(player, 4)
		skin['pants_2'] = GetPedTextureVariation(player, 4)
		skin['shoes_1'] = GetPedDrawableVariation(player, 6)
		skin['shoes_2'] = GetPedTextureVariation(player, 6)
		skin['chain_1'] = GetPedDrawableVariation(player, 7)
		skin['chain_2'] = GetPedTextureVariation(player, 7)
		skin['tshirt_1'] = GetPedDrawableVariation(player, 8)
		skin['tshirt_2'] = GetPedTextureVariation(player, 8)
		skin['torso_1'] = GetPedDrawableVariation(player, 11)
		skin['torso_2'] = GetPedTextureVariation(player, 11)
		skin['helmet_1'] = GetPedPropIndex(player, 0)
		skin['helmet_2'] = GetPedPropTextureIndex(player, 0)
		skin['glasses_1'] = GetPedPropIndex(player, 1)
		skin['glasses_2'] = GetPedPropTextureIndex(player, 1)
		skin['ears_1'] = GetPedPropIndex(player, 2)
		skin['ears_2'] = GetPedPropTextureIndex(player, 2)
		skin['watches_1'] = GetPedPropIndex(player, 6)
		skin['watches_2'] = GetPedPropTextureIndex(player, 6)
		TriggerServerEvent('esx_skin:save', skin)
        TriggerEvent('skinchanger:loadSkin', skin)
        -- ShowLocationSelection()   
        CloseVexCreator() 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local ped = PlayerPedId()

		if isOnCreator == true then
            local x,y,z = table.unpack(camcoord)

            DisableControlAction(0, 25, true)
            DisableControlAction(0, 24, true)
			DisableControlAction(2, 14, true)
            DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
            DisableControlAction(2, 16, true)
			DisableControlAction(2, 17, true)
            DisableControlAction(2, 31, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 15, true)
			-- DisableControlAction(2, 32, true)
			
			-- Opciones del Jugador
			-- FreezeEntityPosition(ped, true)
            SetPlayerInvincible(ped, true)
            -- NetworkSetEntityInvisibleToNetwork(ped, false)
            -- SetEntityCollision(ped, false, true)
			
            -- Camara
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(camara, false)
			if(not DoesCamExist(camara)) then
				camara = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
				SetCamActive(camara,  true)
				RenderScriptCams(true,  false,  0,  true,  true)
				SetCamCoord(camara, camcoord)
                SetCamRot(camara, 0.0, 0.0, h-180.0)
			end

			if plano == 'cara' then
                SetCamCoord(camara, facecoord)
            elseif plano == 'ropa' then
                SetCamCoord(camara, clothescoord)
            elseif plano == 'tatuajes' then
                SetCamCoord(camara, x, y+1.5, z+0.2)
            end
			
            if heading ~= GetEntityHeading(ped) then
			    SetEntityHeading(ped, heading)
            end
		end
	end

end)


CreateYourLooks = function()
	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = 'Save',
			align = 'top-left',
			elements = {
				{label = 'Yes', value = 'yes'}
				}
				}, function(data, menu)
				menu.close()
				if data.current.value == 'yes' then					
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
					end)
				end
			end, function(data, menu)
				menu.close()
			end)
		end, function(data, menu)
		menu.close()
	end, {
	'tshirt_1',
	'tshirt_2',
	'torso_1',
	'torso_2',
	'arms',
	'arms_2',
	'pants_1',
	'pants_2',
	'shoes_1',
	'shoes_2',
})
end