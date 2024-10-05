local allowZone = 0.02

CreateThread(function()
    while true do
        if IS_PHONE_OPEN then
            local x, y = GetNuiCursorPosition()
            local maxX, maxY = GetActiveScreenResolution()

            x = x / maxX
            y = y / maxY

            DisableControlAction(0, 0, true)    -- Next Camera
            if x < (1 - allowZone) and x > allowZone and y < (1 - allowZone) and y > allowZone and TOGGLE_INPUT then
                DisableControlAction(0, 1, true)    -- Look Left/Right
                DisableControlAction(0, 2, true)    -- Look up/Down
            end
            DisableControlAction(0, 16, true)   -- Next Weapon
            DisableControlAction(0, 17, true)   -- Select Previous Weapon
            DisableControlAction(0, 22, true)   -- Jump
            DisableControlAction(0, 24, true)   -- Attack
            DisableControlAction(0, 25, true)   -- Aim
            DisableControlAction(0, 26, true)   -- Look Behind
            DisableControlAction(0, 36, true)   -- Input Duck/Sneak
            DisableControlAction(0, 37, true)   -- Weapon Wheel
            DisableControlAction(0, 44, true)   -- Cover
            DisableControlAction(0, 47, true)   -- Detonate
            DisableControlAction(0, 50, true)   -- Dive
            DisableControlAction(0, 55, true)   -- Dive
            DisableControlAction(0, 68, true)   -- Dive
            DisableControlAction(0, 69, true)   -- Dive
            DisableControlAction(0, 70, true)   -- Dive
            DisableControlAction(0, 75, true)   -- Exit Vehicle
            DisableControlAction(0, 76, true)   -- Vehicle Handbrake
            DisableControlAction(0, 81, true)   -- Next Radio (Vehicle)
            DisableControlAction(0, 82, true)   -- Previous Radio (Vehicle)
            DisableControlAction(0, 91, true)   -- Passenger Aim (Vehicle)
            DisableControlAction(0, 92, true)   -- Passenger Attack (Vehicle)
            DisableControlAction(0, 99, true)   -- Select Next Weapon (Vehicle)
            DisableControlAction(0, 106, true)  -- Control Override (Vehicle)
            DisableControlAction(0, 114, true)  -- Fly Attack (Flying)
            DisableControlAction(0, 115, true)  -- Next Weapon (Flying)
            DisableControlAction(0, 121, true)  -- Fly Camera (Flying)
            DisableControlAction(0, 122, true)  -- Control OVerride (Flying)
            DisableControlAction(0, 135, true)  -- Control OVerride (Sub)
            DisableControlAction(0, 140, true)  -- Melee attack light
            DisableControlAction(0, 141, true)  -- Melee attack light
            DisableControlAction(0, 142, true)  -- Melee attack light
            DisableControlAction(0, 199, true)  -- Pause Menu
            DisableControlAction(0, 200, true)  -- Pause Menu
            DisableControlAction(0, 245, true)  -- Chat
            DisableControlAction(0, 257, true)  -- Chat
            DisableControlAction(0, 263, true)  -- Chat
            DisableControlAction(0, 264, true)  -- Chat
        else
            Wait(100)
        end
        Wait(0)
    end
end)

-- Handles pause menu state
CreateThread(function()
    while true do
        Wait(500)

        local isPauseOpen = IsPauseMenuActive() ~= false
        -- Handle if the phone is already visible and escape menu is opened
        if isPauseOpen and IS_PHONE_OPEN then
            exports[GetCurrentResourceName()]:ToggleDisabled()
        end
    end
end)

local keepInput = nil
RegisterNUICallback('toggleInput', function(data, cb)
    if not IS_PHONE_OPEN then return end
    keepInput = not data
    repeat Wait(0) until IsDisabledControlReleased(0, 25) and IsDisabledControlReleased(0, 24)
    SetNuiFocusKeepInput(keepInput)
    cb('ok')
end)

RegisterKeyMapping('+use_togglephonefocus_key', 'Activer le curseur', 'keyboard', 'LMENU')

RegisterCommand('-use_togglephonefocus_key', function() end)
RegisterCommand('+use_togglephonefocus_key', function()
    if not IS_PHONE_OPEN then return end
    TOGGLE_INPUT = not TOGGLE_INPUT
    SetNuiFocus(true, TOGGLE_INPUT)
end)