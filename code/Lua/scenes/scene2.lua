local Scene = require("Lua/module/scene")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, "Local/卧室五倍", _parent, Vector2(2040, 900))
    return scene
end

return module
