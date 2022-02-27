local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isDead = false
local isInstructorMode = false
local carrying = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
local PlayerData = {}
local licenses = {}

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('np-menu:loadLicenses')
AddEventHandler('np-menu:loadLicenses', function(licenses2)
	licenses = licenses2
end)

local hasBagOn = false

AddEventHandler("hasBagOnCheck",function(status)
	hasBagOn = status
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		TriggerEvent("checkBag")
	end
end)

rootMenuConfig =  {
    {
        id = "general",
        displayName = "Genel",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"general:emotes","general:flipvehicle","genel:billing","genel:carry", "wht:rob"}
    },
    {
        id = "police-action",
        displayName = "Polis Aksiyonları",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
        end,
        subMenus = {"cuffs:cuff", "cuffs:uncuff",  "police:kelepcekir", "pw:search", "police:escort", "police:putinvehicle", "police:unseatnearest","police:revive", "police:gsr", "police:getid", "police:impound", "police:open", "police:community", "police:jail", "police:fine", "police:telsizkullan", "police:gpskullan", "police:odenmemisfatura", "police:lisansver"}
    }, 

    {
        id = "police-action",
        displayName = "Sheriff Aksiyonları",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "sheriff" and not fuck then
                return true
            end
        end,
        subMenus = {"cuffs:cuff", "cuffs:uncuff",  "police:kelepcekir", "pw:search", "police:escort", "police:putinvehicle", "police:unseatnearest","police:revive", "police:gsr", "police:getid", "police:impound", "police:open", "police:community", "police:jail", "police:fine", "police:telsizkullan", "police:gpskullan", "police:odenmemisfatura", "police:lisansver"}
    },  
	
	{
        id = "gang-menu",
        displayName = "Gang Menüsü",
        icon = "#gang-menu",
		functionName = "NB:openMenuGang",
        enableMenu = function()
            return (PlayerData.job.name == 'gang' and not isDead)
        end,
    },
	{
        id = "bag-menu",
        displayName = "Sırt Çantası",
        icon = "#bag",
        enableMenu = function()
            return (hasBagOn and not isDead)
        end,
		subMenus = { "bag:drop", "bag:open" }
    },
    {
        id = "animations",
        displayName = "Yürüyüşler",
        icon = "#walking",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
    {
        id = "lisans",
        displayName = "Lisanslar",
        icon = "#general-giveid",
        enableMenu = function()
            return (not isDead)
        end,
        subMenus = {"kimlik:goster","kimlik:gor","kimlik:silahgoster","kimlik:silahgor" }
    },
    {
        id = "blips",
        displayName = "Blipler",
        icon = "#blips",
        enableMenu = function()
            return (not isDead)
        end,
        subMenus = {"blip:marketler", "blip:berberler", "blip:garajlar", "blip:kıyafetciler", "blip:bankalar", "blip:benzinlikler" }
    },
   
    --[[
    {
        id = "expressions",
        displayName = "Ruh Halleri",
        icon = "#expressions",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    --]]
    {
        id = "accessory",
        displayName = "Aksesuar",
        icon = "#accessory-mask",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "accessory:mask", "accessory:tshirt", "accessory:pants", "accessory:shoes", "accessory:getdressed"}
    },
    {
        id = "medic",
        displayName = "Doktor",
        icon = "#medic-heartbeat",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "ambulance" and not fuck then
                return true
            end
        end,
        subMenus = {"medic:revive", "medic:heal", "medic:bigheal", "medic:out", "medic:put", "medic:telsizkullan", "medic:gpskullan", "medic:faturakes"}
    },
	{
        id = "mecha-action",
        displayName = "Mekanik Aksiyonları",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "mechanic" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:repair", "mechanic:clean", "mechanic:impound"}
    },
    {
        id = "vehicle",
        displayName = "Araç Aksiyonları",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }, 
    --[[
    {
        id = "mdt",
        displayName = "MDT",
        icon = "#mdt",
        functionName = "police:tablet",
        enableMenu = function()
            return (PlayerData.job.name == 'police' and not isDead)
        end
    }
    --]] 
}

