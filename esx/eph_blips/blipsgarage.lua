local blips = {

--{title="GANK 1", colour=2, id=225, x = 1014.98, y = -2333.22, z = 30.52},
--{title="GANK 2", colour=49, id=225, x = -836.1, y = -693.7, z = 26.51},
--{title="Vagos", colour=5, id=310, x = 340.93, y = -2047.31, z = 21.29},
--{title="Ballas", colour=27, id=310, x = 102.97, y = -1942.86, z = 20.8},
--{title="Aztecas", colour=3, id=310, x = 489.5650, y = -1714.04, z = 29.706},
--{title="Grove", colour=2, id=310, x = -136.01, y = -1589.36, z = 34.21}
}
Citizen.CreateThread(function()

		Citizen.Wait(0)

local bool = true
  
  if bool then
        
		for k,v in pairs(blips) do
           

               zoneblip = AddBlipForRadius(v.x,v.y,v.z, 600.0)
                          SetBlipSprite(zoneblip,1)
                          SetBlipColour(zoneblip,49)
                          SetBlipAlpha(zoneblip,75)
                         
        end
         
    
         for _, info in pairs(blips) do
        
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 2)
						 SetBlipScale(info.blip, 0.5)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end
	   
	   bool = false
   
   end
end)