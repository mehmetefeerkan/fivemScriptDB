local ESX = nil
local PlayerData = {}
attachPropList = {
	["minigameThermite"] = {
		["model"] = "prop_oiltub_06", ["bone"] = 57005, ["x"] = 0.1,["y"] = 0.0,["z"] = -0.09,["xR"] = 145.0,["yR"] = 20.0, ["zR"] = 80.0
	}
}
local doorOpen = false
local search1, search2, search3, search4 = false, false, false, false

Citizen.CreateThread(function ()
 while ESX == nil do
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  Citizen.Wait(1)
 end

 while ESX.GetPlayerData() == nil do
  Citizen.Wait(10)
 end

 PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
 PlayerData = xPlayer
end)

attachedProp = 0
function removeAttachedProp()
	if DoesEntityExist(attachedProp) then
		DeleteEntity(attachedProp)
		attachedProp = 0
	end
end

RegisterNetEvent('attachProp')
AddEventHandler('attachProp', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
  boneNumber = boneNumberSent
  local ped = PlayerPedId()
	SetCurrentPedWeapon(ped, 0xA2719263)
	local bone = GetPedBoneIndex(ped, boneNumberSent)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
  AttachEntityToEntity(attachedProp, ped, bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end)

RegisterNetEvent('attachItem')
AddEventHandler('attachItem', function(item)
	TriggerEvent("attachProp",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

-- zoneNames = {
-- 	AIRP = "Los Santos Uluslararası Havalimanı",
-- 	ALAMO = "Alamo Denizi",
-- 	ALTA = "Alta",
-- 	ARMYB = "Zancuda Askeri Üs",
-- 	BANHAMC = "Banham Kanyonu",
-- 	BANNING = "Banning",
-- 	BAYTRE = "Baytree Kanyonu", 
-- 	BEACH = "Vespucci Kumsalı",
-- 	BHAMCA = "Banham Kanyonu",
-- 	BRADP = "Braddock Geçişi",
-- 	BRADT = "Braddock Tüneli",
-- 	BURTON = "Burton",
-- 	CALAFB = "Calafia Köprüsü",
-- 	CANNY = "Raton Kanyonu",
-- 	CCREAK = "Cassidy Deresi",
-- 	CHAMH = "Chamberlain Tepesi",
-- 	CHIL = "Vinewood Tepesi",
-- 	CHU = "Chumash",
-- 	CMSW = "Chiliad Dağı Eyalet Bölgesi",
-- 	CYPRE = "Cypress Evleri",
-- 	DAVIS = "Davis",
-- 	DELBE = "Del Perro Sahili",
-- 	DELPE = "Del Perro",
-- 	DELSOL = "La Puerta",
-- 	DESRT = "Büyük Senora Çölü",
-- 	DOWNT = "Downtown",
-- 	DTVINE = "Downtown Vinewood",
-- 	EAST_V = "Doğu Vinewood",
-- 	EBURO = "El Burro Tepeleri",
-- 	ELGORL = "El Gordo Deniz Feneri",
-- 	ELYSIAN = "Cennet Adası",
-- 	GALFISH = "Galilee Takas Kampı",
-- 	GALLI = "Galileo Parkı",
-- 	golf = "GWC ve Golf	Topluluğu",
-- 	GRAPES = "Grapeseed",
-- 	GREATC = "Büyük Chaparral",
-- 	HARMO = "Harmony",
-- 	HAWICK = "Hawick",
-- 	HORS = "Vinewood Yarış Pisti",
-- 	HUMLAB = "Humane Lab. ve Araştırma Ens.",
-- 	JAIL = "Federal Hapishane",
-- 	KOREAT = "Little Seoul",
-- 	LACT = "Land Act Baraj Gölü",
-- 	LAGO = "Zancudo Gölü",
-- 	LDAM = "Land Act Barajı",
-- 	LEGSQU = "Legion Meydanı",
-- 	LMESA = "La Mesa",
-- 	LOSPUER = "La Puerta",
-- 	MIRR = "Mirror Park",
-- 	MORN = "Morningwood",
-- 	MOVIE = "Görkemli Richards",
-- 	MTCHIL = "Chiliad Dağı",
-- 	MTGORDO = "Gordo Dağı",
-- 	MTJOSE = "Josiah Dağı",
-- 	MURRI = "Murrieta Tepeleri",
-- 	NCHU = "Kuzey Chumash",
-- 	NOOSE = "N.O.O.S.E",
-- 	OCEANA = "Pasifik Okyanusu",
-- 	PALCOV = "Paleto Koy",
-- 	PALETO = "Paleto Körefezi",
-- 	PALFOR = "Paleto Ormanı",
-- 	PALHIGH = "Palomino Dağlıkları",
-- 	PALMPOW = "Palmer-Taylor Güç İstasyonu",
-- 	PBLUFF = "Pacific Kayalıkları",
-- 	PBOX = "Pillbox Tepeleri",
-- 	PROCOB = "Procopio Sahili",
-- 	RANCHO = "Rancho",
-- 	RGLEN = "Richman Glen",
-- 	RICHM = "Richman",
-- 	ROCKF = "Rockford Tepeleri",
-- 	RTRAK = "Redwood Motocross Pisti",
-- 	SanAnd = "San Andreas",
-- 	SANCHIA = "San Chianski Range Dağları",
-- 	SANDY = "Sandy Shores",
-- 	SKID = "Mission Row",
-- 	SLAB = "Stab City",
-- 	STAD = "Maze Bank Bölgesi",
-- 	STRAW = "Strawberry",
-- 	TATAMO = "Tataviam Dağları",
-- 	TERMINA = "Terminal",
-- 	TEXTI = "Textile City",
-- 	TONGVAH = "Tongva Hills",
-- 	TONGVAV = "Tongva Valley",
-- 	VCANA = "Vespucci Kanalları",
-- 	VESP = "Vespucci",
-- 	VINE = "Vinewood",
-- 	WINDF = "Ron Alternates Rüzgar Çiftliği",
-- 	WVINE = "Güney Vinewood",
-- 	ZANCUDO = "Zancudo Nehri",
-- 	ZP_ORT = "Güney Los Santos Limanı",
-- 	ZQ_UAR = "Davis Quartz Madencilik Sahası"
-- }

RegisterNetEvent('edz-cashdeskrob:attemp')
AddEventHandler('edz-cashdeskrob:attemp', function()
  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)
  ESX.TriggerServerCallback('edz-cashdeskrob:copCount', function(Cops)
    if Cops >= Config.NeedCop then
      doorOpen = true
      -- local plyPos = GetEntityCoords(PlayerPedId())
      -- local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
      -- local street1 = GetStreetNameFromHashKey(s1)
      -- zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
      -- local playerStreetsLocation = zoneNames[tostring(zone)]
      -- local street1 = street1 .. ", " .. playerStreetsLocation
      -- local street2 = GetStreetNameFromHashKey(s2)
      -- local adres = street1.. " " .. street2
      --     TriggerServerEvent('edz_outlawalert:robbery', {
      --       x = ESX.Math.Round(plyPos.x, 1),
      --       y = ESX.Math.Round(plyPos.y, 1),
      --       z = ESX.Math.Round(plyPos.z, 1)
      --     }, adres, playerGender, 'Banka Veznesi Soygunu')
      TriggerServerEvent('m3:dispatch:notify', 'Banka Vezne Soygunu', 'Anonim', 'Yok', GetEntityCoords(ped))
      for k,v in ipairs(Config.Bank) do
        local doorsCo = v.door
        local dst = GetDistanceBetweenCoords(pedCo, doorsCo, true)
        if dst < 3.0 and doorOpen then
          Citizen.Wait(500)
          doorOpen = false
          ThermiteAnim()
          exports['mythic_progbar']:Progress({
            name = "armor",
            duration = 5000,
            label = 'Thermite hazırlanıyor...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
            }
          }, function(cancelled)
            if not cancelled then
              startGame()
            end
          end)
        end
      end
    else
      ESX.ShowNotification("Şehirde yeterli polis yok!")
    end
  end)
end)

function OpenBankDoor()
  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)

  for i = 1, #Config.Bank, 1 do
    local doorsCo = Config.Bank[i].door
    local dst = GetDistanceBetweenCoords(pedCo, doorsCo, true)
    local time = 3000
    if dst <= 2.0 then
      search1, search2, search3, search4 = true, true, true, true
      repeat
        local objFound = GetClosestObjectOfType(pedCo, 3.0,-131754413, 0, 0, 0)
        local objHead = GetEntityHeading(objFound)
        objHead = objHead - 0.3
        time = time - 10
        Citizen.Wait(10)
        SetEntityRotation(objFound, 0.0, 0.0, objHead, 2, true)
      until time == 0
    end
  end
