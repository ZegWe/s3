local UIObject = require("Lua/module/uiObject")
local PlayerImage = require("Lua/resource").Player
local Animation = require("Lua/module/animation")
local Camera = require("Lua/module/camera")
local GameManager = require("Lua/game")

local playerWidth = 610
local playerHeight = 610
local KeyMoveLeft = Enum.KeyCode.A
local KeyMoveRight = Enum.KeyCode.D
local dt = 0.2
local PlayerState = {
    Walk = "Walk",
    Idle = "Idle"
}
local PlayerModel = {
    Normal = "Normal",
    Kid = "Kid",
    Ghost = "Ghost"
}

--- @class Player:UIObject
local Player = class("Player", UIObject)

--- @param _parent UIObject
function Player:initialize(_parent)
    UIObject.initialize(
        self,
        "Player",
        PlayerImage.Idle_Right[1],
        _parent.obj,
        Vector2(playerWidth, playerHeight),
        Vector2.Zero
    )
    self.obj.RaycastTarget = false
    --- @type Scene
    self.scene = nil
    self.model = PlayerModel.Normal
    self.animation = {}
    self:AnimationCreate("Normal_Idle_Left", PlayerImage.Idle_Left, 0.2)
    self:AnimationCreate("Normal_Idle_Right", PlayerImage.Idle_Right, 0.2)
    self:AnimationCreate("Normal_Walk_Left", PlayerImage.Walk_Left, 0.1)
    self:AnimationCreate("Normal_Walk_Right", PlayerImage.Walk_Right, 0.1)
    self:AnimationCreate("Kid_Idle_Left", PlayerImage.Kid_Idle_Left, 0.2)
    self:AnimationCreate("Kid_Idle_Right", PlayerImage.Kid_Idle_Right, 0.2)
    self:AnimationCreate("Kid_Walk_Left", PlayerImage.Kid_Walk_Left, 0.1)
    self:AnimationCreate("Kid_Walk_Right", PlayerImage.Kid_Walk_Right, 0.1)
    self:AnimationCreate("Ghost_Idle_Left", PlayerImage.Ghost_Idle_Left, 0.2)
    self:AnimationCreate("Ghost_Idle_Right", PlayerImage.Ghost_Idle_Right, 0.2)
    self:AnimationCreate("Ghost_Walk_Left", PlayerImage.Ghost_Walk_Left, 0.1)
    self:AnimationCreate("Ghost_Walk_Right", PlayerImage.Ghost_Walk_Right, 0.1)

    self:InitControl()
    self:InitItems()
    self.camera = Camera:new(self)
end

function Player:InitItems()
    self.bucket = UIObject:new("Bucket", PlayerImage.Bucket, self.obj, Vector2(110, 90), Vector2(-130, 300))
    self.bucket:SetClickFunc(
        function()
            self.bucket:SetVisible(false)
            GameManager.PlaceItem("Bucket")
            GameManager.ShowTip("已放置【水桶】", 5)
        end
    )
    self.canvas = UIObject:new("Canvas", PlayerImage.Canvas, self.obj, Vector2(70, 80), Vector2(-30, 300))
    self.canvas:SetClickFunc(
        function()
            self.canvas:SetVisible(false)
            GameManager.PlaceItem("Canvas")
            GameManager.ShowTip("已放置【空画布】", 5)
        end
    )
    self.pigment = UIObject:new("Pigment", PlayerImage.Pigment, self.obj, Vector2(90, 60), Vector2(60, 300))
    self.pigment:SetClickFunc(
        function()
            self.pigment:SetVisible(false)
            GameManager.PlaceItem("Pigment")
            GameManager.ShowTip("已放置【颜料】", 5)
        end
    )
    GameManager.RegisterFunc(
        "SetItemVisible",
        function(_item, _visible)
            if _item == "Bucket" then
                self.bucket:SetVisible(_visible)
            elseif _item == "Canvas" then
                self.canvas:SetVisible(_visible)
            elseif _item == "Pigment" then
                self.pigment:SetVisible(_visible)
            end
        end
    )
end

function Player:ChangeModel(_model)
    self.model = _model
end

--- @param _name string
--- @param _t table
--- @param _dt number
function Player:AnimationCreate(_name, _t, _dt)
    self.animation[_name] = Animation:new(self.obj, _t, _dt)
end

--- @type string
local curAnimation = ""

--- @param _ani string
function Player:AnimationPlay(_ani)
    _ani = self.model .. "_" .. _ani
    if curAnimation == _ani then
        return
    end
    self:AnimationStop()
    curAnimation = _ani
    self.animation[curAnimation]:Play()
end

function Player:AnimationStop()
    if curAnimation == "" then
        return
    end
    self.animation[curAnimation]:Stop()
    curAnimation = ""
end

--- @param _scene Scene
--- @param _pos Vector2
function Player:EnterScene(_scene)
    self:LeaveScene()
    self.scene = _scene
    self.obj.Parent = _scene.obj
    self.scene.player = self
    self.obj.Offset = _scene.enterPos
    self.scene.obj.Offset = Vector2(-self.obj.Offset.X, 0)
    self.scene.bgm:Play()
    self.scene:SetVisible(true)
    self:SetVisible(true)
end

function Player:LeaveScene()
    if self.scene == nil then
        return
    end
    self:SetVisible(false)
    self.scene:SetVisible(false)
    self.scene.bgm:Stop()
    self.scene.enterPos = self.obj.Offset
    self.scene.player = nil
    self.obj.Parent = self.scene.obj.Parent
    self.scene = nil
end

function Player:Move(_dt)
    if self.scene == nil or self.scene.obj.ActiveSelf == false then
        return
    end
    local speed = self.moveSpeed * 600 * _dt
    if self.facing == "Left" then
        speed = speed * -1
    end
    if self.scene.obj.Size.X / 2 - math.abs(self.obj.Offset.X) > 200 then
        self.obj.Offset = self.obj.Offset + Vector2(speed, 0)
    end
end

function Player:Update(_dt)
    self:AnimationPlay(self.state .. "_" .. self.facing)
    self:Move(_dt)
end

function Player:InitControl()
    print("InitControl")
    self.controlEnabled = false
    self.facing = "Right"
    self.moveSpeed = 0
    self.state = PlayerState.Idle_Right
    world.OnRenderStepped:Connect(
        function(_dt)
            if self.controlEnabled == false then
                self.state = PlayerState.Idle
            end
            self:Update(_dt)
        end
    )
    Input.OnKeyDown:Connect(
        function()
            if Input.GetPressKeyData(KeyMoveLeft) == Enum.KeyState.KeyStatePress then
                self.facing = "Left"
                self.moveSpeed = 1
                self.state = PlayerState.Walk
            elseif Input.GetPressKeyData(KeyMoveRight) == Enum.KeyState.KeyStatePress then
                self.facing = "Right"
                self.moveSpeed = 1
                self.state = PlayerState.Walk
            end
        end
    )
    Input.OnKeyUp:Connect(
        function()
            if
                Input.GetPressKeyData(KeyMoveLeft) == Enum.KeyState.KeyStateRelease and self.facing == "Left" or
                    Input.GetPressKeyData(KeyMoveRight) == Enum.KeyState.KeyStateRelease and self.facing == "Right"
             then
                self.state = PlayerState.Idle
                self.moveSpeed = 0
            end
        end
    )
end

--- @param _enable boolean
function Player:EnableControl(_enable)
    self.controlEnabled = _enable
end

return Player
