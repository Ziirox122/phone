RegisterNUICallback('toggleFlashlight', function(data, cb)
    local value = data.toggled and (not Entity(PlayerPedId()).state.flashlight) or false

    Entity(PlayerPedId()).state:set('flashlight', value, true)
    cb(value)
end)