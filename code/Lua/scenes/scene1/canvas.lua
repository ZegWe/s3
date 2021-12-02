local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local CanvasImage = require("Lua/resource").Canvas
local GameManager = require("Lua/game")

local Canvas = {}

--- @param _parent Scene
function Canvas.Get(_parent)
    local canvas = Interactive:new("Canvas", "", CanvasImage.Canvas, _parent, Vector2(520, 570), Vector2(445, -105))
    local animation = Animation:new(canvas.obj, CanvasImage.CanvasAni, 0.2)
    canvas:SetAnimation(animation)
    canvas:SetFunc(function()
        GameManager.GetCanvas(canvas, _parent)
        GameManager.ShowTip("拿到了【空画布】", 5)
    end)
    return canvas
end
return Canvas
