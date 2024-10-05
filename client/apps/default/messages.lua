RegisterNUICallback('Messages', function(data, cb)
    if data.action == 'getMessages' then
        CB.TriggerServerCallback('phone:messages:getMessages', function(returnedData)
            cb(returnedData)
        end, data.id, data.page)
    elseif data.action == 'sendMessage' then
        CB.TriggerServerCallback('phone:messages:sendMessage', function(returnedData)
            cb(returnedData)
        end, data.number, data.content, data.attachments, data.id)
    elseif data.action == 'deleteMessage' then
        CB.TriggerServerCallback('phone:messages:deleteMessage', function(returnedData)
            cb(returnedData)
        end, data.id)
    elseif data.action == 'markRead' then
        CB.TriggerServerCallback('phone:messages:markRead', function(returnedData)
            cb(returnedData)
        end, data.id)
    elseif data.action == 'deleteConversation' then
        CB.TriggerServerCallback('phone:messages:deleteConversation', function(returnedData)
            cb(returnedData)
        end, data.id)
    elseif data.action == 'removeMember' then
        CB.TriggerServerCallback('phone:messages:removeMember', function(returnedData)
            cb(returnedData)
        end, data.id, data.number)
    elseif data.action == 'leaveGroup' then
        CB.TriggerServerCallback('phone:messages:leaveGroup', function(returnedData)
            cb(returnedData)
        end, data.id)
    elseif data.action == 'addMember' then
        CB.TriggerServerCallback('phone:messages:addMember', function(returnedData)
            cb(returnedData)
        end, data.id, data.number)
    elseif data.action == 'createGroup' then
        local membersPhones = {}
        for i=1, #data.members do
            membersPhones[i] = data.members[i].number
        end

        CB.TriggerServerCallback('phone:messages:createGroup', function(returnedData)
            cb(returnedData)
        end, membersPhones, data.content, data.attachments)
    elseif data.action == 'getRecentMessages' then
        CB.TriggerServerCallback('phone:messages:getRecentMessages', function(returnedData)
            cb(returnedData)
        end, data.page)
    elseif data.action == 'renameChannel' then
        CB.TriggerServerCallback('phone:messages:renameChannel', function(returnedData)
            cb(returnedData)
        end, data.id, data.name)
    elseif data.action == 'changeChannelProfileImage' then
        CB.TriggerServerCallback('phone:messages:changeChannelProfileImage', function(returnedData)
            cb(returnedData)
        end, data.id, data.image)
    end
end)

RegisterNetEvent('phone:messages:newMessage', function(channelId, from, message, attachments)
    SendReactMessage('messages:newMessage', {
        id = channelId,
        content = message,
        sender = from,
        attachments = attachments,
    })
end)

RegisterNetEvent('phone:messages:messageDeleted', function(data)
    SendReactMessage('messages:messageDeleted', data)
end)