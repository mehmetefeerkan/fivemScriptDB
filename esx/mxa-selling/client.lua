local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}


ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local sleep = 2000



Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(sleep)
        perform = true
        local ped = PlayerPedId()
        local pedcoords = GetEntityCoords(ped)
        local timer = GetClockHours()
        for k,v in pairs(MXA) do
            for i = 1, #v.inform, 1 do
                if timer == 1 or timer == 2 or timer == 3 or timer == 4 or timer == 5 or timer == 6 or timer == 7 or timer == 20 or timer == 21 or timer == 22 or timer == 23 then
                    local dst = GetDistanceBetweenCoords(pedcoords, v.inform[i].location, true)
                    if dst <= 2 then
                        perform = false
                        DrawText3DMX(v.inform[i].drawcord.x, v.inform[i].drawcord.y, v.inform[i].drawcord.z, v.inform[i].text)
                    end
                    if dst <= 2 then
                       if IsControlJustPressed(0, Keys['E']) then
                            TriggerServerEvent('mxa-selling:sell', v.inform[i].item, v.inform[i].price)
                        end
                    end
                end
            end
        end

        if perform then
            sleep = 1000
        end

        if not perform then
            sleep = 7
        end
    end
end)

function DrawText3DMX(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
