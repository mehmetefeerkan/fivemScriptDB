local ultimaAccion = nil
local currentGarage = nil
local fetchedVehicles = {}
local fueravehicles = {}

function MenuGarage(action)
    if not action then action = ultimaAccion; elseif not action and not ultimaAccion then action = "menu"; end
    ped = PlayerPedId();
    MenuTitle = "Garage"
    ClearMenu()
    ultimaAccion = action
    Citizen.Wait(150)
    DeleteActualVeh()
    if action == "menu" then
        Menu.addButton("Araçlarını Gör","ListeVehicule",nil)
        Menu.addButton("Çekilenler","recuperar",nil)
        Menu.addButton("Kapat","CloseMenu",nil) 
    elseif action == "vehicle" then
        PutInVehicle()
    end
end

function EnvioVehLocal(veh)
    local slots = {}
    for c,v in pairs(veh) do
        table.insert(slots,{["garage"] = v.garage, ["vehiculo"] = json.decode(v.vehicle)})
    end
    fetchedVehicles = slots
end

function EnvioVehFuera(data)
    local slots = {}
    for c,v in pairs(data) do
        print(v.state)
        if v.state == 0 or v.state == 2 or v.state == false or v.garage == nil then
            table.insert(slots,{["vehiculo"] = json.decode(v.vehicle),["state"] = v.state})
        end
    end
    fueravehicles = slots
end

function recuperar()
    currentGarage = cachedData["currentGarage"]

    if not currentGarage then
        CloseMenu()
        return 
    end

   HandleCamera(currentGarage, true)
   ped = PlayerPedId();
   MenuTitle = "Recover :"
   ClearMenu()
   Menu.addButton("Geri dön","MenuGarage",nil)
    for c,v in pairs(fueravehicles) do
        local vehicle = v.vehiculo
        if v.state == 0 or v.state == false then
            Menu.addButton("KURTAR | "..GetDisplayNameFromVehicleModel(vehicle.model), "pagorecupero", vehicle, "CEKILMIS", " Motor : " .. round(vehicle.engineHealth) /10 .. "%", " Yakıt : " .. round(vehicle.fuelLevel) .. "%","SpawnLocalVehicle")
        end
    end 
end

function pagorecupero(data)
    esx.TriggerServerCallback('erp_garage:checkMoney', function(hasEnoughMoney)
        if hasEnoughMoney == true then
            SpawnVehicle({data,nil},true)
        elseif hasEnoughMoney == "deudas" then
            recuperar()
            TriggerEvent('notification', 'Devlete 2000 dolardan fazla borcunuz var, cezalarını ödeyene kadar aracınızı geri alamazsınız!', 2)
        else
            recuperar()
            TriggerEvent('notification', 'Üzerinde hiç para yok', 2)							
        end
    end)
end


function AbrirMenuGuardar()
    currentGarage = cachedData["currentGarage"]
    if not currentGarage then
        CloseMenu()
        return 
    end
   ped = PlayerPedId();
   MenuTitle = "Save :"
   ClearMenu()
   Menu.addButton("KAPAT","CloseMenu",nil)
   Menu.addButton("GARAJ: "..currentGarage.." | KOY", "SaveInGarage", currentGarage, "", "", "","DeleteActualVeh")
end

function ListeVehicule()
    currentGarage = cachedData["currentGarage"]

    if not currentGarage then
        CloseMenu()
        return 
    end

   HandleCamera(currentGarage, true)
   ped = PlayerPedId();
   MenuTitle = "My vehicles :"
   ClearMenu()
   Menu.addButton("Geri dön","MenuGarage",nil)
    for c,v in pairs(fetchedVehicles) do
        if v then
            local vehicle = v.vehiculo
            Menu.addButton("" ..(vehicle.plate).." | "..GetDisplayNameFromVehicleModel(vehicle.model), "OptionVehicle", {vehicle,nil}, "GARAJ: "..currentGarage.."", " Motor : " .. round(vehicle.engineHealth) /10 .. "%", " Yakıt : " .. round(vehicle.fuelLevel) .. "%","SpawnLocalVehicle")
        end
    end
end

function round(n)
    if not n then return 0; end
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function OptionVehicle(data)
   MenuTitle = "Options :"
   ClearMenu()
   Menu.addButton("Al", "SpawnVehicle", data)
   Menu.addButton("Geri dön", "ListeVehicule", nil)
end

function CloseMenu()
    HandleCamera(currentGarage, false)
	TriggerEvent("inmenu",false)
    Menu.hidden = true
end

function LocalPed()
	return PlayerPedId()
end
