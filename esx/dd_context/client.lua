
exports('AddButton', function(title , description , trigger , par , id)
    if(id == nil) then id = false end
    SetNuiFocus(true , true)
    SendNUIMessage({addbutton = true , title = title , description = description , trigger = trigger , par = par , id = id })
end)

exports('SubMenu', function(title , description , menuid)
    SetNuiFocus(true , true)
    SendNUIMessage({addmenu = true , title = title , description = description , menuid = menuid })
end)

exports('SetTitle', function(title)
    SendNUIMessage({SetTitle = true , title = title})
end)

local sound = Config.Sound
local soundName = Config.SoundName 
local enablesound = Config.EnableSound 

RegisterNUICallback("clicked" , function(data , cb)
    local trigger = data.trigger
    local d = data.server
    local d = data.server 
    TriggerServerEvent(trigger ,data.param)
    TriggerEvent(trigger , data.param)
    if(enablesound == true) then
        PlaySoundFrontend(-1, soundName,sound, 1)
    end
end)
RegisterNUICallback("close" , function(data , cb)
    SetNuiFocus(false , false)
    if(enablesound == true) then
        PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    end
    
end)
RegisterCommand('killui', function(source, args)
    SetNuiFocus(false , false)
    if(enablesound == true) then
        PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    end
end)
RegisterNetEvent("menu:test")
AddEventHandler("menu:test" , function(parameter)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        args = {"[MENU]", "Hey, menu test with specific parameter: "..parameter}
      })
      
      
end)


-- RegisterCommand("example" , function()
-- 	exports['br-menu']:SetTitle("Select Spawnpoint")
--     exports['br-menu']:AddButton("Last Position" , "You will be teleported to your last location" ,'menu:lastposition' ,'example button 1' , 'menuone')
--     exports['br-menu']:AddButton("Public Garage" , "You will be teleported to main public garage" ,'menu:test' ,'example button 2' , "menutwo" )
--     exports['br-menu']:AddButton("Hospital" , "You will be teleported to main Hospital" ,'menu:test' ,'example button 3' , "menutwo" )
--     exports['br-menu']:SubMenu("Last Position" , "Go to your last position" , "menuone" )
--     exports['br-menu']:SubMenu("New Selection" , "Create new spawnpoint" , "menutwo" )
-- end)
