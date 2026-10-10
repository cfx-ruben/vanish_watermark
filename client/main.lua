local loaded = false
local enabled = true

---@param visible boolean
local function setVisibility(visible)
    SetNuiFocus(false, false)
    SendNUIMessage({
        status = visible
    })
end

local function toggleWatermark()
    enabled = not enabled
    if enabled then
        setVisibility(enabled)
    else
        setVisibility(enabled)
    end
end
CreateThread(function()
    while true do
        if IsPauseMenuActive() and enabled then
            setVisibility(false)
        else
            if enabled and not loaded then
                setVisibility(true)
            end
        end

        Wait(200)
    end
end)

lib.addKeybind({
    name = 'watermark',
    description = 'Mostrar / Ocultar marca de agua',
    defaultKey = 'TAB',
    onPressed = function() toggleWatermark() end
})
end)

exports('loadWatermark', function()
    setVisibility(enabled)
    loaded = true
end)

exports('showWatermark', function() 
    setVisibility(true)
end)

exports('hideWatermark', function() 
    setVisibility(false)
end)
