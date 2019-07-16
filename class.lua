local function appendfenv(func, appends)
    local env = table.copy(getfenv())
    for k, v in pairs(appends) do env[k] = v end
    setfenv(func, env)
end

function class(name, setAttrs)
    if _G[name] then
        error("Unable to create class `" .. name .. "`: name conflict")
    end

    local klass = local_class(name, setAttrs)

    _G[name] = klass
end

function local_class(name, setAttrs)
    local klassAttrs, instanceAttrs, extendedClass = {}, {}, nil
    appendfenv(setAttrs, {
        extend = function(class)
            extendedClass = class
        end
    })
    setAttrs(klassAttrs, instanceAttrs)

    local klass = {}
    klass.name = name
    klass.new = function(...)
        local obj = {}
        if extendedClass then
            obj = extendedClass.new(...)
        end

        for attr, val in pairs(instanceAttrs) do
            obj[attr] = val
        end

        obj.class = klass

        if klassAttrs.new then
            klassAttrs.new(obj, ...)
        end

        return obj
    end

    local restrictedKlassAttrs = table.copy(klassAttrs)
    restrictedKlassAttrs.name = nil
    restrictedKlassAttrs.new = nil
    for attr, val in pairs(restrictedKlassAttrs) do
        klass[attr] = val
    end

    return klass
end