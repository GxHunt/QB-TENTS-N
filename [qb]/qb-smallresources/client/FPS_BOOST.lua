

function fpson()
    SetTimecycleModifier("cinema")
end

function fpsoff()
        
    SetTimecycleModifier("default")
end

RegisterCommand('fpson', function()
    fpson()
end)

RegisterCommand('fpsoff', function()
    fpsoff()
end)