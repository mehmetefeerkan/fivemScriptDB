ESX          = nil
local IsDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer 
end)

				local used = 0

RegisterNetEvent('eden_accesories:silencieux')
AddEventHandler('eden_accesories:silencieux', function(duration)
				local inventory = ESX.GetPlayerData().inventory
				local silencieux = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'silencieux' then
						silencieux = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used < silencieux then

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  		 	used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  			used = used + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
					used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  		 	used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  			used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek."))
		  		  	used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  		 	used = used + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
				

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used = used + 1
		  		
		  	else 
		  		  ESX.ShowNotification(("Elinizde bir silah yok veya silahınız susturucuyu desteklemiyor.."))
		  		
			end
			else
					  		 ESX.ShowNotification(("Tüm susturucuları kullandın.")) 

		end
end)
				local used2 = 0

RegisterNetEvent('eden_accesories:flashlight')
AddEventHandler('eden_accesories:flashlight', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local flashlight = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'flashlight' then
						flashlight = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used2 < flashlight then
						print('used2')

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  		 	used2 = used2 + 1
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		

		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
				
		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  		 	used2 = used2 + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
				

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
				 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  			

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Silahınızı bir fener ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used2 = used2 + 1
		  		
		  	else 
		  		  ESX.ShowNotification(("Silahınızı bir susturucu ile donattınız. Her şehre dönüşte yeniden donatılması gerekecek."))
		  		
			end
		else
				  		  ESX.ShowNotification(("Tüm fenerleri kullandın."))

		end
end)
				local used3 = 0

RegisterNetEvent('eden_accesories:grip')
AddEventHandler('eden_accesories:grip', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local grip = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'grip' then
						grip = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used3 < grip then

			
			if currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  				used3 = used3 + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		 
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Silahınızı bir kabza ile donattınız. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used3 = used3 + 1
		  		
		  	else 
		  		  ESX.ShowNotification(("Elinizde bir silah yok veya silahınız bu ekipmanı desteklemiyor."))
		  		
			end
		else
				  		  ESX.ShowNotification(("Tüm kabzaları kullandın."))
		end
end)

				local used4 = 0

RegisterNetEvent('eden_accesories:yusuf')
AddEventHandler('eden_accesories:yusuf', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local yusuf = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'yusuf' then
						yusuf = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used4 < yusuf then

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
		  		 	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1
		  		
				
		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1
		  		 

		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1
				


		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Silahınıza bir desen eklediniz. Her şehre dönüşle yeniden donatılması gerekecek.")) 
	used4 = used4 + 1
		  		
		  	
		  	else 
		  		  ESX.ShowNotification(("Elinizde bir silah yok ya da silahınızbu görünümü desteklemiyor."))
		  		
			end
		else
				  		  ESX.ShowNotification(("Tüm desen eşyalarını kullandın."))

		end
end)



AddEventHandler('playerSpawned', function()
  used = 0
  used2 = 0
  used3 = 0
  used4 = 0
end)