newSubMenus = {
    ['blip:marketler'] = {
        title = "Marketler",
        icon = "#blips",
        functionName = "adez:marketler"
    },
    ['blip:berberler'] = {
        title = "Berberler",
        icon = "#blips",
        functionName = "adez:berberler"
    },
    ['blip:garajlar'] = {
        title = "Garajlar",
        icon = "#blips",
        functionName = "adez:garajlar"
    },
    ['blip:garajlar'] = {
        title = "Garajlar",
        icon = "#blips",
        functionName = "adez:garajlar"
    },
    ['blip:kıyafetciler'] = {
        title = "Kıyafetciler",
        icon = "#blips",
        functionName = "adez:kıyafetciler"
    },
    ['blip:dovmeciler'] = {
        title = "Dövmeciler",
        icon = "#blips",
        functionName = "adez:dovmeciler"
    },
    ['blip:bankalar'] = {
        title = "Bankalar",
        icon = "#blips",
        functionName = "adez:bankalar"
    },
    ['blip:benzinlikler'] = {
        title = "Benzinlikler",
        icon = "#blips",
        functionName = "adez:benzinlikler"
    },
    ['bag:open'] = {
        title = "Çantayı Aç",
        icon = "#bag-open",
        functionName = "openMyOwnBag"
    }, 
	['bag:drop'] = {
        title = "Çantayı Düşür",
        icon = "#bag-drop",
        functionName = "bag:drop"
    }, 
    ['general:emotes'] = {
        title = "Animasyonlar",
        icon = "#general-emotes",
        functionName = "dpemotes:openMenu"
    }, 
	['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['genel:rehinal'] = {
        title = "Rehin Al",
        icon = "#take-hostage",
        functionName = "takeHostage"
    },
    ['genel:billing'] = {
        title = "Faturalar",
        icon = "#billing",
        functionName = "openBilling"
    },
    ['genel:carry'] = {
        title = "Adam Taşıma",
        icon = "#general-put-in-veh",
        functionName = "esx_barbie_lyftupp"
    },
    ['genel:carry2'] = {
        title = "Taşımayı Bırak",
        icon = "#general-put-in-veh",
        functionName = "esx_barbie_lyftupp2"
    },       
    ['accessory:hat'] = {
        title = "Kask/Şapka",
        icon = "#accessory-hat",
        functionName = "accessory:setUnset",
		functionParameters =  { "Helmet" }
    },
    ['accessory:ear'] = {
        title = "Kulak Aksesuarı",
        icon = "#accessory-ear",
        functionName = "accessory:setUnset",
		functionParameters =  { "Ears" }
    },
    ['accessory:giysi'] = {
        title = "Giysiler",
        icon = "#accessory-giysi",
        functionName = "clothes:menu"
    },
    ['accessory:mask'] = {
        title = "Maske",
        icon = "#accessory-mask",
        functionName = "pw:mask",	
    },
    ['accessory:glasses'] = {
        title = "Gözlük",
        icon = "#accessory-glass",
        functionName = "pw:glasses",
    },
	['accessory:tshirt'] = {
        title = "Tshirt Çıkar",
        icon = "#accessory-giysi",
        functionName = "pw:tshirt",		
    },
	['accessory:pants'] = {
        title = "Pantolon Çıkar",
        icon = "#accessory-pants",
        functionName = "pw:pants",		
    },
	['accessory:shoes'] = {
        title = "Ayakkabı Çıkar",
        icon = "#accessory-shoes",
        functionName = "pw:shoes",		
    },
	['accessory:getdressed'] = {
        title = "Giyin",
        icon = "#accessory-getdressed",
        functionName = "pw:getdressed",		
    },
    ['kimlik:goster'] = {
        title = "Kimlik Göster",
        icon = "#general-showid",
        functionName = "kimlikgoster_f3"
    }, 
    ['kimlik:gor'] = {
        title = "Kimlik Gör",
        icon = "#general-giveid",
        functionName = "kimlikgor_f3"
    },
    ['kimlik:silahgoster'] = {
        title = "Silah Ruhsatı Göster",
        icon = "#general-showid",
        functionName = "kimlikgoster2_f3"
    }, 
    ['kimlik:silahgor'] = {
        title = "Silah Ruhsatı Gör",
        icon = "#general-giveid",
        functionName = "kimlikgor2_f3"
    }, 	
    ['general:keysgive'] = {
        title = "Anahtar Ver",
        icon = "#general-keys-give",
        functionName = "SOSAY_Locking:GiveKeys"
    },
    ['general:checkoverself'] = {
        title = "Kendini Kontrol Et",
        icon = "#general-check-over-self",
        functionName = "Evidence:CurrentDamageList"
    },
    ['general:checktargetstates'] = {
        title = "Hedefi Kontrol Et",
        icon = "#general-check-over-target",
        functionName = "requestWounds"
    },
    ['general:checkvehicle'] = {
        title = "Aracı Kontrol Et",
        icon = "#general-check-vehicle",
        functionName = "towgarage:annoyedBouce"
    },
    ['general:escort'] = {
        title = "Taşı",
        icon = "#general-escort",
        functionName = "escortPlayer"
    },
    ['general:putinvehicle'] = {
        title = "Araca Koy",
        icon = "#general-put-in-veh",
        functionName = "police:forceEnter"
    },
    ['general:unseatnearest'] = {
        title = "Araçtan Çıkar",
        icon = "#general-unseat-nearest",
        functionName = "unseatPlayer"
    },    
    ['general:flipvehicle'] = {
        title = "Aracı Çevir",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['animations:brave'] = {
        title = "Cesur",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Acele",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "İş Adamı",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Kafası Güzel",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Yaralı",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Sert",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Gıcık",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Üzgün",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Uzaylı",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Para Babası",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Havalı",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Gizemli",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Yamyam",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Normal",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['blips:gasstations'] = {
        title = "Benzin İstasyonu",
        icon = "#blips-gasstations",
        functionName = "ygx:togglegas"
    },    
    ['blips:garages'] = {
        title = "Garaj",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
	['fk:deleteblip'] = {
        title = "İşaret Kaldır",
        icon = "#general-put-in-veh",
        functionName = "fk:deleteblip"
    }, 
    ['blips:barbershop'] = {
        title = "Berber",
        icon = "#blips-barbershop",
        functionName = "ygx:togglebarber"
    }, 
    ['fk:karakol'] = {
        title = "Market",
        icon = "#animation-money",
        functionName = "fk:karakol"
    },
    ['blips:tattooshop'] = {
        title = "Dövmeci",
        icon = "#blips-tattooshop",
        functionName = "ygx:toggletattos"
    },
    ['fk:galeri'] = {
        title = "Garaj",
        icon = "#blips-garages",
        functionName = "fk:galeri"
    },
    ['fk:motel'] = {
        title = "Kiyafetci",
        icon = "#accessory-hat",
        functionName = "fk:motel"
    },			
    ['cuffs:cuff'] = {
        title = "Kelepçe Tak",
        icon = "#cuffs-cuff",
        functionName = "police:cuffMenu"
    },    
	['cuffs:hardcuff'] = {
        title = "Sert Kelepçe Tak",
        icon = "#cuffs-cuff",
        functionName = "police:hardcuffMenu"
    },
    ['cuffs:break'] = {
        title = "Kelepçe Kır",
        icon = "#cuffs-break",
        functionName = "police:breakcuffMenu"
    },
    ['cuffs:uncuff'] = {
        title = "Kelepçe Çöz",
        icon = "#cuffs-uncuff",
        functionName = "police:uncuffMenu"
    },
    ['cuffs:remmask'] = {
        title = "Maske Çıkar",
        icon = "#cuffs-remove-mask",
        functionName = "police:remmask"
    },
    ['wht:rob'] = {
        title = "Hedefi Ara",
        icon = "#cuffs-check-inventory",
        functionName = "police:client:RobPlayer"
    },
    ['cuffs:checkinventory'] = {
        title = "Hedefi Ara",
        icon = "#cuffs-check-inventory",
        functionName = "police:client:RobPlayer"
    },
    ['cuffs:unseat'] = {
        title = "Hedefi Çıkar",
        icon = "#cuffs-unseat-player",
        functionName = "unseatPlayerCiv"
    },
    ['medic:revive'] = {
        title = "Canlandır",
        icon = "#medic-revive",
        functionName = "revive"
    },
    ['medic:heal'] = {
        title = "İyileştir",
        icon = "#medic-heal",
        functionName = "ems:heal"
    },
    ['police:cuff'] = {
        title = "Kelepçe Tak",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },
    ['police:checklicenses'] = {
        title = "Lisanslara Bak",
        icon = "#police-check-licenses",
        functionName = "police:checkLicenses"
    },
    ['police:removeweapons'] = {
        title = "Silah Lisansına El Koy",
        icon = "#police-action-remove-weapons",
        functionName = "police:removeWeapon"
    },
    ['police:gsr'] = {
        title = "GSR Test",
        icon = "#police-action-gsr",
        functionName = "police:gsr"
    },
    ['police:dnaswab'] = {
        title = "DNA Örneği Al",
        icon = "#police-action-dna-swab",
        functionName = "evidence:dnaSwab"
    },
    ['police:toggleradar'] = {
        title = "Radar Çalıştır",
        icon = "#police-vehicle-radar",
        functionName = "wk:toggleRadar"
    },
    ['police:runplate'] = {
        title = "Plaka Sorgula",
        icon = "#police-vehicle-plate",
        functionName = "clientcheckLicensePlate"
    },
    ["expressions:angry"] = {
        title="Sinirli",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Alkollü",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Salak",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Çarpılmış",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Huzursuz",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Mutlu",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Yaralı",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Zevkli",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Nefes Cihazı",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="Tek Göz",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Şaşkın",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Uyuyan",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Düşünceli",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stresli",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulk",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Garip",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Garip 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    },
	
	-------------------Function List---------------------
	
	['mechanic:hijack'] = {
        title = "Aracı Aç",
        icon = "#police-vehicle",
        functionName = "pw:open"
    },
    ['mechanic:repair'] = {
        title = "Tamir Et",
        icon = "#police-vehicle",
        functionName = "pw:mechrepair"
    },
    ['mechanic:clean'] = {
        title = "Temizle",
        icon = "#police-vehicle",
        functionName = "pw:mechclean"
    },
    ['mechanic:impound'] = {
        title = "Çek",
        icon = "#police-vehicle",
        functionName = "pw:menuimpound"
    },
    ['cuffs:cuff'] = {
        title = "Kelepçele",
        icon = "#cuffs-cuff",
        functionName = "pw:handcuff"
    }, 
    ['cuffs:uncuff'] = {
        title = "Kelepçeyi Çöz",
        icon = "#cuffs-uncuff",
        functionName = "pw:uncuff"
    },
	['police:kelepcekir'] = {
        title = "Kelepce Kır",
        icon = "#cuffs-break",
        functionName = "pw:kirmaBaslat"		
	},   
	['medic:revive'] = {
        title = "Yavaş İyileştir",
        icon = "#medic-heartbeat",
        functionName = "pw:emsRevive"
    },
    ['medic:telsizkullan'] = {
        title = "Telsiz Kullan",
        icon = "#police-vehicle-radar",
        functionName = "ls-radio:use"
    },
    ['medic:put'] = {
        title = "Yaralıyı Arabadan Çıkar",
        icon = "#general-put-in-veh",
        functionName = "pw:outv"
    },
    ['medic:out'] = {
        title = "Yaralıyı Arabaya Koy",
        icon = "#general-unseat-nearest",
        functionName = "pw:putv"
    },
    ['medic:heal'] = {
        title = "Küçük Yaraları Tedavi Et",
        icon = "#medic-heal",
        functionName = "pw:emssmallheal"
    },
    ['medic:bigheal'] = {
        title = "Büyük Yaraları Tedavi Et",
        icon = "#medic-heal",
        functionName = "pw:emsbigheal"
    },
	['medic:gpskullan'] = {
	    title = "GPS GIR",
		icon = "#cuffs-check-phone",
		functionName = "pw:gpsgir"
	},
	['medic:faturakes'] = {
	    title = "Fatura Kes",
		icon = "#animation-business",
		functionName = "pw:medicbill"
	},
    ['police:escort'] = {
        title = "Taşı",
        icon = "#general-escort",
        functionName = "pw:escort"
    },
    ['police:revive'] = {
        title = "Canlandır",
        icon = "#medic-revive",
        functionName = "pw:pdrevive"
    },
    ['police:putinvehicle'] = {
        title = "Arabaya Koy",
        icon = "#general-put-in-veh",
        functionName = "pw:putinvehicle"
    },
    ['police:unseatnearest'] = {
        title = "Arabadan Çıkar",
        icon = "#general-unseat-nearest",
        functionName = "pw:takeoutvehicle"
    },
    ['police:impound'] = {
        title = "Aracı Çek",
        icon = "#police-vehicle",
        functionName = "pw:menuimpound"
    },
    ['police:open'] = {
        title = "Aracı Aç",
        icon = "#police-vehicle",
        functionName = "pw:open"
    },
    ['police:community'] = {
        title = "Topluluk Hizmeti",
        icon = "#animation-hobo",
        functionName = "pw:kamu"
    },
    ['police:fine'] = {
        title = "Ceza Kes",
        icon = "#animation-business",
        functionName = "pw:ceza"
    },
    ['police:telsizkullan'] = {
        title = "Telsiz Kullan",
        icon = "#police-vehicle-radar",
        functionName = "ls-radio:use"
    },
	['police:gsr'] = {
        title = "Barut Testi",
        icon = "#police-action-gsr",
        functionName = "pw:checkGSR"
    },
	['pw:search'] = {
        title = "Üst Arama",
        icon = "#police-action-gsr",
        functionName = "police:client:RobPlayer"
    },
    ['police:getid'] = {
        title = "Kimlik Bilgisi",
        icon = "#police-vehicle-plate",
        functionName = "pw:getid"
    },
	['police:gpskullan'] = {
	    title = "GPS GIR",
		icon = "#cuffs-check-phone",
		functionName = "pw:gpsgir"
	},
	['police:odenmemisfatura'] = {
	    title = "Ödenmemiş Fatura",
		icon = "#billing",
		functionName = "pw:faturagor"
	},
	['police:lisansver'] = {
	    title = "Lisans Ver",
		icon = "#police-check-licenses",
		functionName = "pw:lisansver"
	},	
	['police:jail'] = {
	    title = "Hapise Gönder",
		icon = "#police-jail",
		functionName = "pw:jail"
	},
	
	['player:drag'] = {
	    title = "Taşı",
		icon = "#general-escort",
		functionName = "pw:playerescort"
	},
	['player:putin'] = {
	    title = "Araca bindir",
		icon = "#general-put-in-veh",
		functionName = "pw:playerputv"
	},
	['player:putout'] = {
	    title = "Araçtan indir",
		icon = "#general-unseat-nearest",
		functionName = "pw:playeroutv"
	},
	
	
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    if isMedic and job ~= "ambulance" then isMedic = false end
    if isPolice and job ~= "police" then isPolice = false end
    if isDoctor and job ~= "doctor" then isDoctor = false end
    if isNews and job ~= "reporter" then isNews = false end
    if job == "police" then isPolice = true end
    if job == "ambulance" then isMedic = true end
    if job == "reporter" then isNews = true end
    if job == "doctor" then isDoctor = true end
    myJob = job
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

AddEventHandler("carry",function(set)
	carrying = set
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("esx_cuffs:cuffStatus")
AddEventHandler("esx_cuffs:cuffStatus", function(cuffStatus)
    isHandcuffedAndWalking = cuffStatus
    isHandcuffed = cuffStatus
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

trainstations = {
    {-547.34057617188,-1286.1752929688,25.3059978411511},
    {-892.66284179688,-2322.5168457031,-13.246466636658},
    {-1100.2299804688,-2724.037109375,-8.3086919784546},
    {-1071.4924316406,-2713.189453125,-8.9240007400513},
    {-875.61907958984,-2319.8686523438,-13.241264343262},
    {-536.62890625,-1285.0009765625,25.301458358765},
    {270.09558105469,-1209.9177246094,37.465930938721},
    {-287.13568115234,-327.40936279297,8.5491418838501},
    {-821.34295654297,-132.45257568359,18.436864852905},
    {-1359.9794921875,-465.32354736328,13.531299591064},
    {-498.96591186523,-680.65930175781,10.295949935913},
    {-217.97073364258,-1032.1605224609,28.724565505981},
    {113.90325164795,-1729.9976806641,28.453630447388},
    {117.33223724365,-1721.9318847656,28.527353286743},
    {-209.84713745117,-1037.2414550781,28.722997665405},
    {-499.3971862793,-665.58514404297,10.295639038086},
    {-1344.5224609375,-462.10494995117,13.531820297241},
    {-806.85192871094,-141.39852905273,18.436403274536},
    {-302.21514892578,-327.28854370117,8.5495929718018},
    {262.01733398438,-1198.6135253906,37.448017120361},
    {2072.4086914063,1569.0856933594,76.712524414063},
    {664.93090820313,-997.59942626953,22.261747360229},
    {190.62687683105,-1956.8131103516,19.520135879517},
    {2611.0278320313,1675.3806152344,26.578210830688},
    {2615.3901367188,2934.8666992188,39.312232971191},
    {2885.5346679688,4862.0146484375,62.551517486572},
    {47.061096191406,6280.8969726563,31.580261230469},
    {2002.3624267578,3619.8029785156,38.568252563477},
    {2609.7016601563,2937.11328125,39.418235778809}
}
