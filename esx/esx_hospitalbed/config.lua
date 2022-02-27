Config = {
    Price = 120,
    ReviveTime = 10, -- seconds until you are revived
    Hospitals = {
        {
            Bed = {coords = vector3(326.2837, -570.607, 43.317) , heading = 245.31, occupied = false}, --{coords = vector3(255.84, -1352.3, 25.52), heading = 317.0, occupied = false},
            Peds = {
                pedHash = -730659924,
                reception = {coords = vector3(311.5786, -594.012, 42.283), heading = 334.27},
                doctor = {coords = vector3(324.0667, -584.986, 43.284), heading = 69.7}, --255.2, -1351.74, 23.55 232.59
            },
        },
    },
}

Config.QuitCoords = {coords = vector3(326.2837, -570.607, 43.317) , heading = 245.31}
Config.BleedingTime = 40 --second

Strings = {
    ['get_help'] = [[Ameliyathaneye gitmek için %s basınız. (Gerekli Miktar ~g~$%s~w~)]],
    ['not_enough'] = [[Yeterli paranız yok!]],
    ['getting_help'] = [[Tedavi devam ediyor, %s saniye kaldı!]],
    ['occupied'] = [[Tüm ameliyathaneler suanda dolu! Lütfen bekleyiniz.]]
}