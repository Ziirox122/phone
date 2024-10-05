
RegisterNUICallback('DarkChat', function(data, cb)
    if data.action == 'getUsername' then
        CB.TriggerServerCallback('phone:darkChat:getUsername', function(data)
            cb(data)
        end)
    elseif data.action == 'setUsername' then
        CB.TriggerServerCallback('phone:darkChat:setUsername', function(data)
            cb(data)
        end, data.username)
    elseif data.action == 'getChannel' then
        CB.TriggerServerCallback('phone:darkChat:getChannel', function(data)
            cb(data)
        end, data.channel)
    elseif data.action == 'getChannels' then
        CB.TriggerServerCallback('phone:darkChat:getChannels', function(data)
            cb(data)
        end)
    elseif data.action == 'getMembers' then
        CB.TriggerServerCallback('phone:darkChat:getMembers', function(data)
            cb(data)
        end, data.channel)
    elseif data.action == 'kickMember' then
        CB.TriggerServerCallback('phone:darkChat:kickMember', function(data)
            cb(data)
        end, data.channel, data.username)
    elseif data.action == 'joinChannel' then
        CB.TriggerServerCallback('phone:darkChat:joinChannel', function(data)
            cb(data)
        end, data.name)
    elseif data.action == 'getMessages' then
        CB.TriggerServerCallback('phone:darkChat:getMessages', function(data)
            cb(data)
        end, data.channel, data.page)
    elseif data.action == 'sendMessage' then
        CB.TriggerServerCallback('phone:darkChat:sendMessage', function(data)
            cb(data)
        end, data.channel, data.content)
    elseif data.action == 'leaveChannel' then
        CB.TriggerServerCallback('phone:darkChat:leaveChannel', function(data)
            cb(data)
        end, data.channel)
    elseif data.action == 'clearAllMessages' then
        CB.TriggerServerCallback('phone:darkChat:clearAllMessages', function(data)
            cb(data)
        end, data.channel)
    elseif data.action == 'deleteChannel' then
        CB.TriggerServerCallback('phone:darkChat:deleteChannel', function(data)
            cb(data)
        end, data.channel)
    elseif data.action == 'changePasswordChannel' then
        CB.TriggerServerCallback('phone:darkChat:changePasswordChannel', function(data)
            cb(data)
        end, data.channel, data.password)
    elseif data.action == 'changeAccessChannel' then
        CB.TriggerServerCallback('phone:darkChat:changeAccessChannel', function(data)
            cb(data)
        end, data.channel, data.checked)
    elseif data.action == 'changeSafeModeChannel' then
        CB.TriggerServerCallback('phone:darkChat:changeSafeModeChannel', function(data)
            cb(data)
        end, data.channel, data.checked)
    end
end)

RegisterNetEvent('phone:darkChat:newMessage', function(channel, username, content)
    SendReactMessage('darkchat:newMessage', {channel = channel, username = username, content = content})
end)

RegisterNetEvent('phone:darkchat:channelDeleted', function(channel)
    SendReactMessage('darkchat:channelDeleted', channel)
end)

RegisterNetEvent('phone:darkchat:channelCleared', function(channel)
    SendReactMessage('darkchat:channelCleared', channel)
end)


RegisterNetEvent('phone:darkchat:memberKicked', function(channel, userKicked)
    SendReactMessage('darkchat:memberKicked', {
        channel = channel,
        user = userKicked
    })
end)