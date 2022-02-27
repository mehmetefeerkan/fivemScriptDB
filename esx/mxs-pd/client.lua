ESX = nil

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

RegisterNetEvent("mxs:pd:client")
AddEventHandler("mxs:pd:client", function()
  PlayerData = ESX.GetPlayerData()
  if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' then
       startAnim()
       OpenMedicalRecords()
  else
    -- exports['mythic_notify']:SendAlert('error', 'Bu tableti kullanamazsın.')
	TriggerEvent('notification', 'Polis değilsin, tableti kullanamazsın!', 2)
  end
end)


function startAnim()
  Citizen.CreateThread(function()
    temp = false
    if not temp then
         RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
            while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base") do
              Citizen.Wait(0)
            end
        TaskPlayAnim(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
        temp = true
    end
  end)
end

function OpenMedicalRecords()

  tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
  AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
  local ped = PlayerPedId()

  ESX.UI.Menu.CloseAll()

	local elements      = {}

  table.insert(elements, {label = '📌Ceza Kanunu', value = "cezakanunu"})	
  table.insert(elements, {label = '📚Kayıtlı Sabıkalar', value = "kayitlisabika"})	
  table.insert(elements, {label = '📜Arananlar', value = "arananlar"})
  table.insert(elements, {label = '👮 Personel Listesi', value = "personellistesi"})
  table.insert(elements, {label = '📑Ruhsatlar', value = "ruhsatlar"})	
  table.insert(elements, {label = '📚Sabıka Ekle', value = "sabikaekle"})
  table.insert(elements, {label = '📑Ruhsat ekle', value = "ruhsatekle"})	
  table.insert(elements, {label = '📜Arananlar listesine ekle', value = "aramaekle"})	
  table.insert(elements, {label = '👮Personel Ekle', value = "personelekle"})
  table.insert(elements, {label = '❌Kapat', value = "kapat"})	

      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'medical_records',
      {
        title    = 'LSPD-LSSD',
        align    = 'top-right',
        elements = elements,

      }, function(data, menu)

    if data.current.value == "kayitlisabika" then

			ESX.TriggerServerCallback('mxs:checkrecords', function(crimes) 

      local elements = {}

      for i=1, #crimes, 1 do
        table.insert(elements, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("İsim:").. crimes[i].identity .. ' - '  .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("İşlediği suç:").. crimes[i].records .. ' - ' .. ('<span style="color:red;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Tarih:") .. crimes[i].date})
      end

      ESX.UI.Menu.Open(
           'default', GetCurrentResourceName(), 'records',
           {
              title    = 'LSPD-LSSD',
              align    = 'top-right',
              elements = elements
          }, function(data2, menu2)
           menu2.close()
          end,
        function(data2, menu2)
        menu2.close()
        end)
        end)
      elseif data.current.value == "personellistesi" then

			ESX.TriggerServerCallback('mxs:checkrecords2', function(crimes) 

      local elements = {}

      for i=1, #crimes, 1 do
        table.insert(elements, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("Personel:").. crimes[i].identity .. ' - '  .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Personel Kodu:").. crimes[i].records .. ' - ' .. ('<span style="color:red;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Tarih:") .. crimes[i].date})
      end

      ESX.UI.Menu.Open(
           'default', GetCurrentResourceName(), 'records',
           {
              title    = 'LSPD-LSSD',
              align    = 'top-right',
              elements = elements
          }, function(data2, menu2)
           menu2.close()
          end,
        function(data2, menu2)
        menu2.close()
        end)
        end)
      elseif data.current.value == "cctvkapat" then

        TriggerEvent('cctv:camera', '0')   
      elseif data.current.value == "cctv" then

        TriggerEvent('cctv:camera', '2')
      elseif data.current.value == "cctv2" then

        TriggerEvent('cctv:camera', '1') 

      elseif data.current.value == "arananlar" then

        ESX.TriggerServerCallback('mxs:checkrecords2', function(crimes) 
  
        local elements = {}
  
        for i=1, #crimes, 1 do
          table.insert(elements, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("Kişi:").. crimes[i].identity .. ' - '  .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Aranma sebebi:").. crimes[i].records .. ' - ' .. ('<span style="color:red;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Tarih:") .. crimes[i].date})
        end
  
        ESX.UI.Menu.Open(
             'default', GetCurrentResourceName(), 'records',
             {
                title    = 'LSPD-LSSD',
                align    = 'top-right',
                elements = elements
            }, function(data2, menu2)
             menu2.close()
            end,
          function(data2, menu2)
          menu2.close()
          end)
          end)
      elseif data.current.value == "cezakanunu" then

        ESX.TriggerServerCallback('mxs:checkrecords3', function(crimes) 
  
        local elements = {}
  
        for i=1, #crimes, 1 do
          table.insert(elements, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("Suç:").. crimes[i].identity .. ' - '  .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Cezası:").. crimes[i].records .. ' - ' .. ('<span style="color:red;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Tarih:") .. crimes[i].date})
        end
  
        ESX.UI.Menu.Open(
             'default', GetCurrentResourceName(), 'records',
             {
                title    = 'LSPD-LSSD',
                align    = 'top-right',
                elements = elements
            }, function(data2, menu2)
             menu2.close()
            end,
          function(data2, menu2)
          menu2.close()
          end)
          end)
        elseif data.current.value == "ruhsatlar" then

          ESX.TriggerServerCallback('mxs:checkrecords4', function(crimes) 
    
          local elements = {}
    
          for i=1, #crimes, 1 do
            table.insert(elements, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("İsim:").. crimes[i].identity .. ' - '  .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Son tarih:").. crimes[i].records .. ' - ' .. ('<span style="color:red;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Tarih:") .. crimes[i].date})
          end
    
          ESX.UI.Menu.Open(
               'default', GetCurrentResourceName(), 'records',
               {
                  title    = 'LSPD-LSSD',
                  align    = 'top-right',
                  elements = elements
              }, function(data2, menu2)
               menu2.close()
              end,
            function(data2, menu2)
            menu2.close()
            end)
            end)      
            
    elseif data.current.value == "kapat" then

      menu.close()
      ClearPedTasks(ped)
      DeleteObject(tab)

    elseif data.current.value == "sabikaekle" then


       ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kisiismi',
        {
          title = "Kişi ismi"
        },
    function(data3, menu3)

      menu3.close()

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'aciklama',
		  {
		  	title = "Açıklama"
      },
     function(data4, menu4)
      
      menu4.close()
      
      local identity = data3.value
      local record = data4.value

			Citizen.Wait(300)

      TriggerServerEvent("mxs:addrecord", identity, record)
      TriggerServerEvent("mxs:sabikaekle","**Kişi : **" ..identity.. "\n**İşlediği suç : **" ..record)
      -- exports['mythic_notify']:SendAlert('success', 'Sabıka kaydı başarıyla eklendi.')
	  TriggerEvent('notification', 'Sabıka kaydı başarıyla eklendi', 1)
      Wait(1000)

      end, function(data4, menu4)
      end)
			end, function(data3, menu3)
        menu3.close()
      end)
    elseif data.current.value == "ruhsatekle" then


   ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kisiismi',
    {
      title = "Kişi ismi"
    },
function(data3, menu3)

  menu3.close()

ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'son kullanim',
  {
    title = "Açıklama"
  },
 function(data4, menu4)
  
  menu4.close()
  
  local identity = data3.value
  local record = data4.value

  Citizen.Wait(300)

  TriggerServerEvent("mxs:addrecord4", identity, record)
  TriggerServerEvent("mxs:ruhsatekle","**Kişi : **" ..identity.. "\n**Son geçerlilik tarihi : **" ..record)
  -- exports['mythic_notify']:SendAlert('success', 'Ruhsat kaydı başarıyla eklendi.')
  TriggerEvent('notification', 'Ruhsat kaydı başarıyla eklendi', 1)
  Wait(1000)

  end, function(data4, menu4)
  end)
  end, function(data3, menu3)
    menu3.close()
  end)
elseif data.current.value == "aramaekle" then


ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kisiismi',
{
  title = "Kişi ismi"
},
function(data3, menu3)

menu3.close()

ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'son kullanim',
{
title = "Açıklama"
},
function(data4, menu4)

menu4.close()

local identity = data3.value
local record = data4.value

Citizen.Wait(300)

TriggerServerEvent("mxs:addrecord5", identity, record)
TriggerServerEvent("mxs:aramakarari","**Aranan kişi : **" ..identity.. "\n**Aranma sebebi : **" ..record)
-- exports['mythic_notify']:SendAlert('success', 'Arama kaydı başarıyla eklendi.')
 TriggerEvent('notification', 'Arama kaydı başarıyla eklendi', 1)
Wait(1000)

end, function(data4, menu4)
end)
end, function(data3, menu3)
menu3.close()
end)
    elseif data.current.value == "personelekle" then


   ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kisiismi',
    {
      title = "Kişi ismi"
    },
function(data3, menu3)

  menu3.close()

ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'aciklama',
  {
    title = "Kodu"
  },
 function(data4, menu4)
  
  menu4.close()
  
  local identity = data3.value
  local record = data4.value

  Citizen.Wait(300)

  TriggerServerEvent("mxs:addrecord2", identity, record)
  -- exports['mythic_notify']:SendAlert('success', 'Personel başarıyla eklendi.')
  TriggerEvent('notification', 'Personel başarıyla eklendi', 1)
  Wait(1000)

  end, function(data4, menu4)
  end)
  end, function(data3, menu3)
    menu3.close()
  end)
    end
    
  end)
  
end