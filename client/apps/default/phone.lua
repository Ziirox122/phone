local CurrentCall = nil

RegisterNUICallback('Phone', function(data, cb)
    if data.action == 'getContacts' then
        CB.TriggerServerCallback('phone:phone:getContacts', function(data)
            cb(data)
        end)
    elseif data.action == 'getContact' then
        CB.TriggerServerCallback('phone:phone:getContact', function(data)
            cb(data)
        end, data.number)
    elseif data.action == 'removeContact' then
        CB.TriggerServerCallback('phone:phone:removeContact', function(data)
            cb(data)
        end, data.number)
    elseif data.action == 'toggleBlock' then
        CB.TriggerServerCallback('phone:phone:toggleBlock', function(data)
            cb(data)
        end, data.number, data.blocked)
    elseif data.action == 'toggleFavourite' then
        CB.TriggerServerCallback('phone:phone:toggleFavourite', function(data)
            cb(data)
        end, data.number, data.favourite)
    elseif data.action == 'updateContact' then
        CB.TriggerServerCallback('phone:phone:updateContact', function(data)
            cb(data)
        end, data.data)
    elseif data.action == 'getRecent' then
        CB.TriggerServerCallback('phone:phone:getRecentCalls', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'clearRecent' then
        CB.TriggerServerCallback('phone:phone:clearRecentCalls', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'getBlockedNumbers' then
        CB.TriggerServerCallback('phone:phone:getBlockedNumbers', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'call' then
        incomingCall = false
        Animations.startPhoneCall()
        TriggerServerEvent('phone:phone:call', data)
        cb(true)
    elseif data.action == 'endCall' then
        CB.TriggerServerCallback('phone:phone:endCall', function()
            cb(true)
        end)
    elseif data.action == 'answerCall' then
        CB.TriggerServerCallback('phone:phone:answerCall', function(data)
            cb(data)
        end, data.callId)
    elseif data.action == 'toggleMute' then
        exports['pma-voice']:setCallMuted(data.toggle)
        cb(true)
    elseif data.action == 'toggleSpeaker' then
        exports['pma-voice']:setLoudSpeaker(data.toggle)
        cb(true)
    elseif data.action == 'saveContact' then
        CB.TriggerServerCallback('phone:phone:saveContact', function(data)
            cb(data)
        end, data.data)
    elseif data.action == 'flipCamera' then
        local value = data.value
        cb(true)
    end
end)

--SendReactMessage("phone:usedCommand", 'answer')
--SendReactMessage("phone:usedCommand", 'decline')

RegisterNetEvent('phone:phone:updateContact', function()
    SendReactMessage("phone:updateContact")
end)

local incomingCall = false
RegisterNetEvent('phone:phone:setCall', function(data)
    incomingCall = true
    SendReactMessage("phone:incomingCall", data)
end)

RegisterNetEvent('fb-phone:setPhone', function()
    incomingCall = false
end)

RegisterNetEvent('phone:phone:connectCall', function(callId, PhoneCall)
    incomingCall = false
    PhoneCall.callId = callId
    CurrentCall = PhoneCall

    SendReactMessage("phone:call:connected", callId)
    Animations.startPhoneCall()
    exports['pma-voice']:setCallChannel(callId)

    if CurrentCall.videoCall then
        CAMERA_MODE = 1
        CAMERA_FLIPPED = true
        Animations.openCamera()
    end
end)

RegisterNetEvent('phone:phone:endCall', function(callId)
    incomingCall = false
    SendReactMessage("phone:call:endCall", callId)
    exports['pma-voice']:setCallChannel(0)
    Animations.endPhoneCall()
    Animations.closeCamera()

    CAMERA_MODE = nil
    CAMERA_FLIPPED = false
    CurrentCall = nil
end)

RegisterNetEvent('phone:phone:userUnavailable', function(data)
    incomingCall = false
    SendReactMessage("phone:call:userUnavailable", data)
    exports['pma-voice']:setCallChannel(0)
    Animations.endPhoneCall()
end)

RegisterNetEvent('phone:phone:userBusy', function(data)
    incomingCall = false
    SendReactMessage("phone:call:userBusy", data)
    exports['pma-voice']:setCallChannel(0)
    Animations.endPhoneCall()
end)

RegisterKeyMapping('+use_answercall_key', 'Accepter une appel', 'keyboard', 'RETURN')
RegisterKeyMapping('+use_declinecall_key', 'Refuser l\'appel', 'keyboard', 'BACK')

RegisterCommand('-use_answercall_key', function() end)
RegisterCommand('+use_answercall_key', function()
    if exports.fb:HasMenuOpen() then return end
    if not incomingCall then return end
    CB.TriggerServerCallback('phone:phone:answerCall')
end)

RegisterCommand('-use_declinecall_key', function() end)
RegisterCommand('+use_declinecall_key', function()
    if exports.fb:HasMenuOpen() then return end
    if not incomingCall then return end
    CB.TriggerServerCallback('phone:phone:endCall')
end)

exports('IsInCall', function()
    return CurrentCall
end)