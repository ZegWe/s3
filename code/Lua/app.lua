local App = {}

local Canvas = require("Lua/module/canvas")
local Scene = require("Lua/module/scene")

--- @type Canvas
local canvas

local function Init()
    world.CurrentCamera = world.Local.MainCamera
    canvas = Canvas:new()
    local s1 = Scene:new("s1", "Local/scene", canvas, Vector2(3000, 1000))
    s1:SetVisible(true)
end

function App:Run()
    Init()
    print("start!")
    print(canvas)
end

return App
