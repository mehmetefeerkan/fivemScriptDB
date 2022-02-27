ESX = nil
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if ESX ~= nil then
       
        else
            ESX = nil
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
    end
end)

FIZZ = {}
FIZZ.Cloth = true -- Kıyafet Menüsünü kaldırmak için false yapın
FIZZ.Prop = true  -- prop menüsünü kapatmak için false yapın
FIZZ.IDCard = true -- kimlik göstermeyi kapatmak için false yapın

local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
 
RegisterNetEvent('idcard:gor')
AddEventHandler('idcard:gor', function()
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent('idcard:goster')
AddEventHandler('idcard:goster', function()
    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
    else
    exports['mythic_notify']:SendAlert('inform', 'Yakında birisi yok', 2500)
    end
end)



RegisterNetEvent('idcard:ehliyetgor')
AddEventHandler('idcard:ehliyetgor', function()
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end)

RegisterNetEvent('idcard:ehliyetgoster')
AddEventHandler('idcard:ehliyetgoster', function()
    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
    else
        exports['mythic_notify']:SendAlert('inform', 'Yakında birisi yok', 2500)
    end
end)

RegisterNetEvent('idcard:ruhsatgor')
AddEventHandler('idcard:ruhsatgor', function()
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'license')
end)

RegisterNetEvent('idcard:ruhsatgoster')
AddEventHandler('idcard:ruhsatgoster', function()
    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'license')
    else
        exports['mythic_notify']:SendAlert('inform', 'Yakında birisi yok', 2500)
    end
end)

RegisterNetEvent('animasyon:iptal')
AddEventHandler('animasyon:iptal', function()
    ClearPedTasks(PlayerPedId())
    TriggerEvent('fishing:break')
end)

RegisterNetEvent('kiyafet:menu')
AddEventHandler('kiyafet:menu', function()
    ExecuteCommand('km')
end)

RegisterNetEvent('neon:all')
AddEventHandler('neon:all', function()
   ExecuteCommand('neonai')
end)

RegisterNetEvent('neon:right')
AddEventHandler('neon:right', function()
   ExecuteCommand('neonaidesine')
end)

RegisterNetEvent('neon:back')
AddEventHandler('neon:back', function()
   ExecuteCommand('neonaigalas')
end)

RegisterNetEvent('neon:left')
AddEventHandler('neon:left', function()
   ExecuteCommand('neonaikaire')
end)

RegisterNetEvent('neon:front')
AddEventHandler('neon:front', function()
   ExecuteCommand('neonaipriekis')
end)

RegisterNetEvent('arac:motor')
AddEventHandler('arac:motor', function()
   ExecuteCommand('engine')
end)

RegisterNetEvent('arac:bagaj')
AddEventHandler('arac:bagaj', function()
   ExecuteCommand('trunk')
end)

RegisterNetEvent('arac:kaput')
AddEventHandler('arac:kaput', function()
   ExecuteCommand('hood')
end)

RegisterNetEvent('arac:cam')
AddEventHandler('arac:cam', function()
   ExecuteCommand('windowfront')
   ExecuteCommand('windowback')
end)

RegisterNetEvent('arac:koltuk1')
AddEventHandler('arac:koltuk1', function()
   ExecuteCommand('seat 1')
end)

RegisterNetEvent('arac:koltuk2')
AddEventHandler('arac:koltuk2', function()
   ExecuteCommand('seat 2')
end)

RegisterNetEvent('arac:koltuk3')
AddEventHandler('arac:koltuk3', function()
   ExecuteCommand('seat 3')
end)

RegisterNetEvent('arac:koltuk4')
AddEventHandler('arac:koltuk4', function()
   ExecuteCommand('seat 4')
end)

