local PlayerData                = {}
ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
      owner = ESX.GetPlayerData().identifier
    end
end) 
local curHouseCoords = {x = 0, y = 0, z = 0}
local inhouse = false
local houseid = nil
local AvailableHouses = {}
local blips = {}
local buyablehouses = {
    [1] = {x = 1061.04, y = -378.61, z = 68.24, houseid = 1, price = 50000, info = 'Stashouse 1'},
    [2] = {x = 1029.42, y = -408.96, z = 65.95, houseid = 2, price = 55000, info = 'Stashouse 2'},
    [3] = {x = 1011.27, y = -422.89, z = 64.96, houseid = 3, price = 8900, info = 'Stashouse 3'},
    [4] = {x = 988.2, y = -433.74, z = 63.9, houseid = 4, price = 8900, info = 'Stashouse 4'},
    [5] = {x = 967.9, y = -452.62, z = 62.41, houseid = 5, price = 8900, info = 'Stashouse 5'},
    [6] = {x = 943.26, y = -463.9, z = 61.4, houseid = 6, price = 8900, info = 'Stashouse 6'},
    [7] = {x = 922.18, y = -478.69, z = 61.09, houseid = 7, price = 8900, info = 'Stashouse 7'},
    [8] = {x = 906.58, y = -489.69, z = 59.44, houseid = 8, price = 8900, info = 'Stashouse 8'},
    [9] = {x = 878.99, y = -498.51, z = 57.88, houseid = 9, price = 8900, info = 'Stashouse 9'},
    [10] = {x = 862.28, y = -509.58, z = 57.33, houseid = 10, price = 8900,  info = 'Stashouse 10'},
    [11] = {x = 851.09, y = -532.73, z = 57.93, houseid = 11, price = 8900, info = 'Stashouse 11'},
    [12] = {x = 844.37, y = -563.77, z = 57.84, houseid = 12, price = 35000, info = 'Stashouse 12'},
    [13] = {x = 861.92, y = -582.26, z = 58.16, houseid = 13, price = 1500, info = 'Stashouse 13'},
    [14] = {x = 887.43, y = -607.54, z = 58.22, houseid = 14, price = 1000, info = 'Stashouse 14'},
    [15] = {x = 903.47, y = -615.87, z = 58.46, houseid = 15, price = 15200, info = 'Stashouse 15'},
    [16] = {x = 929.51, y = -639.12, z = 58.25, houseid = 16, price = 13500, info = 'Stashouse 16'},
    [17] = {x = 943.4, y = -653.71, z = 58.43, houseid = 17, price = 17850,  info = 'Stashouse 17'},
    [18] = {x = 960.54, y = -669.38, z = 58.45, houseid = 18, price = 25060, info = 'Stashouse 18'},
    [19] = {x = 970.9, y = -701.41, z = 58.49, houseid = 19, price = 45000, info = 'Stashouse 19'},
    [20] = {x = 979.49, y = -715.95, z = 58.22, houseid = 20, price = 8900, info = 'Stashouse 20'},
    [21] = {x = 997.52, y = -729.0, z = 57.82, houseid = 21, price = 35000, info = 'Stashouse 21'},
    [22] = {x = 979.92, y = -627.24, z = 59.24, houseid = 22, price = 8900, info = 'Stashouse 22'},
    [23] = {x = 892.79, y = -540.7, z = 58.51, houseid = 23, price = 75000, info = 'Stashouse 23'},
    [24] = {x = 924.02, y = -525.3, z = 59.58, houseid = 24, price = 8900, info = 'Stashouse 24'},
    [25] = {x = 946.26, y = -518.79, z = 60.63, houseid = 25, price = 8900, info = 'Stashouse 25'},
    [26] = {x = 969.57, y = -502.1, z = 62.15,  houseid = 26, price = 8900, info = 'Stashouse 26'},
    [27] = {x = 1014.14, y = -468.72, z = 64.29, houseid = 27, price = 8900, info = 'Stashouse 27'},
    [28] = {x = 1112.37, y = -390.29, z = 68.74, houseid = 28, price = 8900, info = 'Stashouse 28'},
    [29] = {x = 1263.96, y = -429.2, z = 69.81, houseid = 29, price = 8900, info = 'Stashouse 29'},
    [30] = {x = 1266.76, y = -457.85, z = 70.52, houseid = 30, price = 8900, info = 'Stashouse 30'},
    [31] = {x = 1260.28, y = -479.9, z = 70.19, houseid = 31, price = 8900, info = 'Stashouse 31'},
    [32] = {x = 1251.86, y = -494.2, z = 69.91, houseid = 32, price = 8900, info = 'Stashouse 32'},
    [33] = {x = 1251.5, y = -515.63, z = 69.35, houseid = 33, price = 8900, info = 'Stashouse 33'},
    [34] = {x = 1242.17, y = -565.88, z = 69.66, houseid = 34, price = 8900, info = 'Stashouse 34'},
    [35] = {x = 1241.1, y = -601.67, z = 69.59, houseid = 35, price = 8900, info = 'Stashouse 35'},
    [36] = {x = 1251.6, y = -621.98, z = 69.41, houseid = 36, price = 8900, info = 'Stashouse 36'},
    [37] = {x = 1265.41, y = -647.89, z = 67.93, houseid = 37, price = 8900, info = 'Stashouse 37'},
    [38] = {x = 1271.13, y = -683.04, z = 66.04, houseid = 38, price = 8900, info = 'Stashouse 38'},
    [39] = {x = 1265.94, y = -703.52, z = 64.56, houseid = 39, price = 8900, info = 'Stashouse 39'},
    [40] = {x = 1302.79, y = -528.61, z = 71.47, houseid = 40, price = 8900, info = 'Stashouse 40'},
    [41] = {x = 1327.76, y = -535.86, z = 72.45, houseid = 41, price = 8900, info = 'Stashouse 41'},
    [42] = {x = 1347.87, y = -548.01, z = 73.9, houseid = 42, price = 8900, info = 'Stashouse 42'},
    [43] = {x = 1372.97, y = -555.69, z = 74.69, houseid = 43, price = 8900, info = 'Stashouse 43'},
    [44] = {x = 1388.3, y = -569.93, z = 74.5, houseid = 44, price = 8900, info = 'Stashouse 44'},
    [45] = {x = 1385.47, y = -592.93, z = 74.49, houseid = 45, price = 8900, info = 'Stashouse 45'},
    [46] = {x = 1367.28, y = -605.44, z = 74.72, houseid = 46, price = 8900, info = 'Stashouse 46'},
    [47] = {x = 1341.63, y = -597.5, z = 74.71, houseid = 47, price = 8900, info = 'Stashouse 47'},
    [48] = {x = 1323.76, y = -582.45, z = 73.25, houseid = 48, price = 8900, info = 'Stashouse 48'},
    [49] = {x = 1301.24, y = -573.21, z = 71.74, houseid = 49, price = 8900, info = 'Stashouse 49'},
    [50] = {x = 1437.15, y = -1492.97, z = 63.44, houseid = 50, price = 8900, info = 'Stashouse 50'},
    [51] = {x = 118.41, y = -1921.02, z = 21.32, houseid = 51, price = 2500, info = 'Stashouse 51'},
    [52] = {x = 101.1, y = -1912.31, z = 21.41, houseid = 52, price = 2500, info = 'Stashouse 52'},
    [53] = {x = 86.0, y = -1959.54, z = 21.12, houseid = 53, price = 2500, info = 'Stashouse 53'},
    [54] = {x = 114.39, y = -1961.16, z = 21.33, houseid = 54, price = 2500, info = 'Stashouse 54'},
    [55] = {x = 76.18, y = -1948.19, z = 21.17, houseid = 55, price = 8900, info = 'Stashouse 55'},
    [56] = {x = -140.3, y = -1599.58, z = 34.83, houseid = 56, price = 2500, info = 'Stashouse 56'},
    [57] = {x = -147.81, y = -1596.49, z = 34.83, houseid = 57, price = 2500, info = 'Stashouse 57'},
    [58] = {x = -119.96, y = -1574.65, z = 34.18, houseid = 58, price = 2500, info = 'Stashouse 58'},
    [59] = {x = -134.25, y = -1580.34, z = 37.41, houseid = 59, price = 2500, info = 'Stashouse 59'},
    [60] = {x = -140.06, y = -1587.3, z = 37.41, houseid = 60, price = 8900, info = 'Stashouse 60'},
    [61] = {x = -140.41, y = -1599.49, z = 38.21, houseid = 61, price = 8900, info = 'Stashouse 61'},
    [62] = {x = 343.47, y = -2027.81, z = 22.35, houseid = 62, price = 2500, info = 'Stashouse 62'},
    [63] = {x = 352.02, y = -2034.98, z = 22.35, houseid = 63, price = 2500, info = 'Stashouse 63'},
    [64] = {x = 365.23, y = -2064.6, z = 21.74, houseid = 64, price = 2500, info = 'Stashouse 64'},
    [65] = {x = 341.82, y = -2064.52, z = 20.94, houseid = 65, price = 2500, info = 'Stashouse 65'},
    [66] = {x = 399.13, y = -1864.9, z = 26.72, houseid = 66, price = 8900, info = 'Stashouse 66'},
    [67] = {x = 412.47, y = -1856.38, z = 27.32, houseid = 67, price = 8900, info = 'Stashouse 67'},
    [68] = {x = 427.25, y = -1842.08, z = 28.46, houseid = 68, price = 8900, info = 'Stashouse 68'},
    [69] = {x = 440.44, y = -1829.66, z = 28.36, houseid = 69, price = 8900, info = 'Stashouse 69'},
    [70] = {x = -1109.16, y = -1482.35, z = 4.93, houseid = 70, price = 8900, info = 'Stashouse 70'},
    [71] = {x = -1142.53, y = -1461.34, z = 4.63, houseid = 71, price = 8900, info = 'Stashouse 71'},
    [72] = {x = -1883.28, y = -578.94, z = 11.82, houseid = 72, price = 8900, info = 'Stashouse 72'},
    [73] = {x = -1901.72, y = -586.55, z = 11.88, houseid = 73, price = 8900, info = 'Stashouse 73'},
    [74] = {x = -1913.45, y = -574.22, z = 11.44, houseid = 74, price = 8900, info = 'Stashouse 74'},
    [75] = {x = -1917.79, y = -558.82, z = 11.85, houseid = 75, price = 8900, info = 'Stashouse 75'},
    [76] = {x = -1924.05, y = -559.33, z = 12.07, houseid = 76, price = 8900, info = 'Stashouse 76'},
    [77] = {x = -1918.64, y = -542.55, z = 11.83, houseid = 77, price = 8900, info = 'Stashouse 77'},
    [78] = {x = -1947.03, y = -544.07, z = 11.87, houseid = 78, price = 8900, info = 'Stashouse 78'},
    [79] = {x = -1947.95, y = -531.65, z = 11.83, houseid = 79, price = 8900, info = 'Stashouse 79'},
    [80] = {x = -1968.27, y = -532.39, z = 12.18, houseid = 80, price = 8900, info = 'Stashouse 80'},
    [81] = {x = -1968.36, y = -523.33, z = 11.85, houseid = 81, price = 8900, info = 'Stashouse 81'},
    [82] = {x = -1980.0, y = -520.54, z = 11.9, houseid = 82, price = 8900, info = 'Stashouse 82'},
    [83] = {x = -1070.57, y = -1653.81, z = 4.41, houseid = 83, price = 8900, info = 'Stashouse 83'},
    [84] = {x = -1076.09, y = -1645.79, z = 4.51, houseid = 84, price = 8900, info = 'Stashouse 84'},
    [85] = {x = -1082.93, y = -1631.47, z = 4.74, houseid = 85, price = 8900, info = 'Stashouse 85'},
    [86] = {x = -1088.77, y = -1623.08, z = 4.74, houseid = 86,  price = 8900, info = 'Stashouse 86'},
    [87] = {x = -1092.39, y = -1607.42, z = 8.47, houseid = 87, price = 8900, info = 'Stashouse 87'},
    [88] = {x = -1106.29, y = -1596.34, z = 4.6, houseid = 88, price = 8900, info = 'Stashouse 88'},
    [89] = {x = -1038.86, y = -1609.53, z = 5.0, houseid = 89, price = 8900, info = 'Stashouse 89'},
    [90] = {x = -1029.29, y = -1603.62, z = 4.97, houseid = 90, price = 8900, info = 'Stashouse 90'},
    [91] = {x = -1032.69, y = -1582.77, z = 5.14, houseid = 91, price = 8900, info = 'Stashouse 91'},
    [92] = {x = -1043.47, y = -1580.43, z = 5.04, houseid = 92, price = 8900, info = 'Stashouse 92'},
    [93] = {x = -1041.27, y = -1591.25, z = 4.99, houseid = 93, price = 8900, info = 'Stashouse 93'},
    [94] = {x = -1057.06, y = -1587.44, z = 4.61, houseid = 94, price = 8900, info = 'Stashouse 94'},
    [95] = {x = -1058.16, y = -1540.21, z = 5.05, houseid = 95, price = 8900, info = 'Stashouse 95'},
    [96] = {x = 35.27, y = 6662.8, z = 32.2, houseid = 96, price = 8900, info = 'Stashouse 96'},
    [97] = {x = -9.75, y = 6654.15, z = 31.7, houseid = 97, price = 8900, info = 'Stashouse 97'},
    [98] = {x = -41.3, y = 6636.99, z = 31.09, houseid = 98,  price = 8900, info = 'Stashouse 98'},
    [99] = {x = -130.1, y = 6551.49, z = 29.53, houseid = 99, price = 8900, info = 'Stashouse 99'},
    [100] = {x = -229.77, y = 6445.18, z = 31.2, houseid = 100, price = 8900, info = 'Stashouse 100'},
    [101] = {x = -238.37, y = 6423.4, z = 31.46, houseid = 101, price = 8900, info = 'Stashouse 101'},
    [102] = {x = -272.14, y = 6400.61, z = 31.51, houseid = 102, price = 8900, info = 'Stashouse 102'},
    [103] = {x = -359.51, y = 6334.64, z = 29.85, houseid = 103, price = 8900, info = 'Stashouse 103'},
    [104] = {x = -407.22, y = 6314.12, z = 28.95, houseid = 104, price = 8900, info = 'Stashouse 104'},
    [105] = {x = -447.9, y = 6271.69, z = 33.34, houseid = 105, price = 8900, info = 'Stashouse 105'},
    [106] = {x = -467.97, y = 6206.18, z = 29.56, houseid = 106, price = 8900, info = 'Stashouse 106'},
    [107] = {x = -379.73, y = 6253.05, z = 31.86, houseid = 107, price = 8900, info = 'Stashouse 107'},
    [108] = {x = -370.91, y = 6267.2, z = 31.88, houseid = 108, price = 8900, info = 'Stashouse 108'},
    [109] = {x = -302.07, y = 6327.4, z = 32.89, houseid = 109, price = 8900, info = 'Stashouse 109'},
    [110] = {x = -280.62, y = 6350.84, z = 32.61, houseid = 110, price = 8900, info = 'Stashouse 110'},
    [111] = {x = -247.88, y = 6369.98, z = 31.85, houseid = 111, price = 8900, info = 'Stashouse 111'},
    [112] = {x = -227.7, y = 6377.93, z = 31.76, houseid = 112, price = 8900, info = 'Stashouse 112'},
    [113] = {x = -213.86, y = 6396.5, z = 33.09, houseid = 113, price = 8900, info = 'Stashouse 113'},
    [114] = {x = -189.07, y = 6409.72, z = 32.3, houseid = 114, price = 8900, info = 'Stashouse 114'},
    [115] = {x = -167.23, y = 6439.25, z = 31.92, houseid = 115, price = 8900, info = 'Stashouse 115'},
    [116] = {x = -160.3, y = 6432.18, z = 31.92, houseid = 116, price = 8900, info = 'Stashouse 116'},
    [117] = {x = -150.38, y = 6422.38, z = 31.92, houseid = 117, price = 8900, info = 'Stashouse 117'},
    [118] = {x = -150.38, y = 6416.99, z = 31.92, houseid = 118, price = 8900, info = 'Stashouse 118'},
    [119] = {x = -157.31, y = 6409.99, z = 31.92, houseid = 119, price = 8900, info = 'Stashouse 119'}
}

