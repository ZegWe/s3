local Scene = require("Lua/module/scene")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, "Local/scene2", _parent, Vector2(3000, 1000))
    return scene
end

return module
