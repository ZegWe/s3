local App = {}

local Canvas = require("Lua/module/canvas")
local Player = require("Lua/module/player")
local GameManager = require("Lua/game")
local scene0 = require("Lua/scenes/scene0/scene0")
local scene1 = require("Lua/scenes/scene1/scene1")
local scene2 = require("Lua/scenes/scene2/scene2")
local scene3 = require("Lua/scenes/scene3/scene3")
local scene4 = require("Lua/scenes/scene4/scene4")

local start = require("Lua/start")

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
    local s0 = scene0:Get("s0", self.canvas)
    local s1 = scene1:Get("s1", self.canvas)
    local s2 = scene2:Get("s2", self.canvas)
    local s3 = scene3:Get("s3", self.canvas)
    local s4 = scene4:Get("s4", self.canvas)

    self.scenes["s0"] = s0
    self.scenes["s1"] = s1
    self.scenes["s2"] = s2
    self.scenes["s3"] = s3
    self.scenes["s4"] = s4

    GameManager.RegisterFunc(
        "EnterBeginning",
        function()
            self:ChangeScene("s0")
            s0:Tip("按住键盘A和D控制移动", 5)
            wait(5)
            s0:Tip("鼠标左键点击发光物体与之交互", 5)
        end
    )

    GameManager.RegisterFunc(
        "EnterLivingRoom",
        function(_pos)
            if _pos ~= nil then
                s1.enterPos = _pos
            end
            self:ChangeScene("s1")
        end
    )
    GameManager.RegisterFunc(
        "EnterBedRoom",
        function(_pos)
            if _pos ~= nil then
                s2.enterPos = _pos
            end
            self:ChangeScene("s2")
        end
    )
    GameManager.RegisterFunc(
        "EnterLoft",
        function(_pos)
            if _pos ~= nil then
                s3.enterPos = _pos
            end
            self:ChangeScene("s3")
        end
    )
    GameManager.RegisterFunc(
        "End",
        function(_pos)
            if _pos ~= nil then
                s4.enterPos = _pos
            end
            self:ChangeScene("s4")
        end
    )
end

function App:InitPlayer()
    self.player = Player:new(self.canvas)
end

function App:ChangeScene(_name)
    self.player:EnterScene(self.scenes[_name])
    self.currentScene = _name
end

function App:Run()
    self:Init()
    self:InitScene()
    self:InitPlayer()
    print("start!")
    start.Get(self.canvas)
    -- GameManager.CallFunc("End")
end

return App
