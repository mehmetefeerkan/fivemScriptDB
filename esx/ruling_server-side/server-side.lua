RegisterNetEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function()
local _source = source
DropPlayer(source, 'Heyyo')
end)