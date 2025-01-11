local API = {}

setmetatable(API, {
    __index = function(_, Index)
        local Service = nil
        local Success, Error = pcall(function()
            Service = game:GetService(Index)
        end)
        if Success then
            return game:GetService(Index)
        else
            print("ServiceAPI Error: " .. Error)
        end
    end
})

return API