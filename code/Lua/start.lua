local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").Start

local Start = {}

--- @param _canvas Canvas
function Start.Get(_canvas, _scene)
    local start = UIObject:new("start", Resource.Start, _canvas.obj, Vector2(1600, 900), Vector2(0, 0))
    local animation = Animation:new(start.obj, Resource.StartAni, 0.25)
    local button = UIObject:new("startButton", Resource.Button, start.obj, Vector2(330, 100), Vector2(490, 10))
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
                    start:SetVisible(false)
                    _scene:SetVisible(true)
                    GameManager.ShowTip("按住键盘A和D控制移动", 5)
                end
            )
        end
    )

    return start
end

return Start
