ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local pisiriyormu = false
-- local hazirliyormu = false
local paketliyormu = false
local ekmekaliyormu = false
-- local malzemealiyormu = false
local satiyormu = false
local satiskordinat = false
local satisblip = false
local sleep = 2000
local isInMarker = false
local isInMarker2 = false
local aracalindi = false

local locations = { -- Random Delivers Location Config 
    vector4(-212.88, -1618.16, 34.87, 183.45),
    vector4(-223.15, -1617.6, 34.87, 90.52),
    vector4(-223.15, -1601.2, 34.88, 89.98),
    vector4(-223.06, -1585.81, 34.87, 96.12),
    vector4(-219.32, -1579.92, 34.87, 56.45),
    vector4(-215.66, -1576.28, 34.87, 328.55),
    vector4(-208.74, -1600.64, 34.87, 262.82),
    vector4(-210.01, -1607.03, 34.87, 258.99),
    vector4(-205.7, -1585.59, 38.05, 261.13),
    vector4(-215.73, -1576.32, 38.05, 318.59),
    vector4(-219.29, -1579.92, 38.05, 57.37),
    vector4(-223.09, -1585.89, 38.05, 84.95),
    vector4(-223.07, -1601.14, 38.05, 91.67),
    vector4(-223.08, -1617.59, 38.06, 100.36),
    vector4(-212.1, -1617.63, 38.05, 253.22),
    vector4(-209.96, -1607.11, 38.05, 262.46),
    vector4(-208.63, -1600.57, 38.05, 264.01),
    vector4(-160.08, -1636.25, 34.03, 319.31),
    vector4(-161.1, -1638.77, 34.03, 139.27),
    vector4(-161.66, -1638.4, 37.25, 142.38),
    vector4(159.96, -1636.3, 37.25, 326.86),
    vector4(-150.35, -1625.66, 33.66, 235.2),
    vector4(-151.32, -1622.34, 33.65, 56.46),
    vector4(-144.95, -1618.58, 36.05, 230.86),
    vector4(-152.42, -1623.58, 36.85, 51.96),
    vector4(-150.36, -1625.62, 36.85, 236.43),
    vector4(69.0, -1570.04, 29.6, 230.32),
    vector4(20.43, -1505.37, 31.85, 54.24),
    vector4(-1098.15, -345.84, 37.8, 355.64),
    vector4(-1102.43, -367.91, 37.78, 211.79),
    vector4(-1112.61, -355.77, 37.8, 86.28),
    vector4(-1077.63, -354.84, 37.8, 204.43),
    vector4(-930.84, -214.46, 38.55, 265.65),
    vector4(-783.65, -390.64, 37.33, 334.83),
    vector4(-733.45, -317.38, 36.55, 343.73),
    vector4(-1200.24, -156.96, 40.09, 193.64),
    vector4(-1440.64, -174.37, 47.7, 93.43),
    vector4(-336.23, 30.89, 47.86, 258.93),
    vector4(-338.85, 21.43, 47.86, 258.64),
    vector4(-345.18, 17.91, 47.86, 168.13),
    vector4(-360.45, 20.89, 47.86, 174.26),
    vector4(-371.42, 23.1, 47.86, 178.76),
    vector4(-362.25, 57.76, 54.43, 2.21),
    vector4(-350.59, 57.74, 54.43, 359.38),
    vector4(-344.57, 57.55, 54.43, 354.84),
    vector4(-333.07, 57.1, 54.43, 354.49),
    vector4(-483.53, -18.08, 45.09, 176.3),
    vector4(-492.97, -17.99, 45.06, 177.8),
    vector4(-500.47, -19.27, 45.13, 218.85),
    vector4(-569.88, 169.57, 66.57, 85.5),
    vector4(-476.72, 217.54, 83.7, 177.98),
    vector4(-310.15, 221.54, 87.93, 194.03),
    vector4(-169.9, 285.42, 93.76, 355.38),
    vector4(57.58, 449.66, 147.03, 151.65),
    vector4(318.84, 561.05, 155.0, 199.5),
    vector4(228.73, 765.8, 204.97, 238.66),
    vector4(-429.48, 1109.5, 327.68, 165.38),
    vector4(1179.77, -394.61, 68.0, 73.78),
    vector4(1114.32, -391.27, 68.95, 243.22),
    vector4(1028.76, -408.28, 66.34, 40.17),
    vector4(945.84, -519.02, 60.63, 121.84),
    vector4(964.3, -596.2, 59.9, 253.62),
    vector4(996.89, -729.58, 57.82, 128.54),
    vector4(1207.47, -620.29, 66.44, 268.16),
    vector4(1341.31, -597.31, 74.7, 48.81),
    vector4(1389.03, -569.57, 74.5, 293.76),
    vector4(1303.21, -527.36, 71.46, 340.6),
    vector4(213.08, -592.83, 43.87, 342.72),
    vector4(269.81, -640.79, 42.02, 245.95),
    vector4(-192.43, -652.64, 40.68, 71.02),
    vector4(-759.92, -709.14, 30.06, 94.47),
    vector4(-741.55, -982.29, 17.44, 203.21),
    vector4(-884.2, -1072.55, 2.53, 212.04),
    vector4(-978.07, -1108.35, 2.15, 214.74),
    vector4(-985.86, -1121.67, 4.55, 302.03),
    vector4(-991.71, -1103.4, 2.15, 31.96),
    vector4(-1113.9, -1193.92, 2.38, 215.16),
    vector4(-1207.17, -1264.31, 7.08, 150.31),
    vector4(-1150.83, -1519.37, 4.36, 308.62),
    vector4(-935.52, -1523.16, 5.24, 287.73),
    vector4(347.01, 2618.08, 44.67, 213.95),
}

