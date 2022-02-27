ESX = nil

PE_noclip = false
PE_noclipveh = false
PE_god = false
PE_revive = false
PE_heal = false
PE_invisible = false
PE = {}

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

local isAdmin

Citizen.CreateThread(function()
	PE.CheckAdmin()
    while true do 
        Citizen.Wait(190)
    end
end)

PE.CheckAdmin = function()
    isAdmin = nil
    TriggerServerEvent('PE-admin:isAdmin')
    while (isAdmin == nil) do
        Citizen.Wait(1)
    end
end

RegisterNetEvent('PE-admin:checkAdmin')
AddEventHandler('PE-admin:checkAdmin', function(state)
    isAdmin = state
end)

RegisterCommand(Config.Command, function()
	if isAdmin then
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style = 'warning', 
				message = _U('admin_menu')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('admin_menu'), false, false, 0)
		end
		AbrirMenuAdministrativo()
	elseif not isAdmin then
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style = 'error', 
				message = _U('perms_false')
			})
		elseif Config.ESX then
				ESX.ShowNotification(_U('perms_false'), false, false, 0)
		end
	end
end, false)

RegisterKeyMapping(Config.Command, _U('suggest'), 'keyboard', Config.Key)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)
		if PE_noclip then
			local ped = PlayerPedId()
			local x, y, z = getPos()
			local px, py, pz = getCamDirection()
			local speed = Config.NoClipSpeed


			if IsControlPressed(0, 32) then
				x = x + speed * px
				y = y + speed * py
				z = z + speed * pz

			elseif IsControlPressed(0, 33) then
				x = x - speed * px
				y = y - speed * py
				z = z - speed * pz
			end
			SetEntityVelocity(ped, 0.05,  0.05,  0.05)
			SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
		end

		if PE_noclipveh then
			local ped = GetVehiclePedIsIn(PlayerPedId(), false)
			local x, y, z = getPos()
			local px, py, pz = getCamDirection()
			local speed = Config.NoClipSpeed


			if IsControlPressed(0, 32) then
				x = x + speed * px
				y = y + speed * py
				z = z + speed * pz

			elseif IsControlPressed(0, 33) then
				x = x - speed * px
				y = y - speed * py
				z = z - speed * pz
			end
			SetEntityVelocity(ped, 0.05,  0.05,  0.05)
			SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
		end
	end
end)

