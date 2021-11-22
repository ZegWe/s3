local Scene = require("Lua/module/scene")
local RoomImage = require("Lua/resource").BedRoom

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, RoomImage.Background, _parent, Vector2(3290, 900), Vector2(-750, -150), RoomImage.BGM)
    return scene
end

return module
