local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").Start

local Start = {}

--- @param _canvas Canvas
function Start.Get(_canvas)
    local start = UIObject:new("start", Resource.Start, _canvas.obj, Vector2(1600, 900), Vector2(0, 0))
    local animation = Animation:new(start.obj, Resource.StartAni, 0.25)
    local button = UIObject:new("startButton", Resource.Button, start.obj, Vector2(300, 120), Vector2(490, 10))
    local buttonAnimation = Animation:new(button.obj, Resource.ButtonAni, 0.3)
    button:SetVisible(true)
    animation:Play()
    buttonAnimation:Play()
    local startAni = Animation:new(start.obj, Resource.StartGameAni, 0.3, true)

    button:SetClickFunc(
        function()
            animation:Stop()
            button:SetVisible(false)
            buttonAnimation:Stop()
            startAni:Play(
                function()
                    print("start")
                    GameManager.CallFunc(
                        "FadeOut",
                        2,
                        function()
                            start:SetVisible(false)
                            GameManager.CallFunc("FadeIn", 1)
                            GameManager.CallFunc("EnterBeginning")
                        end
                    )
                end
            )
        end
    )

    return start
end

return Start
