local Scene = require("Lua/module/scene")
local Hanger = require("Lua/scenes/scene3/hanger")
local Loft = require("Lua/scenes/scene3/loft")
local Lofteasal = require("Lua/scenes/scene3/lofteasal")
local Resource = require("Lua/resource").Loft
local Toy = require("Lua/scenes/scene3/toy")
local Dad = require("Lua/scenes/scene3/dad")
local Cabinet = require("Lua/scenes/scene3/cabinet")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(5070, 900), Vector2(-1900, -115), Resource.BGM)

    scene:AddInteractive(Hanger.Get(scene))
    -- scene:AddInteractive(Loft.Get(scene))
    scene:AddInteractive(Lofteasal.Get(scene))
    scene:AddInteractive(Toy.Get(scene))
    scene:AddInteractive(Dad.Get(scene))
    scene:AddInteractive(Cabinet.Get(scene))
    return scene
end

return module
