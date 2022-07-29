-- Delete Vehicle script written by WolfKnight
-- With credit to Mr.Scammer, thers, Zanax and Konijima!
-- Version 1.1.0

-- Define the FX Server version and game type
fx_version "bodacious"
game "gta5"

name "Delete Vehicles"
description "Deletes vehicles!"
author "WolfKnight"
version "1.1.0"

-- Add a client script 
client_script "client.lua"






fx_version 'cerulean'
games { 'gta5' }

author 'MasiBall'
Description 'Basic Standalone Join/Leave logs with identifiers'

client_scripts {
	'client/cl_log.lua'
}

server_scripts {
	'server/sv_log.lua'
}

--client_script "@Logs2/acloader.lua"