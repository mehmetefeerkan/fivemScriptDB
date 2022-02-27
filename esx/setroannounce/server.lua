msg = ""
RegisterCommand('duyuru', function(source, args, user)
	if IsPlayerAceAllowed(source, "announce") then
			for i,v in pairs(args) do
				msg = msg .. " " .. v
			end
			TriggerClientEvent("announce", -1, msg)
			msg = ""
    end
end)