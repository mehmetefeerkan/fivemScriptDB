RegisterNetEvent("gcPhone:twitter_getTweets")
AddEventHandler("gcPhone:twitter_getTweets", function(tweets)
  SendNUIMessage({event = 'twitter_tweets', tweets = tweets})
end)

RegisterNetEvent("gcPhone:twitter_getFavoriteTweets")
AddEventHandler("gcPhone:twitter_getFavoriteTweets", function(tweets)
  SendNUIMessage({event = 'twitter_favoritetweets', tweets = tweets})
end)

RegisterNetEvent("gcPhone:twitter_newTweets")
AddEventHandler("gcPhone:twitter_newTweets", function(tweet)
  SendNUIMessage({event = 'twitter_newTweet', tweet = tweet})
  TriggerEvent('dd_cyberheist:twt')
end)

RegisterNetEvent("gcPhone:twitter_updateTweetLikes")
AddEventHandler("gcPhone:twitter_updateTweetLikes", function(tweetId, likes)
  SendNUIMessage({event = 'twitter_updateTweetLikes', tweetId = tweetId, likes = likes})
end)

RegisterNetEvent("gcPhone:twitter_setAccount")
AddEventHandler("gcPhone:twitter_setAccount", function(username, avatarUrl)
  SendNUIMessage({event = 'twitter_setAccount', username = username, avatarUrl = avatarUrl})
end)

RegisterNetEvent("gcPhone:twitter_showError")
AddEventHandler("gcPhone:twitter_showError", function(title, message)
  SendNUIMessage({event = 'twitter_showError', message = message, title = title})
end)

RegisterNetEvent("gcPhone:twitter_showSuccess")
AddEventHandler("gcPhone:twitter_showSuccess", function(title, message)
  SendNUIMessage({event = 'twitter_showSuccess', message = message, title = title})
end)

RegisterNetEvent("gcPhone:twitter_setTweetLikes")
AddEventHandler("gcPhone:twitter_setTweetLikes", function(tweetId, isLikes)
  SendNUIMessage({event = 'twitter_setTweetLikes', tweetId = tweetId, isLikes = isLikes})
end)

RegisterNUICallback('twitter_getTweets', function(cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:twitter_getTweets')
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:twitter_getTweets')
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:twitter_getTweets')
  end
end)

RegisterNUICallback('twitter_getFavoriteTweets', function()
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:twitter_getFavoriteTweets')
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:twitter_getFavoriteTweets')
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:twitter_getFavoriteTweets')
  end
  
end)

RegisterNUICallback('twitter_postTweet', function(data, cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:twitter_postTweets', data.message, data.image)
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:twitter_postTweets', data.message, data.image)
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:twitter_postTweets', data.message, data.image)
  end
end)

RegisterNUICallback('twitter_toggleLikeTweet', function(data, cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:twitter_toogleLikeTweet', data.tweetId)
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:twitter_toogleLikeTweet', data.tweetId)
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:twitter_toogleLikeTweet', data.tweetId)
  end
  
end)

RegisterNUICallback('twitter_toggleDeleteTweet', function(data, cb) 
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:twitter_toggleDeleteTweet', data.tweetId)
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:twitter_toggleDeleteTweet', data.tweetId)
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:twitter_toggleDeleteTweet', data.tweetId)
  end
  
end)

RegisterNUICallback('twitter_setAvatarUrl', function(data, cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:twitter_setAvatarUrl', data.avatarUrl)
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:twitter_setAvatarUrl', data.avatarUrl)
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:twitter_setAvatarUrl', data.avatarUrl)
  end
  
end)

RegisterNUICallback('twitter_changeUsername', function(data, cb)
  if Config.UseWifiSpot then
    ESX.TriggerServerCallback('dd_cyberheist:beingHack', function(notHacked)
      if notHacked then
        ESX.TriggerServerCallback('gcPhone:getItemAmount', function(quantity)
          if quantity >= 1 then	
            TriggerServerEvent('gcPhone:twitter_changeUsername', data.newUsername)
          else
            ESX.TriggerServerCallback('dd_cyberheist:CanConnect', function(quantity)
              if quantity then
                TriggerServerEvent('gcPhone:twitter_changeUsername', data.newUsername)
              end
            end)
          end
        end, 'pocket_wifi')
      end
    end)
  else
    TriggerServerEvent('gcPhone:twitter_changeUsername', data.newUsername)
  end
  
end)