end

function ThermiteAnim()
  TriggerEvent("attachItem","minigameThermite")
  RequestAnimDict("weapon@w_sp_jerrycan")
  while ( not HasAnimDictLoaded( "weapon@w_sp_jerrycan" ) ) do
   Wait(10)
  end
  Wait(100)
  local ped = PlayerPedId()
  FreezeEntityPosition(ped, true)
  TaskPlayAnim(ped,"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
end

Citizen.CreateThread( function()
  while true do
    local sleepThread = 50
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(7)
    end
    for i = 1, #Config.Bank, 1 do
      local desk1 = Config.Bank[i].desk1
      local desk2 = Config.Bank[i].desk2
      local desk3 = Config.Bank[i].desk3
      local desk4 = Config.Bank[i].desk4
      local dst1 = GetDistanceBetweenCoords(pedCo, desk1.x, desk1.y, desk1.z, true)
      local dst2 = GetDistanceBetweenCoords(pedCo, desk2.x, desk2.y, desk2.z, true)
      local dst3 = GetDistanceBetweenCoords(pedCo, desk3.x, desk3.y, desk3.z, true)
      local dst4 = GetDistanceBetweenCoords(pedCo, desk4.x, desk4.y, desk4.z, true)
      if dst1 <= 0.75 and search1 then
        sleepThread = 5
        DrawText3Ds(desk1.x, desk1.y, desk1.z, '[H] - Ara')
        if IsControlJustPressed(1, 74) then
          search1 = false
          exports['mythic_progbar']:Progress({
            name = "armor",
            duration = Config.TimeInDesk,
            label = 'Arıyorsun...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
            },
            animation = {
              animDict = "mini@repair",
              anim = "fixing_a_player",
              flags = 49,
            },
          }, function(cancelled)
            if not cancelled then
              TriggerServerEvent('edz-cashdeskrob:giveMoney', Config.MoneyInDesk)
              ClearPedTasks(ped)
            end
          end)
        end
      end
      if dst2 <= 0.75 and search2 then
        sleepThread = 5
        DrawText3Ds(desk2.x, desk2.y, desk2.z, '[H] - Ara')
        if IsControlJustPressed(1, 74) then
          search2 = false
          exports['mythic_progbar']:Progress({
            name = "armor",
            duration = Config.TimeInDesk,
            label = 'Arıyorsun...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
            },
            animation = {
              animDict = "mini@repair",
              anim = "fixing_a_player",
              flags = 49,
            },
          }, function(cancelled)
            if not cancelled then
              TriggerServerEvent('edz-cashdeskrob:giveMoney', Config.MoneyInDesk)
              ClearPedTasks(ped)
            end
          end)
        end
      end
      if dst3 <= 0.75 and search3 then
        sleepThread = 5
        DrawText3Ds(desk3.x, desk3.y, desk3.z, '[H] - Ara')
        if IsControlJustPressed(1, 74) then
          search3 = false
          exports['mythic_progbar']:Progress({
            name = "armor",
            duration = Config.TimeInDesk,
            label = 'Arıyorsun...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
            },
            animation = {
              animDict = "mini@repair",
              anim = "fixing_a_player",
              flags = 49,
            },
          }, function(cancelled)
            if not cancelled then
              TriggerServerEvent('edz-cashdeskrob:giveMoney', Config.MoneyInDesk)
              ClearPedTasks(ped)
            end
          end)
        end
      end
      if dst4 <= 0.75 and search4 then
        sleepThread = 5
        DrawText3Ds(desk4.x, desk4.y, desk4.z, '[H] - Ara')
        if IsControlJustPressed(1, 74) then
          search4 = false
          exports['mythic_progbar']:Progress({
            name = "armor",
            duration = Config.TimeInDesk,
            label = 'Arıyorsun...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
            },
            animation = {
              animDict = "mini@repair",
              anim = "fixing_a_player",
              flags = 49,
            },
          }, function(cancelled)
            if not cancelled then
              TriggerServerEvent('edz-cashdeskrob:giveMoney', Config.MoneyInDesk)
              ClearPedTasks(ped)
              Citizen.Wait(Config.CloseDoorWhenFinish)
              local objFound = GetClosestObjectOfType(pedCo, 30.0,-131754413, 0, 0, 0)
              local objCo = GetEntityCoords(objFound)
              local doorDst = GetDistanceBetweenCoords(pedCo, 1178.87, 2709.365, 38.36251, true)
              local doorDst2 = GetDistanceBetweenCoords(pedCo, -1214.905, -334.7281, 38.05551, true)
              local doorDst3 = GetDistanceBetweenCoords(pedCo, -2960.176, 479.0105, 15.97156, true)
              if doorDst < 30.0 then
              SetEntityRotation(objFound, 0.0, 0.0, 450.0, 2, true)
              elseif doorDst2 < 30.0 then
              SetEntityRotation(objFound, 0.0, 0.0, 300.0, 2, true)
              elseif doorDst3 < 30.0 then
              SetEntityRotation(objFound, 0.0, 0.0, 355.0, 2, true)
              else
              SetEntityRotation(objFound, 0.0, 0.0, 250.0, 2, true)
              end
            end
          end)
        end
      end
    end
    Citizen.Wait(sleepThread)
  end
