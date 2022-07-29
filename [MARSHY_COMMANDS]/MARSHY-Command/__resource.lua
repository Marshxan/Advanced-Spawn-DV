resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'



server_script "server.lua"
server_script "s_fcv.lua"

--client_script 'RealisticTraffic_cl.lua'
--client_script "@Logs2/acloader.lua"
client_script "client.lua"
client_script 'cl_vengine.lua'
client_script 'Client.lua'
client_script "c_fcv.lua"

-- MYTHIC NOTIFY
ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css',
}

client_scripts {
	'client/main.lua'
}

exports {
	'DoShortHudText',
	'DoHudText',
	'DoLongHudText',
	'DoCustomHudText',
	'PersistentHudText',
}