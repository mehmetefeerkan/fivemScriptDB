Config = {}

Config.MoneyInDesk = math.random(250, 450) -- her bir vezneden çıkacak para
Config.TimeInDesk = 15000 -- her bir veznenin arama süresi(ms)
Config.CloseDoorWhenFinish = 15000 -- soygunu bitirdikten sonra kapının kapanması süresi(ms)
Config.NeedCop = 0 -- soygun için gerekli polis sayısı

Config.Bank = {
    [1] = {
        door =  vector3(145.3, -1041.14, 29.37),
        desk1 = vector3(147.3, -1041.3, 29.6),
        desk2 = vector3(148.75, -1041.85, 29.6),
        desk3 = vector3(150.0, -1042.36, 29.6),
        desk4 = vector3(151.4, -1042.8, 29.6)
    },
    [2] = {
        door =  vector3(309.66, -279.52, 54.16),
        desk1 = vector3(311.34, -279.53, 54.16),
        desk2 = vector3(312.63, -280.0, 54.16),
        desk3 = vector3(314.0, -280.5, 54.16),
        desk4 = vector3(315.3, -280.98, 54.16)
    },
    [3] = {
        door =  vector3(-355.62, -50.43, 49.04),
        desk1 = vector3(-353.87, -50.38, 49.04),
        desk2 = vector3(-352.51, -50.84, 49.04),
        desk3 = vector3(-351.1, -51.36, 49.04),
        desk4 = vector3(-349.77, -51.82, 49.04)
    },
    [4] = {
        door =  vector3(-1215.42, -334.39, 37.78),
        desk1 = vector3(-1214.49, -333.21, 37.78),
        desk2 = vector3(-1213.15, -332.64, 37.78),
        desk3 = vector3(-1211.78, -331.84, 37.78),
        desk4 = vector3(-1210.47, -331.18, 37.78)
    },
    [5] = {
        door =  vector3(-2960.81, 478.71, 15.7),
        desk1 = vector3(-2961.27, 480.14, 15.7),
        desk2 = vector3(-2961.22, 481.64, 15.7),
        desk3 = vector3(-2961.16, 483.09, 15.7),
        desk4 = vector3(-2961.08, 484.52, 15.7)
    },
    [6] = {
        door =  vector3(1179.16, 2708.76, 38.09),
        desk1 = vector3(1177.8, 2708.21, 38.09),
        desk2 = vector3(1176.35, 2708.22, 38.09),
        desk3 = vector3(1174.83, 2708.21, 38.09),
        desk4 = vector3(1173.33, 2708.2, 38.09)
    }
}