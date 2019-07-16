local function debugpls()
    local level = 0
    local dbg
    while true do
        dbg = debugGetInfo(level, 'S')
        if not dbg then break end

        print(level, " = ", dbg.short_src)

        level = level + 1
    end
end

-- gets the file that actually made the call
-- it's usually #5, but if you call a file that calls the function, it's 6 or more
local function getCallingFile()
    local level = 5
    local dbg
    while true do
        local newDbg = debugGetInfo(level, 'S')
        if not newDbg then break end
        if newDbg.short_src == "[C]" then break end

        dbg = newDbg
        level = level + 1
    end

    local path = dbg.short_src
    path = string.replace(path, "SF:", "")
    return path
end

local function getCurrentDir()
    --debugpls()

    local path = getCallingFile()
    local explodedPath = string.explode("/", path)
    table.remove(explodedPath)
    path = table.concat(explodedPath, "/")
    
    return path
end

local function doDir(path)
    return dodir(getCurrentDir() .. "/" .. path)
end

util = {
    getCallingFile = getCallingFile,
    getCurrentDir = getCurrentDir,
    dodir = doDir
}