function AbrirMenuAdministrativo()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_actions', {
		title    = _U('admin_menu_top'),
		align    = Config.MenuAlign,
		elements = {
			{label = _U('server_admin'), value = 'server_admin'},
            {label = _U('admin_admin'), value = 'admin_admin'},
			{label = _U('jugador_admin'), value = 'jugador_admin'},
			{label = _U('tp_admin'), value = 'tp_admin'}
	}}, function(data, menu)
		if data.current.value == 'server_admin' then
			local elements = {
				{label = _U('del_veh_time'), value = 'del_veh_time'},
				{label = _U('del_veh'), value = 'del_veh'},
				{label = _U('del_obj'), value = 'del_obj'},
				{label = _U('del_ped'), value = 'del_ped'},
				{label = _U('del_chat'), value = 'del_chat'},
				{label = _U('ten_min'), value = 'ten_min'},
				{label = _U('kick_all'), value = 'kick_all'},
				{label = _U('revive_all'), value = 'revive_all'}
            }

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'server_admin', {
				title    = _U('server_admin'),
				align    = Config.MenuAlign,
				elements = elements
			}, function(data2, menu2)
				local accion = data2.current.value
				if accion == 'del_veh' then
					TriggerServerEvent('PE-admin:delallveh')
					if Config.Tnotify then
					exports['t-notify']:Alert({
						style  =  'success',
						message  =  _U('delallveh_true')
					})
					elseif Config.ESX then
						ESX.ShowNotification(_U('delallveh_true'), false, false, 0)
					end
				elseif accion == 'del_veh_time' then
					TriggerServerEvent('PE-admin:delallvehtime')
				elseif accion == 'del_obj' then
					TriggerServerEvent('PE-admin:delallobj')
				elseif accion == 'del_ped' then
					TriggerServerEvent('PE-admin:delallped')
				elseif accion == 'del_chat' then
					TriggerServerEvent('PE-admin:clearchat')
				elseif accion == 'ten_min' then
					TriggerServerEvent('PE-admin:announce')
				elseif accion == 'kick_all' then
					TriggerServerEvent('PE-admin:kickall')
				elseif accion == 'revive_all' then
					TriggerServerEvent('PE-admin:reviveall')
				end
			end, function(data2, menu2)
				menu2.close()
            end)
		elseif data.current.value == 'admin_admin' then
			local elements = {
				{label = _U('noclip'), value = 'noclip'},
				{label = _U('noclipveh'), value = 'noclipveh'},
				{label = _U('god'), value = 'god'},
				{label = _U('inv'), value = 'inv'},
				{label = _U('tp'), value = 'tp'},
				{label = _U('spawnveh'), value = 'spawnveh'},
				{label = _U('tpveh'), value = 'tpveh'},
				{label = _U('dv'), value = 'dv'},
				{label = _U('fix'), value = 'fix'},
				{label = _U('heal'), value = 'heal'},
				{label = _U('ped'), value = 'ped'},
				{label = _U('coords'), value = 'coords'}
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_admin', {
				title    = _U('admin_admin'),
				align    = Config.MenuAlign,
				elements = elements
			}, function(data2, menu2)
				local accion = data2.current.value
				if accion == 'noclip' then
					TriggerEvent('PE-admin:noclip')
				elseif accion == 'noclipveh' then
                    TriggerEvent('PE-admin:noclipveh')
				elseif accion == 'god' then
                    TriggerEvent('PE-admin:god')
				elseif accion == 'tp' then
					TPtoMarker()
				elseif accion == 'tpveh' then
					GoVeh()
				elseif accion == 'spawnveh' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'VehMenu',
					{
						title = _U('veh_name'),
					}, function(data, menu)
						local parameter = data.value
						TriggerEvent('esx:spawnVehicle', parameter)
						if Config.Tnotify then
							exports['t-notify']:Alert({
								style  =  'info',
								message  =  _U('spawn_true') .. parameter
							})
						elseif Config.ESX then
							ESX.ShowNotification(_U('spawn_true') .. parameter, false, false, 0)
						end
						menu.close()
					end, function(data, menu)
						menu.close()
					end)
				elseif accion == 'dv' then
                    TriggerEvent('esx:deleteVehicle')
				elseif accion == 'heal' then
                    TriggerEvent('PE-admin:healPlayer')
				elseif accion == 'fix' then
					TriggerEvent( 'PE-admin:repairVehicle')
				elseif accion == 'coords' then
					TriggerEvent( 'PE-admin:coords')
				elseif accion == 'ped' then
					ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), 'ped_menu', {
						title = _U('ped'),
					}, function(menuData, menuHandle)
						local pedModel = menuData.value
									
						if not type(pedModel) == "number" then pedModel = 'pedModel' end
						if IsModelInCdimage(pedModel) then
							while not HasModelLoaded(pedModel) do
								Citizen.Wait(15)
								RequestModel(pedModel)
							end
							SetPlayerModel(PlayerId(), pedModel)
							menuHandle.close()
						else
							if Config.Tnotify then
							exports['t-notify']:Alert({
								style  =  'info',
								message  =  _U('ped_false') .. pedModel
							})
							elseif Config.ESX then
								ESX.ShowNotification(_U('ped_false'), false, false, 0)
							end
						end
					end, function(menuData, menuHandle)
						menuHandle.close()
					end)
				elseif accion == 'inv' then
                    TriggerEvent('PE-admin:invisible')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'jugador_admin' then
			ESX.TriggerServerCallback('PE-admin:playersonline', function(players)
				local elements = {}
				for i=1, #players, 1 do
						table.insert(elements, {
							label = players[i].name .. ' | ' .. players[i].source .. ' | ' .. players[i].group,
							value = players[i].source,
							name = players[i].name
						})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_list', {
					title    = _U('player_list'),
					align    = Config.MenuAlign,
					elements = elements
				}, function(data2, menu2)
		
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_name', {
						title    = _U('player_name', data2.current.value),
						align    = Config.MenuAlign,
						elements = {
							{label = _U('freeze'), value = 'freeze'},
							{label = _U('revive_player'), value = 'revive_player'},
							{label = _U('kill'), value = 'kill'},
							{label = _U('kick'), value = 'kick'},
							{label = _U('goto'), value = 'goto'},
							{label = _U('bring'), value = 'bring'},
							{label = _U('weapon_player'), value = 'weapon_player'}
						}
					}, function(data3, menu3)
						menu3.close()
						local name = data2.current.name
						local Playerid = data2.current.value
		
						if data3.current.value == 'freeze' then
							TriggerServerEvent('PE-admin:freezePlayer', Playerid, name)
						elseif data3.current.value == 'kill' then
							TriggerServerEvent('PE-admin:killPlayer', Playerid, name)
						elseif data3.current.value == 'kick' then
							TriggerServerEvent('PE-admin:kickPlayer', Playerid, name)
						elseif data3.current.value == 'revive_player' then
							TriggerServerEvent('PE-admin:revivePlayer', Playerid, name)
						elseif data3.current.value == 'goto' then
							TriggerServerEvent('PE-admin:goto', Playerid, name)
						elseif data3.current.value == 'bring' then
							TriggerServerEvent('PE-admin:bring', Playerid, name)
						elseif data3.current.value == 'weapon_player' then
							TriggerServerEvent('PE-admin:weaponPlayer', Playerid, name)
						end
					end, function(data3, menu3)
						menu3.close()
					end)
		
				end, function(data2, menu2)
					menu2.close()
				end)
		
			end)
		elseif data.current.value == 'tp_admin' then
			local elements = {
				{label = _U('tp_one'), value = 'tp_one'},
				{label = _U('tp_two'), value = 'tp_two'},
				{label = _U('tp_three'), value = 'tp_three'},
				{label = _U('tp_four'), value = 'tp_four'},
				{label = _U('tp_five'), value = 'tp_five'},
				{label = _U('tp_six'), value = 'tp_six'},
				{label = _U('tp_seven'), value = 'tp_seven'},
				{label = _U('tp_eight'), value = 'tp_eight'},
				{label = _U('tp_nine'), value = 'tp_nine'},
				{label = _U('tp_ten'), value = 'tp_ten'},
				{label = _U('tp_eleven'), value = 'tp_eleven'},
				{label = _U('tp_twelve'), value = 'tp_twelve'},
				{label = _U('tp_third'), value = 'tp_third'},
				{label = _U('tp_fourth'), value = 'tp_fourth'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tp_admin', {
				title    = _U('tp_admin'),
				align    = Config.MenuAlign,
				elements = elements
			}, function(data2, menu2)
				local accion = data2.current.value
				local ped = PlayerPedId()
				if accion == 'tp_one' then
					SetEntityCoords(ped, 257.07, 227.12, 101.68, false, false, false, true)
					stNoti()
				elseif accion == 'tp_two' then
					SetEntityCoords(ped, -689.66, -914.35, 23.69, false, false, false, true)
					stNoti()
				elseif accion == 'tp_three' then
					SetEntityCoords(ped, -153.94, 6433.67, 31.92, false, false, false, true)
					stNoti()
				elseif accion == 'tp_four' then
					SetEntityCoords(ped, -182.02, 6225.98, 31.49, false, false, false, true)
					stNoti()
				elseif accion == 'tp_five' then
					SetEntityCoords(ped, 264.88, -757.04, 34.64, false, false, false, true)
					stNoti()
				elseif accion == 'tp_six' then
					SetEntityCoords(ped, -297.91, 305.49, 90.72, false, false, false, true)
					stNoti()
				elseif accion == 'tp_seven' then
					SetEntityCoords(ped, 1704.26, 3789.57, 37.69, false, false, false, true)
					stNoti()
				elseif accion == 'tp_eight' then
					SetEntityCoords(ped, -631.41, -228.94, 38.06, false, false, false, true)
					stNoti()
				elseif accion == 'tp_nine' then
					SetEntityCoords(ped, -24.37, -1793.59, 27.45, false, false, false, true)
					stNoti()
				elseif accion == 'tp_ten' then
					SetEntityCoords(ped, 468.9, -965.4, 27.97, false, false, false, true)
					stNoti()
				elseif accion == 'tp_eleven' then
					SetEntityCoords(ped, -191.14, -1290.4, 31.3, false, false, false, true)
					stNoti()
				elseif accion == 'tp_twelve' then
					SetEntityCoords(ped, 301.14, -603.08, 43.41, false, false, false, true)
					stNoti()
				elseif accion == 'tp_third' then
					SetEntityCoords(ped, -1580.53, -934.86, 15.37, false, false, false, true)
					stNoti()
				elseif accion == 'tp_fourth' then
					SetEntityCoords(ped, -362.15, -104.19, 39.54, false, false, false, true)
					stNoti()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function stNoti()
	if isAdmin then
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local stHash = GetStreetNameAtCoord(x, y, z)
		if stHash ~= nil then
			stName = GetStreetNameFromHashKey(stHash)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('tp_noti' ) .. stName
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('tp_noti') .. stName, false, false, 0)
			end
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end

