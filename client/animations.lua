Animations = {}

AnimationState = {
    ON_CALL = 1,
    PHONE_OPEN = 2,
    ON_CAMERA = 3,
    CAMERA_FREEROAMING = 4,
}

local animationInterval
local onCall = false
local phoneOpen = false
local onCamera = false
local freeroaming = false

local characterId = LocalPlayer.state.characterId or 0

AddStateBagChangeHandler('characterId', 'player:' .. GetPlayerServerId(PlayerId()), function(_, _, _characterId)
	characterId = _characterId
end)

local function newPhoneProp()
    exports.fb:addLocalAttachEntity(PlayerPedId(), 'phone', {
        model = characterId == 4208 and 'prop_cs_tablet' or 'prop_amb_phone',
        pedBoneIndex = 28422,
    })
end

local function removePhoneProp()
    exports.fb:removeLocalAttachEntity(PlayerPedId(), 'phone')
end

local function handleOpenVehicleAnim(playerPed)
    local dict = 'anim@cellphone@in_car@ps'
    local anim = 'cellphone_text_in'
    FB.Streaming.RequestAnimDict(dict)

    if not IsEntityPlayingAnim(playerPed, dict, anim, 3) then
        TaskPlayAnim(playerPed, dict, anim, 7.0, -1, -1, 50, 0, false, false, false)
    end
end

local function handleOpenNormalAnim(playerPed)
    local dict = characterId == 4208 and 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a' or 'cellphone@'
    local anim = characterId == 4208 and 'idle_a' or 'cellphone_text_in'
    FB.Streaming.RequestAnimDict(dict)

    if not IsEntityPlayingAnim(playerPed, dict, anim, 3) then
        TaskPlayAnim(playerPed, dict, anim, 8.0, -1, -1, 50, 0, false, false, false)
    end
end

local function handleCloseVehicleAnim(playerPed)
    local DICT = 'anim@cellphone@in_car@ps';
    StopAnimTask(playerPed, DICT, 'cellphone_text_in', 1.0)
    StopAnimTask(playerPed, DICT, 'cellphone_call_to_text', 1.0)
    removePhoneProp()
end

local function handleCloseNormalAnim(playerPed)
    local DICT = 'cellphone@';
    local ANIM = 'cellphone_text_out';
    StopAnimTask(playerPed, DICT, 'cellphone_text_in', 1.0)
    Wait(100)
    FB.Streaming.RequestAnimDict(DICT)
    TaskPlayAnim(playerPed, DICT, ANIM, 7.0, -1, -1, 50, 0, false, false, false)
    Wait(200)
    StopAnimTask(playerPed, DICT, ANIM, 1.0)
    removePhoneProp()
end

local function handleOnCallInVehicle(playerPed)
    local DICT = 'anim@cellphone@in_car@ps';
    local ANIM = 'cellphone_call_listen_base';

    if not IsEntityPlayingAnim(playerPed, DICT, ANIM, 3) then
        FB.Streaming.RequestAnimDict(DICT)
        TaskPlayAnim(playerPed, DICT, ANIM, 3.0, 3.0, -1, 49, 0, false, false, false)
    end
end

local function handleOnCallNormal(playerPed)
    local DICT = 'cellphone@';
    local ANIM = 'cellphone_call_listen_base';
    if not IsEntityPlayingAnim(playerPed, DICT, ANIM, 3) then
        FB.Streaming.RequestAnimDict(DICT)
        TaskPlayAnim(playerPed, DICT, ANIM, 3.0, 3.0, -1, 49, 0, false, false, false)
    end
end

local function handleCallEndVehicleAnim(playerPed)
    local DICT = 'anim@cellphone@in_car@ps'
    local ANIM = 'cellphone_call_to_text'
    StopAnimTask(playerPed, DICT, 'cellphone_call_listen_base', 1.0)
    FB.Streaming.RequestAnimDict(DICT)
    TaskPlayAnim(playerPed, DICT, ANIM, 1.3, 5.0, -1, 50, 0, false, false, false)
end

