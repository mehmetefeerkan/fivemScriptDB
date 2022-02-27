Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(648870714614743051)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('dlogo')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Momentum Roleplayde Oynuyor')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('logo')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('discord.gg/UsEvNCG')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)