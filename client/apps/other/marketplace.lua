
RegisterNUICallback('MarketPlace', function(data, cb)
    if data.action == 'search' then
        CB.TriggerServerCallback('phone:marketplace:search', function(data)
            cb(data)
        end, data.query)
    elseif data.action == 'getPosts' then
        CB.TriggerServerCallback('phone:marketplace:getPosts', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'sendPost' then
        CB.TriggerServerCallback('phone:marketplace:createPost', function(data)
            cb(data)
        end, data.data)
    elseif data.action == 'deletePost' then
        CB.TriggerServerCallback('phone:marketplace:deletePost', function(data)
            cb(data)
        end, data.id)
    end
end)

RegisterNetEvent('phone:marketplace:newPost', function(data)
    SendReactMessage("marketplace:newPost", data)
end)