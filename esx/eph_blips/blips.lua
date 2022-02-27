local blips = {
  {title="Hastane", colour=2, id= 61, x=306.85, y=-589.04, z=43.29},
  --{title="Portakal Cafe", colour=47, id= 399, x=-2206.7, y=4258.51, z=47.5790},
  {title="Adams", colour=40, id= 76, x=-103.89, y=973.792, z=235.757},
  {title="B", colour=0, id= 106, x = -1509.20, y = 85.92702, z = 55.607},
  --{title="Sovay Casino", colour=0, id= 106, x = 925.9805, y = 48.14820, z = 80.894},
  {title="Lod Malikanesi", colour=1, id= 84, x = -843.338, y = 157.5134, z = 72.0},  
  --{title="Walker GunShop", colour=1, id= 110, x = 18.30565, y = -1112.88, z = 29.797},  
  {title="Walker Mekanik", colour=4, id= 446, x=-347.291, y=-133.370, z=38.009},  
  {title="Mekanik", colour=3, id= 446, x = 719.5338, y = -1088.76, z = 22.297},
  {title="Paşa Mekanik", colour=3, id= 446, x = 938.4426, y = -970.728, z = 39.119},  
  --{title="U.S.A.F", colour=0, id= 251, x = -2251.83, y = 3352.875, z = 33.061}, 
  {title="Unicorn", colour=27, id= 121, x = 129.3244, y = -1299.10, z = 29.232}, 
  {title="Slizer MC Mekanik", colour=2, id= 446, x=536.2176, y=-179.205, z=54.401},
  {title="Cosa Mekanik", colour=5, id= 446, x=-207.8, y=-1321.04, z=30.89},
  {title="Market", colour=2, id= 59, x=373.875, y=325.896, z=102.566},
  {title="Market", colour=2, id= 59, x=2557.458, y=382.282, z=107.622},
  {title="Market", colour=2, id= 59, x=-3038.939, y=585.954, z=6.908},
  {title="Market", colour=2, id= 59, x=-1487.553, y=-379.107, z=39.163},
  {title="Market", colour=2, id= 59, x=1392.562, y=3604.684, z=33.980},
  {title="Market", colour=2, id= 59, x=-2968.243, y=390.910, z=14.043},
  {title="Market", colour=2, id= 59, x=2678.916, y=3280.671, z=54.241},
  {title="Market", colour=2, id= 59, x=-48.519, y=-1757.514, z=28.421},
  {title="Market", colour=2, id= 59, x=1163.373, y=-323.801, z=68.205},
  {title="Market", colour=2, id= 59, x=-707.501, y=-914.260, z=18.215},
  {title="Market", colour=2, id= 59, x=-1820.523, y=792.518, z=137.118},
  {title="Market", colour=2, id= 59, x=1698.388, y=4924.404, z=41.063},
  {title="Market", colour=2, id= 59, x=1961.464, y=3740.672, z=31.343},
  {title="Market", colour=2, id= 59, x=1135.808, y=-982.281, z=45.415},
  {title="Market", colour=2, id= 59, x=25.88, y=-1347.1, z=28.5},
  {title="Market", colour=2, id= 59, x=-1393.409, y=-606.624, z=29.319},
  {title="Market", colour=2, id= 59, x=547.431, y=2671.710, z=41.156},
  {title="Market", colour=2, id= 59, x=-3241.927, y=1001.462, z=11.830},
  {title="Market", colour=2, id= 59, x=1166.024, y=2708.930, z=37.157},
  {title="Market", colour=2, id= 59, x=1729.216, y=6414.131, z=34.037},
  {title="Kuaför", colour=47, id= 71, x=-814.3, y=-183.8, z=36.6},
  {title="Kuaför", colour=47, id= 71, x=136.8, y=-1708.4, z=28.3},
  {title="Kuaför", colour=47, id= 71, x=-1282.6, y=-1116.8, z=6.0},
  {title="Kuaför", colour=47, id= 71, x=1931.5, y=3729.7, z=31.8},
  {title="Kuaför", colour=47, id= 71, x=1212.8, y=-472.9, z=65.2},
  {title="Kuaför", colour=47, id= 71, x=-32.9, y=-152.3, z=56.1},
  {title="Kuaför", colour=47, id= 71, x=-278.1, y=6228.5, z=30.7},
  {title="Balık Tutma Alanı", colour=3, id= 266, x=1299.51, y=4219.34, z=33.91},
  --{title="Ricci Malikanesi", colour=46, id= 112, x=-1731.42, y=370.25, z=94.93},
  {title="Walker Emlak", colour=2, id= 374, x=-135.38, y=-642.49, z=168.84},
  --{title="Morgan", colour=27, id= 124, x=1399.66, y=1146.58, z=119.096}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