Citizen.CreateThread(function()
	if Hsn.ShowBlips == true then
    for k,v in pairs(buyablehouses) do
		local blip = AddBlipForCoord(v.x,v.y)

		SetBlipSprite (blip, 40)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5)
		SetBlipColour (blip, 0)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Evler')
		EndTextCommandSetBlipName(blip)
    end
end

end)


RegisterCommand("eval",function()
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    for id,v in pairs(buyablehouses) do
        if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
            houseid = v.houseid
            price = v.price
          TriggerServerEvent('hsn-stashouse:setbuy', houseid, price)
        end
    end
end) 


RegisterNetEvent('hsn-stashouse:setHouseclient')
AddEventHandler('hsn-stashouse:setHouseclient', function(houseid)
  OwnedHouse = houseid

  --for k, v in pairs(blips) do
    --  RemoveBlip(v)
  --end

  for k, v in pairs(buyablehouses) do
      if v.houseid ~= OwnedHouse.houseid then
          AvailableHouses[v.houseid] = v.houseid
      end
  end

  for k, v in pairs(buyablehouses) do
      if OwnedHouse.houseid == k then
          CreateBlip(v.x,v.y, 40, 3, 0.75, "Ev")
      else
          if not AvailableHouses[k] then
             -- if Config.AddHouseBlips then
                  CreateBlip(v.x,v.y, 374, 0, 0.45, "Ev")
             -- end
          else
            --  if Config.AddBoughtHouses then
                  CreateBlip(v.x,v.y, 374, 2, 0.45, "Ev")
            --  end
          end
      end
  end
end)

