fx_version "cerulean"
game "gta5"
lua54 "yes"

version "custom-1.1.6"

client_scripts {
    '@fb/shared.lua',
	"@fb/common/modules/dataview.lua",
}

server_scripts {
    '@fb/shared.lua',
}

shared_script {
    "config/*.lua",
    "shared/**/*.lua"
}

client_script "client/**/*.lua"

server_scripts {
	"@oxmysql/lib/MySQL.lua",
    "server/**/*.lua",
	'tools/sv_parseSourceMap.js'
}

files {
    "build/**/*",
    "config/**/*"
}

ui_page "build/index.html"
