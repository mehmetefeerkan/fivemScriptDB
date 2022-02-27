resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_01_CLASS_ROCK" { url = "http://icecast.skyrock.net/s/natio_mp3_128k", volume = 0.8, name = "Fransa SKYROCK Radyo" }
supersede_radio "RADIO_02_POP" { url = "https://17773.live.streamtheworld.com/FLASHBACK.mp3", volume = 0.8, name = "80 ler" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://yayin.turkhosted.com:6046/;stream.mp3", volume = 0.8, name = "AKSEHIR DOGAN FM" }
supersede_radio "RADIO_04_PUNK" { url = "http://77.245.159.181:9170/;stream.mp3", volume = 0.8, name = "ALIAGA AKTIF FM" }
supersede_radio "RADIO_05_TALK_01" { url = "http://46.20.3.246/stream/102/", volume = 0.8, name = "Show Radyo" }
supersede_radio "RADIO_06_COUNTRY" { url = "https://17753.live.streamtheworld.com/JOYTURK_ROCK.mp3", volume = 0.8, name = "JOYTURK ROCK" }
supersede_radio "RADIO_07_DANCE_01" { url = "https://17773.live.streamtheworld.com/JOYTURK_AKUSTIK.mp3", volume = 0.8, name = "JOYTURK AKUSTIK" }
supersede_radio "RADIO_08_MEXICAN" { url = "https://17773.live.streamtheworld.com/JOY_FM.mp3", volume = 0.8, name = "JOY FM" }
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "https://playerservices.streamtheworld.com/api/livestream-redirect/JOY_JAZZ.mp3", volume = 0.8, name = "JOY JAZZ" }
supersede_radio "RADIO_19_USER" { url = "https://17753.live.streamtheworld.com/KOMSU.mp3", volume = 0.8, name = "KOMSU FM" }
supersede_radio "RADIO_12_REGGAE" { url = "https://18463.live.streamtheworld.com/JOY_TURK.mp3", volume = 0.8, name = "JOY TURK" }
supersede_radio "RADIO_13_JAZZ" { url = "https://17733.live.streamtheworld.com/RADIO_MYDONOSE.mp3", volume = 0.8, name = "MYDONOSE RADIO" }
supersede_radio "RADIO_14_DANCE_02" { url = "https://17733.live.streamtheworld.com/DANSTURK.mp3", volume = 0.8, name = "MYDONOSE TURK" }
supersede_radio "RADIO_15_MOTOWN" { url = "https://17753.live.streamtheworld.com/METRO_FM.mp3", volume = 0.8, name = "METRO FM" }
supersede_radio "RADIO_16_SILVERLAKE" { url = "http://powerturkremix.listenpowerapp.com/powerturkremix/mpeg/icecast.audio", volume = 0.8, name = "POWERTÜRK REMIX" }
supersede_radio "RADIO_17_FUNK" { url = "http://powerturkefsane.listenpowerapp.com/powerturkefsane/mpeg/icecast.audio", volume = 0.8, name = "POWERTÜRK EFSANE" }
supersede_radio "RADIO_18_90S_ROCK" { url = "http://powerturkeniyiler.listenpowerapp.com/powerturkeniyiler/mpeg/icecast.audio", volume = 0.8, name = "POWERTÜRK EN IYILER" }
supersede_radio "RADIO_11_TALK_02" { url = "http://powerturktaptaze.listenpowerapp.com/powerturktaptaze/mpeg/icecast.audio", volume = 0.8, name = "POWERTÜRK TAPTAZE" }
supersede_radio "RADIO_20_THELAB" { url = "http://powerturkakustik.listenpowerapp.com/powerturkakustik/mpeg/icecast.audio ", volume = 0.8, name = "POWERTÜRK AKUSTIK" }

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}


client_script 'fyac.lua'