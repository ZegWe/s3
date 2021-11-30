local Interactive = require("Lua/module/interactive")
local Resource = require("Lua/resource").Cabinet
local GameManager = require("Lua/game")

local Cabinet = {}

--- @param _parent Scene
function Cabinet.Get(_parent)
    local cabinet =
        Interactive:new("cabinet", Resource.Cabinet, Resource.Cabinet, _parent, Vector2(200, 400), Vector2(-2000, 0))

    local enabled = false

    GameManager.RegisterFunc(
        "cabinet",
        function()
            enabled = true
        end
    )

    cabinet:SetFunc(
        function()
            if enabled then
                GameManager.CallFunc("EnterBedRoom")
                GameManager.PickMemory(1)
                GameManager.CallFunc("escape")
            else
                _parent:Tip("这是一条无法回头的道路。", 5)
            end
        end
    )

    return cabinet
end

return Cabinet
