RegisterNetEvent("gcPhone:yellow_getPosts")
AddEventHandler("gcPhone:yellow_getPosts", function(posts)
  SendNUIMessage({event = 'yellow_posts', posts = posts})
end)

RegisterNetEvent("gcPhone:yellow_getMyPosts")
AddEventHandler("gcPhone:yellow_getMyPosts", function(posts)
  SendNUIMessage({event = 'yellow_getMyPosts', posts = posts})
end)

RegisterNUICallback('yellow_getPosts', function(cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:yellow_getPosts')
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:yellow_getPosts')
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:yellow_getPosts')
  end
   
end)

RegisterNUICallback('yellow_getMyPosts', function(cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:yellow_getMyPosts')
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:yellow_getMyPosts')
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:yellow_getMyPosts')
  end
 
end)

RegisterNUICallback('yellow_toggleDeletePost', function(data, cb) 
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:yellow_toggleDeletePost', data.id)
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:yellow_toggleDeletePost', data.id)
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:yellow_toggleDeletePost', data.id)
  end
  
end)

RegisterNUICallback('yellow_postIlan', function(data, cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:yellow_postIlan', data.message, data.image)
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:yellow_postIlan', data.message, data.image)
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:yellow_postIlan', data.message, data.image)
  end
    
end)

RegisterNetEvent("gcPhone:yellow_newPost")
AddEventHandler("gcPhone:yellow_newPost", function(post)
  SendNUIMessage({event = 'yellow_newPost', post = post})
end)