CreateBlip = function(x,y,sprite, colour, scale, text)
  local blip = AddBlipForCoord(x,y)
  SetBlipSprite(blip, sprite)
  SetBlipColour(blip, colour)
  SetBlipAsShortRange(blip, true)
  SetBlipScale(blip, scale)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(blip)
  table.insert(blips, blip)
end



RegisterCommand('stashgir',function()
    print("+komut")
  local playerCoords = GetEntityCoords(PlayerPedId(), true)
    for id,v in pairs(buyablehouses) do
        if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
          houseid,evid = v.houseid
          ESX.TriggerServerCallback('hsn-stashouse:checkIsOwner', function(sahip)
            if sahip then
              TriggerEvent("enteranimation")
              Citizen.Wait(800)
            TriggerEvent('hsn-stashouse:createhouse',id)
            print("Giriliyor"..houseid.."")
            else
              ESX.ShowNotification("Bu evin sahibi siz değilsiniz.")
            end
          end,houseid)
        end
    end
end)




RegisterCommand("evfiyat",function()
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    for id,v in pairs(buyablehouses) do
        if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
            price = v.price
            ESX.ShowNotification("Evin fiyatı :"..price.." $ ")
        end
    end
end)

RegisterNetEvent('hsn-stashouse:createhouse')
AddEventHandler('hsn-stashouse:createhouse', function(id,evid)
 local house = buyablehouses[id]



 DoScreenFadeOut(100)
 Citizen.Wait(100)

 evolustur({x = house.x, y = house.y, z = house.z-50})
 Citizen.Wait(3000)


 curHouseCoords = {x = house.x, y = house.y, z = house.z-50}
 disturbance = 0



 DoScreenFadeIn(100)
 Citizen.Wait(100)

 inhouse = true

 while inhouse do
  Citizen.Wait(0)
  SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
  local playerCoords = GetEntityCoords(PlayerPedId(), true)
  
  if GetDistanceBetweenCoords(playerCoords, house.x+3.6, house.y-15, house.z-50, true) < 2.5 then
    drawNativeNotification("[E] Evden Ayrıl!")
   if IsControlJustPressed(0, 38) then
    TriggerEvent("enteranimation")
    TriggerEvent('hsn-stashouse:deletehouse', id)
   end
  end
 end
end)


  


