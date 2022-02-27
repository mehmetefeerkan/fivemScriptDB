ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("adz-paraver")
AddEventHandler("adz-paraver", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local para = math.random(Config.MinimumPara, Config.MaximumPara)
    
    xPlayer.addMoney(para)
end)

RegisterServerEvent("adz-malzemeal")
AddEventHandler("adz-malzemeal", function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem(Config.Malzeme, 10)
end)

RegisterServerEvent("adz-malzemever")
AddEventHandler("adz-malzemever", function()
	local xPlayer = ESX.GetPlayerFromId(source)
 
    xPlayer.addInventoryItem(Config.Malzeme, 10)
end)


AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2adz-denizticareti^0] - Started!')
	end
end)