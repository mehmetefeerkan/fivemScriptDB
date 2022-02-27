RegisterNUICallback('youtube_Play', function(data)
    if Config.UseWifiSpot then
      ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
        if notHacked then
          ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
            if quantity >= 1 then	
              exports["xsound"]:Cal(data, false)
            else
              ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
                if quantity then
                  exports["xsound"]:Cal(data, false)
                end
              end)
            end
          end, 'pocket_wifi')
        end
      end)
    else
        exports["xsound"]:Cal(data, false)
    end
    
end)

RegisterNUICallback('youtube_Pause', function()
    if Config.UseWifiSpot then
      ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
        if notHacked then
          ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
            if quantity >= 1 then	
              exports["xsound"]:Duraklat()
            else
              ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
                if quantity then
                  exports["xsound"]:Duraklat()
                end
              end)
            end
          end, 'pocket_wifi')
        end
      end)
    else
        exports["xsound"]:Duraklat()
    end
    
end)

RegisterNUICallback('youtube_Stop', function() 
    if Config.UseWifiSpot then
      ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
        if notHacked then
          ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
            if quantity >= 1 then	
                      exports["xsound"]:Durdur()
            else
              ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
                if quantity then
                  exports["xsound"]:Durdur()
                end
              end)
            end
          end, 'pocket_wifi')
        end
      end)
    else
        exports["xsound"]:Durdur()
    end
    
end)

RegisterNUICallback('youtube_Resume', function()
    if Config.UseWifiSpot then
      ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
        if notHacked then
          ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
            if quantity >= 1 then	
                      exports["xsound"]:Devamet()
            else
              ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
                if quantity then
                  exports["xsound"]:Devamet()
                end
              end)
            end
          end, 'pocket_wifi')
        end
      end)
    else
        exports["xsound"]:Devamet()
    end
    
end)