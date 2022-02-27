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

RegisterNetEvent("edz:medicalrecords:client")
AddEventHandler("edz:medicalrecords:client", function()
  PlayerData = ESX.GetPlayerData()
  if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'avocat' then
       startAnim()
       OpenMedicalRecords()
  else
    exports['mythic_notify']:DoHudText('inform', 'Bu tableti kullanamazsın.')
  end
end)


function startAnim()
  Citizen.CreateThread(function()
    temp = false
    if not temp then
         RequestAnimDict("missheistdockssetup1clipboard@base")
            while not HasAnimDictLoaded("missheistdockssetup1clipboard@base") do
              Citizen.Wait(0)
            end
        TaskPlayAnim(GetPlayerPed(-1), "missheistdockssetup1clipboard@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
        temp = true
    end
  end)
end

function OpenMedicalRecords()

  tab = CreateObject(GetHashKey(""), 0, 0, 0, true, true, true)
  AttachEntityToEntity(tab, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
  local ped = PlayerPedId()

  ESX.UI.Menu.CloseAll()

	local elements      = {}

  table.insert(elements, {label = 'Kayıtlı Hastalar', value = "kayitli"})	
  table.insert(elements, {label = 'Kayıt Ekle', value = "ekle"})	
  table.insert(elements, {label = 'Kapat', value = "kapat"})	

      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'medical_records',
      {
        title    = 'Hasta Kayıt İşlemi',
        align    = 'top-right',
        elements = elements,

      }, function(data, menu)
        menu.close()

    if data.current.value == "kayitli" then

			ESX.TriggerServerCallback('edz:checkrecords', function(crimes) 

      local elements = {}

      for i=1, #crimes, 1 do
        table.insert(elements, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("Hasta:").. crimes[i].identity .. ' - '  .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Açıklama:").. crimes[i].records .. ' - ' .. ('<span style="color:red;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Tarih:") .. crimes[i].date})
      end

      ESX.UI.Menu.Open(
           'default', GetCurrentResourceName(), 'records',
           {
              title    = 'Hasta Kayıtları',
              align    = 'top-right',
              elements = elements
          }, function(data2, menu2)
           menu2.close()
          end,
        function(data2, menu2)
        menu2.close()
        ClearPedTasks(ped)
        DeleteObject(tab)
        end)
        end)
          
    elseif data.current.value == "kapat" then

      menu.close()
      ClearPedTasks(ped)
      DeleteObject(tab)

    elseif data.current.value == "ekle" then

          menu.close()

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

      TriggerServerEvent("edz:addrecord", identity, record)
      exports['mythic_notify']:SendAlert('inform', 'Hasta kaydı başarıyla eklendi.')
      Wait(1000)
      ClearPedTasks(ped)
      DeleteObject(tab)

      end, function(data4, menu4)
      end)
			end, function(data3, menu3)
        menu3.close()
      end)
      menu.close()
    end
  end)
end

