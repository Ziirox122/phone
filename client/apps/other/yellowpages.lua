
RegisterNUICallback('YellowPages', function(data, cb)
    if data.action == 'search' then
        CB.TriggerServerCallback('phone:yellowPages:search', function(data)
            cb(data)
        end, data.query)
    elseif data.action == 'getPosts' then
        CB.TriggerServerCallback('phone:yellowPages:getPosts', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'sendPost' then
        CB.TriggerServerCallback('phone:yellowPages:createPost', function(data)
            cb(data)
        end, data.data)
    elseif data.action == 'deletePost' then
        CB.TriggerServerCallback('phone:yellowPages:deletePost', function(data)
            cb(data)
        end, data.id)
    end
end)


RegisterNetEvent('phone:yellowPages:newPost', function(data)
    SendReactMessage("yellowPages:newPost", data)
end)
