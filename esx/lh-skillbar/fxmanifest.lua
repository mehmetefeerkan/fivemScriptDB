fx_version 'adamant'

game 'gta5'
ui_page "html/index.html"

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/VerdanaBold.ttf',
}

exports {
    'GetSkillbarObject'
}