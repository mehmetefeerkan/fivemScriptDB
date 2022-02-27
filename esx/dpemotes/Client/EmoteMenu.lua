ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
  end
end)

local crouched = false
local currentmvclipset = nil

RegisterCommand('walk', function(source, args, raw) WalkCommandStart(args[1]) end)
-- RegisterCommand('walks', function(source, args, raw) WalksOnCommand() end)

function WalkMenuStart(name)
  RequestWalking(name)
  SetPedMovementClipset(PlayerPedId(), name, 0.2)
  RemoveAnimSet(name)
end

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

-- function WalksOnCommand(source, args, raw)
--   local WalksCommand = ""
--   for a in pairsByKeys(DP.Walks) do
--     WalksCommand = WalksCommand .. ""..string.lower(a)..", "
--   end
--   EmoteChatMessage(WalksCommand)
--   EmoteChatMessage("To reset do /walk reset")
-- end

function WalkCommandStart(walktype)
  local name = firstToUpper(walktype)

  if name == "Reset" then
      -- ResetPedMovementClipset(PlayerPedId()) return
      WalkMenuStart("move_m@shocked@a") currentmvclipset = nil return
  end

  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
    WalkMenuStart(name2)
    currentmvclipset = name2
  else
    EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end

TriggerServerEvent("dp:CheckVersion")

rightPosition = {x = 1450, y = 100}
leftPosition = {x = 0, y = 100}
menuPosition = {x = 0, y = 200}

if Config.MenuPosition then
  if Config.MenuPosition == "left" then
    menuPosition = leftPosition
  elseif Config.MenuPosition == "right" then
    menuPosition = rightPosition
  end
end

if Config.CustomMenuEnabled then
  local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head')
  local Object = CreateDui(Config.MenuImage, 512, 128)
  _G.Object = Object
  local TextureThing = GetDuiHandle(Object)
  local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head', TextureThing)
  Menuthing = "Custom_Menu_Head"
else
  Menuthing = "shopui_title_sm_hangar"
end

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Animasyonlar", "", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing)
_menuPool:Add(mainMenu)

function ShowNotification(text)
    -- SetNotificationTextEntry("STRING")
    -- AddTextComponentString(text)
    -- DrawNotification(false, false)
    TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = text, length = 5000})
end

local EmoteTable = {}
local FavEmoteTable = {}
local KeyEmoteTable = {}
local DanceTable = {}
local PropETable = {}
local WalkTable = {}
local FaceTable = {}
local ShareTable = {}
local FavoriteEmote = ""

-- Citizen.CreateThread(function()
--   while true do
--     if Config.FavKeybindEnabled then
--       if IsControlPressed(0, Config.FavKeybind) then
--         if not IsPedSittingInAnyVehicle(PlayerPedId()) then
--           if FavoriteEmote ~= "" then
--             EmoteCommandStart(nil,{FavoriteEmote, 0})
--             Wait(3000)
--           end
--         end
--       end
--     end
--     Citizen.Wait(1)
--   end
-- end)

lang = Config.MenuLanguage

