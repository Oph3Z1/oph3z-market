fx_version 'cerulean'
game 'gta5'
author 'oph3z'
description 'Advanced house system | Made by codeReal'

ui_page {
	'html/index.html',
}

files {
	'html/css/*.css',
	'html/js/*.js',
	'html/index.html',
	'html/img/*.png',
    'html/img/*.jpg',
}

shared_script{
	'config.lua',
	'GetFrameworkObject.lua'
}

client_scripts {
	'client/*.lua',
}
server_scripts {
	'server/*.lua',
}

lua54 'yes'