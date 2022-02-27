Config = {
    ESXBilling = true, -- let it false if you dont know what are you doing
    Fee = 300, -- per hour
    Locations = {
        ["Imperial Araç Kiralama"] = {
            coords = {
                rent = vector3(-253.654, -999.715, 29.428),
                spawn = vector3(-305.165, -988.208, 30.796),
                heading = 343.14 
            },
            Vehicles = {
                {name = "bmx",label = "Bmx", price = 100, max_time = 6 --[[ hours ]]},
                {name = "faggio",label = "Faggio", price = 400, max_time = 6 --[[ hours ]]},
                {name = "asea",label = "Asea", price = 800, max_time = 6 --[[ hours ]]},
            }
        },
    }
}
