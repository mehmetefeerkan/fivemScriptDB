Config = {

UsingCoreEvidence = false, -- If you are using Core Evidence (https://core.tebex.io/package/4265655) it adds (undetectable bullet shells)

SetVestIfNone = true, -- Sets a vest to a player when armor used
VestId = 5, -- The id of the vest set

OpenCommand = 'weapon', -- The key to open UI menu (Leave blank if you dont want to open with command)
UIOpenKey = '', -- The key to open UI menu (Leave blank if you dont want to open with a key)

--Blip information (https://docs.fivem.net/docs/game-references/blips/)
AttachmentStoreShowBlip = true,
AttachmentStoreBlip = 175,
AttachmentStoreBlipColor = 49,
AttachmentStoreBlipName = 'Attachment Store',

AttachmentStoreMarker = 27,
AttachmentStoreMarkerSize = 1.2,
AttachmentStoreMarkerColor = {252, 20, 20},

AttachmentStoreItems = { -- Attachment Store Prices

	['weapon_clips'] = {
		['pistol_clip'] = 100,
		['smg_clip'] = 400,
		['lightsmg_clip'] = 300,
		['rifle_clip'] = 700,
		['shotgun_clip'] = 500,
		['sniper_clip'] = 2000
	},
	['weapon_attachments'] = {

		['weapon_tint_green'] = 200,
		['weapon_tint_gold'] = 500,
		['weapon_tint_pink'] = 200,
		['weapon_tint_army'] = 200,
		['weapon_tint_lspd'] = 200,
		['weapon_tint_orange'] = 200,
		['weapon_tint_platinum'] = 300,
		['weapon_luxary_finish'] = 1000,
		['weapon_flashlight'] = 500,
		['weapon_suppressor'] = 800,
		['weapon_clip_extended'] = 300

	},
	['misc'] = {
		['armor'] = 500
	}
	

},

--[[AttachmentStores = {

	vector3(-328.35314941406,6078.8203125,31.4547901153), -- PALETO
	vector3(1695.8673095703,3755.1027832031,34.70535278), -- SANDY
	vector3(18.349586486816,-1111.1280517578,29.7970314) -- LS

},

Text = {

	['attachment_store_clip_category'] = 'Weapon Clips',
	['attachment_store_misc_category'] = 'Misc',
	['attachment_store_attachments_category'] = 'Weapon Attachments',
	['open_attachment_store'] = '[~r~E~w~] Open Attachment Store',
	['attachment_store_name'] = 'Attachment Store',
	['unsuccessful_purchase'] = 'You dont have enough money or available space',
	['successful_purchase'] = 'You bought {item}',
	['clip_full'] = 'Clip is full',
	['wrong_clip'] = 'Wrong clip for gun',
	['full_armor'] = 'Your armor is already full',
	['attachment_equipped'] = 'Attachment already equipped',
	['attachment_not_taken'] = 'Attachment cant be applied'

}]]
	

}

-- Only change if you know what are you doing!
function SendMessage(msg)

		--SetNotificationTextEntry('STRING')
		--AddTextComponentString(msg)
		--DrawNotification(0,1)

		--EXAMPLE USED IN VIDEO
		exports['mythic_notify']:SendAlert('inform', msg)

end


