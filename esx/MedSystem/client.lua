

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local health
local multi
local pulse = 70
local area = "Unknown"
local lastHit
local blood = 100
local bleeding = 0
local dead = false
local timer = 0

local cPulse = -1
local cBlood = -1
local cNameF = ""
local cNameL = ""
local cArea = ""
local cBleeding = "NONE"

RegisterCommand('getpulse', function(source, args)
	local health = GetEntityHealth(PlayerPedId())
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	
	print(pulse)
	local hit, bone = GetPedLastDamageBone(PlayerPedId())
	print(bone)
	
end, false)

AddEventHandler('esx:onPlayerDeath', function(data)

	multi = 2.0
	blood = 100
	health = GetEntityHealth(PlayerPedId())
	area = "BACAK/KOL"
	local hit, bone = GetPedLastDamageBone(PlayerPedId())
	bleeding = 1
	if (bone == 31086) then
		multi = 0.0
		print('HEADSHOT')
		TriggerEvent('chatMessage', "[MED] ", {255, 0, 0}, "Kafadan vuruldun!")
		bleeding = 5
		area = "KAFADAN"
	end
	if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		multi = 1.0
		print('BODYSHOT')
		TriggerEvent('chatMessage', "[MED] ", {255, 0, 0}, "Vücutdan vuruldun!")
		bleeding = 2
		area = "VUCUT"
	end
	
	pulse = ((health / 4 + 20) * multi) + math.random(0, 4)
	dead = true
end)

Citizen.CreateThread( function()
while true do
	Wait(5000)
	local hp = GetEntityHealth(PlayerPedId())
	if hp >= 1 and dead then
		dead = false
		bleeding = 0
		blood = 100
	end
	if dead and blood > 0 then
	blood = blood - bleeding
	end
end
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,100)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

RegisterNetEvent('medSystem:near')
AddEventHandler('medSystem:near', function(x,y,z, pulse, blood, nameF, nameL, area, bldn)
		
	
	local a,b,c = GetEntityCoords(PlayerPedId())
	
	if GetDistanceBetweenCoords(x,y,z,a,b,c,false) < 10 then
		timer = 10
		TriggerEvent('chatMessage', "[MED]", {255,0 , 0}, "^2 [Kişi Kontrol Ediliyor..]")
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
		
		if bldn == 1 then
		cBleeding = "YAVAS"
		elseif bldn == 2 then
		cBleeding "MEDIUM"
		elseif bldn == 5 then
		cBleeding = "HIZLI"
		elseif bldn == 0 then
		cBleeding = "YOK"
		end
		
	else
		timer = 0
		cBlood = -1
		cPulse = -1
		cNameF = ""
		cNameL = ""
		cArea = ""
		cBleeding = "YAVAS"
	end
	

end)

Citizen.CreateThread( function()
	while true do
		Wait(1)
			while timer >= 1 do
				Wait(1)
				if cPulse ~= -1 and cBlood ~= -1 then
					DrawAdvancedText(0.7, 0.7, 0.005, 0.0028, 0.9, cNameF .. " " .. cNameL .. "\n~r~Nabız: ~w~" .. cPulse .. "BPM\n~r~Kan: ~w~" .. cBlood .. "%~r~\nVurulan Bölge: ~w~" .. cArea .. "\n~r~Kanama: ~w~" .. cBleeding, 255, 255, 255, 255, 4, 1)
					
				end
			end
	end
end)

Citizen.CreateThread( function()
	while true do
		Wait(1000)
		if timer >= 1 then
			timer = timer - 1
		end	
	end
end)

RegisterNetEvent('medSystem:send')
AddEventHandler('medSystem:send', function(req)
		
	
	local health = GetEntityHealth(PlayerPedId())
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	local a, b, c = table.unpack(GetEntityCoords(PlayerPedId()))

	print(a)
	TriggerServerEvent('medSystem:print', req, math.floor(pulse * (blood / 90)), area, blood, a, b, c, bleeding)

end)