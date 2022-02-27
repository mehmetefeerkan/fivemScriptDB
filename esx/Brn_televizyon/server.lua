
local data = {}

local GenerateId = function(length, usecapital, usenumbers)
    local result = ''

    for i = 1, length do
        local randomised = string.char(math.random(97, 122))
        if usecapital then
            if math.random(1, 2) == 1 then
                randomised = randomised:upper()
            end
        end
        if usenumbers then
            if math.random(1, 2) == 1 then
                randomised = tostring(math.random(0, 9))
            end
        end
        result = result .. randomised
    end

    return result
end

local time

RegisterServerEvent('loaf_tv:add')
AddEventHandler('loaf_tv:add', function(url, object, coords, scale, offset)
    local id = GenerateId(20, true, true)
    for k, v in pairs(data) do
        if v['Object'] == object and v['Coords'] == coords then -- if it's the same tv, just update the video etc
            id = k -- so we update the same object (if it's the same tv)
        end
    end

    local time = os.time()

    data[id] = {
        ['URL'] = url,
        ['Object'] = object,
        ['Coords'] = coords,
        ['Scale'] = scale,
        ['Offset'] = offset,
        ['Time'] = time,
        ['Volume'] = 3,
    }
    local checking = false
    if Config['DurationCheck'] then
        checking = true
        PerformHttpRequest(Config['API']['URL']:format(url, Config['API']['Key']), function(err, text, headers)
            if text then
                local decoded = json.decode(text)
                if decoded then
                    if decoded['items'] then
                        if decoded['items'][1] then
                            if decoded['items'][1]['contentDetails'] then
                                if decoded['items'][1]['contentDetails']['duration'] then
                                    local duration = decoded['items'][1]['contentDetails']['duration']
                                    local found = string.find(duration, 'M')
                                    local length = 0
                                    if not found then
                                        length = length + tonumber(duration:match("PT(.-)S"))
                                    else
                                        length = length + (tonumber(duration:match("PT(.-)M")) * 60)
                                        length = length + tonumber(duration:match("M(.-)S"))
                                    end
                                    data[id]['Duration'] = length
                                    checking = false
                                end
                            end
                        end
                    end
                end
            end
        end, 'GET', '')
    end

    while checking do Wait(0) end

    local tosend = {}
    for k, v in pairs(data) do
        tosend[k] = { -- = v will just fuck this shit up im tired ok? (04.00 wtf am i doing up this late)
            ['URL'] = v['URL'],
            ['Object'] = v['Object'],
            ['Coords'] = v['Coords'],
            ['Scale'] = v['Scale'],
            ['Offset'] = v['Offset'],
            ['Time'] = v['Time'],
            ['Volume'] = v['Volume'],
        }
        if v['Duration'] then
            tosend[k]['Duration'] = v['Duration']
        end
        tosend[k]['Time'] = (os.time() - tosend[k]['Time'])
    end

    TriggerClientEvent('loaf_tv:update', -1, tosend)
end)

RegisterServerEvent('loaf_tv:fetch')
AddEventHandler('loaf_tv:fetch', function()
    local tosend = {}

    for k, v in pairs(data) do
        tosend[k] = { -- = v will just fuck this shit up im tired ok? (04.00 wtf am i doing up this late)
            ['URL'] = v['URL'],
            ['Object'] = v['Object'],
            ['Coords'] = v['Coords'],
            ['Scale'] = v['Scale'],
            ['Offset'] = v['Offset'],
            ['Time'] = v['Time'],
            ['Volume'] = v['Volume'],
        }
        if v['Duration'] then
            tosend[k]['Duration'] = v['Duration']
        end
        tosend[k]['Time'] = (os.time() - tosend[k]['Time'])
    end

    TriggerClientEvent('loaf_tv:update', source, tosend)
end)

RegisterServerEvent('loaf_tv:setvolume')
AddEventHandler('loaf_tv:setvolume', function(id, volume)
    if volume >= 0 and volume <= 10 then
        if data[id] then

            data[id]['Volume'] = volume

            TriggerClientEvent('loaf_tv:updatevolume', -1, id, volume)

        end
    end
end)

RegisterServerEvent('loaf_tv:destroy')
AddEventHandler('loaf_tv:destroy', function(id)
    if data[id] then
        data[id] = nil
        TriggerClientEvent('loaf_tv:delete', -1, id)
    end
end)