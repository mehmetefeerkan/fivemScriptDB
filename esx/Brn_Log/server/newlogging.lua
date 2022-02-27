print('^2BrnOrkun x ephesus Logsystem ^3Aktif')
AddEventHandler('esx:onRemoveInventoryItem', function(playerid, itemname, itemcount)
    if itemcount == 0 then itemcount = itemcount + 1 end
    local logID = string.random(8)
        local embed = {
              {
                  ["color"] = "8663711",
                  ["title"] = "**Item kişinin üstünden gitti.**",
                  ["description"] = "Player ID: **"..playerid.. "(<@" .. getPDis(playerid) .. ">" .. "**\nItem: **"..itemname.."**\nCount: **"..itemcount.."**",
                  ["footer"] = {
                    ["text"] = "BrnOrkun X ephesus | LOG ID : " .. logID ,
                },
              }
          }
        sendIlistir(getPDis(playerid), logID)
        PerformHttpRequest(Config.New_ItemOutLog, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end)
AddEventHandler('esx:onAddInventoryItem', function(playerid, itemname, itemcount)
    if itemcount == 0 then itemcount = itemcount + 1 end
    local logID = string.random(8)
    local embed = {
          {
              ["color"] = "8663711",
              ["title"] = "**Item kişinin üstüne geldi.**",
              ["description"] = "Player ID: **"..playerid.. "(<@" .. getPDis(playerid) .. ">" .. "**\nItem: **"..itemname.."**\nCount: **"..itemcount.."**",
              ["footer"] = {
                ["text"] = "BrnOrkun X ephesus | LOG ID : " .. logID ,
            },
          }
      }
    sendIlistir(getPDis(playerid), logID)
    PerformHttpRequest(Config.New_ItemInLog, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end)


function getPDis(player)
    for k,v in ipairs(GetPlayerIdentifiers(player))do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        end
    end
    return string.sub(discord, 9)
end


local charset = {}

-- qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length)
  math.randomseed(os.time())

  if length > 0 then
    return string.random(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end


function sendIlistir(dcid, logID_)
    local embed = {
        {
            ["color"] = "8663711",
            ["title"] = "**LOG ID " .. logID_ .. "**",
            ["description"] = "LOG ID:"..logID_.. " | " .. "(<@" .. dcid .. ">)",
            ["footer"] = {
              ["text"] = "BrnOrkun X ephesus | LOG ID : " .. logID_ ,
          },
        }
    }
  PerformHttpRequest(Config.ilistirmeWHID, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent('imperial:brnlog:holster')
AddEventHandler('imperial:brnlog:holster', function(dir, weap)
    local logID = string.random(8)
    local embed = {
          {
              ["color"] = "8663711",
              ["title"] = "**Kişi silah**" .. dir ,
              ["description"] = "Player ID: **"..source.. "(<@" .. getPDis(source) .. ">" .. "**\n Silah: **"..weap.."**",
              ["footer"] = {
                ["text"] = "BrnOrkun X ephesus | LOG ID : " .. logID ,
            },
          }
      }
    sendIlistir(getPDis(source), logID)
    PerformHttpRequest(Config.holsterwhid, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end)