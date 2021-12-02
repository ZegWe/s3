local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local UIObject = require("Lua/module/uiObject")
local DrawImage = require("Lua/resource").Draw
local GameManager = require("Lua/game")

local Draw = {}

--- @param _parent Scene
function Draw.Get(_parent)
    local draw = Interactive:new("Draw", DrawImage.Draw, DrawImage.Draw, _parent, Vector2(100, 140), Vector2(525, -20))

    local animation = Animation:new(draw.obj, DrawImage.DrawAni, 0.3)
    draw:SetAnimation(animation)

    --- @type UIObject
    local drawInfo = UIObject:new("Draw", DrawImage.DrawInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)

    draw:SetFunc(
        function()
            _parent:SetVisible(false)
            drawInfo:SetVisible(true)
            GameManager.ShowTip("看起来已经很久了的涂鸦，这房子有些年头了……", 5)
        end
    )

    drawInfo:SetClickFunc(
        function()
            drawInfo:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    draw:SetVisible(false)
    GameManager.SetDraw(draw)
    return draw
end
return Draw