function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end
  



RegisterNetEvent('hsn-stashouse:deletehouse')
AddEventHandler('hsn-stashouse:deletehouse', function(id)
 local house = buyablehouses[id]

 DoScreenFadeOut(100)
 Citizen.Wait(100)

 FreezeEntityPosition(PlayerPedId(), true)
 DeleteSpawnedHouse(id)

 Citizen.Wait(1000)

 SetEntityCoords(PlayerPedId(), house.x, house.y, house.z)
 FreezeEntityPosition(PlayerPedId(), false)

 Citizen.Wait(500)

 DoScreenFadeIn(100)
 Citizen.Wait(100)

 disturbance = 0
 inhouse = false
end)





function evolustur(generator)
  SetEntityCoords(PlayerPedId(), 347.04724121094, -1000.2844848633, -99.194671630859)
  FreezeEntityPosition(PlayerPedId(), true)
  Citizen.Wait(2000)
  local building = CreateObject(GetHashKey("clrp_house_1"), generator.x, generator.y-0.05, generator.z+1.26253700-89.825, false, false, false)
  FreezeEntityPosition(building, true)
  Citizen.Wait(500)
  SetEntityCoords(PlayerPedId(), generator.x+3.6, generator.y-14.8, generator.z+2.9)
  SetEntityHeading(PlayerPedId(), 358.106)
 
  local dt = CreateObject(GetHashKey("V_16_DT"), generator.x-1.21854400, generator.y-1.04389600, generator.z+1.39068600, false, false, false)
  local mpmid01 = CreateObject(GetHashKey("V_16_mpmidapart01"), generator.x+0.52447510, generator.y-5.04953700, generator.z+1.32, false, false, false)
  local mpmid09 = CreateObject(GetHashKey("V_16_mpmidapart09"), generator.x+0.82202150, generator.y+2.29612000, generator.z+1.88, false, false, false)
  local mpmid07 = CreateObject(GetHashKey("V_16_mpmidapart07"), generator.x-1.91445900, generator.y-6.61911300, generator.z+1.45, false, false, false)
  local mpmid03 = CreateObject(GetHashKey("V_16_mpmidapart03"), generator.x-4.82565300, generator.y-6.86803900, generator.z+1.14, false, false, false)
  local midData = CreateObject(GetHashKey("V_16_midapartdeta"), generator.x+2.28558400, generator.y-1.94082100, generator.z+1.32, false, false, false)
  local glow = CreateObject(GetHashKey("V_16_treeglow"), generator.x-1.37408500, generator.y-0.95420070, generator.z+1.135, false, false, false)
  local curtins = CreateObject(GetHashKey("V_16_midapt_curts"), generator.x-1.96423300, generator.y-0.95958710, generator.z+1.280, false, false, false)
  local mpmid13 = CreateObject(GetHashKey("V_16_mpmidapart13"), generator.x-4.65580700, generator.y-6.61684000, generator.z+1.259, false, false, false)
  local mpcab = CreateObject(GetHashKey("V_16_midapt_cabinet"), generator.x-1.16177400, generator.y-0.97333810, generator.z+1.27, false, false, false)
  local mpdecal = CreateObject(GetHashKey("V_16_midapt_deca"), generator.x+2.311386000, generator.y-2.05385900, generator.z+1.297, false, false, false)
  local mpdelta = CreateObject(GetHashKey("V_16_mid_hall_mesh_delta"), generator.x+3.69693000, generator.y-5.80020100, generator.z+1.293, false, false, false)
  local beddelta = CreateObject(GetHashKey("V_16_mid_bed_delta"), generator.x+7.95187400, generator.y+1.04246500, generator.z+1.28402300, false, false, false)
  local bed = CreateObject(GetHashKey("V_16_mid_bed_bed"), generator.x+6.86376900, generator.y+1.20651200, generator.z+1.33589100, false, false, false)
  local beddecal = CreateObject(GetHashKey("V_16_MID_bed_over_decal"), generator.x+7.82861300, generator.y+1.04696700, generator.z+1.34753700, false, false, false)
  local bathDelta = CreateObject(GetHashKey("V_16_mid_bath_mesh_delta"), generator.x+4.45460500, generator.y+3.21322800, generator.z+1.21116100, false, false, false)
  local bathmirror = CreateObject(GetHashKey("V_16_mid_bath_mesh_mirror"), generator.x+3.57740800, generator.y+3.25032000, generator.z+1.48871300, false, false, false)
 
   --props
  local beerbot = CreateObject(GetHashKey("Prop_CS_Beer_Bot_01"), generator.x+1.73134600, generator.y-4.88520200, generator.z+1.91083000, false, false, false)
  local couch = CreateObject(GetHashKey("v_res_mp_sofa"), generator.x-1.48765600, generator.y+1.68100600, generator.z+1.33640500, false, false, false)
  local chair = CreateObject(GetHashKey("v_res_mp_stripchair"), generator.x-4.44770800, generator.y-1.78048800, generator.z+1.21640500, false, false, false)
  local chair2 = CreateObject(GetHashKey("v_res_tre_chair"), generator.x+2.91325400, generator.y-5.27835100, generator.z+1.22746400, false, false, false)
  local plant = CreateObject(GetHashKey("Prop_Plant_Int_04a"), generator.x+2.78941300, generator.y-4.39133900, generator.z+2.12746400, false, false, false)
  local lamp = CreateObject(GetHashKey("v_res_d_lampa"), generator.x-3.61473100, generator.y-6.61465100, generator.z+2.09373700, false, false, false)
  local fridge = CreateObject(GetHashKey("v_res_fridgemodsml"), generator.x+1.90339700, generator.y-3.80026800, generator.z+1.29917900, false, false, false)
  local micro = CreateObject(GetHashKey("prop_micro_01"), generator.x+2.03442400, generator.y-4.64585100, generator.z+2.28995600, false, false, false)
  local sideBoard = CreateObject(GetHashKey("V_Res_Tre_SideBoard"), generator.x+2.84053000, generator.y-4.30947100, generator.z+1.24577300, false, false, false)
  local bedSide = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x-3.50363200, generator.y-6.55289400, generator.z+1.30625800, false, false, false)
  local lamp2 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+2.69674700, generator.y-3.831262, generator.z+2.09373700, false, false, false)
  local plant2 = CreateObject(GetHashKey("v_res_tre_tree"), generator.x-4.96064800, generator.y-6.09898500, generator.z+1.31631400, false, false, false)
  local table = CreateObject(GetHashKey("V_Res_M_DineTble_replace"), generator.x-3.50712600, generator.y-4.13621600, generator.z+1.29625800, false, false, false)
  local tv = CreateObject(GetHashKey("Prop_TV_Flat_01"), generator.x-5.53120400, generator.y+0.76299670, generator.z+2.17236000, false, false, false)
  local plant3 = CreateObject(GetHashKey("v_res_tre_plant"), generator.x-5.14112800, generator.y-2.78951000, generator.z+1.25950800, false, false, false)
  local chair3 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.04652400, generator.y-4.95971200, generator.z+1.19625800, false, false, false)
  local lampStand = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+1.26588400, generator.y+3.68883900, generator.z+1.35556700, false, false, false)
  local stool = CreateObject(GetHashKey("V_Res_M_Stool_REPLACED"), generator.x-3.23216300, generator.y+2.06159000, generator.z+1.20556700, false, false, false)
  local chair4 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-2.82237200, generator.y-3.59831300, generator.z+1.25950800, false, false, false)
  local chair5 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-4.14955100, generator.y-4.71316600, generator.z+1.19625800, false, false, false)
  local chair6 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.80622900, generator.y-3.37648300, generator.z+1.19625800, false, false, false)
  local plant4 = CreateObject(GetHashKey("v_res_fa_plant01"), generator.x+2.97859200, generator.y+2.55307400, generator.z+1.85796300, false, false, false)
  local storage = CreateObject(GetHashKey("v_res_tre_storageunit"), generator.x+8.47819500, generator.y-2.50979300, generator.z+1.19712300, false, false, false)
  local storage2 = CreateObject(GetHashKey("v_res_tre_storagebox"), generator.x+9.75982700, generator.y-1.35874100, generator.z+1.29625800, false, false, false)
  local basketmess = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+8.70730600, generator.y-2.55503600, generator.z+1.94059590, false, false, false)
  local lampStand2 = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+9.54306000, generator.y-2.50427700, generator.z+1.30556700, false, false, false)
  local plant4 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+9.87521400, generator.y+3.90917400, generator.z+1.20829700, false, false, false)
  local basket = CreateObject(GetHashKey("v_res_tre_washbasket"), generator.x+9.39091500, generator.y+4.49676300, generator.z+1.19625800, false, false, false)
  local wardrobe = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+8.46626300, generator.y+4.53223600, generator.z+1.19425800, false, false, false)
  local basket2 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.51593000, generator.y+4.55647300, generator.z+3.46737300, false, false, false)
  local basket3 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+7.57797200, generator.y+4.55198800, generator.z+3.46737300, false, false, false)
  local basket4 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+7.12286400, generator.y+4.54689200, generator.z+3.46737300, false, false, false)
  local wardrobe2 = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+7.24382000, generator.y+4.534262, generator.z+1.19625800, false, false, false)
  local basket5 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.03364600, generator.y+4.54835500, generator.z+3.46737300, false, false, false)
  local switch = CreateObject(GetHashKey("v_serv_switch_2"), generator.x+6.28086900, generator.y-0.68169880, generator.z+2.30326000, false, false, false)
  local table2 = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x+5.84416200, generator.y+2.57377400, generator.z+1.22089100, false, false, false)
  local lamp3 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+5.84912100, generator.y+2.58001100, generator.z+1.95311890, false, false, false)
  local ashtray = CreateObject(GetHashKey("Prop_ashtray_01"), generator.x-1.24716200, generator.y+1.07820500, generator.z+1.87089300, false, false, false)
  local candle1 = CreateObject(GetHashKey("v_res_fa_candle03"), generator.x-2.89289900, generator.y-4.35329700, generator.z+2.02881310, false, false, false)
  local candle2 = CreateObject(GetHashKey("v_res_fa_candle02"), generator.x-3.99865700, generator.y-4.06048500, generator.z+2.02530190, false, false, false)
  local candle3 = CreateObject(GetHashKey("v_res_fa_candle01"), generator.x-3.37733400, generator.y-3.66639800, generator.z+2.02526200, false, false, false)
  local woodbowl = CreateObject(GetHashKey("v_res_m_woodbowl"), generator.x-3.50787400, generator.y-4.11983000, generator.z+2.02589900, false, false, false)
  local gardropd = CreateObject(GetHashKey("V_Res_gardropidsA"), generator.x-0.80513000, generator.y+0.51389600, generator.z+1.18418800, false, false, false)
  local tapeplayer = CreateObject(GetHashKey("Prop_Tapeplayer_01"), generator.x-1.26010100, generator.y-3.62966400, generator.z+2.37883200, false, false, false)
  local woodbowl2 = CreateObject(GetHashKey("v_res_tre_fruitbowl"), generator.x+2.77764900, generator.y-4.138297000, generator.z+2.10340100, false, false, false)
  local sculpt = CreateObject(GetHashKey("v_res_sculpt_dec"), generator.x+3.03932200, generator.y+1.62726400, generator.z+3.58363900, false, false, false)
  local jewlry = CreateObject(GetHashKey("v_res_jewelbox"), generator.x+3.04164100, generator.y+0.31671810, generator.z+3.58363900, false, false, false)
  local basket6 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.64906300, generator.y+1.62675900, generator.z+1.39038500, false, false, false)
  local basket7 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.63938900, generator.y+0.91133310, generator.z+1.39038500, false, false, false)
  local basket8 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.19923400, generator.y+1.69598600, generator.z+1.39038500, false, false, false)
  local basket9 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.18293800, generator.y+0.91436380, generator.z+1.39038500, false, false, false)
  local bowl = CreateObject(GetHashKey("v_res_r_sugarbowl"), generator.x-0.26029210, generator.y-6.66716800, generator.z+3.77324900, false, false, false)
  local breadbin = CreateObject(GetHashKey("Prop_Breadbin_01"), generator.x+2.09788500, generator.y-6.57634000, generator.z+2.24041900, false, false, false)
  local knifeblock = CreateObject(GetHashKey("v_res_mknifeblock"), generator.x+1.82084700, generator.y-6.58438500, generator.z+2.27399500, false, false, false)
  local toaster = CreateObject(GetHashKey("prop_toaster_01"), generator.x-1.05790700, generator.y-6.59017400, generator.z+2.26793200, false, false, false)
  local wok = CreateObject(GetHashKey("prop_wok"), generator.x+2.01728800, generator.y-5.57091500, generator.z+2.31793200, false, false, false)
  local plant5 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+2.55015600, generator.y+4.60183900, generator.z+1.20829700, false, false, false)
  local tumbler = CreateObject(GetHashKey("p_tumbler_cs2_s"), generator.x-0.90916440, generator.y-4.24099100, generator.z+2.24693200, false, false, false)
  local wisky = CreateObject(GetHashKey("p_whiskey_bottle_s"), generator.x-0.92809300, generator.y-3.99099100, generator.z+2.24693200, false, false, false)
  local tissue = CreateObject(GetHashKey("v_res_tissues"), generator.x+7.95889300, generator.y-2.54847100, generator.z+1.94013400, false, false, false)
  local pants = CreateObject(GetHashKey("V_16_Ap_Mid_Pants4"), generator.x+7.55366500, generator.y-0.25457100, generator.z+1.33009200, false, false, false)
  local pants2 = CreateObject(GetHashKey("V_16_Ap_Mid_Pants5"), generator.x+7.76753200, generator.y+3.00476500, generator.z+1.33052800, false, false, false)
  local hairdryer = CreateObject(GetHashKey("v_club_vuhairdryer"), generator.x+8.12616000, generator.y-2.50562000, generator.z+1.96009390, false, false, false)
 
  FreezeEntityPosition(dt,true)
  FreezeEntityPosition(mpmid01,true)
  FreezeEntityPosition(mpmid09,true)
  FreezeEntityPosition(mpmid07,true)
  FreezeEntityPosition(mpmid03,true)
  FreezeEntityPosition(midData,true)
  FreezeEntityPosition(glow,true)
  FreezeEntityPosition(curtins,true)
  FreezeEntityPosition(mpmid13,true)
  FreezeEntityPosition(mpcab,true)
  FreezeEntityPosition(mpdecal,true)
  FreezeEntityPosition(mpdelta,true)
  FreezeEntityPosition(couch,true)
  FreezeEntityPosition(chair,true)
  FreezeEntityPosition(chair2,true)
  FreezeEntityPosition(plant,true)
  FreezeEntityPosition(lamp,true)
  FreezeEntityPosition(fridge,true)
  FreezeEntityPosition(micro,true)
  FreezeEntityPosition(sideBoard,true)
  FreezeEntityPosition(bedSide,true)
  FreezeEntityPosition(plant2,true)
  FreezeEntityPosition(table,true)
  FreezeEntityPosition(tv,true)
  FreezeEntityPosition(plant3,true)
  FreezeEntityPosition(chair3,true)
  FreezeEntityPosition(lampStand,true)
  FreezeEntityPosition(chair4,true)
  FreezeEntityPosition(chair5,true)
  FreezeEntityPosition(chair6,true)
  FreezeEntityPosition(plant4,true)
  FreezeEntityPosition(storage2,true)
  FreezeEntityPosition(basket,true)
  FreezeEntityPosition(wardrobe,true)
  FreezeEntityPosition(wardrobe2,true)
  FreezeEntityPosition(table2,true)
  FreezeEntityPosition(lamp3,true)
  FreezeEntityPosition(beddelta,true)
  FreezeEntityPosition(bed,true)
  FreezeEntityPosition(beddecal,true)
  FreezeEntityPosition(tapeplayer,true)
  FreezeEntityPosition(basket7,true)
  FreezeEntityPosition(basket6,true)
  FreezeEntityPosition(basket8,true)
  FreezeEntityPosition(basket9,true)
 

  SetEntityHeading(beerbot,GetEntityHeading(beerbot)+90)
  SetEntityHeading(couch,GetEntityHeading(couch)-90)
  SetEntityHeading(chair,GetEntityHeading(chair)+getRotation(0.28045480))
  SetEntityHeading(chair2,GetEntityHeading(chair2)+getRotation(0.3276100))
  SetEntityHeading(fridge,GetEntityHeading(chair2)+160)
  SetEntityHeading(micro,GetEntityHeading(micro)-90)
  SetEntityHeading(sideBoard,GetEntityHeading(sideBoard)+90)
  SetEntityHeading(bedSide,GetEntityHeading(bedSide)+180)
  SetEntityHeading(tv,GetEntityHeading(tv)+90)
  SetEntityHeading(plant3,GetEntityHeading(plant3)+90)
  SetEntityHeading(chair3,GetEntityHeading(chair3)+200)
  SetEntityHeading(chair4,GetEntityHeading(chair3)+100)
  SetEntityHeading(chair5,GetEntityHeading(chair5)+135)
  SetEntityHeading(chair6,GetEntityHeading(chair6)+10)
  SetEntityHeading(storage,GetEntityHeading(storage)+180)
  SetEntityHeading(storage2,GetEntityHeading(storage2)-90)
  SetEntityHeading(table2,GetEntityHeading(table2)+90)
  SetEntityHeading(tapeplayer,GetEntityHeading(tapeplayer)+90)
  SetEntityHeading(knifeblock,GetEntityHeading(knifeblock)+180)
  FreezeEntityPosition(PlayerPedId(),false)
 end
 