rootMenuConfig =  {
	{
        id = "car",
        displayName = "Araç",
        icon = "#general-keys-give",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end
        end,
        subMenus = {"arac:motor", "arac:bagaj", "arac:kaput", "arac:cam"}
    },
    {
        id = "koltuk",
        displayName = "Koltuk",
        icon = "#general-keys-give",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end
        end,
        subMenus = {"arac:koltuk1", "arac:koltuk2", "arac:koltuk3", "arac:koltuk4"}
    },
    {
        id = "neon",
        displayName = "Neon",
        icon = "#general-keys-give",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end
        end,
        subMenus = {"neon:all", "neon:right", "neon:left", "neon:front", "neon:back"}
    },
    {
        id = "fizzfaugenel",
        displayName = "Kucaklama Menüsü",
        icon = "#anims",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end        end,
        functionName = "esx_barbie_lyftupp"
        --subMenus = {"kvl:tasi"}
    },
    {
        id = "id",
        displayName = "Kimlik",
        icon = "#id-card-symbol",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if FIZZ.IDCard then
            return not fuck
        end
        end,
        subMenus = {"idcard:goster", "idcard:gor", "idcard:ehliyetgor", "idcard:ehliyetgoster", "idcard:ruhsatgoster", "idcard:ruhsatgor"}
    },
	{
        id = "general",
        displayName = "Animasyon",
        icon = "#anims",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end        end,
        functionName = "dp:RecieveMenu"
    },
    {
        id = "general",
        displayName = "En Yakın",
        icon = "#blips",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
            return not fuck
        end,
        subMenus = {"blips:gasstations", "blips:clotheshop", "blips:barbershop", "blips:garages", "blips:tattooshop", "blips:bank", "blips:market"}
    },
    {
        id = "police-action",
        displayName = "Polis Eylemleri",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
        end,
        subMenus = {"cuffs:cuff", "cuffs:uncuff","police:escort", "police:putinvehicle", "police:object", "police:unseatnearest", "cuffs:checkinventory", "police:gsr", "police:getid", "police:impound", "police:checklicenses", "police:communityservice", "police:jailmenu", "police:billing", "general:checktargetstates"}
    },
    {
        id = "police-action",
        displayName = "Şerif Eylemleri",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "sheriff" and not fuck then
                return true
            end
        end,
        subMenus = {"cuffs:cuff", "cuffs:uncuff","police:escort", "police:putinvehicle", "police:unseatnearest", "cuffs:checkinventory", "police:gsr", "police:getid", "police:impound", "police:checklicenses", "police:communityservice", "police:jailmenu", "police:billing", "general:checktargetstates"}
    },
    {
        id = "stopanim",
        displayName = "Animasyon İptali",
        icon = "#anims",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end        end,
        functionName = "animasyon:iptal"
    },
    {
        id = "clothe",
        displayName = "Kıyafet",
        icon = "#tshirt",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end        end,
        functionName = 'dpc:ToggleMenu'
    },
    {
        id = "expressions",
        displayName = "Ruh Hali",
        icon = "#expressions",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            return not fuck
        end
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "judge-actions",
        displayName = "Mekanik Eylemleri",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "mechanic" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:repair", "mechanic:clean", "mechanic:impound", "mechanic:fatura"}
    },
    {
        id = "judge-actions",
        displayName = "Mekanik Two Eylemleri",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "mechanictwo" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:repair", "mechanic:clean", "mechanic:impound", "mechanic2:fatura"}
    },
       {
        id = "judge-actions",
        displayName = "Mekanik Three Eylemleri",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "mechanicthree" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:repair", "mechanic:clean", "mechanic:impound", "mechanic3:fatura"}
    },
       {
        id = "judge-actions",
        displayName = "Mekanik Four Eylemleri",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "mechanicfour" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:repair", "mechanic:clean", "mechanic:impound", "mechanic4:fatura"}
    },
    {
        id = "prop",
        displayName = "Prop",
        icon = "#prop",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if FIZZ.Prop and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and PlayerData.job.name ~= 'police' then
            return not fuck
        end        end,
 
        subMenus = {"prop:sil", "prop:koy", "prop:briefcase", "prop:boombox", "prop:box", "prop:cashbag"}

    },
    {
        id = "prop",
        displayName = "Prop",
        icon = "#prop",
        enableMenu = function()
        fuck = exports["esx_ambulancejob"]:GetDeath()
        if FIZZ.Prop and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and PlayerData.job.name == 'police' then
            return not fuck
        end        end,
        subMenus = {"prop:sil", "prop:koy", "prop:briefcase", "prop:boombox", "prop:medkit", "prop:box", "prop:cashbag", "prop:cone", "prop:spike", "prop:barrier"}
    },
    {
        id = "medic",
        displayName = "EMS",
        icon = "#medic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
           fuck = exports["esx_ambulancejob"]:GetDeath()
            if PlayerData.job.name == "ambulance" and not fuck then
                return true
            end
        end,
        subMenus = {"medic:revive", "medic:heal", "medic:bigheal", "medic:putinvehicle", "medic:takeoutvehicle"} 
    },
    {
        id = "news",
        displayName = "Haber",
        icon = "#news",
        enableMenu = function()
            return (not isDead and isNews)
        end,
        subMenus = { "news:setCamera", "news:setMicrophone", "news:setBoom" }
    }
}

