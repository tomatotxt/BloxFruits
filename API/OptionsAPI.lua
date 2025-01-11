local API = {}

API.Options = {}

API.setOption = function(Option: string, Value: any)
    API.Options[Option] = Value
end

API.getOption = function(Option: string)
    return API.Options[Option]
end

return API