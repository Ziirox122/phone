
RegisterNUICallback('Twitter', function(data, cb)
    if data.action == 'isLoggedIn' then
        CB.TriggerServerCallback('phone:twitter:isLoggedIn', function(data)
            cb(data)
        end, data)
    elseif data.action == 'login' then
        CB.TriggerServerCallback('phone:twitter:login', function(data)
            cb(data)
        end, data.data.username, data.data.password)
    elseif data.action == 'createAccount' then
        CB.TriggerServerCallback('phone:twitter:createAccount', function(data)
            cb(data)
        end, data.data.name, data.data.username, data.data.password)
    elseif data.action == 'getNotifications' then
        CB.TriggerServerCallback('phone:twitter:getNotifications', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'getProfile' then
        CB.TriggerServerCallback('phone:twitter:getProfile', function(data)
            cb(data)
        end, data.data.username)
    elseif data.action == 'signOut' then
        CB.TriggerServerCallback('phone:twitter:signOut', function(data)
            cb(data)
        end)
    elseif data.action == 'updateProfile' then
        CB.TriggerServerCallback('phone:twitter:updateProfile', function(data)
            cb(data)
        end, data.data.name, data.data.bio, data.data.profile_picture, data.data.header)
    elseif data.action == 'sendTweet' then
        CB.TriggerServerCallback('phone:twitter:sendTweet', function(data)
            cb(data)
        end, data.data.username, data.data.content, data.data.attachments, data.data.replyTo, data.data.hashtags)
    elseif data.action == 'getRecentHashtags' then
        CB.TriggerServerCallback('phone:twitter:getRecentHashtags', function(data)
            cb(data)
        end)
    elseif data.action == 'getTweets' then
        CB.TriggerServerCallback('phone:twitter:getTweets', function(data)
            cb(data)
        end, data.filter, data.page)
    elseif data.action == 'toggleNotifications' then
        CB.TriggerServerCallback('phone:twitter:toggleNotifications', function(data)
            cb(data)
        end, data.data.username, data.data.toggle)
    elseif data.action == 'searchAccounts' then
        CB.TriggerServerCallback('phone:twitter:searchAccounts', function(data)
            cb(data)
        end, data.query)
    elseif data.action == 'searchTweets' then
        CB.TriggerServerCallback('phone:twitter:searchTweets', function(data)
            cb(data)
        end, data.query, data.page)
    elseif data.action == 'getMessages' then
        CB.TriggerServerCallback('phone:twitter:getMessages', function(data)
            cb(data)
        end, data.data.username, data.data.page)
    elseif data.action == 'sendMessage' then
        CB.TriggerServerCallback('phone:twitter:sendMessage', function(data)
            cb(data)
        end, data.data.recipient, data.data.content, data.data.attachments)
    elseif data.action == 'getRecentMessages' then
        CB.TriggerServerCallback('phone:twitter:getRecentMessages', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'searchAccounts' then
        CB.TriggerServerCallback('phone:twitter:searchAccounts', function(data)
            cb(data)
        end, data.query)
    elseif data.action == 'getFollowing' then
        CB.TriggerServerCallback('phone:twitter:getData', function(data)
            cb(data)
        end, 'following', data.data.username, data.data.page)
    elseif data.action == 'getFollowers' then
        CB.TriggerServerCallback('phone:twitter:getData', function(data)
            cb(data)
        end, 'followers', data.data.username, data.data.page)
    elseif data.action == 'getLikes' then
        CB.TriggerServerCallback('phone:twitter:getData', function(data)
            cb(data)
        end, 'likes', data.data.tweet_id, data.data.page)
    elseif data.action == 'getRetweeters' then
        CB.TriggerServerCallback('phone:twitter:getData', function(data)
            cb(data)
        end, 'retweeters', data.data.tweet_id, data.data.page)
    elseif data.action == 'getTweet' then
        CB.TriggerServerCallback('phone:twitter:getTweet', function(data)
            cb(data)
        end, data.tweetId)
    elseif data.action == 'toggleRetweet' then
        CB.TriggerServerCallback('phone:twitter:toggleInteraction', function(data)
            cb(data)
        end, 'retweet', data.tweet_id, data.retweeted)
    elseif data.action == 'toggleLike' then
        CB.TriggerServerCallback('phone:twitter:toggleInteraction', function(data)
            cb(data)
        end, 'like', data.tweet_id, data.liked)
    elseif data.action == 'toggleFollow' then
        CB.TriggerServerCallback('phone:twitter:toggleInteraction', function(data)
            cb(data)
        end, 'follow', data.data.username, data.data.following)
    elseif data.action == 'deleteTweet' then
        CB.TriggerServerCallback('phone:twitter:deleteTweet', function(data)
            cb(data)
        end, data.tweet_id)
    end
end)

RegisterNetEvent('phone:twitter:setLikes', function(data)
    SendReactMessage("twitter:setLikes", data)
end)

RegisterNetEvent('phone:twitter:setReplyCount', function(data)
    SendReactMessage("twitter:setReplies", data)
end)

RegisterNetEvent('phone:twitter:setRetweets', function(data)
    SendReactMessage("twitter:setRetweets", data)
end)

RegisterNetEvent('phone:twitter:updateFollowers', function(data)
    SendReactMessage("twitter:setFollowers", data)
end)

RegisterNetEvent('phone:twitter:updateFollowing', function(data)
    SendReactMessage("twitter:setFollowing", data)
end)

RegisterNetEvent('phone:twitter:newMessage', function(data)
    SendReactMessage("twitter:newMessage", data)
end)

RegisterNetEvent('phone:twitter:newtweet', function(data)
    SendReactMessage("twitter:newTweet", data)
end)