local function handleCallEndNormalAnim(playerPed)
    local DICT = 'cellphone@';
    local ANIM = 'cellphone_call_to_text';

    if IsEntityPlayingAnim(playerPed, 'cellphone@', 'cellphone_call_listen_base', 49) then
        FB.Streaming.RequestAnimDict(DICT)
        TaskPlayAnim(playerPed, DICT, ANIM, 2.5, 8.0, -1, 50, 0, false, false, false)
    end
end

local function handleCallAnimation(playerPed)
    if IsPedInAnyVehicle(playerPed, true) then
        handleOnCallInVehicle(playerPed)
    else
        handleOnCallNormal(playerPed)
    end
end

local function handleOpenAnimation(playerPed)
    if IsPedInAnyVehicle(playerPed, true) then
        handleOpenVehicleAnim(playerPed)
    else
        handleOpenNormalAnim(playerPed)
    end
end

local function handleSelfieAnimation(playerPed)
    local DICT = 'cellphone@self';
    local ANIM = 'selfie';

    if not IsEntityPlayingAnim(playerPed, DICT, ANIM, 49) then
        FB.Streaming.RequestAnimDict(DICT)
        TaskPlayAnim(playerPed, DICT, ANIM, 9999999.0, 9999999.0, -1, 50, 0, false, false, false)
    end
end

local function createAnimationInterval()
    CreateThread(function()
        animationInterval = true
        while animationInterval do
            local playerPed = PlayerPedId()

            if onCamera then
                if freeroaming then
                    handleSelfieAnimation(playerPed)
                else
                    -- Don't do animation in normal mode
                end
            elseif onCall then
                handleCallAnimation(playerPed)
            elseif phoneOpen and not onCamera then
                handleOpenAnimation(playerPed)
            end
            Wait(250)
        end
    end)
end

local function setPhoneState(state, stateValue)
    if state == AnimationState.ON_CALL then
        onCall = stateValue
    elseif state == AnimationState.PHONE_OPEN then
        phoneOpen = stateValue
    elseif state == AnimationState.ON_CAMERA then
        onCamera = stateValue
    elseif state == AnimationState.CAMERA_FREEROAMING then
        freeroaming = stateValue
    end

    if not onCall and not phoneOpen then
        if animationInterval then
            animationInterval = nil
        end
    end

    if (onCall or phoneOpen) and not animationInterval then
        createAnimationInterval()
    end
end

local function handleCallEndAnimation(playerPed)
    if IsPedInAnyVehicle(playerPed, true) then
        handleCallEndVehicleAnim(playerPed)
    else
        handleCallEndNormalAnim(playerPed)
    end
end

local function handleCloseAnimation(playerPed)
    if IsPedInAnyVehicle(playerPed, true) then
        handleCloseVehicleAnim(playerPed)
    else
        handleCloseNormalAnim(playerPed)
    end
end

Animations.openPhone = function()
    newPhoneProp()
    if not onCall then
        handleOpenAnimation(PlayerPedId())
    end
    setPhoneState(AnimationState.PHONE_OPEN, true)
end

Animations.closePhone = function()
    setPhoneState(AnimationState.PHONE_OPEN, false)
    if not onCall then
        handleCloseAnimation(PlayerPedId())
    end
end

Animations.startPhoneCall = function()
    handleCallAnimation(PlayerPedId())
    setPhoneState(AnimationState.ON_CALL, true)
end

Animations.endPhoneCall = function()
    if phoneOpen then
        handleCallEndAnimation(PlayerPedId())
    end
    setPhoneState(AnimationState.ON_CALL, false)
end

Animations.openCamera = function()
    setPhoneState(AnimationState.ON_CAMERA, true)
end

Animations.closeCamera = function()
    setPhoneState(AnimationState.ON_CAMERA, false)
end

Animations.freeroamCamera = function()
    setPhoneState(AnimationState.CAMERA_FREEROAMING, true)
end

Animations.normalCamera = function()
    setPhoneState(AnimationState.CAMERA_FREEROAMING, false)
end