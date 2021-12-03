local Scene = require("Lua/module/scene")
local UIObject = require("Lua/module/uiObject")
local RoomDoor = require("Lua/scenes/scene2/roomDoor")
local Table = require("Lua/scenes/scene2/table")
local Easel = require("Lua/scenes/scene2/easel")
local Wardrobe = require("Lua/scenes/scene2/wardrobe")
local Clock = require("Lua/scenes/scene2/clock")
local Resource = require("Lua/resource").BedRoom
local Drawer = require("Lua/scenes/scene2/drawer")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(3290, 900), Vector2(-750, -150), Resource.BGM)

    scene:AddInteractive(RoomDoor.Get(scene))
    scene:AddInteractive(Table.Get(scene))
    scene:AddInteractive(Easel.Get(scene))
    scene:AddInteractive(Drawer.Get(scene))
    scene:AddInteractive(Wardrobe.Get(scene))
    scene:AddInteractive(Clock.Get(scene))

    scene.foreground = UIObject:new("foreground", Resource.Foreground, scene.obj, Vector2(3290, 900), Vector2(0, 0))
    scene.foreground:SetVisible(true)
    scene.foreground.obj.RaycastTarget = false
    return scene
end

return module