function DrawText3D(x, y, z, text)
	SetTextScale(0.30, 0.30)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 15, 16, 17, 100)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(sleep)
		perform = false
		isInMarker = false

		local player = PlayerPedId()
		local playerCoords = GetEntityCoords(player)
		local distance = GetDistanceBetweenCoords(playerCoords, -256.49, -978.07, 31.22, true)
		local distance2 = GetDistanceBetweenCoords(playerCoords, -253.06, -994.93, 29.49, true)

		if (distance < 16) then
			perform = true
			DrawMarker(2, -256.49, -978.07, 31.22, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
			if distance < 3 then
				isInMarker = true
				DrawText3D(-256.49, -978.07, 31.22 + 0.4, '~g~E~s~ - Meslek Aracı Çıkart')
			end
		end

		if (distance2 < 16) then
			perform = true
			DrawMarker(2, -253.0, -994.95, 29.52, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
			if distance2 < 3 then
				isInMarker2 = true
				DrawText3D(-253.0, -994.95, 29.52 + 0.4, '~g~E~s~ - Meslek Aracını Geri Ver')
			end
		end

		if IsControlJustReleased(0, 38) and isInMarker then
			AracCikart()
		elseif IsControlJustReleased(0, 38) and isInMarker2 then
			AracSil()
		end

		if perform then
			sleep = 7
		elseif not perform then
			sleep = 2000
		end

	end
end)

function AracCikart()
	local player = PlayerPedId()
	local aractami = IsPedInAnyVehicle(player, false)
	if not aractami then
		if not aracalindi then
			ESX.Game.SpawnVehicle('blista', vector3(-253.06, -994.93, 29.49), 248.18, function(vehicle)
				local plate = 'ADEZTR' .. math.random(100, 900)
				SetVehicleNumberPlateText(vehicle, plate)
				-- local plate2 = GetVehicleNumberPlateText(vehicle)
				-- exports['hsn-hotwire']:AddKeys(plate2)
				aracalindi = true
				TaskWarpPedIntoVehicle(player, vehicle, -1)
			end)
			TriggerServerEvent('bros-jobveh:takemoney')
		else
			ESX.ShowNotification('Zaten araç almışsınız!')
		end
	else
		ESX.ShowNotification('Bir araçtayken bunu yapamazsınız!')
	end
end

function AracSil()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)
    local driver = GetPedInVehicleSeat(vehicle, -1)
	local model = GetEntityModel(vehicle)
	local aractami = IsPedInAnyVehicle(player, false)
	if aractami then
		if aracalindi then
			if player == driver then
				if model == -344943009 then
            		DeleteVehicle(vehicle)
            		aracalindi = false
					ESX.TriggerServerCallback("bros-jobveh:givemoney", function(CB)
						if CB then
						  ESX.ShowNotification('Depozito olarak alınan 100$ banka hesabınıza iade edildi!')
						end
					end, 100)
				else
					ESX.ShowNotification('Bu araç meslek aracı değil!')
				end
			else
				ESX.ShowNotification('Aracın sürücüsü siz değilsiniz!')
			end
    	else
        	ESX.ShowNotification('Meslek aracı almamışsınız!')
		end
	else
		ESX.ShowNotification('Bir araçta değilsiniz!')
	end
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000

        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(playercoords, Config.BurgerEtPisirme.x, Config.BurgerEtPisirme.y, Config.BurgerEtPisirme.z, true)
        local distance2 = GetDistanceBetweenCoords(playercoords, Config.BurgerHazirlama.x, Config.BurgerHazirlama.y, Config.BurgerHazirlama.z, true)
        local distance3 = GetDistanceBetweenCoords(playercoords, Config.BurgerPaketleme.x, Config.BurgerPaketleme.y, Config.BurgerPaketleme.z, true)
        local distance4 = GetDistanceBetweenCoords(playercoords, Config.BurgerSatisyeri.x, Config.BurgerSatisyeri.y, Config.BurgerSatisyeri.z, true)
        local coords = GetBlipInfoIdCoord(satisblip)
        local distance5 = GetDistanceBetweenCoords(playercoords, coords[1], coords[2], coords[3], true)
        local distance6 = GetDistanceBetweenCoords(playercoords, Config.Malzeme.x, Config.Malzeme.y, Config.Malzeme.z, true)
        local distance7 = GetDistanceBetweenCoords(playercoords, Config.PatatesPisir.x, Config.PatatesPisir.y, Config.PatatesPisir.z, true)

        if distance < 10 then
            sleep = 7,
           DrawMarker(2, Config.BurgerEtPisirme.x, Config.BurgerEtPisirme.y, Config.BurgerEtPisirme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance < 1 then
                DrawText3D(Config.BurgerEtPisirme.x, Config.BurgerEtPisirme.y, Config.BurgerEtPisirme.z + 0.4, '~g~[E]~s~ - Eti Pisir')
                if IsControlJustReleased(0, 38) then
                    pisirmenu()
                end
            end
        end

        if distance4 < 10 then
            sleep = 7
          --  DrawMarker(2, Config.BurgerSatisyeri.x, Config.BurgerSatisyeri.y, Config.BurgerSatisyeri.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance4 < 1 then
                DrawText3D(Config.BurgerSatisyeri.x, Config.BurgerSatisyeri.y, Config.BurgerSatisyeri.z + 0.4, '~g~[E]~s~ - Hamburger Sat')
                if IsControlJustReleased(0, 38) then
                    BurgerSat()
                end
            end
        end

        if distance6 < 10 then
            sleep = 7
           -- DrawMarker(2, Config.Malzeme.x, Config.Malzeme.y, Config.Malzeme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance6 < 1 then
                DrawText3D(Config.Malzeme.x, Config.Malzeme.y, Config.Malzeme.z + 0.4, '~g~[E]~s~ - Malzeme Dolabı')
                if IsControlJustReleased(0, 38) then
                  malzememenu()
                end
            end
        end

        if distance3 < 10 then
            sleep = 7
           -- DrawMarker(2, Config.BurgerPaketleme.x, Config.BurgerPaketleme.y, Config.BurgerPaketleme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance3 < 1 then
                DrawText3D(Config.BurgerPaketleme.x, Config.BurgerPaketleme.y, Config.BurgerPaketleme.z + 0.4, '~g~[E]~s~ - Domates ve Patatesi Isle')
                if IsControlJustReleased(0, 38) then
                    BurgerPaketle()
                end
            end
        end

        if distance2 < 10 then
        sleep = 7
       -- DrawMarker(2, Config.BurgerHazirlama.x, Config.BurgerHazirlama.y, Config.BurgerHazirlama.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
        if distance2 < 1 then
            DrawText3D(Config.BurgerHazirlama.x, Config.BurgerHazirlama.y, Config.BurgerHazirlama.z + 0.4, '~g~[E]~s~ - Yiyecekleri Hazırla')
            if IsControlJustReleased(0, 38) then
                burgermenu()
            end
        end
    end

        if satiyormu == true and satiskordinat ~= false and distance5 < 10 then
            sleep = 7
            DrawMarker(2, coords[1], coords[2], coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance5 < 1 then
                DrawText3D(coords[1], coords[2], coords[3] + 0.4, '~g~[E]~s~ - Kapıyı Çal')
                if IsControlJustReleased(0, 38) then
                    BurgeryuSat()
                end
            end
        end

        if distance7 < 10 then
            sleep = 7
        --    DrawMarker(2, Config.PatatesPisir.x, Config.PatatesPisir.y, Config.PatatesPisir.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 86, 27, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance7 < 1 then
                DrawText3D(Config.PatatesPisir.x, Config.PatatesPisir.y, Config.PatatesPisir.z + 0.4, '~g~[E]~s~ - Ekmekleri Al')
                if IsControlJustReleased(0, 38) then
                    Patates()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function Patates()
    if not malzemealiyormu then
        malzemealiyormu = true
        exports['mythic_progbar']:Progress({
            name = "burgermalzemesi",
            duration = 5000,
            label = 'Ekmekleri Alıyorsun...',
            useWhileDead = false,
            canCancel = true,
             controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_arresting",
                anim = "a_uncuff",
                flags = 49,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent('bros-burger:patatesver')
                malzemealiyormu = false
                ESX.ShowNotification('Yavaş lan kaç tane alıyon!')
             else
                 -- Do Something If Action Was Cancelled
            end
        end)
    end
end


RegisterNetEvent('bros-burger:koftepisir')
AddEventHandler('bros-burger:koftepisir', function()
    if not pisiriyormu then
        pisiriyormu = true
        local player = PlayerPedId()
        TaskStartScenarioInPlace(player, 'PROP_HUMAN_BBQ', 0, true)
        local finished = exports["reload-skillbar"]:taskBar(5000,math.random(5,15))
        if finished ~= 100 then
            pisiriyormu = false
            ClearPedTasksImmediately(player)
            ESX.ShowNotification('Eti pişiremedin!')
        else
            local finished2 = exports["reload-skillbar"]:taskBar(4750,math.random(5,15))
            if finished2 ~= 100 then
                pisiriyormu = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('Eti pişiremedin!')
            else
                local finished3 = exports["reload-skillbar"]:taskBar(4500,math.random(5,15))
                if finished3 ~= 100 then
                    pisiriyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Eti pişiremedin!')
                else
                    TriggerServerEvent('bros-burger:etver')
                    pisiriyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Eti başarıyla pişirdin!')
                end
            end
        end
    end
end)

RegisterNetEvent('bros-burger:tavukkoftepisir')
AddEventHandler('bros-burger:tavukkoftepisir', function()
    if not pisiriyormu then
        pisiriyormu = true
        local player = PlayerPedId()
        TaskStartScenarioInPlace(player, 'PROP_HUMAN_BBQ', 0, true)
        local finished = exports["reload-skillbar"]:taskBar(5000,math.random(5,15))
        if finished ~= 100 then
            pisiriyormu = false
            ClearPedTasksImmediately(player)
            ESX.ShowNotification('Eti pişiremedin!')
        else
            local finished2 = exports["reload-skillbar"]:taskBar(4750,math.random(5,15))
            if finished2 ~= 100 then
                pisiriyormu = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('Eti pişiremedin!')
            else
                local finished3 = exports["reload-skillbar"]:taskBar(4500,math.random(5,15))
                if finished3 ~= 100 then
                    pisiriyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Eti pişiremedin!')
                else
                    TriggerServerEvent('bros-burger:tavukkoftever')
                    pisiriyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Eti başarıyla pişirdin!')
                end
            end
        end
    end
end)

function BurgerSat()
    if not satiyormu then
        ESX.TriggerServerCallback('bros-burger:malzemekontrol', function(data)
            local random = math.random(1,#locations)
	        satisblip = true
	        satiskordinat = {
		        x = locations[random][1],
		        y = locations[random][2],
		        z = locations[random][3],
		        h = locations[random][4]
	        }
	        satisblip = SatisBlipOlustur(satiskordinat.x, satiskordinat.y, satiskordinat.z)
            satiyormu = true
            ESX.ShowNotification('Burger satmaya başladın!')
        end, "burgerpaketi", 1)
    elseif satiyormu then
        ESX.ShowNotification('Zaten bir burger satıyorsun!')
    end
end

function SatisBlipOlustur(x,y,z)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip, 514)
	SetBlipColour(blip, 4)
	AddTextEntry('MYBLIP', "Müşteri")
	BeginTextCommandSetBlipName('MYBLIP')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	return blip
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if satiyormu == false and satisblip ~= false then
            sleep = 7
			RemoveBlip(satisblip)
			satisblip = false
        end
        Citizen.Wait(sleep)
    end
end)

function BurgeryuSat()
    exports['mythic_progbar']:Progress({
        name = "kapicalma",
        duration = 3000,
        label = 'Kapıyı çalıyorsun...',
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "timetable@jimmy@doorknock@",
            anim = "knockdoor_idle",
            flags = 49,
        },
    }, function(cancelled)
        if not cancelled then
            TriggerServerEvent('bros-burger:burgersat')
            satiskordinat = false
            satiyormu = false
            ESX.ShowNotification('Başarıyla burger sattın!')
        else
            -- Do Something If Action Was Cancelled
        end
    end)
end

function burgermenu()

	local elements ={  
    { label = 'Hamburger', value = 'burger'},
    { label = 'Taco', value = 'dburger'},
    { label = 'Pizza', value = 'cburger'},
	}
	
	ESX.UI.Menu.CloseAll() 
	ESX.UI.Menu.Open('default', GetCurrentResourceName(),'ventacyc',{
		title = 'Ne yapmak istiyosun?', 
		align = 'top-right',
		elements = elements  
	
	}, function(data, menu)
	
	if data.current.value == 'burger' then 
		menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "burger",
            duration = 3250,
            label = 'Hazırlıyorsun.',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:burgerver")
            end
        end)
    elseif data.current.value == 'dburger' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "dburger",
            duration = 3250,
            label = 'Hazırlıyorsun.',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:tavukver")
            end
        end)
    elseif data.current.value == 'cburger' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "cburger",
            duration = 3250,
            label = 'Hazırlıyorsun.',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:pizzaver")
            end
        end)
	end

end, function(data, menu)
	menu.close()
	TriggerEvent('notification', 'Yapmaktan vazgeçtin!', 2, 2000)
	ClearPedTasks(player)
	FreezeEntityPosition(player,false)
end, function(data, menu)
end)
end

function pisirmenu()
	local elements ={  
        { label = 'Hamburger Köftesi', value = 'burger'},
        { label = 'Taco Eti', value = 'tavukofte'},
        
        }
        
        ESX.UI.Menu.CloseAll() 
        ESX.UI.Menu.Open('default', GetCurrentResourceName(),'burger',{
            title = 'Ne yapmak istiyosun?', 
            align = 'top-right',
            elements = elements  
        
        }, function(data, menu)
        
        if data.current.value == 'burger' then 
            menu.close()
            local ped = PlayerPedId()
            exports['mythic_progbar']:Progress({
                name = "etli_burger",
                duration = 3250,
                label = 'Pişiriyorsun',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@prop_human_bbq@male@base",
                    anim = "base",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    TriggerEvent("bros-burger:koftepisir")
                end
            end)
        elseif data.current.value == 'tavukofte' then
            menu.close()
            local ped = PlayerPedId()
            exports['mythic_progbar']:Progress({
                name = "balikli_burger",
                duration = 3250,
                label = 'Eti Pişiriyorsun',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@prop_human_bbq@male@base",
                    anim = "base",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    TriggerEvent("bros-burger:tavukkoftepisir")
                end
            end)
        end
    
    end, function(data, menu)
        menu.close()
        TriggerEvent('notification', 'Yapmaktan vazgeçtin!', 2, 2000)
        ClearPedTasks(player)
        FreezeEntityPosition(player,false)
    end, function(data, menu)
    end)
    end
  
function malzememenu()

	local elements ={  
    --{ label = 'Ekmek', value = 'ekmek'},
  --  { label = 'Ketçap', value = 'ketcap'},
    { label = 'Mayonez', value = 'mayonez'},
 --   { label = 'Marul', value = 'marul'},
    { label = 'Chedar', value = 'chedar'},
    { label = 'Pizza Hamuru', value = 'susamliekmek'},
	}
	
	ESX.UI.Menu.CloseAll() 
	ESX.UI.Menu.Open('default', GetCurrentResourceName(),'burger',{
		title = 'Ne yapmak istiyosun?', 
		align = 'top-right',
		elements = elements  
	
	}, function(data, menu)
	
	if data.current.value == 'ekmek' then 
		menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "etli_burger",
            duration = 2000,
            label = 'Ekmek Alıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:ekmekver")
            end
        end)
    elseif data.current.value == 'ketcap' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "ketcap",
            duration = 2000,
            label = 'Ketçap Alıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:ketcapver")
            end
        end)
    elseif data.current.value == 'mayonez' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "mayonez",
            duration = 2000,
            label = 'Mayonez Alıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:mayonezver")
            end
        end)
    elseif data.current.value == 'susamliekmek' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "susamliekmek",
            duration = 2000,
            label = 'Pizza Hamuru Alıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:susamliekmekver")
            end
        end)
    elseif data.current.value == 'marul' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "marul",
            duration = 2000,
            label = 'Marul Alıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:marulver")
            end
        end)
    elseif data.current.value == 'chedar' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "chedar",
            duration = 2000,
            label = 'Chedar Alıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:chedarver")
            end
        end)
	end