end)

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 225)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 320
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03,15,15,15, 150)
end

function startGame(dropAmount,letter,speed,inter)
  openGui()
  local dropAmount = 15
	local letter = 2
	local speed = 6
	local inter = 900
  play(dropAmount,letter,speed,inter)
  return Gec;
end
			   
local gui = false

function openGui()
    gui = true
    SetNuiFocus(true,true)
    SendNUIMessage({openPhone = true})
end

function play(dropAmount,letter,speed,inter) 
  SendNUIMessage({openSection = "playgame", amount = dropAmount,letterSet = letter,speed = speed,interval = inter})
end

function CloseGui()
    gui = false
    SetNuiFocus(false,false)
    SendNUIMessage({openPhone = false})
end

RegisterNUICallback('close', function(data, cb)
  CloseGui()
  removeAttachedProp()
  local ped = PlayerPedId()
  ClearPedTasks(ped)
  FreezeEntityPosition(ped, false)
  exports['mythic_notify']:SendAlert('error', 'İptal edildi.')
  cb('ok')
end)

RegisterNUICallback('failure', function(data, cb)
  CloseGui()
  removeAttachedProp()
  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)
  ClearPedTasks(ped)
  FreezeEntityPosition(ped, false)
  exports['mythic_notify']:SendAlert('error', 'Kapıyı açamadın!')
  TriggerServerEvent('edz-cashdeskrob:deleteItem', 'thermite')
  local fire = StartScriptFire(pedCo.x,pedCo.y,pedCo.z, 25, true)
  Wait(2000)
  RemoveScriptFire(fire)
  cb('ok')
end)

RegisterNUICallback('complete', function(data, cb)
  CloseGui()
  removeAttachedProp()
  local ped = PlayerPedId()
  ClearPedTasks(ped)
  FreezeEntityPosition(ped, false)
  Citizen.Wait(2500)
  exports['mythic_notify']:SendAlert('inform', 'Kapıyı açtın!')
  TriggerServerEvent('edz-cashdeskrob:deleteItem', 'thermite')
  OpenBankDoor()
  cb('ok')
end)
