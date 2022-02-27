TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

RegisterServerEvent('esx_jobChat:chat')
AddEventHandler('esx_jobChat:chat', function(job, msg)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    local pName= getIdentity(source)
	fal = pName.firstname .. " " .. pName.lastname
	jobName = string.upper(job)
	local messageFull = {
        template = '<div style="padding: 8px; margin: 8px; background-color: rgba(0, 153, 51, 0.9); border-radius: 25px;"><i class="far fa-building"style="font-size:15px"></i> [{0}] {1} : {2}</font></i></b></div>',
        args = {jobName, fal, msg}
    }
    TriggerClientEvent('esx_jobChat:Send', -1, messageFull, job)
end)

RegisterServerEvent('esx_jobChat:911')
AddEventHandler('esx_jobChat:911', function(targetCoords, msg, streetName, emergency)
    local _source = source
    local xPlayers = ESX.GetPlayers()
	local pName= getIdentity(source)
	local messageFull
	local xPlayer = ESX.GetPlayerFromId(_source)
	fal = pName.firstname .. " " .. pName.lastname
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'ambulance' then 
	if emergency == '911' then
		messageFull = {
			-- 		TriggerEvent('chat:addMessage', { template = '<div class="chat-message server"><b>[Dispatch]</b> {0}</div>', args = {messagek}, '..adres'})
			template = '<div style=" max-width: 100%;  width: fit-content;  padding-bottom: 0.7vw;  padding-top: 0.6vw;  padding: 0.6vw;  display: inline-block !important; word-break: break-word; overflow: hidden; margin-left: 0.4vw; margin: 10px; background-color: rgba(210, 10, 10, 0.9); border-radius: 10px;"><i class="fas fa-bell"style="font-size:15px"></i> [Dispatch] Acil: Ağır Yaralı - Konum : {1} | Memur : {0}</font></i></b></div>',
        	args = {fal, streetName, msg}
		}
	else
		messageFull = {
			template = '<div style=" max-width: 100%;  width: fit-content;  padding-bottom: 0.7vw;  padding-top: 0.6vw;  padding: 0.6vw;  display: inline-block !important; word-break: break-word; overflow: hidden; margin-left: 0.4vw; margin: 10px; background-color: rgba(37, 0, 224, 0.9); border-radius: 10px;"><i class="fas fa-bell"style="font-size:15px"></i> [311] | {0} | {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg}
		}
	end
	TriggerClientEvent('esx_jobChat:911Marker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:EmergencySend', -1, messageFull)
end
end)