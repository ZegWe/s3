local App = {}

local Canvas = require("Lua/module/canvas")
local Player = require("Lua/module/player")
local scene1 = require("Lua/scenes/scene1/scene1")
local scene2 = require("Lua/scenes/scene2")

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
    local s1 = scene1:Get("s1", self.canvas)
    local s2 = scene2:Get("s2", self.canvas)
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
    self.player:EnterScene(self.scenes["s1"], Vector2(500, -120))
    self.player.controlEnabled = true
    -- wait(2)
    -- self:ChangeScene("s2")
    -- self.player:EnterScene(self.scenes["s2"])
end

return App
