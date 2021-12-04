local Interactive = require("Lua/module/interactive")
local Resource = require("Lua/resource").Cabinet
local GameManager = require("Lua/game")

local Cabinet = {}

--- @param _parent Scene
function Cabinet.Get(_parent)
    local cabinet =
        Interactive:new("cabinet", Resource.Cabinet, Resource.Cabinet, _parent, Vector2(380, 700), Vector2(-1975, -60))

    local enabled = false
    local picked = false

    GameManager.RegisterFunc(
        "cabinet",
        function(_ok)
            enabled = _ok
        end
    )

    cabinet:SetFunc(
        function()
            if not enabled or (GameManager.CallFunc("GetStage") == 3 and not GameManager.CheckMemory(2)) then
                GameManager.ShowTip("这是一条无法回头的道路。", 5)
            else
                GameManager.CallFunc("escape")
                GameManager.CallFunc(
                    "FadeOut",
                    1,
                    function()
                        GameManager.CallFunc("EnterBedRoom")
                        if not picked then
                            picked = true
                            GameManager.ShowTip("我想起了那些事情，必须画下来才行……", 5)
                        end
                        GameManager.CallFunc("FadeIn", 1)
                    end
                )
            end
        end
    )

    return cabinet
end

return Cabinet
