local Interactive = require("Lua/module/interactive")
local Resource = require("Lua/resource").Clock
local GameManager = require("Lua/game")

local Clock = {}

--- @param _parent Scene
function Clock.Get(_parent)
    local clock = Interactive:new("clock", Resource.ClockEight, Resource.ClockEight, _parent, Vector2(520, 570), Vector2(445, 205))
    local text = "指针已经停止转动了。"
    GameManager.RegisterFunc("SetClock", function()
        clock.ref = Resource.ClockThree
        clock.ref_active = Resource.ClockThree
        text = "和之前显示的时间不一样了……？"
    end)
    clock:SetFunc(
        function()
            _parent:Tip(text, 5)
        end
    )
    return clock
end

return Clock
