RegisterNUICallback("Wallet", function(data, cb)
    local action = data.action
    if action == "getData" then
        CB.TriggerServerCallback("phone:wallet:getData", cb)
    elseif action == "doesNumberExist" then
        CB.TriggerServerCallback("phone:wallet:doesNumberExist", cb, data.number)
    elseif action == "sendPayment" then
        CB.TriggerServerCallback("phone:wallet:sendPayment", cb, {
            amount = data.amount,
            phoneNumber = data.number
        })
    end
end)

RegisterNetEvent("fb:bankaccount:updateTransactions", function()
    -- TODO
end)