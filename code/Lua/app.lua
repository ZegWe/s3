local App = {}

local Canvas = require("Lua/module/canvas")
local Scene = require("Lua/module/scene")

function App:Init()
    --- Init Camera
    world.CurrentCamera = world.Local.MainCamera

    --- @type Canvas
    self.canvas = Canvas:new()

    --- @type table
    self.scenes = {}

    --- @type string
    self.currentScene = ""
end

function App:InitScene()
    local s1 = Scene:new("s1", "Local/scene", self.canvas, Vector2(3000, 1000))
    s1:SetVisible(false)
    self.scenes["s1"] = s1
end

function App:ChangeScene(_name)
    if self.currentScene ~= "" then
        self.scenes[self.currentScene]:SetVisible(false)
    end
    self.scenes[_name]:SetVisible(true)
    self.currentScene = _name
end

function App:Run()
    self:Init()
    self:InitScene()
    self:ChangeScene("s1")
    print("start!")
    print(self.canvas)
end

return App
