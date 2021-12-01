local Scene = require("Lua/module/scene")
local Resource = require("Lua/resource").Beginning
local Ticket = require("Lua/scenes/scene0/ticket")
local Dad = require("Lua/scenes/scene0/dad")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    --- @type Scene
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(6230, 900), Vector2(-2265, -115), Resource.BGM)

    scene:AddInteractive(Ticket.Get(scene))
    Dad.Get(scene)
    return scene
end

return module
