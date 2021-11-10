local App = {}

local Canvas = require("Lua/module/canvas")
local Scene = require("Lua/module/scene")
local Player = require("Lua/module/player")

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
    local s2 = Scene:new("s2", "Local/scene2", self.canvas, Vector2(3000, 1000))
    self.scenes["s1"] = s1
    self.scenes["s2"] = s2
end

function App:InitPlayer()
    self.player = Player:new(self.canvas)
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
    self:InitPlayer()
    print("start!")
    self:ChangeScene("s1")
    self.scenes["s1"].obj.Offset = Vector2(-500, 0)
    self.player:EnterScene(self.scenes["s1"])
    wait(2)
    self:ChangeScene("s2")
    self.player:EnterScene(self.scenes["s2"])
end

return App
