resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
    'handling.meta',
    'vehicles.meta',
    'dlctext.meta',
    'carcols.meta',
    'carvariations.meta',
	'vehicleaihandlinginfo',
	'vehiclelayouts.meta',
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'HANDLING_FILE' 'vehicleaihandlinginfo.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'TEXTFILE_METAFILE' 'dlctext.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'CARCOLS_FILE' 'carcols.ymt'
data_file 'vehicle_variation_file' 'carvariations.meta'
data_file 'DLCTEXT_file' 'dlctext.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'

client_scripts 'vehicle_names.lua'
is_els 'true'