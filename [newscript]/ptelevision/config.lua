Config = {}

Config.Models = { -- Any TV Models used on the map or in locations must be defined here.
    [`prop_tv_flat_01`] = {
        DefaultVolume = 0.5,
        Range = 20.0,
        Target = "tvscreen", -- Only use if prop has render-target name.
        Scale = 0.085, 
        Offset = vector3(-1.02, -0.055, 1.04)
    }
}

Config.Locations = { -- REMOVE ALL IF NOT USING ONESYNC, OR IT SHALL BREAK.
    {
        Model = `prop_tv_flat_01`,
        Position = vector4(-1214.26, -1538.24, 7.91, 327.85),
    },
}

Config.Channels = { -- These channels are default channels and cannot be overriden.
    {name = "Pickle Mods", url = "twitch.tv/picklemods"},
}

Config.BannedWords = {
    "google",
}

Config.Events = { -- Events for approving broadcasts / interactions (due to popular demand).
    ScreenInteract = function(source, data, key, value, cb) -- cb() to approve. 
        if value.url then 
            for i=1, #Config.BannedWords do 
                if string.find(value.url, Config.BannedWords[i]) then 
                    return
                end
            end
        end
        cb()
    end,    
    Broadcast = function(source, data, cb)  -- cb() to approve. 
        cb()
    end,
}
