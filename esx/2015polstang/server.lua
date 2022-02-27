AddEventHandler('explosionEvent', function(sender, ev)
    CancelEvent()
                    --MySQL.Async.execute('INSERT INTO pwuclog_patlatmaloglari (OyuncuID, Steamismi)VALUES (@OyuncuID, @Steamismi) ', {
                    --['@OyuncuID']   = sender,
                    --['@Steamismi']   = GetPlayerName(sender),

--})
TriggerClientEvent('Blowjob',sender)
end)