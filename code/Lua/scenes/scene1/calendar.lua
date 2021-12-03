local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").Calendar
local Animation = require("Lua/module/animation")

local Calendar = {}

--- @param _parent Scene
function Calendar.Get(_parent)
    local calendar =
        Interactive:new(
        "calendar",
        Resource.Calendar,
        Resource.Calendar,
        _parent,
        Vector2(190, 240),
        Vector2(-1330, 260)
    )
    local animation = Animation:new(calendar.obj, Resource.CalendarAni, 0.2)
    calendar:SetAnimation(animation)

    local bigcalendar =
        UIObject:new("biglendar", Resource.CalendarInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    bigcalendar:SetVisible(false)

    local back = UIObject:new("back", Resource.Back, bigcalendar.obj, Vector2(100, 100), Vector2(650, -350))
    back:SetVisible(true)

    back:SetClickFunc(
        function()
            bigcalendar:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    calendar:SetFunc(
        function()
            _parent:SetVisible(false)
            bigcalendar:SetVisible(true)
            if GameManager.CallFunc("GetStage") == 1 then
                GameManager.ShowTip("这个月是谁的生日吗……？", 5)
            else
                GameManager.ShowTip("每年的生日我都是在阁楼过，爸爸偶尔会上来，\n将我一次又一次往墙上推。", 5)
            end
        end
    )
    return calendar
end
return Calendar
