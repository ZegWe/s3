local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").Easel

local Easel = {}

--- @param _parent Scene
function Easel.Get(_parent)
    local easel = Interactive:new("Easel", Resource.Easel, Resource.Easel, _parent, Vector2(330, 620), Vector2(1390, -100))
    local animation = Animation:new(easel.obj, Resource.EaselAni, 0.3)
    easel:SetAnimation(animation)

    return easel
end

return Easel