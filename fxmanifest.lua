fx_version 'cerulean'
game 'gta5'

author 'Nexiii, ProjectX'
description 'Resource originally made by TRClassic modified by Nexiii to be a simple Weedfarming script'
version '0.1_BETA'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'Client/*.lua'

server_script 'Server/*.lua'

lua54 'yes'
