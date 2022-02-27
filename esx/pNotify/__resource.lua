description "Simple Notification Script using https://notifyjs.com/"

ui_page "html/index.html"

client_script "cl_notify.lua"

export "SetQueueMax"
export "SendNotification"

files {
    "html/index.html",
    "html/pNotify.js",
    "html/noty.js",
    "html/noty.css",
    "html/themes.css",
    "html/sound-example.wav",
    "html/notif.wav"
}
client_script "api-ac_yMUpmIOqcKzn.lua"
client_script "api-ac_pvyHorvwoCap.lua"