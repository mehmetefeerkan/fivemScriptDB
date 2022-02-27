local display = false

RegisterCommand("kordinat", function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local x = string.sub(playerCoords.x, 0, 8) 
    local y = string.sub(playerCoords.y, 0, 8)
    local z = string.sub(playerCoords.z, 0, 6)
    yordiCoords('yordi', 'x = ' .. x .. ', y = ' .. y .. ', z = ' .. z)
    yordicoordsNormal('normal', x .. ', ' .. y .. ', ' .. z)
    yordicoordsVector3('vector3', 'vector3(' .. x .. ', ' .. y .. ', ' .. z .. ')')
    SetDisplay(not display)
end)

function yordiCoords(type, text)
	SendNUIMessage({
        type = type,
		text = text
	})
end

function yordicoordsNormal(type, text)
    SendNUIMessage({
        type = type,
		text = text
	})
end

function yordicoordsVector3(type, text)
    SendNUIMessage({
        type = type,
		text = text
	})
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("yordicloseButton", function(data)
    SetNuiFocus(false, false)
    SetDisplay(false)
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)