newSubMenus = {
    ['idcard:gor'] = {
        title = "Kimlik Gör",
        icon = "#id-card-symbol-v3",
        functionName = "idcard:gor"
    },    
    ['idcard:goster'] = {
        title = "Kimlik Göster",
        icon = "#id-card-symbol-v3",
        functionName = "idcard:goster"
    },  
    ['idcard:ehliyetgoster'] = {
        title = "Ehliyet Göster",
        icon = "#id-card-symbol-v2",
        functionName = "idcard:ehliyetgoster"
    },
    ['idcard:ehliyetgor'] = {
        title = "Ehliyet Gör",
        icon = "#id-card-symbol-v2",
        functionName = "idcard:ehliyetgor"
    },  
    ['idcard:ruhsatgor'] = {
        title = "Silah Ruhsatı Gör",
        icon = "#police-vehicle-plate",
        functionName = "idcard:ruhsatgor"
    }, 
    ['idcard:ruhsatgoster'] = {
        title = "Silah Ruhsatı Göster",
        icon = "#police-vehicle-plate",
        functionName = "idcard:ruhsatgoster"
    },
    ['neon:all'] = {
        title = "Neon Tüm",
        icon = "#general-keys-give",
        functionName = "neon:all"
    },
    ['neon:left'] = {
        title = "Neon Sol",
        icon = "#general-keys-give",
        functionName = "neon:left"
    },
    ['neon:right'] = {
        title = "Neon Sağ",
        icon = "#general-keys-give",
        functionName = "neon:right"
    },
    ['neon:front'] = {
        title = "Neon Ön",
        icon = "#general-keys-give",
        functionName = "neon:front"
    },
    ['neon:back'] = {
        title = "Neon Arka",
        icon = "#general-keys-give",
        functionName = "neon:back"
    },
    ['arac:motor'] = {
        title = "Motor Aç/kapa",
        icon = "#general-keys-give",
        functionName = "arac:motor"
    },      
    ['arac:bagaj'] = {
        title = "Bagaj aç/kapa",
        icon = "#general-keys-give",
        functionName = "arac:bagaj"
    },  
    ['arac:kaput'] = {
        title = "Kaput Aç/kapa",
        icon = "#general-keys-give",
        functionName = "arac:kaput"
    },  
    ['arac:cam'] = {
        title = "Camları Aç/kapa",
        icon = "#general-keys-give",
        functionName = "arac:cam"
    },  
    ['arac:koltuk1'] = {
        title = "Sürücü Koltuğu",
        icon = "#general-keys-give",
        functionName = "arac:koltuk1"
    },  
    ['arac:koltuk2'] = {
        title = "Sürücü Yanı",
        icon = "#general-keys-give",
        functionName = "arac:koltuk2"
    },  
    ['arac:koltuk3'] = {
        title = "Arka Sol",
        icon = "#general-keys-give",
        functionName = "arac:koltuk3"
    },  
    ['arac:koltuk4'] = {
        title = "Arka Sağ",
        icon = "#general-keys-give",
        functionName = "arac:koltuk4"
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
        title = "İş",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Alkollü",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Yaralı",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Zorlu",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Şımarık",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Üzgün",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Lüks",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Yabancı",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:hobo'] = {
        title = "Serseri",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Zengin",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Çalımlı",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Gizemli",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Baştan Çıkaran",
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
    ["prop:briefcase"]  = {
        title="Çanta",
        icon="#brief-case",
        functionName = "prop:briefcase"
    },
    ["prop:cone"]  = {
        title="Koni",
        icon="#cone",
        functionName = "attach:cone"
    },
    ["prop:cashbag"]  = {
        title="Para Çantası",
        icon="#brief-case",
        functionName = "attach:cashbag"
    },
    ["prop:sil"]  = {
        title="Sil",
        icon="#delete-prop",
        functionName = "prop:sil"
    },
    ["prop:boombox"]  = {
        title="Teyip",
        icon="#boombox",
        functionName = "prop:boombox"
    },
    ["prop:koy"]  = {
        title=" Koy / Al",
        icon="#put",
        functionName = "prop:koy"
    },
    ["prop:medkit"]  = {
        title="Medkit",
        icon="#medkit",
        functionName = "attach:medkit"
    },
    ["prop:box"]  = {
        title="Kutu",
        icon="#kutu",
        functionName = "attach:box"
    },
    ["prop:spike"]  = {
        title="Diken",
        icon="#spike",
        functionName = "attach:spike"
    },
    ["prop:barrier"]  = {
        title="Bariyer",
        icon="#barrier",
        functionName = "attach:barrier"
    },
    ['mechanic:hijack'] = {
        title = "Aracın Kilidini Aç",
        icon = "#open-lock",
        functionName = "st:hijack"
    },
    ['mechanic:repair'] = {
        title = "Tamir",
        icon = "#general-check-vehicle",
        functionName = "st:mechrepair"
    },
    ['mechanic:clean'] = {
        title = "Temizle",
        icon = "#broom-fizz",
        functionName = "st:mechclean"
    },
    ['mechanic:impound'] = {
        title = "Aracı Çek",
        icon = "#police-vehicle",
        functionName = "st:mechimpound"
    },
    ['mechanic:fatura'] = {
        title = "Fatura",
        icon = "#fine-amount",
        functionName = "st:fatura"
    },
    ['mechanic2:fatura'] = {
        title = "Fatura",
        icon = "#fine-amount",
        functionName = "st:fatura2"
    },
    ['mechanic3:fatura'] = {
        title = "Fatura",
        icon = "#fine-amount",
        functionName = "st:fatura3"
    },
    ['mechanic4:fatura'] = {
        title = "Fatura",
        icon = "#fine-amount",
        functionName = "st:fatura4"
    },
    ['cuffs:cuff'] = {
        title = "Sert Kelepçe",
        icon = "#cuffs-cuff",
        functionName = "st:handcuff"
    }, 
    ['cuffs:uncuff'] = {
        title = "Kelepçeyi Çöz",
        icon = "#cuffs-uncuff",
        functionName = "st:uncuff"
    },
    ['cuffs:checkinventory'] = {
        title = "Kişi Ara",
        icon = "#cuffs-check-inventory",
        functionName = "st:search"
    },
    ['cuffs:unseat'] = {
        title = "Araçtan Çıkar",
        icon = "#cuffs-unseat-player",
        functionName = "esx_ambulancejob:pullOutVehicle"
    },
    ['medic:revive'] = {
        title = "İlkyardım",
        icon = "#medic-revive",
        functionName = "st:emsRevive"
    },
    ['medic:heal'] = {
        title = "Hafif Müdahale",
        icon = "#medic-heal",
        functionName = "st:emssmallheal"
    },
    ['medic:bigheal'] = {
        title = "Ciddi Müdahale",
        icon = "#ciddimud",
        functionName = "st:emsbigheal"
    },
    ['medic:putinvehicle'] = {
        title = "Araça Koy",
        icon = "#general-put-in-veh",
        functionName = "st:emsputinveh"
    },
    ['medic:takeoutvehicle'] = {
        title = "Araçtan Çıkar",
        icon = "#general-unseat-nearest",
        functionName = "st:emstakeoutvehicle"
    },
	['medic:billing'] = {
        title = "Fatura",
        icon = "#fine-amount",
        functionName = "ambulance:billing"
    },
    ['police:escort'] = {
        title = "Taşı",
        icon = "#general-escort",
        functionName = "st:escort"
    },
    ['police:putinvehicle'] = {
        title = "Araca Koy",
        icon = "#general-put-in-veh",
        functionName = "st:emsputinveh"
    },
    ['police:unseatnearest'] = {
        title = "Araçtan Çıkar",
        icon = "#general-unseat-nearest",
        functionName = "st:takeoutvehicle"
    },
    ['police:impound'] = {
        title = "El Koy",
        icon = "#police-vehicle",
        functionName = "st:mechimpound"
    },
    ['police:cuff'] = {
        title = "Kelepçele",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },
    ['police:checkbank'] = {
        title = "Ödenmemiş Fatura",
        icon = "#check-bills",
        functionName = "police:checkBank"
    },
    ['police:billing'] = {
        title = "Fatura",
        icon = "#fine-amount",
        functionName = "police:billing"
    },
    ['police:checklicenses'] = {
        title = "Lisanslar",
        icon = "#police-check-licenses",
        functionName = "police:checkLicenses"
    },
    ['police:gsr'] = {
        title = "GSR Test",
        icon = "#police-action-gsr",
        functionName = "st:checkGSR"
    },
    ['police:getid'] = {
        title = "Kimlik Bak",
        icon = "#id-card-symbol",
        functionName = "st:getid"
    },
    ['police:communityservice'] = {
        title = "Kamu Hizmeti",
        icon = "#broom-fizz",
        functionName = "police:communityservice"
    },
    ['police:jailmenu'] = {
        title = "Hapis",
        icon = "#jail-fizz",
        functionName = "esx-qalle-jail:openJailMenu"
    },
    ['police:object'] = {
        title = "Obje Menüsü",
        icon = "#judge-licenses-remove-da",
        functionName = "police:object"
    },
    ["expressions:angry"] = {
        title="Sinirli",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Sarhoş",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Aptal",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Şok",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Huysuz",
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
        title="Neşeli",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Ağzı Açık",
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
        title="Şok Olmuş",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Uykulu",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Kibirli",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Düşündürücü",
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
        title="Somurtgan",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Tuhaf",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Tuhaf 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    },
    ["kvl:tasi"]  = {
        title="Taşı",
        icon="#lift",
        functionName = "esx_barbie_lyftupp"
    },
   ['blips:gasstations'] = {
        title = "Benzin",
        icon = "#blips-gasstations",
        functionName = "lexia:togglegas"
    },    
    ['blips:clotheshop'] = {
        title = "Kıyafetçi",
        icon = "#blips-clothe",
        functionName = "lexia:toggleclothes"
    },
    ['blips:bank'] = {
        title = "Banka",
        icon = "#blips-bank",
        functionName = "lexia:togglebank"
    },
    ['blips:market'] = {
        title = "Market",
        icon = "#blips-market",
        functionName = "lexia:togglemarket"
    },
    ['blips:garages'] = {
        title = "Garaj",
        icon = "#blips-garages",
        functionName = "lexia:togglegarage"
    },
    ['blips:barbershop'] = {
        title = "Berber",
        icon = "#blips-barbershop",
        functionName = "lexia:togglebarber"
    },    
    ['blips:tattooshop'] = {
        title = "Dövmeci",
        icon = "#blips-tattooshop",
        functionName = "lexia:toggletattos"
    },
    ["police:eup"]  = {
        title="Kıyafet Menüsü",
        icon="#tshirt",
        functionName = "police:eup"
    },
    ["blips:cardealer"]  = {
        title="Galeri",
        icon="#cardealer",
        functionName = "blips:cardealer"
    },
	['animasyon:iptal'] = {
        title = "Animasyon İptal",
        icon = "#anims",
        functionName = "animasyon:iptal"
    },
    ['animasyon:aç'] = {
        title = "Animasyonlar",
        icon = "#anims",
        functionName = "dp:RecieveMenu"
    },
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
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
