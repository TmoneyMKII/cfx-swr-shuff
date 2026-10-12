fx_version 'cerulean'
game 'gta5'

author 'SWR Entertainment'
description 'Shuffle Blocker - stops passengers auto-shuffling into the driver seat, /shuff to move over on purpose'
version '1.0.0'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/client.lua',
    'client/target.lua',
}

lua54 'yes'

escrow_ignore {
    'fxmanifest.lua',
    'README.md',
    'config.lua',
}
