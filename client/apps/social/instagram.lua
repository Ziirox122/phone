
RegisterNUICallback('Instagram', function(data, cb)
    if data.action == 'isLoggedIn' then
        CB.TriggerServerCallback('phone:instagram:isLoggedIn', function(data)
            cb(data)
        end)
    elseif data.action == 'getPost' then
        CB.TriggerServerCallback('phone:instagram:getPost', function(data)
            cb(data)
        end, data.id)
    elseif data.action == 'getPosts' then
        CB.TriggerServerCallback('phone:instagram:getPosts', function(data)
            cb(data)
        end, data.filters, data.page)
    elseif data.action == 'getProfile' then
        CB.TriggerServerCallback('phone:instagram:getProfile', function(data)
            cb(data)
        end, data.username)
    elseif data.action == 'getComments' then
        CB.TriggerServerCallback('phone:instagram:getComments', function(data)
            cb(data)
        end, data.postId, data.page)
    elseif data.action == 'logIn' then
        CB.TriggerServerCallback('phone:instagram:logIn', function(data)
            cb(data)
        end, data.username, data.password)
    elseif data.action == 'createAccount' then
        CB.TriggerServerCallback('phone:instagram:createAccount', function(data)
            cb(data)
        end, data.name, data.username, data.password)
    elseif data.action == 'getNotifications' then
        CB.TriggerServerCallback('phone:instagram:getNotifications', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'toggleFollow' then
        CB.TriggerServerCallback('phone:instagram:toggleFollow', function(data)
            cb(data)
        end, data.data.username, data.data.following)
    elseif data.action == 'updateProfile' then
        CB.TriggerServerCallback('phone:instagram:updateProfile', function(data)
            cb(data)
        end, data.data.name, data.data.bio, data.data.avatar)
    elseif data.action == 'signOut' then
        CB.TriggerServerCallback('phone:instagram:signOut', function(data)
            cb(data)
        end)
    elseif data.action == 'viewLive' then
        CB.TriggerServerCallback('phone:instagram:viewLive', function(data)
            cb(data)
        end, data.username)
    elseif data.action == 'getMessages' then
        CB.TriggerServerCallback('phone:instagram:getMessages', function(data)
            cb(data)
        end, data.username, data.page)
    elseif data.action == 'getRecentMessages' then
        CB.TriggerServerCallback('phone:instagram:getRecentMessages', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'getLives' then
        CB.TriggerServerCallback('phone:instagram:getLives', function(data)
            cb(data)
        end, data)
    elseif data.action == 'deletePost' then
        CB.TriggerServerCallback('phone:instagram:deletePost', function(data)
            cb(data)
        end, data.id)
    elseif data.action == 'postComment' then
        CB.TriggerServerCallback('phone:instagram:postComment', function(data)
            cb(data)
        end, data.data.postId, data.data.comment)
    elseif data.action == 'toggleLike' then
        CB.TriggerServerCallback('phone:instagram:toggleLike', function(data)
            cb(data)
        end, data.data.postId, data.data.toggle, data.data.isComment)
    elseif data.action == 'search' then
        CB.TriggerServerCallback('phone:instagram:search', function(data)
            cb(data)
        end, data.query)
    elseif data.action == 'endLive' then
        CB.TriggerServerCallback('phone:instagram:endLive', function(data)
            CAMERA_MODE = nil
            CAMERA_FLIPPED = false
            Animations.closeCamera()

            cb(data)
        end, data)
    elseif data.action == 'newPost' then
        CB.TriggerServerCallback('phone:instagram:createPost', function(data)
            cb(data)
        end, data.data.images, data.data.caption)
    elseif data.action == 'getFollowing' then
        CB.TriggerServerCallback('phone:instagram:getData', function(data)
            cb(data)
        end, 'following', data.data)
    elseif data.action == 'getFollowers' then
        CB.TriggerServerCallback('phone:instagram:getData', function(data)
            cb(data)
        end, 'followers', data.data)
    elseif data.action == 'getLikes' then
        CB.TriggerServerCallback('phone:instagram:getData', function(data)
            cb(data)
        end, 'likes', data.data)
    elseif data.action == 'setLive' then
        TriggerServerEvent('phone:instagram:setLive', data)
    elseif data.action == 'goLive' then
        Animations.openCamera()
        CAMERA_MODE = 1
        CAMERA_FLIPPED = true

        TriggerServerEvent('phone:instagram:startLive', data)

        cb(true)
    elseif data.action == 'addCall' then
        TriggerServerEvent('phone:instagram:addCall', data.id)
        cb(true)
    elseif data.action == 'sendLiveMessage' then
        TriggerServerEvent('phone:instagram:sendLiveMessage', data.data)
        cb(true)
    elseif data.action == 'stopViewing' then
        TriggerServerEvent('phone:instagram:stopViewing', data.username)
        cb(true)
    elseif data.action == 'sendMessage' then
        CB.TriggerServerCallback('phone:instagram:sendMessage', function(data)
            cb(data)
        end, data.username, data.message)
    elseif data.action == 'flipCamera' then
        -- flipCamera
        cb(true)
    end
end)

RegisterNetEvent('phone:instagram:addLiveMessage', function(data)
    SendReactMessage("instagram:addMessage", data)
end)

RegisterNetEvent('phone:instagram:setLive', function(data)
    SendReactMessage("instagram:setLive", data)
end)

RegisterNetEvent('phone:instagram:updateLives', function(data)
    SendReactMessage("instagram:updateLives", data)
end)

RegisterNetEvent('phone:instagram:endLive', function(data)
    SendReactMessage("instagram:liveEnded", data)
end)

RegisterNetEvent('phone:instagram:endCall', function(data)
    SendReactMessage("instagram:endCall", data)
end)

RegisterNetEvent('phone:instagram:updateViewers', function(data)
    SendReactMessage("instagram:updateViewers", data)
end)

RegisterNetEvent('phone:instagram:updateFollowers', function(data)
    SendReactMessage("instagram:setFollowers", data)
end)

RegisterNetEvent('phone:instagram:updateFollowing', function(data)
    SendReactMessage("instagram:setFollowing", data)
end)

RegisterNetEvent('phone:instagram:updateLikes', function(data)
    SendReactMessage("instagram:setLikes", data)
end)

RegisterNetEvent('phone:instagram:newMessage', function(data)
    SendReactMessage("instagram:newMessage", data)
end)