function DeleteSpawnedHouse(id)
  inhouse = false
    local housePosition = buyablehouses[id]
    local handle, ObjectFound = FindFirstObject()
    repeat
     local pos = GetEntityCoords(ObjectFound)
     local distance = GetDistanceBetweenCoords(housePosition["x"], housePosition["y"], (housePosition["z"] - 24.0), pos, true)
     if distance < 35.0 and ObjectFound ~= PlayerPedId() then
      if IsEntityAPed(ObjectFound) then
       if not IsPedAPlayer(ObjectFound) then
        DeleteObject(ObjectFound)
       end
      else
       DeleteObject(ObjectFound)
      end
     end
     success, ObjectFound = FindNextObject(handle)
    until not success
    EndFindObject(handle)
end
   
   
function getRotation(input)
    return 360/(10*input)
end
   


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  local coords, letSleep = GetEntityCoords(PlayerPedId()), true
  local generator = {x = curHouseCoords["x"], y = curHouseCoords["y"], z = curHouseCoords["z"]}
  if inhouse then
  if GetDistanceBetweenCoords(coords, generator.x+8.46626300, generator.y+4.53223600, generator.z+2.50, true) < 5.0 then
    letSleep = false
  	DrawText3Ds(generator.x+7.46626300, generator.y+3.8000, generator.z+2.50,"[~r~E~s~] Kıyafet - Depo ")
  if IsControlJustPressed(0, 38) then
    TriggerEvent("enteranimation")
    houseconfigs()
  end
  end
