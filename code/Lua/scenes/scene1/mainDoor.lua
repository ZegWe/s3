local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")

--- 正门
local MainDoor = {}

function MainDoor.Get(_parent)
    --- @type Interactive
    local door =
        Interactive:new("MainDoor", "Local/大门/大", "Local/大门/大门", _parent, Vector2(420, 720), Vector2(1300, -30), nil)
    local animation =
        Animation:new(
        door.obj,
        {
            "Local/大门/大门1",
            "Local/大门/大门2",
            "Local/大门/大门3",
            "Local/大门/大门4"
        },
        0.4
    )
    door:SetFunc(
        function()
            print("shake")
            animation:Play()
            wait(1.5)
            animation:Stop()
        end
    )
    return door
end

return MainDoor
