local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").Clock
local GameManager = require("Lua/game")

local Clock = {}

--- @param _parent Scene
function Clock.Get(_parent)
    local clock =
        Interactive:new(
        "clock",
        Resource.ClockEight,
        Resource.ClockEight,
        _parent,
        Vector2(150, 150),
        Vector2(-160, 305)
    )
    local animation = Animation:new(clock.obj, Resource.ClockEightAni, 0.3)
    clock:SetAnimation(animation)
    local text = "指针已经停止转动了。"
    GameManager.RegisterFunc(
        "SetClock",
        function()
            clock.ref = Resource.ClockThree
            clock.ref_active = Resource.ClockThree
            animation.t = Resource.ClockThreeAni
            clock:UpdateTexture(Resource.ClockThree)
            text = "和之前显示的时间不一样了……？"
        end
    )
    clock:SetFunc(
        function()
            GameManager.ShowTip(text, 5)
        end
    )
    return clock
end

return Clock
