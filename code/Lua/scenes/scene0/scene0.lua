local Scene = require("Lua/module/scene")
local UIObject = require("Lua/module/uiObject")
local Resource = require("Lua/resource").Beginning
local Ticket = require("Lua/scenes/scene0/ticket")
local Dad = require("Lua/scenes/scene0/dad")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    --- @type Scene
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(6230, 900), Vector2(-2265, -135), Resource.BGM)
    scene.bgm.obj.Volume = 20

    scene:AddInteractive(Ticket.Get(scene))
    Dad.Get(scene)
    scene.foreground = UIObject:new("Foreground", Resource.Foreground, scene.obj, Vector2(6230, 900), Vector2(0, 0))
    scene.foreground:SetVisible(true)
    scene.foreground.obj.RaycastTarget = false
    scene.filter = UIObject:new("Filter", Resource.Filter, scene.obj, Vector2(6230, 900), Vector2(0, 0))
    scene.filter.obj.RaycastTarget = false
    scene.filter:SetVisible(true)
    return scene
end

return module
