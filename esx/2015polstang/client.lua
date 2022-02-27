local event = 'Blowjob'
local explosionEventsinir = 5
local explosionEventtimer = 20000
RegisterNetEvent(event)
AddEventHandler(event, function()
    CancelEvent()

if kugpanexplosionEvent == nil then
kugpanexplosionEvent = 0
end

kugpanexplosionEvent = kugpanexplosionEvent+1
if kugpanexplosionEvent > explosionEventsinir then
    --server a yolla adam hile
TriggerServerEvent("patlatmalogu")
TriggerServerEvent("BanSql:ICheat", "Nabıyon lan serverımı trollüyon :d yarrama bak hele BrnOrkun#3131")

else
    --sorun yok kanka
end

end)


Citizen.CreateThread(function()

while true do 
    kugpanexplosionEvent = 0
    Citizen.Wait(explosionEventtimer)
end

end)