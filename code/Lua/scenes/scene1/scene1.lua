local Scene = require("Lua/module/scene")
local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local MainDoor = require("Lua/scenes/scene1/mainDoor")
local Mirror = require("Lua/scenes/scene1/mirror")
local Bucket = require("Lua/scenes/scene1/bucket")
local Canvas = require("Lua/scenes/scene1/canvas")
local Lock = require("Lua/scenes/scene1/lock")
local Photo = require("Lua/scenes/scene1/photo")
local Calendar = require("Lua/scenes/scene1/calendar")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    --- @type Scene
    local scene = Scene:new(_name, "Local/客厅场景/整体1", _parent, Vector2(3290, 900), Vector2(0, -150))
    -- local p1 = UIObject:new(_name.."_p1", "Local/客厅场景/整体(1", scene.obj, Vector2(2048, 900), Vector2(-621,0))
    -- p1:SetVisible(true)
    -- local p2 = UIObject:new(_name.."_p2", "Local/客厅场景/整体(2", scene.obj, Vector2(1242, 900), Vector2(1024,0))
    -- p2:SetVisible(true)

    scene:AddInteractive(MainDoor.Get(scene))
    scene:AddInteractive(Mirror.Get(scene))
    scene:AddInteractive(Bucket.Get(scene))
    scene:AddInteractive(Canvas.Get(scene))
    scene:AddInteractive(Lock.Get(scene))
    scene:AddInteractive(Photo.Get(scene))
    scene:AddInteractive(Calendar.Get(scene))
    return scene
end

return module
