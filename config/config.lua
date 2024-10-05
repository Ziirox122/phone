Config = {}

Config.Companies = {}
Config.Companies.Enabled = true -- allow players to call companies?
Config.Companies.Services = {}

Config.Locales = { -- languages that the player can choose from when setting up a phone [Check the docs to see which languages the phone supports]
    {
        locale = "fr",
        name = "Français"
    },
    {
        locale = "en",
        name = "English"
    },
    {
        locale = "es",
        name = "Español"
    },
}

Config.locations = {}

Config.CurrencyFormat = "$%s" -- ($100) Choose the formatting of the currency. %s will be replaced with the amount.

Config.CityName = "Los Santos" -- The name that's being used in the weather app etc.

Config.EmailDomain = "gmail.fb"

Config.AllowExternal = true -- allow people to upload external images? (note: this means they can upload nsfw / gore etc)

Config.Post = {} -- What apps should send posts to discord? You can set your webhooks in server/webhooks.lua
Config.Post.Twitter = true -- New tweets
Config.Post.Instagram = true -- New posts

Config.KeyBinds = {
    -- Find keybinds here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    Open = { -- toggle the phone
        Command = "phone",
        Bind = "K",
        Description = "Ouvrir le téléphone"
    },
    Focus = { -- keybind to toggle the mouse cursor.
        Command = "togglePhoneFocus",
        Bind = "LMENU",
        Description = "Activer le curseur"
    },
    StopSounds = { -- in case the sound would bug out, you can use this command to stop all sounds.
        Command = "stopSounds",
        Bind = false,
        Description = "Arrêter tous les sons"
    },

    FlipCamera = {
        Command = "flipCam",
        Bind = "UP",
        Description = "Flip la caméra"
    },
    TakePhoto = {
        Command = "takePhoto",
        Bind = "RETURN",
        Description = "Prendre une photo/vidéo"
    },
    ToggleFlash = {
        Command = "toggleCameraFlash",
        Bind = "E",
        Description = "Activer le flash"
    },
    LeftMode = {
        Command = "leftMode",
        Bind = "LEFT",
        Description = "Changer de mode"
    },
    RightMode = {
        Command = "rightMode",
        Bind = "RIGHT",
        Description = "Changer de mode"
    },

    AnswerCall = {
        Command = "answerCall",
        Bind = "RETURN",
        Description = "Accepter une appel"
    },
    DeclineCall = {
        Command = "declineCall",
        Bind = "BACK",
        Description = "Refuser l'appel"
    },
}

--[[ PHOTO / VIDEO OPTIONS ]]--
-- Set your api keys in fb-phone/server/apiKeys.lua
Config.UploadMethod = {}
Config.UploadMethod.Video = "Imgur" --[[
    What API should be used to upload videos?
    Options: "Discord" or "Imgur"
]]
Config.UploadMethod.Image = "Imgur" --[[
    What API should be used to upload images?
    Options: "Discord" or "Imgur"
]]
Config.UploadMethod.Audio = "Discord" --[[
    What API should be used to upload audio?
    Options: "Discord"
]]