getPos = function()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  	return x,y,z
end

getCamDirection = function()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)

	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
	  x = x/len
	  y = y/len
	  z = z/len
	end

	return x,y,z
end

TPtoMarker = function()
    if isAdmin then
        local WaypointHandle = GetFirstBlipInfoId(8)

        if DoesBlipExist(WaypointHandle) then
            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

            for height = 1, 1000 do
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                if foundGround then
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

					break
                end
				Citizen.Wait(10)
            end
			if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'success',
				message  =  _U('tp_true')
			})
			elseif Config.ESX then
				ESX.ShowNotification(_U('tp_true'), false, false, 0)
			end
        else
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'info',
					message  =  _U('tp_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('tp_false'), false, false, 0)
			end
        end
	else
		if Config.Tnotify then
		exports['t-notify']:Alert({
			style  =  'error',
			message = _U('user_perms')
		})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end


function GoVeh()
	if isAdmin then
		local playerPed = PlayerPedId()
		local playerPedPos = GetEntityCoords(playerPed, true)
		local CloseVeh = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 4)
		local CloseVehPos = GetEntityCoords(CloseVeh, true)
		local CloseAir = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 10000)
		local CloseAirPos = GetEntityCoords(CloseAir, true)
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'info',
				message  =  _U('veh_wait'),
				duration = 1200
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('veh_wait'), false, false, 0)
		end
		Citizen.Wait(1600)
		if (CloseVeh == 0) and (CloseAir == 0) then
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('veh_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('veh_false'), false, false, 0)
			end
		elseif (CloseVeh == 0) and (CloseAir ~= 0) then
			if IsVehicleSeatFree(CloseAir, -1) then
				SetPedIntoVehicle(playerPed, CloseAir, -1)
				SetVehicleDoorsLocked(CloseAir, 1)
				SetVehicleNeedsToBeHotwired(CloseAir, false)
				Citizen.Wait(1)
			else
				local driverPed = GetPedInVehicleSeat(CloseAir, -1)
				ClearPedTasksImmediately(driverPed)
				SetEntityAsMissionEntity(driverPed, 1, 1)
				DeleteEntity(driverPed)
				SetPedIntoVehicle(playerPed, CloseAir, -1)
				SetVehicleDoorsLocked(CloseAir, 1)
				SetVehicleNeedsToBeHotwired(CloseAir, false)
				Citizen.Wait(1)
			end
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('veh_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('veh_true'), false, false, 0)
			end
		elseif (CloseVeh ~= 0) and (CloseAir == 0) then
			if IsVehicleSeatFree(CloseVeh, -1) then
				SetPedIntoVehicle(playerPed, CloseVeh, -1)
				SetVehicleDoorsLocked(CloseVeh, 1)
				SetVehicleNeedsToBeHotwired(CloseVeh, false)
				Citizen.Wait(1)
			else
				local driverPed = GetPedInVehicleSeat(CloseVeh, -1)
				ClearPedTasksImmediately(driverPed)
				SetEntityAsMissionEntity(driverPed, 1, 1)
				DeleteEntity(driverPed)
				SetPedIntoVehicle(playerPed, CloseVeh, -1)
				SetVehicleDoorsLocked(CloseVeh, 1)
				SetVehicleNeedsToBeHotwired(CloseVeh, false)
				Citizen.Wait(1)
			end
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('veh_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('veh_true'), false, false, 0)
			end
		elseif (CloseVeh ~= 0) and (CloseAir ~= 0) then
			if Vdist(CloseVehPos.x, CloseVehPos.y, CloseVehPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) < Vdist(CloseAirPos.x, CloseAirPos.y, CloseAirPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
				if IsVehicleSeatFree(CloseVeh, -1) then
					SetPedIntoVehicle(playerPed, CloseVeh, -1)
					SetVehicleAlarm(CloseVeh, false)
					SetVehicleDoorsLocked(CloseVeh, 1)
					SetVehicleNeedsToBeHotwired(CloseVeh, false)
					Citizen.Wait(1)
				else
					local driverPed = GetPedInVehicleSeat(CloseVeh, -1)
					ClearPedTasksImmediately(driverPed)
					SetEntityAsMissionEntity(driverPed, 1, 1)
					DeleteEntity(driverPed)
					SetPedIntoVehicle(playerPed, CloseVeh, -1)
					SetVehicleAlarm(CloseVeh, false)
					SetVehicleDoorsLocked(CloseVeh, 1)
					SetVehicleNeedsToBeHotwired(CloseVeh, false)
					Citizen.Wait(1)
				end
			elseif Vdist(CloseVehPos.x, CloseVehPos.y, CloseVehPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) > Vdist(CloseAirPos.x, CloseAirPos.y, CloseAirPos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
				if IsVehicleSeatFree(CloseAir, -1) then
					SetPedIntoVehicle(playerPed, CloseAir, -1)
					SetVehicleAlarm(CloseAir, false)
					SetVehicleDoorsLocked(CloseAir, 1)
					SetVehicleNeedsToBeHotwired(CloseAir, false)
					Citizen.Wait(1)
				else
					local driverPed = GetPedInVehicleSeat(CloseAir, -1)
					ClearPedTasksImmediately(driverPed)
					SetEntityAsMissionEntity(driverPed, 1, 1)
					DeleteEntity(driverPed)
					SetPedIntoVehicle(playerPed, CloseAir, -1)
					SetVehicleAlarm(CloseAir, false)
					SetVehicleDoorsLocked(CloseAir, 1)
					SetVehicleNeedsToBeHotwired(CloseAir, false)
					Citizen.Wait(1)
				end
			end
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('veh_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('veh_true'), false, false, 0)
			end
			Citizen.Wait(1)
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end


RegisterNetEvent('PE-admin:noclipveh')
AddEventHandler('PE-admin:noclipveh',function()
	if isAdmin then
		PE_noclipveh = not PE_noclipveh
		if PE_noclipveh == true then
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('noclip_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_true'), false, false, 0)
			end
		else
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('noclip_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_false'), false, false, 0)
			end
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end)

RegisterNetEvent('PE-admin:noclip')
AddEventHandler('PE-admin:noclip',function()
	if isAdmin then
		ped = PlayerPedId()
		PE_noclip = not PE_noclip
		if PE_noclip == true then
			RequestAnimDict("swimming@base")
			while not HasAnimDictLoaded("swimming@base") do
				Citizen.Wait(0)
			end
			TaskPlayAnim(ped, "swimming@base", "dive_idle", -25.0, -8.0, -1, 1, 0, false, false, false)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('noclip_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_true'), false, false, 0)
			end
		else
			ClearPedTasks(ped)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('noclip_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('noclip_false'), false, false, 0)
			end
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end)

RegisterNetEvent('PE-admin:invisible')
AddEventHandler('PE-admin:invisible', function()
	if isAdmin then
		PE_invisible = not PE_invisible
		local ped = PlayerPedId()
		SetEntityVisible(ped, not PE_invisible, false)
		if PE_invisible == true then
				if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('inv_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('inv_true'), false, false, 0)
			end
		else
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('inv_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('inv_false'), false, false, 0)
			end
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end)

RegisterNetEvent('PE-admin:god')
AddEventHandler('PE-admin:god', function()
	if isAdmin then
		PE_god = not PE_god
		local playerPed = PlayerPedId()
		SetEntityInvincible(playerPed, PE_god, true)
		if PE_god == true then
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('god_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('god_true'), false, false, 0)
			end
		else
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('god_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('god_false'), false, false, 0)
			end
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end)

RegisterNetEvent('PE-admin:healPlayer')
AddEventHandler('PE-admin:healPlayer', function()
	if isAdmin then 
		PE_heal = not PE_heal
		local PE_ped = PlayerPedId()
		if PE_heal == true then
			SetEntityHealth(PE_ped, 200)
			SetPedArmour(PE_ped, 100)
			ClearPedBloodDamage(PE_ped)
        	ResetPedVisibleDamage(PE_ped)
			ClearPedLastWeaponDamage(PE_ped)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('heal_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('heal_true'), false, false, 0)
			end
		elseif PE_heal == false then
			SetEntityHealth(PE_ped, 200)
			SetPedArmour(PE_ped, 0)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'warning',
					message  =  _U('heal_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('heal_false'), false, false, 0)
			end
		end
    else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end)

RegisterNetEvent('PE-admin:clearchat')
AddEventHandler('PE-admin:clearchat', function()
	TriggerEvent('chat:clear', -1)
	if Config.Tnotify then
		exports['t-notify']:Alert({
			style  =  'info',
			message  =  _U('chat_false')
		})
	elseif Config.ESX then
		ESX.ShowNotification(_U('chat_false'), false, false, 0)
	end
end)

RegisterNetEvent('PE-admin:repairVehicle')
AddEventHandler('PE-admin:repairVehicle', function()
	if isAdmin then
		local ply = PlayerPedId()
		local plyVeh = GetVehiclePedIsIn(ply)
		if IsPedInAnyVehicle(ply) then 
			SetVehicleFixed(plyVeh)
			SetVehicleDeformationFixed(plyVeh)
			SetVehicleUndriveable(plyVeh, false)
			SetVehicleEngineOn(plyVeh, true, true)
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'success',
					message  =  _U('fix_true')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('fix_true'), false, false, 0)
			end
		else
			if Config.Tnotify then
				exports['t-notify']:Alert({
					style  =  'error',
					message  =  _U('fix_false')
				})
			elseif Config.ESX then
				ESX.ShowNotification(_U('fix_false'), false, false, 0)
			end
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end)

RegisterNetEvent('PE-admin:delallveh')
AddEventHandler('PE-admin:delallveh', function()
	for vehicle in EnumerateVehicles() do
		if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then
			SetVehicleHasBeenOwnedByPlayer(vehicle, false)
			SetEntityAsMissionEntity(vehicle, false, false)
			DeleteVehicle(vehicle)
			if (DoesEntityExist(vehicle)) then
				DeleteVehicle(vehicle)
			end
		end
	end
end)

RegisterNetEvent('PE-admin:delallobj')
AddEventHandler('PE-admin:delallobj', function()
	for object in EnumerateObjects() do
        SetEntityAsMissionEntity(object, false, false)
		DeleteObject(object)
		if (DoesEntityExist(object)) then 
			DeleteObject(object)
		end
    end
end)

RegisterNetEvent('PE-admin:delallped')
AddEventHandler('PE-admin:delallped', function()
	for ped in EnumeratePeds() do
		if not (IsPedAPlayer(ped))then
			DeleteEntity(ped)
			RemoveAllPedWeapons(ped, true)
		end
	end
end)

RegisterNetEvent('PE-admin:freezePlayer')
AddEventHandler('PE-admin:freezePlayer', function()
	freeze = not freeze
	local ped = PlayerPedId()
	if freeze == true then
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(ped, true)
		ClearPedTasksImmediately(ped, true)
		RequestAnimDict("amb@world_human_jog_standing@female@idle_a")
			while not HasAnimDictLoaded("amb@world_human_jog_standing@female@idle_a") do
				Citizen.Wait(0)
			end
		TaskPlayAnim(ped, "amb@world_human_jog_standing@female@idle_a", "idle_a", -25.0, -8.0, -1, 1, 0, false, false, false)
	else
		SetEntityCollision(ped, true)
		FreezeEntityPosition(ped, false)  
		SetPlayerInvincible(ped, false)
		ClearPedTasksImmediately(ped, false)
	end
end)

RegisterNetEvent('PE-admin:revivePlayer')
AddEventHandler('PE-admin:revivePlayer', function()
	local ped = PlayerPedId()
	local player = IsPedFatallyInjured(ped)
	if player then
		TriggerEvent('esx_ambulancejob:revive')
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  = _U('not_dead')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('not_dead'), false, false, 0)
		end
	end
end)

RegisterNetEvent('PE-admin:killPlayer')
AddEventHandler('PE-admin:killPlayer', function()
	local ped = PlayerPedId()
	local player = IsPedDeadOrDying(ped, p1)
	if player then
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  = _U('not_alive')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('not_alive'), false, false, 0)
		end
	else
		SetEntityHealth(ped, 0)
	end
end)

RegisterNetEvent('PE-admin:weaponPlayer')
AddEventHandler('PE-admin:weaponPlayer', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped, Config.Weapon, 250, true, true)
end)

RegisterNetEvent('PE-admin:coords')
AddEventHandler('PE-admin:coords', function()
	if isAdmin then
		coords = not coords
		local x = GetEntityCoords(PlayerPedId())
		if coords == true then
			if Config.Tnotify then
				exports['t-notify']:Persist({
					id = '12',
					step = 'start',
					options = {
						style = 'info',
						message = tostring(x),
						title = _U('coords')
					}
				})
			elseif Config.ESX then
				ESX.ShowHelpNotification(tostring(x), true, true)
			end
		else
			if Config.Tnotify then
				exports['t-notify']:Persist({
					id = '12',
					step = 'end'
				})
			elseif Config.ESX then
				ESX.ShowHelpNotification(tostring(x), true, true)
			end
		end
	else
		if Config.Tnotify then
			exports['t-notify']:Alert({
				style  =  'error',
				message  =  _U('user_perms')
			})
		elseif Config.ESX then
			ESX.ShowNotification(_U('user_perms'), false, false, 0)
		end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ESX.UI.Menu.CloseAll()
    end
end)
