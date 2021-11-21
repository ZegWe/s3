local UIObject = require("Lua/module/uiObject")
local PlayerImage = require("Lua/resource").Player
local Animation = require("Lua/module/animation")

local playerWidth = 610
local playerHeight = 610
local KeyMoveLeft = Enum.KeyCode.A
local KeyMoveRight = Enum.KeyCode.D
local dt = 0.2

--- @class Player:UIObject
local Player = class("Player", UIObject)

--- @param _parent UIObject
function Player:initialize(_parent)
    UIObject.initialize(
        self,
        "Player",
        PlayerImage.Idle_Left[1],
        _parent.obj,
        Vector2(playerWidth, playerHeight),
        Vector2.Zero
    )
    --- @type Scene
    self.scene = nil
    self.animation = {}
    self:AnimationCreate("Idle_Left", PlayerImage.Idle_Left, 0.2)
    self:AnimationCreate("Idle_Right", PlayerImage.Idle_Right, 0.2)
    self:AnimationCreate("Walk_Left", PlayerImage.Walk_Left, 0.1)
    self:AnimationCreate("Walk_Right", PlayerImage.Walk_Right, 0.1)
    self:AnimationPlay("Idle_Left")
    self:InitControl()
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
    if curAnimation == _ani then return end
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
function Player:EnterScene(_scene, _pos)
    if self.scene ~= nil then
        self.scene.player = nil
    end
    self.scene = _scene
    self.obj.Parent = _scene.obj
    self.scene.player = self
    self.obj.Offset = _pos
    self:SetVisible(true)
    if self.faceLeft then
        self:AnimationPlay("Idle_Left")
    else
        self:AnimationPlay("Idle_Right")
    end
    self:EnableControl(true)
end

function Player:Move()
    local face = ""
    if self.faceLeft == true then
        face = "Left"
    else
        face = "Right"
    end
    local ani = ""
    if self.controlEnabled == false or self.moveSpeed == 0 then
        ani = "Idle" .. "_" .. face
    elseif self.moveSpeed == 1 then
        ani = "Walk" .. "_" .. face
    else
        ani = "Idle" .. "_" .. face
    end
    self:AnimationPlay(ani)
    local speed = self.moveSpeed * 10
    if self.faceLeft then
        speed = speed * -1
    end
    self.obj.Offset = self.obj.Offset + Vector2(speed, 0)
    if self.scene == nil or self.scene.obj.ActiveSelf == false then
        return
    end
    if self.scene.obj.Size.X / 2 - math.abs(self.obj.Offset.X) < 200 then
        self.obj.Offset = self.obj.Offset - Vector2(speed, 0)
    end
    if self.scene.obj.Parent.Size.X / 2 - math.abs(self.obj.Offset.X + self.scene.obj.Offset.X) < 600 then
        self.scene.obj.Offset = self.scene.obj.Offset - Vector2(speed, 0)
    end
end

function Player:InitControl()
    print("InitControl")
    self.controlEnabled = false
    self.faceLeft = false
    self.moveSpeed = 0
    world.OnRenderStepped:Connect(
        function()
            self:Move()
        end
    )
    Input.OnKeyDown:Connect(
        function()
            if self.controlEnabled == false then
                self.moveSpeed = 0
                return
            end
            if Input.GetPressKeyData(KeyMoveLeft) == Enum.KeyState.KeyStatePress then
                self.faceLeft = true
                self.moveSpeed = 1
            elseif Input.GetPressKeyData(KeyMoveRight) == Enum.KeyState.KeyStatePress then
                self.faceLeft = false
                self.moveSpeed = 1
            end
        end
    )
    Input.OnKeyUp:Connect(
        function()
            if
                Input.GetPressKeyData(KeyMoveLeft) == Enum.KeyState.KeyStateRelease and self.faceLeft == true and
                    self.moveSpeed == 1
             then
                self.moveSpeed = 0
            elseif
                Input.GetPressKeyData(KeyMoveRight) == Enum.KeyState.KeyStateRelease and self.faceLeft == false and
                    self.moveSpeed == 1
             then
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