function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['emotes'], "", "", Menuthing, Menuthing)
    local dancemenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['danceemotes'], "", "", Menuthing, Menuthing)
    local propmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['propemotes'], "", "", Menuthing, Menuthing)
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])

    if Config.SharedEmotesEnabled then
      sharemenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['shareemotes'], Config.Languages[lang]['shareemotesinfo'], "", Menuthing, Menuthing)
      shareddancemenu = _menuPool:AddSubMenu(sharemenu, Config.Languages[lang]['sharedanceemotes'], "", "", Menuthing, Menuthing)
      table.insert(ShareTable, 'none')
      table.insert(EmoteTable, Config.Languages[lang]['shareemotes'])
    end

    if not Config.SqlKeybinding then
      unbind2item = NativeUI.CreateItem(Config.Languages[lang]['rfavorite'], Config.Languages[lang]['rfavorite'])
      unbinditem = NativeUI.CreateItem(Config.Languages[lang]['prop2info'], "")
      favmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['favoriteemotes'], Config.Languages[lang]['favoriteinfo'], "", Menuthing, Menuthing)
      favmenu:AddItem(unbinditem)
      favmenu:AddItem(unbind2item)
      table.insert(FavEmoteTable, Config.Languages[lang]['rfavorite'])
      table.insert(FavEmoteTable, Config.Languages[lang]['rfavorite'])
      table.insert(EmoteTable, Config.Languages[lang]['favoriteemotes'])
    else
      table.insert(EmoteTable, "keybinds")
      keyinfo =  NativeUI.CreateItem(Config.Languages[lang]['keybinds'], Config.Languages[lang]['keybindsinfo'].." /emotebind [~y~num4-9~w~] [~g~emotename~w~]")
      submenu:AddItem(keyinfo)
    end

    for a,b in pairsByKeys(DP.Emotes) do
      x,y,z = table.unpack(b)
      emoteitem = NativeUI.CreateItem(z, "/e ("..a..")")
      submenu:AddItem(emoteitem)
      table.insert(EmoteTable, a)
      if not Config.SqlKeybinding then
        favemoteitem = NativeUI.CreateItem(z, Config.Languages[lang]['set']..z..Config.Languages[lang]['setboundemote'])
        favmenu:AddItem(favemoteitem)
        table.insert(FavEmoteTable, a)
      end
    end

    for a,b in pairsByKeys(DP.Dances) do
      x,y,z = table.unpack(b)
      danceitem = NativeUI.CreateItem(z, "/e ("..a..")")
      sharedanceitem = NativeUI.CreateItem(z, "")
      dancemenu:AddItem(danceitem)
      if Config.SharedEmotesEnabled then
        shareddancemenu:AddItem(sharedanceitem)
      end
      table.insert(DanceTable, a)
    end

    if Config.SharedEmotesEnabled then
      for a,b in pairsByKeys(DP.Shared) do
        x,y,z,otheremotename = table.unpack(b)
        if otheremotename == nil then
          shareitem = NativeUI.CreateItem(z, "/nearby (~g~"..a.."~w~)")
        else 
          shareitem = NativeUI.CreateItem(z, "/nearby (~g~"..a.."~w~) "..Config.Languages[lang]['makenearby'].." (~y~"..otheremotename.."~w~)")
        end
        sharemenu:AddItem(shareitem)
        table.insert(ShareTable, a)
      end
    end

    for a,b in pairsByKeys(DP.PropEmotes) do
      x,y,z = table.unpack(b)
      propitem = NativeUI.CreateItem(z, "/e ("..a..")")
      propmenu:AddItem(propitem)
      table.insert(PropETable, a)
      if not Config.SqlKeybinding then
        propfavitem = NativeUI.CreateItem(z, Config.Languages[lang]['set']..z..Config.Languages[lang]['setboundemote'])
        favmenu:AddItem(propfavitem)
        table.insert(FavEmoteTable, a)
      end
    end

    if not Config.SqlKeybinding then
      favmenu.OnItemSelect = function(sender, item, index)
        if FavEmoteTable[index] == Config.Languages[lang]['rfavorite'] then
          FavoriteEmote = ""
          ShowNotification(Config.Languages[lang]['rfavorite'], 2000)
        return end 
        if Config.FavKeybindEnabled then
          FavoriteEmote = FavEmoteTable[index]
          ShowNotification("\""..firstToUpper(FavoriteEmote)..Config.Languages[lang]['newsetemote']) 
        end
      end
    end

    dancemenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(DanceTable[index], "dances")
    end

      
        sharemenu.OnItemSelect = function(sender, item, index)
          if ShareTable[index] ~= 'none' then
            target, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
              _,_,rename = table.unpack(DP.Shared[ShareTable[index]])
              TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), ShareTable[index])
              TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Kişiye istek yolladın.'})
          else
           -- SimpleNotify(Config.Languages[lang]['nobodyclose'])
          TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Yakında kimse yok!'})
            end
          end

        
      shareddancemenu.OnItemSelect = function(sender, item, index)
        target, distance = GetClosestPlayer()
        if(distance ~= -1 and distance < 3) then
          _,_,rename = table.unpack(DP.Dances[DanceTable[index]])
          TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), DanceTable[index], 'Dances')
          --SimpleNotify(Config.Languages[lang]['sentrequestto']..GetPlayerName(target)) 
          TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Kişiye istek yolladın.'})
        else
          --SimpleNotify(Config.Languages[lang]['nobodyclose'])
          TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Yakında kimse yok!'})
        end
      end
    end

    propmenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(PropETable[index], "props")
    end

    submenu.OnItemSelect = function(sender, item, index)
     if EmoteTable[index] ~= Config.Languages[lang]['favoriteemotes'] then
      EmoteMenuStart(EmoteTable[index], "emotes")
    end
  end
end

function AddCancelEmote(menu)
    local newitem = NativeUI.CreateItem(Config.Languages[lang]['cancelemote'], Config.Languages[lang]['cancelemoteinfo'])
    menu:AddItem(newitem)
    menu.OnItemSelect = function(sender, item, checked_)
        if item == newitem then
          EmoteCancel()
          DestroyAllProps()
          TriggerEvent('fishing:break')
        end
    end
end

function AddWalkMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['walkingstyles'], "", "", Menuthing, Menuthing)

    walkreset = NativeUI.CreateItem(Config.Languages[lang]['normalreset'], Config.Languages[lang]['resetdef'])
    submenu:AddItem(walkreset)
    table.insert(WalkTable, Config.Languages[lang]['resetdef'])

    WalkInjured = NativeUI.CreateItem("Injured", "")
    submenu:AddItem(WalkInjured)
    table.insert(WalkTable, "move_m@injured")

    for a,b in pairsByKeys(DP.Walks) do
      x = table.unpack(b)
      walkitem = NativeUI.CreateItem(a, "")
      submenu:AddItem(walkitem)
      table.insert(WalkTable, x)
    end

    submenu.OnItemSelect = function(sender, item, index)
      if item ~= walkreset then
        WalkMenuStart(WalkTable[index])
        currentmvclipset = WalkTable[index]
      else
        ResetPedMovementClipset(PlayerPedId())
        currentmvclipset = nil
      end
    end
end

function AddFaceMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['moods'], "", "", Menuthing, Menuthing)

    facereset = NativeUI.CreateItem(Config.Languages[lang]['normalreset'], Config.Languages[lang]['resetdef'])
    submenu:AddItem(facereset)
    table.insert(FaceTable, "")

    for a,b in pairsByKeys(DP.Expressions) do
      x,y,z = table.unpack(b)
      faceitem = NativeUI.CreateItem(a, "")
      submenu:AddItem(faceitem)
      table.insert(FaceTable, a)
    end

    submenu.OnItemSelect = function(sender, item, index)
      if item ~= facereset then
        EmoteMenuStart(FaceTable[index], "expression")
      else
        ClearFacialIdleAnimOverride(PlayerPedId())
      end
    end
end

function OpenEmoteMenu()
    mainMenu:Visible(not mainMenu:Visible())
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

AddEmoteMenu(mainMenu)
AddCancelEmote(mainMenu)
if Config.WalkingStylesEnabled then
  AddWalkMenu(mainMenu)
end
if Config.ExpressionsEnabled then
  AddFaceMenu(mainMenu)
end

_menuPool:RefreshIndex()

Citizen.CreateThread(function()
	while true do 
    Citizen.Wait(0)
    _menuPool:ProcessMenus()
    DisableControlAction(0, 36, true)
    local player = PlayerPedId()
    if crouched then
			if IsPlayerFreeAiming(PlayerId()) then
        ResetPedMovementClipset(player, 0)
        ResetPedStrafeClipset(player)
        if currentmvclipset ~= nil then
          WalkMenuStart(currentmvclipset)
        else
          WalkMenuStart("move_m@shocked@a")
        end
        crouched = false 
			end
		end
    if not IsPauseMenuActive() then 
      if IsDisabledControlJustPressed(0, 36) then
        if crouched then
					ResetPedMovementClipset(player, 0)
          ResetPedStrafeClipset(player)
          if currentmvclipset ~= nil then
            WalkMenuStart(currentmvclipset)
          else
            WalkMenuStart("move_m@shocked@a")
					end
					crouched = false 
        else
          crouched = true
          RequestAnimSet("move_ped_crouched")
          repeat
            Citizen.Wait(0)
          until (HasAnimSetLoaded("move_ped_crouched"))
					SetPedMovementClipset(player, "move_ped_crouched", 0.55)
          SetPedStrafeClipset(player, "move_ped_crouched_strafing")
				end 
      end
		else
			crouched = false
    end
    
    if IsControlJustPressed(0, 73) then --x
      if DoesEntityExist(player) then -- and not IsEntityDead(player) 
        if IsEntityPlayingAnim(player, "random@mugging3", "handsup_standing_base", 3) then
          SetCurrentPedWeapon(player, GetHashKey('WEAPON_UNARMED'), true)
          ClearPedSecondaryTask(player)
          IsInAnimation = false
        else
          SetCurrentPedWeapon(player, GetHashKey('WEAPON_UNARMED'), true)
          LoadAnim("random@mugging3")
          TaskPlayAnim(player, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
          RemoveAnimDict("random@mugging3")
          IsInAnimation = false
        end
      end
    end

    if not crouched then
      local ped = PlayerPedId()
      if GetEntityHealth(ped) <= 129 then
        WalkMenuStart("move_m@injured")
      elseif GetEntityHealth(ped) > 130 then
        if currentmvclipset ~= nil then
          WalkMenuStart(currentmvclipset)
        else
          WalkMenuStart("move_m@shocked@a")
        end
      end
    end
  end
end)

RegisterNetEvent("dp:Update")
AddEventHandler("dp:Update", function(state)
    UpdateAvailable = state
    -- AddInfoMenu(mainMenu)
    _menuPool:RefreshIndex()
end)

RegisterNetEvent("dp:RecieveMenu") -- For opening the emote menu from another resource.
AddEventHandler("dp:RecieveMenu", function()
    OpenEmoteMenu() 
end)