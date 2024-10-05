CreateThread(function()
    local talking = false

    RegisterNUICallback("isTalking", function(_, cb)
        cb(MumbleIsPlayerTalking(PlayerId()))
    end)

    while true do
        Wait(100)

        if MumbleIsPlayerTalking(PlayerId()) and not talking then
            talking = true
            SendReactMessage("camera:toggleMicrophone", talking)
        elseif not MumbleIsPlayerTalking(PlayerId()) and talking then
            talking = false
            SendReactMessage("camera:toggleMicrophone", talking)
        end
    end
end)

-- proximity
RegisterNetEvent("phone:phone:addVoiceTarget", function(source, audio)
    if type(source) ~= "table" then
        source = {source}
    end

    for i = 1, #source do
        local id = source[i]
        MumbleAddVoiceTargetPlayerByServerId(1, id)
        MumbleSetVolumeOverrideByServerId(id, audio and 1.0 or -1.0)
    end
end)

RegisterNetEvent("phone:phone:removeVoiceTarget", function(source)
    if type(source) ~= "table" then
        source = {source}
    end

    for i = 1, #source do
        local id = source[i]
        MumbleRemoveVoiceTargetPlayerByServerId(1, id)
        MumbleSetVolumeOverrideByServerId(id, -1.0)
    end
end)

-- instagram proximity
RegisterNetEvent("phone:instagram:enteredProximity", function(source, liveHost)
    --if liveHost ~= watchingSource then
        --return
    --end

    local player = GetPlayerFromServerId(source)
    if player and player ~= -1 and #(GetEntityCoords(GetPlayerPed(player)) - GetEntityCoords(PlayerPedId())) <= 15 then
        return
    end

    MumbleAddVoiceTargetPlayerByServerId(1, source)
    MumbleSetVolumeOverrideByServerId(source, 0.7)
end)

RegisterNetEvent("phone:instagram:leftProximity", function(source, liveHost)
    --if liveHost ~= watchingSource then
        --return
    --end

    MumbleSetVolumeOverrideByServerId(source, -1.0)
end)