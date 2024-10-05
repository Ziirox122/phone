CAMERA_MODE = nil
CAMERA_FLIPPED = false

local displayHud = false
local recording = false

RegisterNUICallback('Camera', function(data, cb)
    if data.action == 'getLastImage' then
        CB.TriggerServerCallback('phone:camera:getLastImage', function(link)
            cb(link)
        end)
    elseif data.action == 'getUploadApi' then
        CB.TriggerServerCallback('phone:camera:getUploadApi', function(link)
            cb(link)
        end, data.uploadType)
    elseif data.action == 'setRecord' then
        if recording and data.recording then return end
        recording = data.recording
        CreateThread(function()
            while recording do
                BeginTextCommandDisplayHelp('AUDIO_RECORDING')
                EndTextCommandDisplayHelp(0, false, false, 1)
                Wait(0)
            end
            ClearHelp(true)
        end)
    elseif data.action == 'deleteFromGallery' then
        CB.TriggerServerCallback('phone:camera:deleteFromGallery', function(numberOfLineDeleted)
            cb(numberOfLineDeleted)
        end, type(data.links) == 'table' and data.links or {data.links})
    elseif data.action == 'getImages' then
        CB.TriggerServerCallback('phone:camera:getImages', function(images)
            cb(images)
        end, data.filter, data.page)
    elseif data.action == 'flipCamera' then
        CAMERA_FLIPPED = data.value
        cb(true)
    elseif data.action == 'toggleLandscape' then
        cb(true)
    elseif data.action == 'toggleVideo' then
        cb(true)
    elseif data.action == 'saveToGallery' then
        CB.TriggerServerCallback('phone:camera:saveToGallery', function(returnedData)
            cb(returnedData)
        end, data.link, data.size, (data.isVideo ~= nil) or false)
    elseif data.action == 'toggleHud' then
        displayHud = not data.toggled
        exports.fb_ui:tmpHideHud(displayHud)
        cb(true)
    elseif data.action == 'open' then
        CAMERA_MODE = 0
        Animations.openCamera()
        cb(true)
    elseif data.action == 'close' then
        CAMERA_MODE = nil
        Animations.closeCamera()
        cb(true)
    end
end)

RegisterKeyMapping('+use_takephoto_key', 'Prendre une photo/vidéo', 'keyboard', 'RETURN')

RegisterCommand('-use_takephoto_key', function() end)
RegisterCommand('+use_takephoto_key', function()
    if not IS_PHONE_OPEN then return end
    SendReactMessage('camera:usedCommand', 'toggleTaking')
end)

RegisterKeyMapping('+use_flipcam_key', 'Flip la caméra', 'keyboard', 'UP')

RegisterCommand('-use_flipcam_key', function() end)
RegisterCommand('+use_flipcam_key', function()
    CAMERA_FLIPPED = not CAMERA_FLIPPED
    SendReactMessage('camera:usedCommand', 'toggleFlip')
end)

RegisterKeyMapping('+use_togglecameraflash_key', 'Activer le flash', 'keyboard', 'E')

RegisterCommand('-use_togglecameraflash_key', function() end)
RegisterCommand('+use_togglecameraflash_key', function()
    SendReactMessage('camera:usedCommand', 'toggleFlash')
end)

RegisterKeyMapping('+use_rightmode_key', 'Changer de mode', 'keyboard', 'RIGHT')
RegisterKeyMapping('+use_leftmode_key', 'Changer de mode', 'keyboard', 'LEFT')

RegisterCommand('-use_rightmode_key', function() end)
RegisterCommand('+use_rightmode_key', function()
    SendReactMessage('camera:usedCommand', 'rightMode')
end)

RegisterCommand('-use_leftmode_key', function() end)
RegisterCommand('+use_leftmode_key', function()
    SendReactMessage('camera:usedCommand', 'leftMode')
end)

RegisterKeyMapping('+allow_movement', 'Autoriser le mouvement', 'keyboard', 'SPACE')
RegisterCommand('-allow_movement', function() end)
RegisterCommand('+allow_movement', function()
    if CAMERA_MODE == nil then return end

    CAMERA_MODE += 1
    if CAMERA_MODE > 1 then CAMERA_MODE = 0 end
end)

