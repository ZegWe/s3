local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local GameManager = require("Lua/game")
local CalendarImage = require("Lua/resource").Calendar
local Animation = require("Lua/module/animation")

local Calendar = {}

--- @param _parent Scene
function Calendar.Get(_parent)
    local calendar =
        Interactive:new(
        "calendar",
        CalendarImage.Calendar,
        CalendarImage.Calendar,
        _parent,
        Vector2(190, 240),
        Vector2(-1330, 260)
    )
    local animation = Animation:new(calendar.obj, CalendarImage.CalendarAni, 0.2)
    calendar:SetAnimation(animation)

    local bigcalendar =
        UIObject:new("biglendar", CalendarImage.CalendarInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    bigcalendar:SetVisible(false)

    bigcalendar:SetClickFunc(
        function()
            bigcalendar:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    calendar:SetFunc(
        function()
            _parent:SetVisible(false)
            bigcalendar:SetVisible(true)
            GameManager.ShowTip("这个月是谁的生日吗……？", 5)
        end
    )
    return calendar
end
return Calendar
