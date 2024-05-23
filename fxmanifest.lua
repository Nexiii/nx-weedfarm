fx_version 'cerulean'
game 'gta5'

author 'xNexiii, ProjectX'
description 'Resource originally made by ProjextX modified by xNexiii to be Weedfarm'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'Client/*.lua'

server_script 'Server/*.lua'

lua54 'yes'