CreateThread(function()
    DestroyMobilePhone()
    CellCamActivate(false, false)

    AddTextEntry('CAMERA_TIP2', 'Appuyez sur ~INPUT_5FB6A681~ pour prendre une photo\n' ..
'Appuyez sur ~INPUT_A7F7209D~ pour retourner la caméra\n' ..
'Appuyez sur ~INPUT_E77500AA~ pour activer le flash\n' ..
'Appuyez sur ~INPUT_9160BB8D~ pour activer le curseur et se tourner\n' ..
'Appuyez sur ~INPUT_8C260CB0~ pour activer le mouvement\n' ..
'Appuyez sur ~INPUT_AEA22233~ ~INPUT_81068F0A~ pour changer le mode de caméra')

AddTextEntry('AUDIO_RECORDING', '~r~N\'oubliez pas d\'appuyer sur ~INPUT_PUSH_TO_TALK~ pour parler pendant l\'enregistrement !')

    local cam = nil
    local lastMode = -1
    local lastFlipped = false
    local followPed = nil
    local followVehicle = nil

    while true do
        if CAMERA_MODE ~= nil then
            if lastMode ~= CAMERA_MODE or lastFlipped ~= CAMERA_FLIPPED then
                if CAMERA_MODE == 0 then
                    if cam then
                        exports.fb:DestroyCam(cam, true)
                        RenderScriptCams(false, 0, 0, 0, 0)
                        cam = nil
                    end

                    Animations.normalCamera()
                    CreateMobilePhone(1)
                    CellCamActivate(true, true)
                    Citizen.InvokeNative(0x2491A93618B7D838, CAMERA_FLIPPED)
                elseif CAMERA_MODE == 1 then
                    Animations.freeroamCamera()
                    DestroyMobilePhone()
                    CellCamActivate(false, false)

                    if followPed == nil then
                        followPed = GetFollowPedCamViewMode()
                        followVehicle = GetFollowVehicleCamViewMode()
                    end

                    if CAMERA_FLIPPED then
                        if not cam then
                            cam = exports.fb:CreateCam('DEFAULT_SCRIPTED_CAMERA')
                        end
                        SetCamFov(cam, 60.0)
                        AttachCamToPedBone_2(cam, PlayerPedId(), 28422, 5.0, -15.0, 180.0, 0.0, 0.0, 0.0, false)
                        SetCamActive(cam, true)
                        RenderScriptCams(true, 0, 0, 0, 0)

                        SetFollowPedCamViewMode(0)
                        SetFollowVehicleCamViewMode(0)
                    else
                        if cam then
                            exports.fb:DestroyCam(cam)
                            RenderScriptCams(false, 0, 0, 0, 0)
                            cam = nil
                        end

                        SetFollowPedCamViewMode(3)
                        SetFollowVehicleCamViewMode(4)
                    end
                else
                    CAMERA_MODE = 0
                end

                lastMode = CAMERA_MODE
                lastFlipped = CAMERA_FLIPPED
            end

            if not displayHud then
                BeginTextCommandDisplayHelp('CAMERA_TIP2')
                EndTextCommandDisplayHelp(0, false, false, 1)
            end
        end

        if CAMERA_MODE == 1 then
            if CAMERA_FLIPPED then
                SetGameplayCamRelativeHeading(0)
                SetGameplayCamRelativeRotation(0, 0, 0)
            end

            DisableControlAction(0, 0, true)
        end

        if CAMERA_MODE == nil and lastMode ~= -1 then
            lastMode = -1
            SetFollowPedCamViewMode(followPed)
            SetFollowVehicleCamViewMode(followVehicle)
            followPed = nil
            followVehicle = nil

            if cam then
                exports.fb:DestroyCam(cam)
                RenderScriptCams(false, 0, 0, 0, 0)
                cam = nil
            end

            DestroyMobilePhone()
            CellCamActivate(false, false)
        end

        Wait(0)
    end
end)