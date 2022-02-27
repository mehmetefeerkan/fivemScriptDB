

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local health
local multi
local pulse = 70
local area = "YOK"
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
local cBleeding = "YOK"


AddEventHandler('esx:onPlayerDeath', function(data)

	multi = 2.0
	blood = 100
	health = GetEntityHealth(GetPlayerPed(-1))
	area = "Bacak/Kollar"
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	bleeding = 1
	if (bone == 31086) then
		multi = 0.0
		print('HEADSHOT')
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.1vw; background-color: rgba(236, 57, 32, 0.6); border-radius: 1px;"><i class="fas fa-user-circle"></i> {0}<br> </div>',
			args = { "Kafa bölgenden yaralandın." }
		}) 
		bleeding = 5
		area = "Kafa"
	end
	if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		multi = 1.0
		print('BODYSHOT')
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.1vw; background-color: rgba(236, 57, 32, 0.6); border-radius: 1px;"><i class="fas fa-user-circle"></i> {0}<br> </div>',
			args = { "Vücudundan yaralandın." }
		}) 	
			bleeding = 2
		area = "Vücut"
	end
	
	pulse = ((health / 4 + 20) * multi) + math.random(0, 4)
	dead = true
end)

Citizen.CreateThread( function()
while true do
	Wait(5000)
	local hp = GetEntityHealth(GetPlayerPed(-1))
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
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.52, 0.52)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,100)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.54+w, y - -0.14+h)
	
end



RegisterNetEvent('medSystem:near')
AddEventHandler('medSystem:near', function(x,y,z, pulse, blood, nameF, nameL, area, bldn)
		
--	ESX.ShowNotification( nameF..' '..nameL..area , true , true, 30)   --- client

local md = Config.Declared

	if area == "Kafa" and blood<=5 then
	--if area ~= nil then
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
			
	ESX.ShowNotification( nameF..' '..nameL..' '..Config.Declared , true , true, 20)   --- client
		message = nameF..' '..nameL..' '..Config.Declared
	

		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.1vw; background-color: rgba(236, 57, 32, 0.6); border-radius: 1px;"><i class="fas fa-user-circle"></i> {0}<br> </div>',
			args = { -1, message }
		}) 	
		-- TriggerEvent('chatMessage', "Eastbound Medical: ", {255,0 , 0}, "^1 "..message..!")
		   

		
	end
	local a,b,c = GetEntityCoords(GetPlayerPed(-1))
	
	if GetDistanceBetweenCoords(x,y,z,a,b,c,false) < 10 then
		timer = Config.Timer
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.1vw; background-color: rgba(236, 57, 32, 0.6); border-radius: 1px;"><i class="fas fa-user-circle"></i> {0}<br> </div>',
			args = {"MedSystem: [0-5] ÖLÜ | [5-15] Hastaneye gitmesi gerekli | [15-38] EMS yardım edebilir | [38-55] Polis yardım edebilir | [55+] Sağlıklı", false,true,30 }
		  })
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
		
		if bldn == 1 then
		cBleeding = "YAVAS"
		elseif bldn == 2 then
		cBleeding "ORTA"
		elseif bldn == 5 then
		cBleeding = "HIZLI"
		elseif bldn == 0 then
		cBleeding = "YOK"
		end

	
	--	TriggerEvent('chatMessage', "Eastbound Medical", {255,0 , 0}, cNameF.." "..cNameL.."^1 DECLARED DEAD. ^6 PLEASE RESPAWN.!")
		
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
					DrawAdvancedText(0.7, 0.7, 0.005, 0.0028, 0.9, cNameF .. " " .. cNameL .. "\n~r~Nabız: ~w~" .. cPulse .. "BPM\n~r~Kan Durumu: ~w~" .. cBlood .. "%~r~\nHasar Alan Bölge: ~w~" .. cArea .. "\n~r~Kanama: ~w~" .. cBleeding, 255, 255, 255, 255, 4, 1)
					
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
		
	
	local health = GetEntityHealth(GetPlayerPed(-1))
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	local a, b, c = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

	
	TriggerServerEvent('medSystem:print', req, math.floor(pulse * (blood / 90)), area, blood, a, b, c, bleeding)


end)