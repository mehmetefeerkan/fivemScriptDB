ESX = nil
local ped = PlayerPedId()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--SÜRE
Citizen.CreateThread(function()
    timer = Config.ArabaSure * 1000
    time = 0
	while true do
		Wait(1000)
		time = time + 1000
	end
end)

Citizen.CreateThread(function()
while true do
	sleep = 2000
	local ped = PlayerPedId()
	local kordinat = GetEntityCoords(ped)
	local dist = GetDistanceBetweenCoords(kordinat, -1021.64, -2738.55, 20.02, true) 
	if dist < 3.0 then
		sleep = 5
	end
	if dist < 2.0 then
		DrawText3D(-1021.64, -2738.55, 20.02, ('~g~[E]~s~ Araç Kirala'))
		if IsControlJustReleased(0, 46) then
			arackirala()
		end
	end
	Citizen.Wait(sleep)
end
end)

function arackirala()
	local elements = {}
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'aiakos',
	{
    title    = ('ARAC KIRALA'),
    align = 'top-left', 
    elements = {
      {label = ('Panto <span style="color: green;">&nbsp;250$</span>'),     value = 'pantokirala'},
      {label = ('BMX <span style="color: green;">&nbsp;100$</span>'),     value = 'bmxkirala'}
    }
  },
  function(data, menu) 
    if data.current.value == 'pantokirala' then
	if(time > timer) then
		TriggerServerEvent('pantokirala', source)
	time = 0
	else
	TriggerEvent('notification', 'Araç kiralamak için 1 dakika beklemelisin!', 1)
	 end
	  menu.close()   
	elseif data.current.value == 'bmxkirala' then
	if(time > timer) then
		TriggerServerEvent('bmxkirala', source)
	time = 0
	else
	TriggerEvent('notification', 'Araç kiralamak için 1 dakika beklemelisin!', 1)
	end
	menu.close()
	end
  end,
  function(data, menu) 
      menu.close() 
  end
)
end

RegisterNetEvent('bz:pantocikart')
AddEventHandler('bz:pantocikart', function()

ESX.Game.SpawnVehicle('panto', vector3(-1014.84, -2739.24, 20.15), 245.25, function(vehicle)
end)

end)

RegisterNetEvent('bz:bmxcikart')
AddEventHandler('bz:bmxcikart', function()

ESX.Game.SpawnVehicle('bmx', vector3(-1014.84, -2739.24, 20.15), 245.25, function(vehicle)
end)

end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

--PED

Citizen.CreateThread(function()
  modelHash = GetHashKey(Config.PedModel)
  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
       Wait(1)
  end
  createNPC() 
end)
function createNPC()
	created_ped = CreatePed(0, modelHash , Config.PedKordinat.x,Config.PedKordinat.y,Config.PedKordinat.z - 1, Config.PedKordinat.rotation, Config.PedKordinat.NetworkSync)
	FreezeEntityPosition(created_ped, true)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)
	TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_COP_IDLES", 0, true)
end
