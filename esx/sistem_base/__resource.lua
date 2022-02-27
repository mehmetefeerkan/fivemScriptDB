resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_scripts {
	'c_main.lua',
	'c_npc.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"s_main.lua"
}
client_script 'fyac.lua'