end, function(data, menu)
	menu.close()
	TriggerEvent('notification', 'Yapmaktan vazgeçtin!', 2, 2000)
	ClearPedTasks(player)
	FreezeEntityPosition(player,false)
end, function(data, menu)
end)
end

function BurgerPaketle()

	local elements ={  
    { label = 'Ketcap Yap', value = 'burger'},
   { label = 'Patatesleri Dilimle', value = 'tavukburger'},
	}
	
	ESX.UI.Menu.CloseAll() 
	ESX.UI.Menu.Open('default', GetCurrentResourceName(),'burger',{
		title = 'Ne yapmak istiyosun?', 
		align = 'top-right',
		elements = elements  
	
	}, function(data, menu)
	
	if data.current.value == 'burger' then 
		menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "etli_burger",
            duration = 2000,
            label = '5 Domatesle 1 Ketcap Yapıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:paketver")
            end
        end)
    elseif data.current.value == 'tavukburger' then
        menu.close()
		local ped = PlayerPedId()
        exports['mythic_progbar']:Progress({
            name = "balikli_burger",
            duration = 20000,
            label = '5 File ile 1 Patates Yapıyorsun',
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent("bros-burger:tavukpaketver")
            end
        end)
	end

end, function(data, menu)
	menu.close()
	TriggerEvent('notification', 'Yapmaktan vazgeçtin!', 2, 2000)
	ClearPedTasks(player)
	FreezeEntityPosition(player,false)
end, function(data, menu)
end)
end

