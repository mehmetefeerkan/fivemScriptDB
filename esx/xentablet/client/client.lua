--====================================================================================
-- #XenKnighT
--====================================================================================
 
-- Configuration
local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}
local KeyOpenClose = 166 -- F2
local KeyTakeCall = 38 -- E
local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
local USE_RTC = false
local useMouse = true
local ignoreFocus = false
local takePhoto = false
local hasFocus = false



--====================================================================================
--  Check si le joueurs poséde un téléphone
--  Callback true or false
--====================================================================================
function hasPhone (cb)
  cb(true)
end
--====================================================================================
--  Que faire si le joueurs veut ouvrir sont téléphone n'est qu'il en a pas ?
--====================================================================================
function ShowNoPhoneWarning ()
end

--[[
  Ouverture du téphone lié a un item
  Un solution ESC basé sur la solution donnée par HalCroves
  https://forum.fivem.net/t/tutorial-for-gcphone-with-call-and-job-message-other/177904


ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
  end
end)

function hasPhone (cb)
  if (ESX == nil) then return cb(0) end
  ESX.TriggerServerCallback('xentablet:getItemAmount', function(qtty)
    cb(qtty > 0)
  end, 'xentab')
end
function ShowNoPhoneWarning () 
  if (ESX == nil) then return end
  ESX.ShowNotification("Vous n'avez pas de ~r~téléphone~s~")
end
--]]




--====================================================================================
--  
--====================================================================================
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if takePhoto ~= true then
      if IsControlJustPressed(1, KeyOpenClose) then
        hasPhone(function (hasPhone)
          if hasPhone == true then
            TooglePhone()
          else
            ShowNoPhoneWarning()
          end
        end)
      end
      if menuIsOpen == true then
        for _, value in ipairs(KeyToucheCloseEvent) do
          if IsControlJustPressed(1, value.code) then
            SendNUIMessage({keyUp = value.event})
          end
        end
        if useMouse == false and hasFocus == ignoreFocus then
          local nuiFocus = not hasFocus
          SetNuiFocus(nuiFocus, nuiFocus)
          hasFocus = nuiFocus
        elseif useMouse == true and hasFocus == true then
          SetNuiFocus(false, false)
          hasFocus = false
        end
      else
        if hasFocus == true then
          SetNuiFocus(false, false)
          hasFocus = false
        end
      end
    end
  end
end)



--====================================================================================
--  Active ou Deactive une application (appName => config.json)
--====================================================================================
RegisterNetEvent('xentablet:setEnableApp')
AddEventHandler('xentablet:setEnableApp', function(appName, enable)
  SendNUIMessage({event = 'setEnableApp', appName = appName, enable = enable })
end)

--====================================================================================
--  Gestion des appels fixe
--====================================================================================



function PlaySoundJS (sound, volume)
  SendNUIMessage({ event = 'playSound', sound = sound, volume = volume })
end

function SetSoundVolumeJS (sound, volume)
  SendNUIMessage({ event = 'setSoundVolume', sound = sound, volume = volume})
end

function StopSoundJS (sound)
  SendNUIMessage({ event = 'stopSound', sound = sound})
end




--====================================================================================
--  Event NUI - Appels
--====================================================================================



--====================================================================================
--  Gestion des evenements NUI
--==================================================================================== 
RegisterNUICallback('log', function(data, cb)
  print(data)
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)
RegisterNUICallback('blur', function(data, cb)
  cb()
end)
RegisterNUICallback('reponseText', function(data, cb)
  local limit = data.limit or 255
  local text = data.text or ''
  
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)

--====================================================================================
--  Event - Contacts
--====================================================================================

RegisterNUICallback('useMouse', function(um, cb)
  useMouse = um
end)

function TooglePhone() 
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then 
    PhonePlayIn()
  else
    PhonePlayOut()
  end
end
RegisterNUICallback('faketakePhoto', function(data, cb)
  menuIsOpen = false
  SendNUIMessage({show = false})
  cb()
  TriggerEvent('camera:open')
end)

RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  SendNUIMessage({show = false})
  PhonePlayOut()
  cb()
end)




----------------------------------
---------- GESTION APPEL ---------
----------------------------------


----------------------------------
---------- GESTION VIA WEBRTC ----
----------------------------------
AddEventHandler('onClientResourceStart', function(res)
  DoScreenFadeIn(300)
  if res == "xentablet" then
      TriggerServerEvent('xentablet:allUpdate')
  end
end)


RegisterNUICallback('setIgnoreFocus', function (data, cb)
  ignoreFocus = data.ignoreFocus
  cb()
end)















RegisterNUICallback('takePhoto', function(data, cb)
	CreateMobilePhone(1)
  CellCamActivate(true, true)
  takePhoto = true
  Citizen.Wait(0)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takePhoto do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takePhoto = false
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload(data.url, data.field, function(data)
        local resp = json.decode(data)
        DestroyMobilePhone()
        CellCamActivate(false, false)
        cb(json.encode({ url = resp.files[1].url }))   
      end)
      takePhoto = false
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)