local Scene = require("Lua/module/scene")
local Interactive = require("Lua/module/interactive")
local MainDoor = require("Lua/scenes/scene1/mainDoor")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    --- @type Scene
    local scene = Scene:new(_name, "Local/整体1", _parent, Vector2(3290, 900))
    scene:AddInteractive(MainDoor.Get(scene))
    return scene
end

return module
