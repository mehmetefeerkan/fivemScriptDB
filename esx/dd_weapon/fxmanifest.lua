fx_version 'adamant'
game 'gta5'
-- shared_script '@es_extended/imports.lua'
server_scripts {
  'config.lua',
  'sv.lua',
}
client_scripts {
  '@dd_core/inLoops.lua',
  'config.lua',
  'cl.lua',
  'recoil.lua',
}
files {
	'weapons.meta',
  'stream/resident/*.awc',
	'stream/weapons_player/*.awc',
}
data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'
data_file 'AUDIO_WAVEPACK' 'stream/resident/*.awc'
data_file 'AUDIO_WAVEPACK' 'stream/weapons_player/*.awc'