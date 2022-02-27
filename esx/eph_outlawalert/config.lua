Config = {}

Config.Locale = 'en'

-- Set the time (in minutes) during the player is outlaw
Config.Timer = 1

-- Set if show alert when player use gun
Config.GunshotAlert = true

-- Set if show when player do carjacking
Config.CarJackingAlert = false

-- Set if show when player fight in melee
Config.MeleeAlert = false

-- In seconds
Config.BlipGunTime = 7 -- 15 saniye  boyunca blip gösterir.

-- Blip radius, in float value!
Config.BlipGunRadius = 50.0

-- In seconds
Config.BlipMeleeTime = 5 -- 10 saniye  boyunca blip gösterir.

-- Blip radius, in float value!
Config.BlipMeleeRadius = 50.0

-- In seconds
Config.BlipJackingTime = 5 -- 20 saniye  boyunca blip gösterir.

-- Blip radius, in float value!
Config.BlipJackingRadius = 50.0

-- Show notification when cops steal too?
Config.ShowCopsMisbehave = true

-- Jobs in this table are considered as cops
Config.WhitelistedCops = {
	'police'
}

Config.Colors = {
[0] = "Metalik Siyah",
[1] = "Metalik Grafit Siyahı",
[2] = "Metalik Siyah Çelik",
[3] = "Metalik Koyu Gümüş",
[4] = "Metalik Gümüş",
[5] = "Metalik Mavi Gümüş",
[6] = "Metalik Çelik Gri",
[7] = "Metalik Gölge Gümüş",
[8] = "Metalik Taş Gümüş",
[9] = "Metalik Gece Yarısı Gümüş",
[10] = "Metalik Silah Metal",
[11] = "Metalik Antrasit Gri",
[12] = "Mat Siyah",
[13] = "Mat Gri",
[14] = "Mat Açık Gri",
[15] = "Util Siyah",
[16] = "Util Siyah Poli",
[17] = "Util Koyu gümüş",
[18] = "Util Gümüş",
[19] = "Util Gun Metal",
[20] = "Util Gölge Gümüş",
[21] = "Yıpranmış Siyah",
[22] = "Aşınmış Grafit",
[23] = "Aşınmış Gümüş Gri",
[24] = "Yıpranmış Gümüş",
[25] = "Yıpranmış Mavi Gümüş",
[26] = "Aşınmış Gölge Gümüşü",
[27] = "Metalik Kırmızı",
[28] = "Metalik Torino Kırmızısı",
[29] = "Metalik Formül Kırmızı",
[30] = "Metalik Blaze Kırmızı",
[31] = "Metalik Zarif Kırmızı",
[32] = "Metalik Garnet Kırmızısı",
[33] = "Metalik Çöl Kırmızısı",
[34] = "Metalik Cabernet Kırmızı",
[35] = "Metalik Şeker Kırmızı",
[36] = "Metalik Gündoğumu Turuncu",
[37] = "Metalik Klasik Altın",
[38] = "Metalik Portakal",
[39] = "Mat Kırmızı",
[40] = "Mat Koyu Kırmızı",
[41] = "Mat Turuncu",
[42] = "Mat Sarı",
[43] = "Util Kırmızı",
[44] = "Util Parlak Kırmızı",
[45] = "Util Garnet Kırmızısı",
[46] = "Yıpranmış Kırmızı",
[47] = "Aşınmış Altın Kırmızı",
[48] = "Aşınmış Koyu Kırmızı",
[49] = "Metalik Koyu Yeşil",
[50] = "Metalik Yarış Yeşili",
[51] = "Metalik Deniz Yeşili",
[52] = "Metalik Zeytin Yeşili",
[53] = "Metalik Yeşil",
[54] = "Metalik Benzin Mavi Yeşil",
[55] = "Mat Kireç Yeşili",
[56] = "Util Koyu Yeşil",
[57] = "Util Yeşil",
[58] = "Aşınmış Koyu Yeşil",
[59] = "Yıpranmış Yeşil",
[60] = "Yıpranmış Deniz Yıkama",
[61] = "Metalik Gece Mavisi",
[62] = "Metalik Koyu Mavi",
[63] = "Metalik Saksonya Mavisi",
[64] = "Metalik Mavi",
[65] = "Metalik Denizci Mavi",
[66] = "Metalik Liman Mavisi",
[67] = "Metalik Pırlanta Mavi",
[68] = "Metalik Sörf Mavisi",
[69] = "Metalik Deniz Mavisi",
[70] = "Metalik Parlak Mavi",
[71] = "Metalik Mor Mavi",
[72] = "Metalik Spinnaker Mavi",
[73] = "Metalik Ultra Mavi",
[74] = "Metalik Parlak Mavi",
[75] = "Util Koyu Mavi",
[76] = "Util Gece Mavisi",
[77] = "Util Mavi",
[78] = "Util Deniz Köpüğü Mavi",
[79] = "Util Açık mavi",
[80] = "Util Maui Mavi Poli",
[81] = "Util Parlak Mavi",
[82] = "Mat Koyu Mavi",
[83] = "Mat Mavi",
[84] = "Mat Gece Mavisi",
[85] = "Aşınmış Koyu mavi",
[86] = "Aşınmış Mavi",
[87] = "Aşınmış Açık mavi",
[88] = "Metalik Taksi Sarı",
[89] = "Metalik Yarış Sarı",
[90] = "Metalik Bronz",
[91] = "Metalik Sarı Kuş",
[92] = "Metalik Kireç",
[93] ="Metalik Şampanya",
[94] ="Metalik Pueblo Bej",
[95] ="Metalik Koyu Fildişi",
[96] ="Metalik Choco Kahve",
[97] ="Metalik Altın Kahve",
[98] ="Metalik Açık Kahverengi",
[99] ="Metalik Hasır Bej",
[100] ="Metalik Yosun Kahve",
[101] ="Metalik Biston Kahve",
[102] ="Metalik Kayın Ağacı",
[103] ="Metalik Koyu Kayın Ağacı",
[104] ="Metalik Choco Portakal",
[105] ="Metalik Sahil Kumu",
[106] ="Metalik Güneş Bleeched Kum",
[107] ="Metalik Krem",
[108] ="Util Kahve",
[109] ="Util Orta Kahve",
[110] ="Util Açık Kahve",
[111] ="Metalik Beyaz",
[112] ="Metalik Don Beyaz",
[113] ="Yıpranmış Bal Bej",
[114] ="Yıpranmış Kahverengi",
[115] ="Yıpranmış Koyu Kahverengi",
[116] ="Yıpranmış saman bej",
[117] ="Fırçalanmış Çelik",
[118] ="Fırçalanmış Siyah çelik",
[119] ="Fırçalanmış Alüminyum",
[120] ="Krom",
[121] ="Yıpranmış Beyaz",
[122] ="Util Kırık Beyaz",
[123] ="Yıpranmış Turuncu",
[124] ="Yıpranmış Açık Turuncu",
[125] ="Metalik Securicor Yeşil",
[126] ="Yıpranmış Taksi Sarı",
[127] ="polis arabası mavi",
[128] ="Mat Yeşil",
[129] ="Mat Kahve",
[130] ="Yıpranmış Turuncu",
[131] ="Mat Beyaz",
[132] ="Yıpranmış Beyaz",
[133] ="Yıpranmış Zeytin Ordu Yeşili",
[134] ="Saf Beyaz",
[135] ="Sıcak Pembe",
[136] ="Somon pembe",
[137] ="Metalik Vermillion Pembe",
[138] ="Turuncu",
[139] ="Yeşil",
[140] ="Mavi",
[141] ="Mettalik Siyah Mavi",
[142] ="Metalik Siyah Mor",
[143] ="Metalik Siyah Kırmızı",
[144] ="avcı yeşili",
[145]="Metalik Mor",
[146] ="Metaillik V Koyu Mavi",
[147] ="MODSHOP SİYAH",
[148] ="Mat Mor",
[149] ="Mat Koyu Mor",
[150] ="Metalik Lav Kırmızı",
[151] ="Mat Orman Yeşili",
[152] ="Mat Zeytin Yeşili",
[153] ="Mat Çöl Kahvesi",
[154] ="Mat Çöl Tan",
[155] ="Mat Foilage Yeşil",
[156] ="VARSAYILAN ALAŞIM RENGİ",
[157] ="Epsilon Mavi",
[158] ="Saf Altın",
[159] ="Fırçalı Altın",
}