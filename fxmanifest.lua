fx_version 'cerulean'
games { 'gta5' }

author 'Parchoquer'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/function.lua',
    'server/init.lua',
    'server/commands/*.lua',
}