end
end
end)



function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 425
    DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end












function OpenPropertyInventoryMenu(property, owner)
    owner = ESX.GetPlayerData().identifier
	ESX.TriggerServerCallback(
		"lsrp-motels:getPropertyInventory",
		function(inventory)
			TriggerEvent("esx_inventoryhud:openMotelsInventory", inventory)
		end, owner)
end





function houseconfigs()
  ESX.TriggerServerCallback('hsn-stashouse:checkIsOwner', function(owner)
    if owner then
  ESX.TriggerServerCallback('hsn-stashouse:getprice', function(price) 
  ESX.TriggerServerCallback('hsn-stashouse:getid', function(houseid)
    evinidsi = houseid
      local elements = {}
  elements[1] = {label = "Kıyafet Değiştir",val="Change"}
  elements[2] = {label = "Kıyafet Sil",val="Delete"}
 elements[3] = {label = "Depolama",val="Depolama"}
 elements[4] = {label = "evisat",val="evisat"}
 elements[5] = {label = "Yeni Ev Sahibi",val="yenievsahibi"}
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
    title    = "Stashouse = "..evinidsi.."", 
    align    = 'top-left',
    elements = elements
  }, function(data, menu)
    ESX.TriggerServerCallback('hsn-stashouse:getPlayerDressing', function(d)
      local dressing = d
      if data.current.val == "Change" then
        local elements = {}
        for i=1, #dressing, 1 do
          table.insert(elements, {
            label = dressing[i],
            value = i
          })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'change_clothes', {
          title    = "Kıyafetlerini Değiştir",
          align    = 'top-left',
          elements = elements
        }, function(data2, menu2)
          TriggerEvent('skinchanger:getSkin', function(skin)
            ESX.TriggerServerCallback('hsn-stashouse:getPlayerOutfit', function(clothes)
              TriggerEvent('skinchanger:loadClothes', skin, clothes)
              TriggerEvent('esx_skin:setLastSkin', skin)

              TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
              end)
            end, data2.current.value)
          end)
          ESX.ShowNotification("Kıyafetiniz değiştirildi.")
        end, function(data2, menu2)
          menu2.close()
        end)
      elseif data.current.val == "Delete" then
        local elements = {}

        for i=1, #dressing, 1 do
          table.insert(elements, {
            label = dressing[i],
            value = i
          })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
          title    = "Kıyafetlerini Sil",
          align    = 'top-left',
          elements = elements
        }, function(data2, menu2)
          menu2.close()
          TriggerServerEvent('hsn-stashouse:removeOutfit', data2.current.value)
            ESX.ShowNotification("Kıyafet silindi.")
        end, function(data2, menu2)
          menu2.close()
        end)

  
   elseif data.current.val == "Depolama" then
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'stashopen', 0.7)
    Citizen.Wait(1500)
    if Hsn.UseDisc then
      TriggerEvent('inventory:server:OpenInventory', {
          type = 'owner',
          slots = 80,
          owner = "Stashouse = "..evinidsi.."", 
          })
        
  else
      OpenPropertyInventoryMenu('motels', owner)
  end
    menu.close()
  elseif data.current.val == "yenievsahibi" then

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Kişi',
    {
      title = "Kişi ID'si"
    },
function(data5, menu5)
  local targetplayer = data5.value
  local evid = evinidsi
  TriggerServerEvent("hsn-stashouse:addnewowner",targetplayer,evid)
  menu5.close()
    menu.close()
    end)
  elseif data.current.val == "evisat" then   
    TriggerServerEvent("hsn-stashouse:detelehouseownership",evinidsi , price)

     end
     menu.close()

    end)
  end, function(data8, menu8)
    menu.close()
  end)
   end)
   end)
else
  ESX.ShowNotification("Ev sahibi değilsiniz")
end
end,houseid)
end

RegisterNetEvent( 'enteranimation' )
AddEventHandler( 'enteranimation', function() 
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 48, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())

end)

function loadAnimDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
      Citizen.Wait(5)
  end
end


