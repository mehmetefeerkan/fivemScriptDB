Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'en',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,    -- Delete tuşuna basınca animasyon iptal ediyor.
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
-- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 166, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = false,
	FavKeybind = 108, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgyukle.com/2020/03/08/nwO7fe.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = false,
	RagdollKeybind = 303, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = false,
-- If you have the SQL imported enable this to turn on keybinding.
    SqlKeybinding = true,
}

Config.KeybindKeys = {
    ['num4'] = 108,
    ['num5'] = 110,
    ['num6'] = 109,
    ['num7'] = 117,
    ['num8'] = 111,
    ['num9'] = 118
}

Config.Languages = {
    ['en'] = {
        ['emotes'] = 'Animasyonlar',
        ['danceemotes'] = "🕺 Dans Animasyonları",
        ['propemotes'] = "📦 Eşya Animasyonları",
        ['favoriteemotes'] = "🌟 Favoriler",
        ['favoriteinfo'] = "Favori belirlemek için bir animasyon seç.",
        ['rfavorite'] = "Favorileri Sıfırla",
        ['prop2info'] = "❓ Eşya Animasyonları sonunda bulunabilir",
        ['set'] = "Ayarla (",
        ['setboundemote'] = ") animasyon kısayolu olarak ayarlansın mı?",
        ['newsetemote'] = "~w~ senin yeni bir atanmış animasyonun ~g~F5~w~ \'e basarak kullabilirsiniz.",
        ['cancelemote'] = "Animasyon iptal ~y~ DELETE ~r~ tuşuna bas",
        ['cancelemoteinfo'] = "~r~X~y~ Animasyonu iptal et.",
        ['walkingstyles'] = "Yürüme Animasyonları",
        ['resetdef'] = "Varsayılana sıfırla",
        ['normalreset'] = "Normal (Reset)",
        ['moods'] = "Yüz İfadeleri",
        ['infoupdate'] = "~r~Kodlayanlar",
        ['infoupdateav'] = "Bilgi (Güncelleme Mevcut)",
        ['infoupdateavtext'] = "",
        --Güncelleme mevcut,Son versiyonu burdan indirebilirsiniz. ~y~https://github.com/andristum/dpemotes~w~
        ['suggestions'] = "ImperialRP Discord",
        ['suggestionsinfo'] = "~b~Discord:~s~ discord.gg/imperialroleplay",
        ['notvaliddance'] = "Geçerli bir dans değil.",
        ['notvalidemote'] = "Geçerli bir animasyon değil.",
        ['nocancel'] = "İptal edilebilecek bir animasyon yok.",
        ['maleonly'] = "Bu animsayon sadece erkekler için!",
        ['emotemenucmd'] = "Menü için /emotemenu kullan.",
        ['shareemotes'] = "👫 Paylaşılan Animasyonlar",
        ['shareemotesinfo'] = "Yakın kişiyi davet et",
        ['sharedanceemotes'] = "🕺 Paylaşılan Danslar",
        ['notvalidsharedemote'] = "Bu bir karşılıklı animasyon değil.",
        ['sentrequestto'] =  "~y~ ile istek gönder";
        ['nobodyclose'] = "Yakınında kimse yok ~r~close~w~ ",
        ['doyouwanna'] = " Kabul etmek için ~y~Y~w~, reddetmek için  ~r~L~w~ (~g~",
        ['refuseemote'] = "Animasyon Reddedildi.",
        ['makenearby'] = "En yakın oyuncu oynamaya başladı",
        ['camera'] = "Kamerayı kullanmak için ~y~G~w~ basınız.",
        ['makeitrain'] = "Yağmur yağdırmak için ~y~G~w~ /'a basın.",
        ['pee'] = "İşemek için ~y~G~w~ /'e basılı tutun.",
        ['spraychamp'] = "Şampanya patlatmak için ~y~G~w~ \'a basılı tutun ",
        ['bound'] = "Ata ",
        ['to'] = "to",
        ['currentlyboundemotes'] = " Ayarlanmış Animasyonlar:",
        ['notvalidkey'] = "Geçerli bir tuş değil.",
        ['keybinds'] = "🔢 Tuş kombinasyonları",
        ['keybindsinfo'] = "Kullan"
  },
}