MySQL.ready(function()
    local sqlTasks = {}

    local sqlQuery = [[
        INSERT
            INTO
        items
            (name, label)
        VALUES
            (@name, @label)
        ON DUPLICATE KEY UPDATE
            label = @label
    ]]

    for itemKey, itemData in pairs(Config.FishingItems) do
        table.insert(sqlTasks, function(callback)
            MySQL.Async.execute(sqlQuery, {
                ["@name"] = itemData["name"],
                ["@label"] = itemData["label"] or itemData["name"]
            }, function(rowsChanged)
                callback(rowsChanged > 0)
            end)
        end)
    end

    Async.parallel(sqlTasks, function(responses)
        print(#responses == 3 and "Inserted items and successfully updated labels." or "Error occured, is items correct?")
    end)
end)